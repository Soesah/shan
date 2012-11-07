<?xml version="1.0" encoding="UTF-8" ?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

	<xsl:output method="html" encoding="UTF-8" indent="yes"/>

	
  <xsl:template name="menu">
    <ul class="menu box">
      <!--li class="selected">
        <a href="/">
          <xsl:value-of select="string(title/chinese)"/>
          <xsl:text> </xsl:text>
          <xsl:value-of select="string(title/node()[last()])"/>
        </a>
      </li-->
      <li>
        <span>一 </span><a href="search.php" onclick="return setClass('content','search');">Search</a>
      </li>
      <li>
        <span>二 </span><a href="list.php" onclick="comm.send('content/words-of-the-day.php');return setClass('content','words-of-the-day');">Daily Words</a>
      </li>
      <li>
        <span>三 </span><a href="list.php" onclick="return setClass('content','list');">Characters</a>
        <!--sup ondblclick="document.location = 'checklist.php';">*</sup-->
      </li>
      <li>
        <span>四 </span><a href="add.php" onclick="shan.resetForm(document.getElementById('add-form'));return setClass('content','add');">Add</a>
      </li>
      <li>
        <span>五 </span><a href="text.php" onclick="return setClass('content','sentences');">Sentences</a>
      </li>
      <li>
        <span>六 </span><a href="add-sentence.php" onclick="shan.resetForm(document.getElementById('add-sentence-form'));return setClass('content','add-sentence');">Add</a>
      </li>
      <li>
        <span>七 </span><a href="sentences.php" onclick="return setClass('content','conversations');">Text</a>
      </li>
      <li>
        <span>八 </span><a href="content/downloads.php" onclick="comm.send(this.href);return setClass('content','downloads');">Download</a>
      </li>
    </ul>
  </xsl:template>

</xsl:stylesheet>
