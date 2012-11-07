<?xml version="1.0" encoding="UTF-8" ?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

	<xsl:output method="html" encoding="UTF-8" indent="yes"/>

	
	<!-- characters -->
  <xsl:template match="words">
 		<div class="words box page-content hide" id="words">
			<h2>Characters </h2>
			<div id="list_pinyin" class="hidepinyin">
				<ul class="character-list">
	        <xsl:apply-templates select="word" mode="list"/>
				</ul>
				<div class="options">
          <span class="count"><xsl:value-of select="count(word)"/> words</span>
          <xsl:text> / </xsl:text>
					<a href="#" class="hide" id="showpinyin" onclick="return setClass('list_pinyin','showpinyin');">Show Pinyin</a>
					<a href="#" class="hide" id="hidepinyin" onclick="return setClass('list_pinyin','hidepinyin');">Hide Pinyin</a>
				</div>
			</div>
		</div>
 	</xsl:template>

  <xsl:template match="words" mode="words-of-the-day">
    <div class="words box page-content hide" id="words-of-the-day">
      <h2>Words of the day</h2>
			<div id="wordsofday_pinyin" class="hidepinyin">
				<div id="wordsofday_meanings" class="hidemeanings">
        	<ul id="words-of-the-day-list" class="character-list">
          
	        </ul>
	        <div class="options">
	          <a href="#" class="hide" id="showpinyin" onclick="return setClass('wordsofday_pinyin','showpinyin');">Show Pinyin</a>
	          <a href="#" class="hide" id="hidepinyin" onclick="return setClass('wordsofday_pinyin','hidepinyin');">Hide Pinyin</a>
	        </div>
      	</div>
      </div>
    </div>
  </xsl:template>

  <xsl:template match="words-of-the-day">
    <ul id="words-of-the-day-list" class="character-list daily-words-list">
      <xsl:apply-templates select="day[last()]/word" mode="list"/>
    </ul>
  </xsl:template>

  <xsl:template match="word" mode="list">
		<li>
			<xsl:attribute name="class">character-box-<xsl:value-of select="string-length(character|characters)"/></xsl:attribute>
			<a href="{@id}" onclick="comm.send('content/content-item.php?id='+this.getAttribute('href',2));return setClass('content','contentitem');">
				<xsl:apply-templates select="character|characters" />
				<xsl:apply-templates select="pinyin" />
			</a>
		</li>
	</xsl:template>
	
	
	<xsl:template match="word">
 		<div class="content box dialog hide word" id="content-page">
				<div class="word-header">
       		<xsl:apply-templates select="character|characters"/>
	    	</div>
				<div id="{@id}_pinyin" class="hidepinyin">
					<div id="{@id}_meanings" class="hidemeanings">
						<div class="options">
							<a href="#" class="hide" id="showpinyin" onclick="return setClass('{@id}_pinyin','showpinyin');">Show Pinyin</a>
							<a href="#" class="hide" id="hidepinyin" onclick="return setClass('{@id}_pinyin','hidepinyin');">Hide Pinyin</a>
							<xsl:text> / </xsl:text>
							<a href="#" class="hide" id="showmeanings" onclick="return setClass('{@id}_meanings','showmeanings');">Show Meanings</a>
							<a href="#" class="hide" id="hidemeanings" onclick="return setClass('{@id}_meanings','hidemeanings');">Hide Meanings</a>
							<xsl:text> / </xsl:text>
							<a href="content/content-item.php?id={@id}&amp;item=edit" onclick="comm.send(this.href);return setClass('content','add');">Update</a>
						</div>
						<div class="word-content">
		       		<xsl:apply-templates select="pinyin|meanings"/>
						  <p class="additional">
								<xsl:for-each select="character">
									<xsl:apply-templates select="//word[@id != current()/../@id and contains(character, current()/text())]" mode="additional"/>
								</xsl:for-each>
							</p>
						</div>
					</div>
				</div>
				<div class="writing">
		      <xsl:value-of select="character/@page|characters/@pages"/> - <xsl:value-of select="character/@position|characters/@positions"/>
		    </div>        
				<div class="meta">
          <xsl:value-of select="position()"/>
          <xsl:text> / </xsl:text>
          <xsl:apply-templates select="@batch"/>
          <xsl:apply-templates select="@checked"/>
        </div>
			</div>
	</xsl:template>
	
	<xsl:template match="word" mode="additional">
  	<a href="{@id}" onclick="comm.send('content/content-item.php?id='+this.getAttribute('href',2));return setClass('content','contentitem');">
  		<xsl:apply-templates select="character"/>
  	</a>
    <xsl:if test="position() != last()">
      <xsl:text>, </xsl:text>
    </xsl:if>
	</xsl:template>

	<xsl:template match="*" mode="additional">
  	<span>
  		<xsl:value-of select="name()"/>
  	</span>
    <xsl:if test="position() != last()">
      <xsl:text>, </xsl:text>
    </xsl:if>
	</xsl:template>
	

  <xsl:template match="word/@checked">
  </xsl:template>

  <xsl:template match="word/@batch">
    <span>
      <xsl:text>Batch: </xsl:text>
      <xsl:value-of select="."/>
    </span>
  </xsl:template>
  
  <xsl:template match="character|characters">
    <span class="character">
      <xsl:apply-templates select="node()"/>
    </span>
  </xsl:template>
  
  <xsl:template match="word/pinyin">
    <div class="{name()}">
      <xsl:if test="text() = '' or not(text())"><span class="unknown">pinyin Unknown</span></xsl:if>
      <xsl:apply-templates select="node()"/>
    </div>
  </xsl:template>

  <xsl:template match="@order-string">
    <xsl:if test="$show-order-strings = 'false'">
      <span class="{name()}">
        (<xsl:value-of select="."/>)
      </span>
    </xsl:if>
  </xsl:template>
  
  <xsl:template match="pinyin">
    <span class="{name()}">
      <xsl:apply-templates select="node()"/>
    </span>
  </xsl:template>

  <xsl:template match="meanings">
    <div class="{name()}">
      <xsl:apply-templates/>
    </div>
  </xsl:template>
  
  <xsl:template match="meaning">
     <div class="{name()}">
       <xsl:if test="text() = '' or not(text())"><span class="unknown">Meaning Unknown</span></xsl:if>
       <xsl:apply-templates select="node()"/>
     </div>
  </xsl:template>

	<!-- download -->
	<xsl:template name="download-dialog">
    <div class="download box page-content hide" id="download-page">
      <h2>Download</h2>
			<p>These are pdf files with the notes from the class. </p>
			<ul id="downloads">
			</ul>
		</div>
	</xsl:template>
	
	<xsl:template match="downloads">
		<div id="children">
			<ul id="downloads" class="download-list">
				<xsl:apply-templates select="file"/>
			</ul>
		</div>
	</xsl:template>
	
	<xsl:template match="file">
		<li>
				<a href="downloads/{@name}">
					<xsl:value-of select="."/>
				</a>
				<xsl:apply-templates select="@size"/>
		</li>
	</xsl:template>
	
	<xsl:template match="@size">
		<span class="size">
			<xsl:text> (</xsl:text>
			<xsl:choose>
				<xsl:when test="number(.) &gt; 1000000">
					<xsl:value-of select="round(. div 1000000)"/> Mb.
				</xsl:when>
				<xsl:when test="number(.) &gt; 1000">
					<xsl:value-of select="round(. div 1000)"/> Kb.
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="@size"/> b.
				</xsl:otherwise>
			</xsl:choose>
			<xsl:text>)</xsl:text>
		</span>
	</xsl:template>


</xsl:stylesheet>
