<?php 

namespace Shan;

//get root folder
global $root;
$root = $_SERVER['DOCUMENT_ROOT'];

//set default time zone for date functions
date_default_timezone_set('Europe/Amsterdam');

class Settings {
  const path = '/shan/';
  const debug = True;

  protected static $version = null;

  static function getVersion() {
    if (!isset(self::$version)) {
      global $root;
      $json = json_decode(file_get_contents($root.self::path.'settings.json'), true);
      self::$version = $json['version'];
    }
    return self::$version;
  }
}

if (Settings::debug) {
  ini_set('display_errors', '1');
}

?>