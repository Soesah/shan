<?php 

namespace Shan\handlers;

use Shan\BaseHandler;

/**
* Cleanup, removes certain files
*/
class CleanupHandler extends BaseHandler
{
  const PRIORITY = 1;

  function match($method, $uri, $contentType)
  {
    $matches = array(
      '/clean\.(json)/'
      );

    return parent::matches($method, $uri, $contentType, $matches);
  }

  function GET()
  {
    if (!Settings::debug)
    {
      $files = array();
      $dirs = array('css', 'js');
      foreach ($dirs as $path)
      {
        if (!is_dir($path))
          continue;
        $handle = opendir($path);
        while (false !== ($file = readdir($handle)))
        {
          $childdir = $path."/".$file;
          if (is_file($childdir) && preg_match("/((account.min.))/", $childdir) && preg_match("/^((?!".Settings::getVersion().").)*$/", $childdir))
          {
            array_push($files, $childdir);
            unlink($childdir);
          }
        }
      }
      if (count($files) !== 0)
        return '{"status":"success","message":"Clean up complete","data":'.json_encode($files).'}';
      else
        return '{"status":"success","message":"Deploy is clean","data":[]}';

    }
    else
      throw new Exception("Clean up does not work in debug mode", 500);

  }
}

 ?>