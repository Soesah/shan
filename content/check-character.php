<?php

  $xml = DOMDocument::load("../xml/shan.xml");
  $xml->formatOutput = true;
  $xml->encoding = "utf-8";
  $xpath = new DOMXPath($xml);
  
  
  
  $word = $xpath->query("//word[characters = '".$_GET["w"]."' or character = '".$_GET["w"]."']")->item(0);
  
  echo "<div id=\"script\"><span>document.getElementById('double').style.display='";
  if($word)
  {
    echo "block";
  }
  else
    echo "none";
  echo "';</span></div>";
?>