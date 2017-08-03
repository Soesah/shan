<?php 

namespace Shan;

Class Logger {
  const LOGS_TABLE = 'docs_logs';
  /*
   * Log a message
   * Params message:string
   */
  public function logMessage($id, $message) {
    $query = 'INSERT INTO '.self::LOGS_TABLE.' (id, document_id, date, message) VALUES (null, \''.$id.'\', now(),\''.mysql_real_escape_string($message).'\')';
    $result = Database::query($query);
  }
}

?>