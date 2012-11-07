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
    $sentences =    $xml->documentElement->getElementsByTagName("sentences")->item(0);
    $newsentence =  $dom->documentElement->getElementsByTagName("sentence")->item(0);
    
    $id = $newsentence->getAttribute("id");
    $oldsentence = $xpath->query("//sentence[@id = '".$id."']")->item(0);
    
    $newsentence = $xml->importNode($newsentence,true);

    if($oldsentence)
      $sentences->replaceChild($newsentence, $oldsentence);
    else   
      $sentences->appendChild($newsentence);
    
    $saved = $xml->save($file);
  }

?>