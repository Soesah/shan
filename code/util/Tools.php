<?php

namespace Shan\util;

/*
 *  tools for many little things
 *  Created by Carl Giesberts on 2011-01-26.
 */

Class Tools {

  public static function leadingZero($value, $zeros = 2) {
    while(strlen($value) < $zeros)
      $value = '0'.$value;
    return $value;
  }

  public function is_assoc($array) {
    return (bool)count(array_filter(array_keys($array), 'is_string'));
  }


  /*
   * Create a tree of a directory structure. Function is recursive.
   * Params: dir:path, handle:DirectoryHandle, dom:DomDocument, parent:DomNode
   * Returns: DomDocument
   */
  public function processDirectory($dir, $handle, $dom, $parent) {
    while (false !== ($file = readdir($handle))) {
      $childdir = $dir."/".$file;
      if($file == ".DS_Store" || $file == "Thumbs.db"){

      } else if(!strstr($file, ".") && $childhandle = opendir($childdir)) {
        $child = $dom->createElement('directory');
        $child->setAttribute("name",$file);
        $parent->appendChild($child);
        self::processDirectory($childdir, $childhandle, $dom, $child);
      } else if($file != "." && $file != "..") {
        $name = substr($file, 0, strpos($file, "."));

        $child = $dom->createElement('file');
        $text = $dom->createTextNode($name);

        if(strstr($file, ".xml")) {
          $doc = new DOMDocument();
          $doc->load($childdir);
          $text = $dom->createTextNode($doc->getElementsByTagName('title')->item(0)->textContent);
          foreach($doc->documentElement->attributes as $name => $node) {
            $child->setAttribute($name, $node->value);
          }
        }

        $child->setAttribute("name",$file);
        $child->setAttribute("size",filesize($childdir));
        $child->setAttribute("date",date("Y.m.d H:i:s.",filemtime($childdir)));
        $child->appendChild($text);
        $parent->appendChild($child);
      }
    }
  }

  /*
   * Build a path of folders
   */

  public function ensureFolders($path) {
    if (!file_exists($path)) {
      mkdir($path, 0777, true);
    }
  }

  /*
   * Get a proper file structure name
   * Params: title:string, includesExtension:boolean
   * Returns: String
   */
  public function getIOName($name, $includesExtension = false) {
    if($includesExtension) {
      $ext = strtolower(substr($name, strrpos($name,'.')));
      $name = substr($name, 0, strrpos($name,'.'));
    }
    $name = trim($name);

    $a = array('/\ /','/\'/', '/\\\/', '/\//', '/\^/', '/\./', '/\$/', '/\|/','/\(/', '/\)/', '/\[/', '/\]/', '/\*/', '/\+/','/\?/', '/\{/', '/\}/', '/\,/');
    $b = array('_','_','_','_','_','_','_','_','_','_','_','_','_','_','_','_','_','_'); //18 items
    $name = preg_replace($a, $b, $name);
    $name = str_replace("__", "_", $name);

    while(substr($name, 0, 1) == '-') {
      $name = substr($name, 1);
    }

    while(substr($name, -1) == '-') {
      $name = substr($name, 0, strrpos($name, '-'));
    }

    if($includesExtension) {
      return strtolower($name).$ext;
    } else {
      return strtolower($name);
    }
  }
}
?>