<?php

  header("Content-type: text/css");
  header("Content-Encoding: gzip");

  ob_start('ob_gzhandler') ;

  include 'menu.css';
  include 'dialog.css';
  include 'page.css';
  include 'default.css';

?>