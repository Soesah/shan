<?php 

namespace Shan;

/**
* Handler: connect objects in the database with a url
*/
class BaseHandler {
  const URL_MATCH = null;

  function __construct($response) {
    $this->response = $response;
  }

  static function matches($method, $uri, $contentType, $matches) {
    foreach ($matches as $match) {
      if(preg_match($match, $uri))
        return true;
    }
    return false;
  }

  function GET() {
    throw new Exception(get_class($this). ' does not implement method GET');
  }

  function POST() {
    throw new Exception(get_class($this). ' does not implement method POST');
  }

  function PUT() {
    throw new Exception(get_class($this). ' does not implement method PUT');
  }

  function PATCH() {
    throw new Exception(get_class($this). ' does not implement method PATCH');
  }

  function DELETE() {
    throw new Exception(get_class($this). ' does not implement method DELETE');
  }

  // parameter methods
  protected function getParam($name, $default = null) {
    $param = $this->response->getParam($name);
    if ($param)
      return $param;
    return $default;
  }
}

 ?>