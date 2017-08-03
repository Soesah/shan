<?php 

namespace Shan;

/**
* Request: an API for information about the request
*/
class Request {
  function __construct() {
    $this->uri = $this->getRequestURI();
    $this->method = $this->getRequestMethod();
    $this->contentType = 'json';

    $this->parseURI();
    $this->parseRequestParameters();
  }

  // request URI
  private function getRequestURI() {
    return substr($_SERVER['REQUEST_URI'], strlen(Settings::path), strlen($_SERVER['REQUEST_URI']));
  }

  // request method
  private function getRequestMethod() {
    return $_SERVER['REQUEST_METHOD'];
  }

  private function parseURI() {
    $parts = split('/', $this->uri);

    // never mind the handler
    array_shift($parts);

    $this->parseURIParameters($parts);
  }

  // parameter methods
  private function parseURIParameters($parts) {

    $this->id = null;
    $this->actions = array();

    if (count($parts) > 1) {    
      $first = $parts[0];

      if (is_numeric($first)) {
        $this->id = intval($first);
        array_shift($parts);
      }

      for($i=0; $i<count($parts); $i+=2) {
        $value = $parts[$i + 1];
        if (!isset($value)) {
          $value = True;
        }
        if ($parts[$i] !== '') {
          $this->actions[$parts[$i]] = $value;
        }
      }
    }
  }

  private function parseRequestParameters() {
    $data = array();

    if (isset($_SESSION)) {
      foreach($_SESSION as $key => $value) {
        $data[$key] = $value;
      }
    }
    foreach($_GET as $key => $value) {
      $data[$key] = $value;
    }

    foreach($_POST as $key => $value) {
      $data[$key] = $value;
    }

    // form data
    if ($this->method === 'PUT') {
      foreach ($this->getPUTrequestParameters() as $key => $value) {
        $data[$key] = $value;
      }
    }
    $this->parameters = $data;
  }

  private function getPUTrequestParameters() {
    $data = array();

    // Fetch content and determine boundary
    $raw_data = file_get_contents('php://input');
    $boundary = substr($raw_data, 0, strpos($raw_data, "\r\n"));

    if (!$raw_data) {
      return $data;
    }
    // Fetch each part
    $parts = array_slice(explode($boundary, $raw_data), 1);

    foreach ($parts as $part) {
        // If this is the last part, break
      if ($part == '--\r\n') break;

        // Separate content from headers
      $part = ltrim($part, "\r\n");
      list($raw_headers, $body) = explode("\r\n\r\n", $part, 2);

        // Parse the headers list
      $raw_headers = explode("\r\n", $raw_headers);
      $headers = array();
      foreach ($raw_headers as $header) {
        list($name, $value) = explode(':', $header);
        $headers[strtolower($name)] = ltrim($value, ' ');
      } 
        // Parse the Content-Disposition to get the field name, etc.
      if (isset($headers['content-disposition'])) {
        $filename = null;
        preg_match(
          '/^(.+); *name="([^"]+)"(; *filename="([^"]+)")?/',
          $headers['content-disposition'],
          $matches
          );
        list(, $type, $name) = $matches;
        isset($matches[4]) and $filename = $matches[4];

            // handle your fields here
        switch ($name) {
                // this is a file upload
          case 'userfile':
          file_put_contents($filename, $body);
          break;

                // default for all other files is to populate $data
          default:
          $data[$name] = substr($body, 0, strlen($body) - 2);
          break;
        }
      }
    }

    return $data;
  }

  public function hasParameter($key) {
    return isset($this->parameters[$key]);
  }

  public function setParameter($key, $value) {
    return $this->parameters[$key] = $value;
  }

  public function getParameter($key) {
    if ($this->hasParameter($key)) {
      return $this->parameters[$key];
    }
    return null;
  }

  public function getParameters() {
    return $this->parameters;
  }
}

?>