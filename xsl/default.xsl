<?xml version="1.0" encoding="UTF-8" ?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

	<xsl:output method="html" encoding="UTF-8" indent="yes"/>
  
  <xsl:include href="common.xsl"/>
  
  <xsl:param name="platform" />
  <xsl:param name="lang"/>

  <xsl:param name="id"/>
  <xsl:param name="item"/>
  <xsl:param name="form" select="''"/>
  <xsl:param name="value"/>

	<xsl:template match="/">
		<xsl:choose>
			<xsl:when test="$id != '' and $item != 'edititem'">
				<xsl:choose>
					<xsl:when test="$item = 'edit'">
						<xsl:call-template name="add-character-form"/>
					</xsl:when>
					<xsl:otherwise>
						<xsl:apply-templates select="//*[@id = $id]"/>
					</xsl:otherwise>
				</xsl:choose>
			</xsl:when>
			<xsl:when test="$item = 'random-list'">
				<xsl:apply-templates select="//words"/>
			</xsl:when>
			<xsl:when test="$form != ''">
				<xsl:choose>
					<xsl:when test="$form = 'search'">
						<xsl:apply-templates select="." mode="search"/>
					</xsl:when>
					<xsl:otherwise/>
				</xsl:choose>
			</xsl:when>
			<xsl:otherwise>	
				<xsl:apply-templates />
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>

  <xsl:template match="shan">
    <html>
      <head>
        <title>Shan</title>
        <link rel="stylesheet" type="text/css" href="css/css.php"/>
		    <link rel="shortcut icon" href="img/favicon.ico" type="image/x-icon"/>
     	</head>
      <body>
				<xsl:call-template name="body-class"/>
        
        <div class="page">
          <xsl:apply-templates select="title" mode="header"/>

          <div id="content">
            <xsl:attribute name="class">
              <xsl:choose>
                <xsl:when test="$item = 'edititem'">add</xsl:when>
                <xsl:when test="$item != ''">contentitem</xsl:when>
                <xsl:otherwise>search</xsl:otherwise>
              </xsl:choose>
            </xsl:attribute>
            <xsl:call-template name="search-form"/>
        
					  <xsl:call-template name="add-character-form"/>

            <xsl:call-template name="add-sentence-form"/>
            
            <xsl:call-template name="download-dialog"/>

					  <xsl:apply-templates select="words"/>

            <xsl:apply-templates select="words" mode="words-of-the-day"/>

            <xsl:apply-templates select="sentences"/>
            <xsl:apply-templates select="text"/>
        
					  <xsl:call-template name="content-page"/>
				  </div>

       	  <xsl:call-template name="menu"/>

	        <script type="text/javascript" src="js/script.php"></script>
        </div>
      </body>
    </html>
  </xsl:template>

	<xsl:template name="body-class">
		<xsl:attribute name="class">
			<xsl:if test="$platform != 'Unknown'">
				<xsl:value-of select="$platform"/>
			</xsl:if>
		</xsl:attribute>
	</xsl:template>


  <xsl:template match="shan/title" mode="header">
   	<div class="header">
			<h1>
        <a href="/">
          <xsl:apply-templates select="node()"/>
        </a>
	    </h1>
		</div>
  </xsl:template>


  <!-- sentences -->

  <xsl:template match="sentences">
    <div class="sentences box page-content hide" id="sentences">
      <h2>Sentences</h2>
      <ul class="text-list">
        <xsl:apply-templates select="sentence" mode="list"/>
      </ul>
    </div>
  </xsl:template>

  <xsl:template match="sentence" mode="list">
    <li>
      <a href="{@id}" onclick="comm.send('content/content-item.php?id='+this.getAttribute('href',2));return setClass('content','contentitem');">
        <xsl:value-of select="chinese" />
      </a>
      <span class="pinyin">
        <xsl:value-of select="english" />
      </span>
    </li>
  </xsl:template>
  
	<!-- conversations -->

  <xsl:template match="text">
 		<div class="conversations box page-content hide" id="text">
			<h2>Conversations</h2>
			<ul class="text-list">
        <xsl:apply-templates select="conversation" mode="list"/>
			</ul>
		</div>
 	</xsl:template>

  <xsl:template match="conversation" mode="list">
		<li>
			<a href="{@id}" onclick="comm.send('content/content-item.php?id='+this.getAttribute('href',2));return setClass('content','contentitem');">
        <xsl:value-of select="line[1]/phrase/chinese" />
      </a>
      <span class="pinyin">
      	<xsl:value-of select="line[1]/phrase/english" />
			</span>
		</li>
	</xsl:template>
		
	<xsl:template match="conversation">
 		<div class="content box page-content hide" id="content-page">
      <xsl:apply-templates select="title"/>
      <div id="{@id}_english" class="hideenglish">
	      <div id="{@id}_pinyin" class="hidepinyin">
					<div class="conversation conversation-content">
		        <xsl:apply-templates select="line"/>
		      </div>
					<div class="options">
						<a href="#" class="hide" id="showpinyin" onclick="return setClass('{@id}_pinyin','showpinyin');">Show Pinyin</a>
						<a href="#" class="hide" id="hidepinyin" onclick="return setClass('{@id}_pinyin','hidepinyin');">Hide Pinyin</a>
						<xsl:text> / </xsl:text>
						<a href="#" class="hide" id="showenglish" onclick="return setClass('{@id}_english','showenglish');">Show English</a>
						<a href="#" class="hide" id="hideenglish" onclick="return setClass('{@id}_english','hideenglish');">Hide English</a>
					</div>
				</div>
			</div>
    </div>
  </xsl:template>

  <xsl:template match="line">
    <div class="{name()}">
      <xsl:apply-templates select="*"/>
    </div>
  </xsl:template>

  <xsl:template match="speaker">
    <div class="{name()}">
      <span class="character">
        <xsl:copy-of select="@xml:lang"/>
        <xsl:apply-templates select="node()"/>
        <xsl:text>: </xsl:text>
      </span>
    </div>
  </xsl:template>

  <xsl:template match="phrase">
    <div class="{name()}">
    	<xsl:apply-templates select="chinese"/>
    </div>
	</xsl:template>

  <xsl:template match="chinese">
		<span class="{name()}">
    	<xsl:apply-templates />
		</span>
	</xsl:template>

  <xsl:template match="phrase/english">
    <p class="{name()}">
      <xsl:apply-templates/>
    </p>
  </xsl:template>
  
  <xsl:template match="phrase/chinese">
    <table cellpadding="0" cellspacing="0" border="0">
      <tr class="character">
		    <xsl:call-template name="parse">
			    <xsl:with-param name="text" select="text()"/>
		    </xsl:call-template>
      </tr>
      <tr class="pinyin-text">
        <xsl:call-template name="parse">
          <xsl:with-param name="text" select="text()"/>
          <xsl:with-param name="pinyin" select="true()"/>
        </xsl:call-template>
      </tr>
      <tr class="translation">
        <td colspan="10">
          <xsl:apply-templates select="../english"/>
        </td>
      </tr>
    </table>
	</xsl:template>
  
	<xsl:template name="parse">
		<xsl:param name="text"/>
    <xsl:param name="pinyin" select="false()"/>
    
    <xsl:variable name="character" select="substring($text,1,1)"/>
		<xsl:variable name="character-two" select="substring($text,1,2)"/>
		<xsl:variable name="character-three" select="substring($text,1,3)"/>
    <xsl:variable name="character-four" select="substring($text,1,4)"/>


    <xsl:choose>
      <xsl:when test="//word[characters = $character-four]">
        <td align="center" valign="top">
          <xsl:choose>
            <xsl:when test="not($pinyin)">
              <xsl:value-of select="$character-four"/>
            </xsl:when>
            <xsl:otherwise>
              <xsl:value-of select="//word[characters = $character-four]/pinyin"/>
            </xsl:otherwise>
          </xsl:choose>
        </td>
        <xsl:if test="string-length(substring($text,5)) != 0">
          <xsl:call-template name="parse">
            <xsl:with-param name="text" select="substring($text,5)"/>
            <xsl:with-param name="pinyin" select="$pinyin"/>
          </xsl:call-template>
        </xsl:if>
      </xsl:when>
      <xsl:when test="//word[characters = $character-three]">
        <td align="center" valign="top">
          <xsl:choose>
            <xsl:when test="not($pinyin)">
	  			    <xsl:value-of select="$character-three"/>
            </xsl:when>
            <xsl:otherwise>
							<span class="pinyin">
  				    	<xsl:value-of select="//word[characters = $character-three]/pinyin"/>
            	</span>
						</xsl:otherwise>
          </xsl:choose>
        </td>
				<xsl:if test="string-length(substring($text,4)) != 0">
					<xsl:call-template name="parse">
						<xsl:with-param name="text" select="substring($text,4)"/>
            <xsl:with-param name="pinyin" select="$pinyin"/>
          </xsl:call-template>
				</xsl:if>
			</xsl:when>
      <xsl:when test="//word[characters = $character-two]">
        <td align="center" valign="top">
          <xsl:choose>
            <xsl:when test="not($pinyin)">
              <xsl:value-of select="$character-two"/>
            </xsl:when>
            <xsl:otherwise>
							<span class="pinyin">
              	<xsl:value-of select="//word[characters = $character-two]/pinyin"/>
            	</span>
						</xsl:otherwise>
          </xsl:choose>
        </td>
        <xsl:if test="string-length(substring($text,3)) != 0">
          <xsl:call-template name="parse">
            <xsl:with-param name="text" select="substring($text,3)"/>
            <xsl:with-param name="pinyin" select="$pinyin"/>
          </xsl:call-template>
        </xsl:if>
      </xsl:when>
			<xsl:when test="//word[character = $character]">
        <td align="center" valign="top">
          <xsl:choose>
            <xsl:when test="not($pinyin)">
              <xsl:value-of select="$character"/>
            </xsl:when>
            <xsl:otherwise>
							<span class="pinyin">
                <xsl:value-of select="//word[character = $character]/pinyin"/>
							</span>
            </xsl:otherwise>
          </xsl:choose>
        </td>
        <xsl:if test="string-length(substring($text,2)) != 0">
					<xsl:call-template name="parse">
						<xsl:with-param name="text" select="substring($text,2)"/>
            <xsl:with-param name="pinyin" select="$pinyin"/>
          </xsl:call-template>
				</xsl:if>
			</xsl:when>
      <xsl:otherwise>
        <td>
          <xsl:choose>
            <xsl:when test="not($pinyin)">
              <xsl:value-of select="$character"/>
            </xsl:when>
            <xsl:otherwise>
             
            </xsl:otherwise>
          </xsl:choose>
        </td>
        <xsl:if test="string-length(substring($text,2)) != 0">
          <xsl:call-template name="parse">
            <xsl:with-param name="text" select="substring($text,2)"/>
            <xsl:with-param name="pinyin" select="$pinyin"/>
          </xsl:call-template>
        </xsl:if>
      </xsl:otherwise>
		</xsl:choose>
		
	</xsl:template>
  
	<xsl:template match="*">
		<div>
			<xsl:value-of select="name()"/>
		</div>
	</xsl:template>

	<!-- content page -->
	
  <xsl:template name="content-page">
		<xsl:choose>
			<xsl:when test="$item != '' and $item != 'edititem'">
				<xsl:apply-templates select="//*[@id = $item]"/>
			</xsl:when>
			<xsl:otherwise>
				<div class="content box page-content hide" id="content-page">
				</div>
			</xsl:otherwise>
		</xsl:choose>
 	</xsl:template>


</xsl:stylesheet>
