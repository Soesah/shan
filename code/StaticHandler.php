<?php 

namespace Shan;

/**
* Static, used to serve CSS, JS, fonts, images, etc.
* Has logic to create a cacheable copy
*/
class StaticHandler extends BaseHandler {

  function __construct($response) {
    parent::__construct($response);
  }

  // Store compiled output files, and serve them if they are requested and exist
  public function ServeStoredOutput($filename) {
    if (file_exists($filename)) {
      return file_get_contents($filename);
    } else {
      return False;
    }
  }

  public function StoreOutput($filename, $contents, $version_filter, $ext_filter) {
    // find a filter (using the website's version) for finding older stored files
    $filter = substr($filename, 0, strrpos($filename, $version_filter));
    if ($filter === '')
      throw new Exception('File not found', 404);

    // remove older files
    $older = glob($filter.$ext_filter);
    foreach ($older as $key => $file) {
      if ($file !== $filename)
        unlink($file);
    }
    if(!Settings::debug) {
      // write out the new file
      $f = fopen($filename, 'w+');
      fwrite($f, $contents);
      fclose($f);
    }
  }


  // Concat resources
  public function concatResources($resources) {
    $contents = '';
    foreach ($resources as $key => $resource) {
      $contents .= file_get_contents($resource);
    }
    return $contents;
  }
}

 ?>