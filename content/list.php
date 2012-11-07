<?php

  include '../code/code.php';
	
	header("Content-type: text/html");

  $dom = new DOMDocument();
	$dom->formatOutput = true;
  $dom->encoding = "utf-8";
	$dom->load("../xml/shan.xml");
	$xpath = new DOMXPath($dom);
  
  $words = $xpath->query("//words/word");
  
	$count = $words->length;
	
  foreach($words as $word)
	{	
		$rand =  rand(1, $count);
		
		$sibling =  $xpath->query("//words/word")->item($rand);
		if($sibling != null && $word != null)
			 $xpath->query("//words")->item(0)->insertBefore($sibling, $word);
		echo $word->nodeType." - ".$sibling->nodeType."(".$rand.")<br/>";
	}
	$args = getData();
	array_push($args, "id", "");
	array_push($args, "item", "random-list");
  
  //echo getDOMTransformation($dom, "../xsl/default.xsl", $args);

?>