<?php
header('Content-Type: application/json');
echo json_encode([
  "status" => "Backend API active",
  "project" => "P & C Developers Builder 204",
  "timestamp" => date("Y-m-d H:i:s")
]);
?>
