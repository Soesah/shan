<?php

  header("Content-type: text/javascript");
  header("Content-Encoding: gzip");

  ob_start('ob_gzhandler') ;

  include 'general.js';
  include 'comm.js';
  include 'pinyin.js';
  include 'uuid.js';
  include 'shan.js';

?>