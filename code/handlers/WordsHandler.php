<?php 

namespace Shan\handlers;

use Shan\BaseHandler;
use Shan\Util\XMLUtil;
use Exception;
use DOMXPath;

/**
* Word Request Handler
*/
class WordsHandler extends BaseHandler {
  const PRIORITY = 1;

  function match($method, $uri, $contentType) {
    $matches = array(
      '/words/'
      );

    return parent::matches($method, $uri, $contentType, $matches);
  }

  function POST() {
    throw new Exception('Bad request, nothing to save', 400);
  }

  function GET() {

    return $this->loadWords();

    throw new Exception('Not supported', 405);
  }

  function PUT() {
    throw new Exception('Bad request, no id provided', 400);
  }

  function loadWords() {
    $doc = XMLUtil::getDOMDocument('data/data.xml');
    // $xpath = new DOMXPath($doc);

    // $words = $xpath->query('//words/word');

    // $arr = array();
    // foreach ($words as $word) {
    //   array_push($arr, array($word->getAttribute('id') => $word->getAttribute('batch')));
    // }
    // return $arr;
    return XMLUtil::getDOMTransformation($doc, 'data/xsl/words.xsl', null);
  }
}

?>