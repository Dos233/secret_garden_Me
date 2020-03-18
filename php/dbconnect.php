<?php
$servername = "localhost";
$username   = "lossy";
$password   = "k5RHEK8BcidsWDbF";
$dbname     = "lossy";

$conn = new mysqli($servername, $username, $password, $dbname);
if ($conn->connect_error) {
    die("Connection failed: " . $conn->connect_error);
}
?>
