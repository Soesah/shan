<?php

	$xmlstr = file_get_contents('php://input');

	$dom = new domDocument;
	$dom->formatOutput = true;
  $dom->encoding = "utf-8";

  
  $xml = DOMDocument::load("../xml/shan.xml");
  $xml->formatOutput = true;
  $xml->encoding = "utf-8";
  $xpath = new DOMXPath($xml);
  
  
  $file = "../xml/".$_GET["file"];
  /*$fh = fopen($file, 'w') or die("can't open file");
  fwrite($fh, $xmlstr);
  fclose($fh);
  */
  
	if($dom->loadXML($xmlstr))
  { 
    $words =    $xml->documentElement->getElementsByTagName("words")->item(0);
    $newword =  $dom->documentElement->getElementsByTagName("word")->item(0);
    
    $id = $newword->getAttribute("id");
    $oldword = $xpath->query("//word[@id = '".$id."']")->item(0);
    
    $newword = $xml->importNode($newword,true);

    if($oldword)
      $words->replaceChild($newword, $oldword);
    else   
      $words->appendChild($newword);
    
    echo $xml->saveXML();
    
    $saved = $xml->save($file);
  }

?>