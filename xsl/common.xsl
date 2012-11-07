<?xml version="1.0" encoding="UTF-8" ?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

	<xsl:output method="html" encoding="UTF-8" indent="yes"/>

 	<xsl:include href="dialogs.xsl"/>
 	<xsl:include href="pages.xsl"/>
 	<xsl:include href="menu.xsl"/>

	
	<!-- titles -->
	<xsl:template match="title">
		<h2>
			<xsl:apply-templates />
		</h2>
	</xsl:template>	
	
	<!-- shan common -->
  <xsl:template match="chinese|character">
    <span class="character {name()}">
      <xsl:apply-templates select="node()"/>
    </span>
  </xsl:template>

  <xsl:template match="english|pronunciation">
    <span class="pronunciation {name()}">
      <xsl:apply-templates select="node()"/>
    </span>
  </xsl:template>

  <xsl:template name="label">
    <xsl:param name="id"/>
    <xsl:attribute name="title">
      <xsl:value-of select="//application/label[@id = $id]/english"/>
    </xsl:attribute>
    <xsl:apply-templates select="//application/label[@id = $id]/chinese"/>
  </xsl:template>

	<xsl:template name="position">
		<xsl:param name="pos"/>
		<span class="position">
			<xsl:value-of select="$pos"/>
		</span>
	</xsl:template>

	<!-- common -->
  <xsl:template match="section|tip">
    <div class="{name()}">
      <xsl:apply-templates select="*"/>
    </div>
  </xsl:template>
  
  <xsl:template match="paragraph">
    <p>
      <xsl:apply-templates select="node()"/>
    </p>
  </xsl:template>

  <xsl:template match="unorderedlist">
    <ul>
      <xsl:apply-templates select="*"/>
    </ul>
  </xsl:template>

  <xsl:template match="orderedlist">
    <ol>
      <xsl:apply-templates select="*"/>
    </ol>
  </xsl:template>
  
  <xsl:template match="item">
    <li>
      <xsl:apply-templates select="node()"/>
    </li>
  </xsl:template>

  <xsl:template match="strong">
    <strong>
      <xsl:apply-templates select="node()"/>
    </strong>
  </xsl:template>

  <xsl:template match="emphasis">
    <em>
      <xsl:apply-templates select="node()"/>
    </em>
  </xsl:template>

  <xsl:template match="underline">
    <u>
      <xsl:apply-templates select="node()"/>
    </u>
  </xsl:template>
</xsl:stylesheet>
