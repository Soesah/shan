<?xml version="1.0" encoding="UTF-8" ?>
<xsl:stylesheet version="1.0" xmlns="http://www.w3.org/1999/xhtml" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

  <xsl:output method="text" encoding="UTF-8" indent="yes" doctype-public=""/>


  <xsl:template match="/">
    <xsl:apply-templates select="shan/words" />
  </xsl:template>

  <xsl:template match="words"> [<xsl:apply-templates select="word" />]</xsl:template>

  <xsl:template match="word">
    {
      "id": "<xsl:value-of select="@id"/>",
      "batch": <xsl:value-of select="@batch"/>,
      "characters":[<xsl:apply-templates select="character|characters"/>],
      "pinyin":<xsl:apply-templates select="pinyin"/>,
      "meanings":<xsl:apply-templates select="meanings"/>
    }<xsl:if test="position() != last()">,</xsl:if>
  </xsl:template>

  <xsl:template match="character">{
        "page": <xsl:call-template name="nullornumber"><xsl:with-param name="value" select="@page"/></xsl:call-template>,
        "position": <xsl:call-template name="nullornumber"><xsl:with-param name="value" select="@position"/></xsl:call-template>,
        "text": <xsl:call-template name="nullortext"><xsl:with-param name="value" select="."/></xsl:call-template>
      }</xsl:template>

  <xsl:template match="characters">
    <xsl:call-template name="split">
      <xsl:with-param name="chars" select="text()"/>
      <xsl:with-param name="pages" select="@pages"/>
      <xsl:with-param name="positions" select="@positions"/>
    </xsl:call-template>
  </xsl:template>

   <xsl:template name="split">
    <xsl:param name="chars"/>
    <xsl:param name="pages"/>
    <xsl:param name="positions"/>
    <xsl:choose>
      <xsl:when test="string-length($chars) != 1">
        {
          "page": <xsl:call-template name="nullornumber"><xsl:with-param name="value" select="substring-before($pages, ',')"/></xsl:call-template>,
          "position": <xsl:call-template name="nullornumber"><xsl:with-param name="value" select="substring-before($positions, ',')"/></xsl:call-template>,
          "text": <xsl:call-template name="nullortext"><xsl:with-param name="value" select="substring($chars, 1,1)"/></xsl:call-template>          
        },
        <xsl:call-template name="split">
          <xsl:with-param name="chars" select="substring($chars, 2)"/>
          <xsl:with-param name="pages" select="substring-after($pages, ',')"/>
          <xsl:with-param name="positions" select="substring-after($positions, ',')"/>
        </xsl:call-template>
      </xsl:when>
      <xsl:otherwise>
        {
          "page": <xsl:call-template name="nullornumber"><xsl:with-param name="value" select="$pages"/></xsl:call-template>,
          "position": <xsl:call-template name="nullornumber"><xsl:with-param name="value" select="$positions"/></xsl:call-template>,
          "text": <xsl:call-template name="nullortext"><xsl:with-param name="value" select="$chars"/></xsl:call-template>          
        }
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

  <xsl:template name="nullornumber">
    <xsl:param name="value"/>
    <xsl:choose>
      <xsl:when test="not($value)">null</xsl:when>
      <xsl:when test="$value = '-'">null</xsl:when>
      <xsl:when test="$value = '...'">null</xsl:when>
      <xsl:when test="$value = ''">null</xsl:when>
      <xsl:otherwise><xsl:value-of select="$value"/></xsl:otherwise>
    </xsl:choose>
  </xsl:template>

  <xsl:template name="nullortext">
    <xsl:param name="value"/>
    <xsl:choose>
      <xsl:when test="not($value)">null</xsl:when>
      <xsl:when test="$value = ''">null</xsl:when>
      <xsl:otherwise>"<xsl:value-of select="$value"/>"</xsl:otherwise>
    </xsl:choose>
  </xsl:template>

  <xsl:template match="pinyin">{
        "order": <xsl:call-template name="nullortext"><xsl:with-param name="value" select="@order-string"/></xsl:call-template>,
        "text": <xsl:call-template name="nullortext"><xsl:with-param name="value" select="@text"/></xsl:call-template>,
        "pinyin": <xsl:call-template name="nullortext"><xsl:with-param name="value" select="."/></xsl:call-template>
      }</xsl:template>

  <xsl:template match="meanings">[
        <xsl:apply-templates select="meaning"/>
      ]</xsl:template>

  <xsl:template match="meaning">"<xsl:value-of select="."/>"<xsl:if test="position() != last()">,</xsl:if></xsl:template>
</xsl:stylesheet>
