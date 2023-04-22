<?php

require_once '../models/MailBoxModel.php';
require_once '../models/UserModel.php';
header("Content-Type: application/json; charset=utf-8");

// Get the HTTP method (GET, POST, PUT, or DELETE)
$method = $_SERVER['REQUEST_METHOD'];

$mail_box= new MailBox($_SESSION['user_id']);


// Handle the request
switch ($method) {
    case 'GET':
        $user=array("user_id"=>$_SESSION['user_id']);
        $data = array("data"=>$mail_box->inbox);
        $kq = array_merge($user,$data);
        echo json_encode($kq);
        break;

    case 'POST':
        $data = json_decode(file_get_contents('php://input'),true);
        switch ($data['type']) {
            case 'starred_mail':
                echo json_encode($mail_box->starred_mail);
                break;

            case 'sent_mail':
                echo json_encode($mail_box->sent_mail);
                break;

            case 'all_mail':
                echo json_encode($mail_box->all_mail);
                break;

            case 'trash_mail':
                echo json_encode($mail_box->trash_mail);
                break;

            case 'deleted_mail':
                echo json_encode($mail_box->deleted_mail);
                break;
                
            case 'archived_mail':
                echo json_encode($mail_box->archived_mail);
                break;
                
            case 'unread_mail':
                echo json_encode($mail_box->unread_mail);
                break;
            case 'log_out':
                echo '{"status":true,"msg":"Logged out successfully"}';
                session_unset();
                session_destroy();
                break;

            case 'send_mail':
                $user = new User();
                $receiver_id=$user->checkEmail($data['receiver']);
                if($receiver_id==false){
                    echo '{"status":false,"type":"user","msg":"Không tìm thấy email"}';
                    break;
                }

                if($mail_box->has_badword($data['content'])){
                    echo '{"status":false,"type":"badword","msg":"Chứa từ không hợp lệ"}';
                    break;
                }
                echo $receiver_id;
                $data['receiver']=$receiver_id;
                if($mail_box->createMail($data)){
                    echo '{"status":true,"type":"mail","msg":"Gửi thành công"}';
                    $mail_box->reloadMail();
                    break;
                }
                echo '{"status":true,"type":"mail","msg":"Gửi thất bại"}';
                break;
            default:
                break;
        }
        break;
    default:
        header('HTTP/1.1 405 Method Not Allowed');
        header('Allow: GET, POST, PUT, DELETE');
        break;
    }
?>
