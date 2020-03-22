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
    $mail->CharSet ="UTF-8";                     //设定邮件编码
    $mail->SMTPDebug = 0;                        // 调试模式输出
    $mail->isSMTP();                             // 使用SMTP
    $mail->Host = 'smtp.163.com';                // SMTP服务器
    $mail->SMTPAuth = true;                      // 允许 SMTP 认证
    $mail->Username = 'lossyforme';                // SMTP 用户名  即邮箱的用户名
    $mail->Password = 'qaz147';             // SMTP 密码  部分邮箱是授权码(例如163邮箱)
    $mail->SMTPSecure = 'ssl';                    // 允许 TLS 或者ssl协议
    $mail->Port = 465;                            // 服务器端口 25 或者465 具体要看邮箱服务器支持

    $mail->setFrom('lossyforme@163.com', 'MY.Garden');  //发件人
    $mail->addAddress($email);  // 收件人
   
    //Content
    $mail->isHTML(true);                                  // 是否以HTML文档格式发送  发送后客户端可直接显示对应HTML内容
    $mail->Subject = 'Your email have registered successfully!';
    $mail->Body    = '<h1>You have registered !</h1>'.'<div>Your email: <div>'.$email.'<p><p>' .'<div>Registered date: <div>'. date('Y-m-d H:i:s');

    $mail->send();
} catch (Exception $e) {
    echo 'Send failed: ', $mail->ErrorInfo;
}

?>
