<?php

namespace Shan;

use Shan\handlers\WordsHandler;

class HandlerFactory {

  public function getHandler($response, $request) {

    $method = $request->method;
    $uri = $request->uri;
    $contentType = $request->contentType;

    if (call_user_func(array(new WordsHandler($response), 'match'), $method, $uri, $contentType)) {
      return new WordsHandler($response);
    } else if (call_user_func(array(new CleanupHandler($response), 'match'), $method, $uri, $contentType)) {
      return new CleanupHandler($response);
    } else if (call_user_func(array(new CatchAllHandler($response), 'match'), $method, $uri, $contentType)) {
      return new CatchAllHandler($response);
    }

  }

}

?>