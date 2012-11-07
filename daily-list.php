<?php

  include '../code/code.php';

	date_default_timezone_set("Europe/Amsterdam");
	/*
	  load the words of the day file
	  calculate the date
	  check if a day with the date exists
	  if not, create the date with 10 random words, which do not occur in the day file
	  
	
	*/

	header("Content-type: text/html");
	header("Content-Encoding: gzip");

	ob_start('ob_gzhandler') ;
  
  $date = date("Y-m-d");
  
  function createDay($date, $s_dom, $w_dom)
  { 
    $s_xpath = new DOMXPath($s_dom);
    $w_xpath = new DOMXPath($w_dom);
    
    
    if($w_xpath->query("//day[@date='".$date."']")->length == 0)
    {
      if($w_xpath->query("//day")->length == 15)
      {
        $lastday = $w_xpath->query("//day[1]")->item(0);
        $w_dom->documentElement->removeChild($lastday);
      }      
      $day = $w_dom->createElement("day");
      $day->setAttribute("date", $date);
      $w_dom->documentElement->appendChild($day);
      
	    $maxrandom = $s_xpath->query("//word")->length;
	    
	    $words = 20;
	    
	    while($words > 0)
	    {
  	    $word = $s_xpath->query("//word[position() = ".rand(1, $maxrandom)."]")->item(0);
  	    $id = $word->getAttribute("id");
        if($w_xpath->query("//word[@id='".$id."']")->length == 0)
        {
          $word = $w_dom->importNode($word,true);
          $day->appendChild($word);
    	    
    	    //count down
    	    $words = $words -1;
        }
      }
      
    }
    
    return $w_dom;
  }

	$shan = new DomDocument();
  $shan->load("../xml/shan.xml");

	$dom = new DomDocument();
	$dom->formatOutput = true;
	$dom->encoding = "utf-8";
  $dom->load("daily-list.xml");
  
  $dom = createDay($date, $shan, $dom);

  $dom->save("daily-list.xml");

  echo getDOMTransformation($dom, "../xsl/daily-list.xsl", getData());
?>