<?php 

namespace Shan\Models

use Shan/BaseModel;

class WordModel extends BaseModel {
  function __construct($node) {
    parent::__construct($id);

    $this->id = $this->node->getAttribute('id');
    $this->batch = $this->node->getAttribute('batch');
  }
}

 ?>