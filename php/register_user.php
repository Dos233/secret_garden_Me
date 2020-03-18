<?php
use PHPMailer\PHPMailer\PHPMailer;
use PHPMailer\PHPMailer\SMTP;
use PHPMailer\PHPMailer\Exception;

error_reporting(0);
include_once ("dbconnect.php");
// Load Composer's autoloader
require 'vendor/autoload.php';
$mail = new PHPMailer(true);

$name = $_POST['name'];
$email = $_POST['email'];
$phone = $_POST['phone'];
$password = sha1($_POST['password']);

$sqlinsert = "INSERT INTO USER(NAME,EMAIL,PASSWORD,PHONE) VALUES ('$name','$email','$password','$phone')";

if ($conn->query($sqlinsert) === true)
{
    echo "success";

}
else
{
    echo "failed";
}

    try {
    //服务器配置
    $mail->CharSet ="UTF-8";
    $mail->SMTPDebug = 0;
    $mail->isSMTP();
    $mail->Host = 'smtp.163.com';
    $mail->SMTPAuth = true;
    $mail->Username = 'lossyforme';
    $mail->Password = 'qaz147';
    $mail->SMTPSecure = 'ssl';
    $mail->Port = 465;

    $mail->setFrom('lossyforme@163.com', 'MY.Garden'); //sender
    $mail->addAddress($email);  // receiver
   
    //Content
    $mail->isHTML(true);                                  // Whether to send in HTML document format The client can directly display the corresponding HTML content after sending
    $mail->Subject = 'You have registered !' . time();
    $mail->Body    = '<h1>You have registered !</h1>' . date('Y-m-d H:i:s');

    $mail->send();
} catch (Exception $e) {
    echo 'Send failed: ', $mail->ErrorInfo;
}

?>
