<?xml version="1.0" encoding="UTF-8" ?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

	<xsl:output method="html" encoding="UTF-8" indent="yes"/>

	<xsl:param name="nr" select="count(daily-list/day)"/>

  <xsl:template match="daily-list">
    <html>
      <head>
        <title>Daily List</title>
        <link rel="stylesheet" type="text/css" href="../css/font.php"/>
        <link rel="shortcut icon" href="../img/favicon.ico" type="image/x-icon"/>
      </head>
      <body>
        <h2>Daily Words</h2>
				<p>
					<xsl:if test="$nr != 1">
						<a href="?nr={$nr - 1}">Previous</a>
					</xsl:if>
					<xsl:if test="$nr != 1 and $nr &lt; count(day)">
						<xsl:text> - </xsl:text>
					</xsl:if>
					<xsl:if test="$nr &lt; count(day)">
						<a href="?nr={$nr+1}">Next</a>
					</xsl:if>
				</p>
        <div id="list_pinyin" class="hidepinyin">
          <table class="daily-list" border="0" cellspacing="4" cellpadding="4" width="100%">
            <xsl:apply-templates select="day[position() = $nr]/word" mode="list"/>
          </table>
        </div>
      </body>
    </html>
 	</xsl:template>

  <xsl:template match="word" mode="list">
		<tr>
			<xsl:attribute name="class">character-box-<xsl:value-of select="string-length(character|characters)"/></xsl:attribute>
      <td valign="top" align="center">
        <xsl:value-of select="position()"/>
      </td>
      <td valign="top" align="left">
        <xsl:apply-templates select="character|characters" />
      </td>
      <td valign="middle" align="left">
        <xsl:apply-templates select="pinyin" />
      </td>

      <td valign="middle" align="left">
        <xsl:apply-templates select="meanings" />
      </td>
    </tr>
	</xsl:template>
	

  <xsl:template match="character|characters">
    <div class="character-box">
      <span class="character">
        <xsl:apply-templates select="node()"/>
      </span>
      <div class="writing">
        <xsl:value-of select="@page|@pages"/> - <xsl:value-of select="@position|@positions"/>
      </div>
    </div>
  </xsl:template>
  
  <xsl:template match="word/pinyin">
    <div class="{name()}">
      <xsl:if test="text() = '' or not(text())"><span class="unknown">pinyin Unknown</span></xsl:if>
      <xsl:apply-templates select="node()"/>
    </div>
  </xsl:template>

  <xsl:template match="pinyin">
    <span class="{name()}">
      <xsl:apply-templates select="node()"/>
    </span>
  </xsl:template>

  <xsl:template match="meanings">
    <xsl:choose>
      <xsl:when test="count(meaning) = 1">
        <xsl:apply-templates select="meaning" mode="single"/>
      </xsl:when>
      <xsl:otherwise>
        <ul>
          <xsl:apply-templates select="meaning"/>
        </ul>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

  <xsl:template match="meaning" mode="single">
    <p>
      <xsl:value-of select="."/>
    </p>
  </xsl:template>
  
  <xsl:template match="meaning">
    <li>
      <xsl:value-of select="."/>
    </li>
  </xsl:template>

</xsl:stylesheet>
