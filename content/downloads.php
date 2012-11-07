<?php

  include '../code/code.php';

	date_default_timezone_set("Europe/Amsterdam");


  	header("Content-type: text/html");
  	header("Content-Encoding: gzip");

  	ob_start('ob_gzhandler') ;

	$dir = "../downloads";

	$dom = new DomDocument();
	$dom->formatOutput = true;
	$dom->encoding = "utf-8";
	$root = $dom->createElement("downloads");

	$dom->appendChild($root);

	if ($handle = opendir($dir)) 
	{
		processDirectory($dir, $handle, $dom, $root, "file");
	}
	else
	{
	  echo "<error>Could not read ".$handle."</error>";
	}

	closedir($handle);

  echo getDOMTransformation($dom, "../xsl/pages.xsl", getData());

?>