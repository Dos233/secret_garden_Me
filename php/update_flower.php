<?php
error_reporting(0);
include_once ("../dbconnect.php");

$name = $_POST['name']; 
$duration = $_POST['duration'];
$characters = $_POST['characters'];
$position = $_POST['position'];
$description = $_POST['description'];

$sql = "UPDATE FLOWER SET DURATION = '$duration', CHARACTERS = '$characters', POSITION = '$position', DESCRIPTION = '$description' WHERE NAME = '$name'";
if ($conn->query($sql) === true){
    echo 'success';
}

?>
