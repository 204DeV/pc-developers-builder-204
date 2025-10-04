<?php
header('Content-Type: application/json');
echo json_encode([
  "status" => "Backend active",
  "project" => "P & C Developers Builder 204",
  "time" => date("Y-m-d H:i:s")
]);
?>
