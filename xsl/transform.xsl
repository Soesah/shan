<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    
  <xsl:output method="xml" encoding="utf-8" indent="yes"/>

  <xsl:template match="@* | node()">
      <xsl:copy>
          <xsl:apply-templates select="@* | node()"/>
      </xsl:copy>
  </xsl:template>

  <xsl:template match="cards">
    <words>
      <xsl:apply-templates select="@* | node()"/>
    </words>
  </xsl:template>


  <xsl:template match="card[count(character) != 1]">
    <word>
      <xsl:apply-templates select="@*"/>
      <characters>
        <xsl:apply-templates select="character[1]/@xml:lang"/>
        <xsl:attribute name="pages">
          <xsl:for-each select="character">
            <xsl:value-of select="@page"/>
            <xsl:if test="position() != last()">
              <xsl:text>,</xsl:text>
            </xsl:if>
          </xsl:for-each>
        </xsl:attribute>
        <xsl:attribute name="positions">
          <xsl:for-each select="character">
            <xsl:value-of select="@position"/>
            <xsl:if test="position() != last()">
              <xsl:text>,</xsl:text>
            </xsl:if>
          </xsl:for-each>
        </xsl:attribute>
        <xsl:apply-templates select="character/text()"/>
      </characters>
      <xsl:apply-templates select="pronunciation|meanings"/>
    </word>
  </xsl:template>

  
  <xsl:template match="card">
    <word>
      <xsl:apply-templates select="@* | node()"/>
    </word>
  </xsl:template>


  <xsl:template match="pronunciation">
    <pinyin>
      <xsl:apply-templates select="@xml:lang"/>
      <xsl:choose>
        <xsl:when test="contains(.,',')">
          <xsl:attribute name="text">
            <xsl:value-of select="substring-before(@text,',')"/>
          </xsl:attribute>
          <xsl:attribute name="order-string">
            <xsl:value-of select="substring-before(@order-string,',')"/>
          </xsl:attribute>
          <xsl:value-of select="substring-before(.,',')"/>
        </xsl:when>
        <xsl:otherwise>
          <xsl:apply-templates select="@text|@order-string"/>
          <xsl:value-of select="."/>
        </xsl:otherwise>
      </xsl:choose>
    </pinyin>
    <xsl:if test="contains(.,',')">
      <alternate>
        <xsl:apply-templates select="@xml:lang"/>
        <xsl:attribute name="text">
          <xsl:value-of select="substring-after(@text,',')"/>
        </xsl:attribute>
        <xsl:attribute name="order-string">
          <xsl:value-of select="substring-after(@order-string,',')"/>
        </xsl:attribute>
        <xsl:value-of select="substring-after(.,',')"/>
      </alternate>
    </xsl:if>
  </xsl:template>



</xsl:stylesheet>
