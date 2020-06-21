<?php
error_reporting(0);
include_once ("dbconnect.php");
$name = $_POST['name'];


if (isset($name)){
   $sql = "SELECT * FROM FLOWER WHERE NAME LIKE  '%$name%'";
}else{
    $sql = "SELECT * FROM FLOWER";    
}


$result = $conn->query($sql);

if ($result->num_rows > 0)
{
        $response["flowers"] = array();
    while ($row = $result->fetch_assoc())
    {
        $flowerlist = array();
        $flowerlist["ID"] = $row["ID"];
        $flowerlist["NAME"] = $row["NAME"];
        $flowerlist["DURATION"] = $row["DURATION"];
        $flowerlist["CHARACTERS"] = $row["CHARACTERS"];
        $flowerlist["POSITION"] = $row["POSITION"];
        $flowerlist["DESCRIPTION"] = $row["DESCRIPTION"];
        array_push($response["flowers"], $flowerlist);
    }
    echo json_encode($response);
}
else
{
    echo "nodata";
}
?>