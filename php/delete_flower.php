<?php
error_reporting(0);
include_once ("../dbconnect.php");

$name = $_POST['name']; 


$sql = "DELETE FROM FLOWER WHERE NAME = '$name'";
if ($conn->query($sql) === true){
    echo 'success';
}
?>