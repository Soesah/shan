<?php

namespace Shan\util;

use DOMDocument;
use XSLTProcessor;

// 
//  xml.php
//  XML DOM functions for loading files, and doing transformations
//  
//  Created by Carl Giesberts on 2011-01-26.
//  

Class XMLUtil {
  function __construct(){}

  /*
   * Load an xml file from disk
   * Params: xml_file:path
   * Returns: DomDocument
   */
  static function getDOMDocument($xml_file) {
    $xml = new DOMDocument();
    $xml->load($xml_file);

    return $xml;  
  }

  /*
   * Transform an DomDocument.
   * Params: xml_dom:DomDocument, xsl_file:path, args:array
   * Returns: String
   */
  static function getDOMTransformation($xml_dom, $xsl_file, $args) {

    $xsl = self::getDOMDocument($xsl_file);
    $processor = new XSLTProcessor();
    for($i = 0; $i < count($args); $i=$i+2) {
      if(isset($args[$i]) && isset($args[$i+1]))
        $processor->setParameter('', $args[$i], $args[$i+1]);
    }
    $processor->importStylesheet($xsl);

    return $processor->transformToXML($xml_dom);
  }  


  /*
   * Transform
   * Params: xml_file:path, xsl_file:path, args:array
   * Returns: String
   */
  static function getTransformation($xml_file, $xsl_file, $args) {
    $xml = self::getDOMDocument($xml_file);
    return self::getDOMTransformation($xml, $xsl_file, $args);
  }

  /*
   * get the XML contents of a node, without the node itself, as an XML Fragment
   * Note: this function empties the node, and thus makes it pretty useless after calling this function
   */
  function getXMLContent($node) {
    $frag = $node->ownerDocument->createDocumentFragment(); 
    while($node->childNodes->item(0)) {
      $child = $node->childNodes->item(0);
      $frag->appendChild($child);
    }
    return $frag;
  }

  /*
   * Serialize a node
   * Params: node:DomNode
   * Returns: String
   */
  function serializeXML($node) {
    return $node->ownerDocument->saveXML($node);
  }

}
?>