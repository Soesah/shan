<?xml version="1.0" encoding="UTF-8" ?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

	<xsl:output method="html" encoding="UTF-8" indent="yes"/>
	
	
	<!-- search and results -->
  <xsl:template name="search-form">
    <div class="search box dialog hide" id="search-form">
      <h2 id="form-title">Search</h2>
      <form method="get" id="form" action="content/search.php" onsubmit="return comm.sendForm(this, true);">
				<input type="hidden" name="form" value="search"/>
				<div class="form-body">
          <div class="form-item">
            <label>Value</label>
            <input type="text" id="search-focus" name="value" onblur="this.value = pinyin.convert(this.value);" xonkeyup="shan.setPinYinValues(this);" xonkeydown="shan.setPinYinValues(this);" class="search-value"/>
             <button type="submit" id="form-submit-button">Search</button>
          </div>
        </div>
        <div class="form-side">
        </div>
      </form>
			<div id="search-results"/>
    </div>
  </xsl:template>

	<xsl:template match="shan" mode="search">
		<div id="search-results">
			<h2>Results</h2>
			<ul class="results larger">
        <!-- 
        anything
          - with an id
          - contain the value
          or
          - with the value contained in the @text
        -->
				<xsl:apply-templates select=".//*[(@id and contains(., $value)) or (@id and .//*[contains(@text, $value)])]" mode="results"/>
	  	</ul>
		</div>
	</xsl:template>
	
	
	<xsl:template match="word" mode="results">
		<li>
			<a href="{@id}" onclick="comm.send('content/content-item.php?id='+this.getAttribute('href',2));return setClass('content','contentitem');">
				<xsl:apply-templates select="character|characters"/>
      </a>
      <span class="pinyin">
        <xsl:value-of select="pinyin"/>
      </span>
      <span class="numbers">
        <xsl:text> ( </xsl:text>
        <xsl:apply-templates select="character/@page|characters/@pages" mode="writing-instructions"/>

        <xsl:text> ) </xsl:text>
      </span> 
      (character)
    </li>
	</xsl:template>

  <xsl:template match="@page|@pages" mode="writing-instructions">
    <xsl:param name="pages" select="."/>
    <xsl:param name="positions" select="../@position|../@positions"/>
    <xsl:choose>
      <xsl:when test="contains($pages, ',')">
        <xsl:value-of select="substring-before($pages,',')"/>
        <xsl:text>/</xsl:text>
        <xsl:value-of select="substring-before($positions,',')"/>
        <xsl:text>, </xsl:text>
        <xsl:apply-templates select="." mode="writing-instructions">
          <xsl:with-param name="pages" select="substring-after($pages, ',')"/>
          <xsl:with-param name="positions" select="substring-after($positions, ',')"/>
        </xsl:apply-templates>
      </xsl:when>
      <xsl:otherwise>
        <xsl:value-of select="$pages"/>
        <xsl:text>/</xsl:text>
        <xsl:value-of select="$positions"/>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template> 
	
	<xsl:template match="conversation" mode="results">
		<li>
			<a href="{@id}" onclick="comm.send('content/content-item.php?id='+this.getAttribute('href',2));return setClass('content','contentitem');">
				<xsl:value-of select="line[1]/phrase/chinese"/>
			</a>
			(conversation)
		</li>
	</xsl:template>
		
	<xsl:template match="line" mode="results"/>

	<xsl:template match="*" mode="results">
		<li>
			<a href="{@id}" onclick="comm.send('content/content-item.php?id='+this.getAttribute('href',2));return setClass('content','contentitem');">
				<xsl:value-of select="name()"/>
			</a>
		</li>
	</xsl:template>


	<!-- add dialog -->
	<xsl:template name="add-character-form">
	  <xsl:variable name="max">
	    <xsl:apply-templates select="." mode="max"/>
	  </xsl:variable>
	  <xsl:variable name="word" select="//word[@id = $id]"/>
	  <div class="dialog box add hide" id="add-form">
	    <h2 id="add-form-title">
	      <xsl:choose>
	        <xsl:when test="$id != ''">Update </xsl:when>
	        <xsl:otherwise>Add a </xsl:otherwise>
	      </xsl:choose>
	      <xsl:text>Character</xsl:text>
	    </h2>
	    <form method="post" id="add-form" autocomplete="off" action="content/add-character.php" onsubmit="return shan.addCharacter(this);">
	      <xsl:if test="$id != ''">
	        <input type="hidden" id="update_id" name="update_id" value="{$id}"/>
	      </xsl:if>
	      <div class="form-body">
	        <div class="form-item">
	          <label>Character</label>
	          <input type="text" id="add-focus" name="character" class="character-input" value="{$word/character|$word/characters}" onkeyup="shan.checkWord(this);"/>
	        </div>
          <div id="double" class="double form-item no-label">
            This word already exists.
          </div>
	        <div class="form-item">
	          <label>Pinyin</label>
	          <input type="text" id="pinyin-input" name="pinyin-input" value="{$word/pinyin}" onfocus="var os = document.getElementById('order_string').value;if(os != '')this.value = os;" onblur="this.value = pinyin.convert(this.value);" onkeyup="shan.setPinYinValues(this);" onkeydown="shan.setPinYinValues(this);" class="pinyin-input"/>
	        </div>
	        <div class="form-item hide">
	          <label>Order</label>
	          <input type="text" id="order_string" value="{$word/pinyin/@order-string}" name="order-string" class="pinyin-order-string-input"/>
	        </div>
	        <div class="form-item hide">
	          <label>Text</label>
	          <input type="hidden" id="text-input" name="text" value="{$word/pinyin/@text}" class="pinyin-text-input"/>
	        </div>
	        <div id="meaning">
	          <xsl:attribute name="class">
	            <xsl:text>form-item </xsl:text>
	            <xsl:if test="not($word) or count($word/meanings/meaning) = 1">
	              <xsl:text>with-button</xsl:text>
	            </xsl:if>
	          </xsl:attribute>
	          <label id="meaning-label">
	            <xsl:text>Meaning</xsl:text>
	            <xsl:if test="$word/meanings/meaning and count($word/meanings/meaning) != 1">
	              <xsl:text>s</xsl:text>
	            </xsl:if>
	          </label>
	          <input type="text" id="meaning-input" name="meaning" value="{$word/meanings/meaning[1]}" class="meaning-input"/>
	          <xsl:if test="not($id) or count($word/meanings/meaning) = 1">
	            <button type="button" id="add-meaning" onclick="return shan.add_meaning_field(this)" class="add-meaning">+</button>
	          </xsl:if>
	        </div>
	        <div id="additional-meanings">
	          <xsl:for-each select="$word/meanings/meaning[position() != 1]">
	            <div>
	              <xsl:attribute name="class">
	                <xsl:text>form-item no-label </xsl:text>
	                <xsl:if test="position() = last()">
	                  <xsl:text>no-label with-button</xsl:text>
	                </xsl:if>
	              </xsl:attribute>
	              <input type="text" name="meaning-{position()}" value="{.}" class="meaning-input"/>
	              <xsl:if test="position() = last()">
	                <button type="button" id="add-meaning" onclick="return shan.add_meaning_field(this)" class="add-meaning">+</button>
	              </xsl:if>
	            </div>
	          </xsl:for-each>
	        </div>
	        <div class="form-buttons no-label">
	          <button type="button" onclick="shan.resetForm(document.getElementById('add-form'));">Clear</button>
	          <button type="submit" id="add-form-submit-button">
	            <xsl:choose>
	              <xsl:when test="$id != ''">Update </xsl:when>
	              <xsl:otherwise>Add</xsl:otherwise>
	            </xsl:choose>
	          </button>
	        </div>
	      </div>
	      <div class="form-side">
	        <div class="form-item-small">
	          <label>Page</label>
	          <input type="text" id="page-input" name="page" minimum="1" xonkeyup="return shan.updateValue(event, this);" class="character-page-input">
	            <xsl:attribute name="value">
	              <xsl:choose>
	                <xsl:when test="$word">
	                  <xsl:value-of select="$word/character/@page|$word/characters/@pages"/>
	                </xsl:when>
	                <xsl:otherwise>1</xsl:otherwise>
	              </xsl:choose>
	            </xsl:attribute>
	          </input>
	        </div>
	        <div class="form-item-small">
	          <label>Number</label>
	          <input type="text" id="number-input" name="number" minimum="1" xonkeyup="return shan.updateValue(event, this);" class="character-number-input">
	            <xsl:attribute name="value">
	              <xsl:choose>
	                <xsl:when test="$word">
	                  <xsl:value-of select="$word/character/@position|$word/characters/@positions"/>
	                </xsl:when>
	                <xsl:otherwise>1</xsl:otherwise>
	              </xsl:choose>  
	            </xsl:attribute>
	          </input>
	        </div>
	        <div class="form-item-small">
	          <label>Batch #</label>
	          <input type="text" name="batch" id="batch" minimum="1" onkeyup="return shan.updateValue(event, this);" max="{$max}" class="batch-input">
	            <xsl:attribute name="value">
	              <xsl:choose>
	                <xsl:when test="$word">
	                  <xsl:value-of select="$word/@batch"/>
	                </xsl:when>
	                <xsl:otherwise>
	                  <xsl:value-of select="$max"/>
	                </xsl:otherwise>
	              </xsl:choose>
	            </xsl:attribute>
	          </input>
	        </div>
	      </div>

	    </form>
	  </div>
	</xsl:template>

  <!-- add dialog -->
  <xsl:template name="add-sentence-form">
    <xsl:variable name="sentence" select="//sentence[@id = $id]"/>
    <div class="dialog box add add-sentence hide" id="add-sentence-form">
      <h2 id="add-sentence-form-title">
        <xsl:choose>
          <xsl:when test="$id != ''">Update </xsl:when>
          <xsl:otherwise>Add a </xsl:otherwise>
        </xsl:choose>
        <xsl:text>Sentence</xsl:text>
      </h2>
      <form method="post" id="add-sentence-form" action="content/add-sentence.php" onsubmit="return shan.addSentence(this);">
        <xsl:if test="$id != ''">
          <input type="text" id="update_sentence_id" name="update_id" value="{$id}"/>
        </xsl:if>
        <div class="form-body">
          
          <div class="form-item">
            <label>Chinese</label>
            <input type="text" id="add-sentence-focus" name="sentence-characters" class="sentence-characters-input" value="{$sentence/chinese}"/>
          </div>
          <div class="form-item">
            <label>English</label>
            <input type="text" id="sentence-text-input" name="sentence-text" value="{$sentence/english}" class="sentence-text-input"/>
          </div>

          <div class="form-buttons no-label">
            <button type="button" onclick="shan.resetForm(document.getElementById('add-form'));">Clear</button>
            <button type="submit" id="add-sentence-form-submit-button">
              <xsl:choose>
                <xsl:when test="$id != ''">Update </xsl:when>
                <xsl:otherwise>Add</xsl:otherwise>
              </xsl:choose>
            </button>
          </div>
        </div>
 
      </form>
    </div>
  </xsl:template>

  <xsl:template match="*" mode="max">
    <xsl:for-each select="//words/word">
      <xsl:sort select="@batch" data-type="number" order="descending"/>
      <xsl:if test="position() = 1">
        <xsl:value-of select="@batch"/>
      </xsl:if>
    </xsl:for-each>
  </xsl:template>


</xsl:stylesheet>
