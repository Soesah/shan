<?php

function sortwords()
{
  error_reporting(null);
  
  $file = "xml/shan.xml";
  $xml = DOMDocument::load($file);
  $xml->formatOutput = true;
  $xml->encoding = "utf-8";
  $xpath = new DOMXPath($xml);
  
  /* get words */
  $wordsNode =  $xpath->query("//words")->item(0);
  $words =  $xpath->query("//word");
    
  foreach($words as $word)
  {
    $random = rand(0,200);
    $refNode = $xpath->query("//word")->item($rand);  
        
    $wordsNode->insertBefore($word, $refNode);
    
    if($refNode->previousSibling != $word)
      $wordsNode->appendChild($word);
  }
  
  $xml->save($file);
  
  error_reporting(E_ALL & ~E_NOTICE);
}

?>