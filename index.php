<?php

  include 'code/code.php';
  header("Content-type: text/html");
  header("Content-Encoding: gzip");

  ob_start('ob_gzhandler') ;

  echo getTransformation("xml/shan.xml", "xsl/default.xsl", getData());

?>