<?php
error_reporting(0);
include_once ("../dbconnect.php");
$id = $_POST['id'];
$name = $_POST['name']; 
$duration = $_POST['duration'];
$characters = $_POST['characters'];
$position = $_POST['position'];
$description = $_POST['description'];

$encoded_string = $_POST["encoded_string"];
$decoded_string = base64_decode($encoded_string);
$path = './'.$id.'.jpg';
file_put_contents($path, $decoded_string);

$sql = "INSERT INTO FLOWER VALUES('$id','$name','$duration','$characters','$position','$description')";
if ($conn->query($sql) === true){
    echo 'success';
}

?>
