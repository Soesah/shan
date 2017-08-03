<?php 

namespace Shan;

use Exception;

/**
* Response: match a request to a handler and a build a response
*/
class Response {
  function __construct() {
    //start sessions
    session_start();

    $this->UTFEncoding();

    // parse the request
    $this->request = new Request();

    $this->handleRequest();
  }

  /* Request Handling */
  function handleRequest() {
    $contents;

    $factory = new HandlerFactory();
    $this->handler = $factory->getHandler($this, $this->request);

    // try to get contents from the handler
    try {
      $contents = call_user_method($this->request->method, $this->handler); 
      $this->writeResponse($contents);
    } catch (Exception $e) {
      $contents = $this->formatError($e);
      $this->writeResponse($contents, true);
    }

  }

  function writeResponse($contents, $isError = false) {
    $this->GZIPCompress();
    switch ($this->request->contentType) {
      case 'css':
      $this->CSSContentType();
      $this->renderText($contents);
      break;
      case 'js':
      $this->JavaScriptContentType();
      $this->renderText($contents);
      break;
      case 'json':
      $this->JSONContentType();
      if (is_string($contents))
        $this->renderJSONResponse($contents, $isError);
      else if ($contents instanceof DOMDocument)
        $this->renderJSONFromXML($contents);
      else if ($contents instanceof DOMDocument)
        $this->renderJSON($contents);
      break;
      case 'xml':
      $this->XMLContentType();
      $this->renderXML();
      break;
      default:
      $this->TextContentType();
      $this->renderText($contents);
      break;
    }
    echo $this->rendering;
  }

  function redirect($target) {
    header('location:'.$target);
    exit();
  }

  /* Rendering */
  private function renderText($contents) {
    $this->rendering = $contents;
  }

  private function renderXML() {
    $this->rendering = $this->doc->saveXML();
  }

  private function renderJSONFromXML($xml) {
    $json = array();
    $json[$xml->documentElement->nodeName] = $this->transformXMLtoJSON($json, $xml->documentElement);;
    $this->rendering = json_encode($json, JSON_PRETTY_PRINT);
  }

  private function renderJSON($contents) {
    $this->rendering = json_encode($contents, JSON_PRETTY_PRINT);
  }

  private function renderJSONResponse($str, $isError) {
    $status = ($isError) ? 'error' : 'success';
    $this->rendering = '{"status":"'.$status.'" ,"data":'.$str.'}';
  }

  private function formatError($e) {
    $code = $e->getCode();
    header("HTTP/1.1 ".$code);
    $message = $e->getMessage();

    if ($this->request->contentType === "json")
      return '{"message":"'.$message.'"}';
    else if ($this->request->contentType === "css")
      return "/* ".$message." */";
    else if ($this->request->contentType === "js")
      return "throw new Error('".$message."');";
    else
      return $message;
  }

  /* Encoding */
  private function UTFEncoding() {
    header('Content-Encoding: utf-8');
  }
  
  /* ContentType headers */
  private function TextContentType() {
    self::AddContentTypeHeader('text/plain');
  }

  private function HTMLContentType() {
    self::AddContentTypeHeader('text/html');
  }

  private function XHTMLContentType() {
    self::AddContentTypeHeader('application/xhtml+xml');
  }

  private function XMLContentType() {
    self::AddContentTypeHeader('application/xml');
  }

  private function CSSContentType() {
    self::AddContentTypeHeader('text/css');
  }

  private function JavaScriptContentType() {
    self::AddContentTypeHeader('text/javascript');
  }

  private function JSONContentType() {
    self::AddContentTypeHeader('application/json');
  }

  private function ImageContentType($type='png') {
    self::AddContentTypeHeader('image/'.$type);
  }

  private function AddContentTypeHeader($contentType) {
    header('Content-type: '.$contentType.'; charset=utf-8');
  }

  /* Page Gzip Compression */
  public function GZIPCompress() {
    if (extension_loaded('zlib') && (ini_get('output_handler') != 'ob_gzhandler')) {
      ini_set('zlib.output_compression', 1);
    } else {
      header('Content-Encoding: gzip');
      ob_start('ob_gzhandler');
    }
  }

  /* Cache headers */
  public function AddCacheHeader($total_days = 1, $file = null) {
    header('Cache-Control: public max-age: '. (24*60*60* $total_days));
    header('Expires: ' . gmdate('D, d M Y H:i:s', time()+24*60*60* $total_days) . ' GMT');
    header('Pragma: public');
    if ($file != null && file_exists($file)) {
      header('Last-Modified: '.gmdate('D, d M Y H:i:s', filemtime($file)) . ' GMT');
    }
  }

  public function AddEtagHeader($file) {
    // create an etag token
    $etag = md5($file);

    header('Etag:'.$etag);
  }

  public function getParam($name) {
    return $this->request->getParameter($name);
  }
}

?>