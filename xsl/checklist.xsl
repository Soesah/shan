<?xml version="1.0" encoding="UTF-8" ?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

	<xsl:output method="html" encoding="UTF-8" indent="yes"/>

  <xsl:template match="shan">
    <html>
      <head>
        <title>Check List</title>
        <style>
          body, td
          {
            font-family:verdana;
            font-size:0.8em;
          }
          td
          {
            border:solid 1px lightgrey;
            text-align:center;
          }

          .character
          {
            color:darkred;
            font-weight:bold;
            font-size:1.5em;
          }
          .character a
          {
            text-decoration:none;
            color:darkred;
          } 
          .page
          {
            color:lightgrey;
          }
          .position
          {
            color:lightgrey;
          }
          .pinyin
          {
            font-weight:bold;
            color:gray;
          }
          .order
          {

          }
          .text
          {

          }
          
          .occurs
          {
            font-size:1em;
          }
          
          .occurs a
          {
            text-decoration:none;
            color:darkred;
          }

        </style>
      </head>
      <body>
        <xsl:apply-templates select="words"/>        
      </body>
    </html>
  </xsl:template>

  <xsl:template match="words">
    <h2>words <xsl:value-of select="count(word)"/>
  </h2>
    <table border="0" cellpadding="4" cellspacing="2" width="400px;">
      <!--xsl:apply-templates select="word[pinyin[not(@order-string) or not(@text) or @text = ''] or character[not(@page) or not(@position)]]"/-->
      <xsl:apply-templates select="word"/>
    </table>   
  </xsl:template>

  <xsl:template match="word">
    <xsl:for-each select="character">
      <tr>
        <td valign="middle" width="50" class="character">
          <a href="index.php?id={../@id}&amp;item=edititem">
            <xsl:value-of select="."/>
          </a>
        </td>
        <td valign="top" class="page">
          <xsl:if test="not(@page)">
            <b style="color:darkred;">missing</b>
          </xsl:if>
          <xsl:value-of select="@page"/>
        </td>
        <td valign="top" class="position">
          <xsl:if test="not(@position)">
            <b style="color:darkred;">missing</b>
          </xsl:if>
          <xsl:value-of select="@position"/>
        </td>
        <td valign="middle" class="occurs">
          <xsl:apply-templates select="//word[character[. = current()/.]]" mode="link"/>
        </td>
      </tr>
    </xsl:for-each>
    <tr>
      <td valign="top" class="">
        <xsl:value-of select="@batch"/>
      </td>
        <td valign="top" class="pinyin">
        <xsl:value-of select="pinyin"/>
      </td>
      <td valign="top" class="order">
        <xsl:if test="not(pinyin/@order-string)">
          <b style="color:darkred;">missing</b>
        </xsl:if>
        <xsl:value-of select="pinyin/@order-string"/>
      </td>
      <td valign="top" class="text">
        <xsl:if test="not(pinyin/@text)">
          <b style="color:darkred;">missing</b>
        </xsl:if>
        <xsl:if test="pinyin/@text = ''">
          <b style="color:darkred;">empty</b>
        </xsl:if>
        <xsl:value-of select="pinyin/@text"/>
      </td>
    </tr>
  </xsl:template>

  <xsl:template match="word" mode="link">
    <a href="index.php?id={@id}&amp;item=edititem">
      <xsl:apply-templates select="character"/>
    </a>
    <xsl:if test="position() != last()">
      <xsl:text>, </xsl:text>
    </xsl:if>
  </xsl:template>
  
</xsl:stylesheet>
