<?php
error_reporting(0);
include_once ("dbconnect.php");
$email = $_POST['email'];

if (isset($email)) {
$sql = "SELECT NAME,PHONE FROM USER WHERE EMAIL = '$email'";
}

$result = $conn->query($sql);

if ($result->num_rows > 0)
{
        $response["users"] = array();
    while ($row = $result->fetch_assoc())
    {
        $user = array();
        $user["NAME"] = $row["NAME"];
        $user["PHONE"] = $row["PHONE"];
        array_push($response["users"], $user);
    }
    echo json_encode($response);
}
else
{
    echo "nodata";
}
?>