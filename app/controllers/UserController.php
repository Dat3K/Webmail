<?php

// session_start();
require_once '../models/UserModel.php';
header("Content-Type: application/json; charset=utf-8");

// Get the HTTP method (GET, POST, PUT, or DELETE)
$method = $_SERVER['REQUEST_METHOD'];
$user= new User();


// Handle the request
switch ($method) {
    
    case 'GET':
        if(isset($_SESSION['user_id'])){
            echo json_encode($_SESSION['user_id']);
            break;
        }
        echo '{"msg":"Not found user"}';
        break;
        
    case 'POST':
        $data = json_decode(file_get_contents('php://input'));
        $user->set_email($data->email);
        
        // Xử lí login
        if($data->type=="login"){
            if($user->read_by_email()){
                if($data->password==$user->get_password()){
                    echo json_encode(array("status"=>true,"user"=>$user->get_user(),"msg"=>"Logged in successfully"));
                    $_SESSION['user_id']=$user->get_id();
                }else{
                    echo json_encode(array("status"=>false,"msg"=>"Incorrect password"));
                }
            }else{
                echo json_encode(array("status"=>false,"msg"=>"Invalid email"));
            }
            break;
        }

        // Xử lí register
        if($data->type=="register"){
            if(empty($data->username) || empty($data->password) || empty($data->email) || empty($data->re_password)){
                echo json_encode(array("status"=>false,"msg"=>"Please enter all required information")) ;
                break;
            }
            if(strlen($data->password)<4){
                echo json_encode(array("status"=>false,"msg"=>"Password must be more than 3 characters"));
                break;
            }
            if($data->password != $data->re_password){
                echo json_encode(array("status"=>false,"msg"=>"Confirm password does not match"));
                break;
            }
            if($user->read_by_email()==true){
                echo json_encode(array("status"=>false,"msg"=>"Email already exists"));
                break;
            }
            $user->set_username($data->username);
            $user->set_password($data->password);
            $user->set_email($data->email);
            if($user->create()==false){
                echo json_encode(array("status"=>false,"msg"=>"Register for failure"));
                break;
            }
            echo json_encode(array("status"=>true,"msg"=>"Successful registration"));
            break;
        }
        break;
    default:
        header('HTTP/1.1 405 Method Not Allowed');
        header('Allow: GET, POST, PUT, DELETE');
        break;
    }
?>
