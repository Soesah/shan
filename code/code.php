<?php

	include 'client.class.php';
	include 'actions.php';

	$maxrandom = 11;

	function getTransformation($xml_file, $xsl_file, $args)
	{
		global $maxrandom;
	  $xml = new DOMDocument;
	  $xml->load($xml_file);

	  $processor = new XSLTProcessor();

	  $count = $xml->documentElement->getElementsByTagName("card")->length;
	
	  if($count > 0)
	    $maxrandom = $count;
	  array_push($args, "random", rand(1, $maxrandom));

		return getDOMTransformation($xml, $xsl_file, $args);
	}
	
	function getDOMTransformation($xml_dom, $xsl_file, $args)
	{
		global $maxrandom;
  	$xsl = new DOMDocument;
  	$xsl->load($xsl_file);

	  $processor = new XSLTProcessor();

	 	for($i = 0; $i < sizeof($args); $i=$i+2)
		  $processor->setParameter('', $args[$i], $args[$i+1]);

	  $processor->importStylesheet($xsl);

	  return $processor->transformToXML($xml_dom);
	}

	function getData()
	{
		$data = array();


		foreach($_GET as $key => $value)
	    array_push($data, $key, $value);

	  foreach($_POST as $key => $value)
	    array_push($data, $key, $value);

	  $client = new Client();
	  $os = $client->_get_os_info();

	  array_push($data, "os", $client->_browser_info["os"]);
	  array_push($data, "platform", $client->_browser_info["platform"]);
	  array_push($data, "browser", $client->_browser_info["browser"]);

		return $data;
	}

	function getXML($node)
	{
	   $doc= new DOMDocument;    
		 $doc->formatOutput = true;
	   $doc->encoding = "utf-8";

	   $doc->appendChild($doc->importNode($node,true));
	   return $doc->saveXML();
	}

	function processDirectory($dir, $handle, $dom, $parent, $elementname)
	{
	  while (false !== ($file = readdir($handle)))
	  {
			$childdir = $dir."/".$file;
			if($file == ".DS_Store"){}
			else if(!strstr($file, ".") && $childhandle = opendir($childdir))
			{
	      $child = $dom->createElement($file);
	      $parent->appendChild($child);
				processImgDirectory($childdir, $childhandle, $dom, $child);
			}
	    else if($file != "." && $file != ".." && $file != "Thumbs.db")
	    {
				$name = substr($file, 0, strpos($file, "."));
	      $child = $dom->createElement($elementname);
	      $text = $dom->createTextNode($name);
				$child->setAttribute("name",$file);
				$child->setAttribute("size",filesize($childdir));
				$child->setAttribute("date",date("Y.m.d H:i:s.",filemtime($childdir)));
	      $child->appendChild($text);
	      $parent->appendChild($child);
			}
	  }
	}

?>