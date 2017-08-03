<?php

namespace Shan\handlers;

use Shan\BaseHandler;
use Exception;

/**
* Page: serve and put together whole pages 
*/
class CatchAllHandler extends BaseHandler
{
  const PRIORITY = 0;

  function match($method, $uri, $contentType)
  {
    $matches = array(
      '/(.*)?$/'
      );

    return parent::matches($method, $uri, $contentType, $matches);
  }

  function GET()
  {
    $uri = $this->response->request->uri;
    $contentType = $this->response->request->contentType;

    if(file_exists($uri) && $contentType === "json") // IIS does not allow loading of json files
    {
      $this->response->doc = file_get_contents($uri);
      return $this->response->doc;
    }
    else
        throw new Exception("File not found", 404);
  }

  function POST()
  {
    throw new Exception("Access denied", 403);
  }
  function PUT()
  {
    throw new Exception("Access denied", 403);
  }
  function PATCH()
  {
    throw new Exception("Access denied", 403);
  }
  function DELETE()
  {
    throw new Exception("Access denied", 403);
  }
}

?>