<?php
    require_once 'Connection.php';
    class Mailbox {

        private $conn;
        private $id;        //
        public $max_id;    //  id lớn nhất
        public $inbox;  //  Gồm đã nhận và đã gửi
        public $all_mail;   //  Gồm tất cả thư
        public $receiver_mail;  // Thư đã nhận
        public $starred_mail;   //  Thư đánh dấu sao
        public $sent_mail;  //  Thư đã gửi
        public $trash_mail;     // Thư spam
        public $deleted_mail;   // Thư đã xoá
        public $archived_mail;  // Thư đã lưu
        public $unread_mail;    //  Thư chưa đọc


        public function __construct($id){
            $this->conn = DBConnection::getConnection();
            $this->id=$id;
            $this->reloadMail();
        }
        
        public function reloadMail(){
            $this->sent_mail = $this->getSentMail();
            $this->receiver_mail = $this->getReceivedMail();
            $this->inbox = array_merge($this->receiver_mail,$this->sent_mail);
            $this->trash_mail = $this->getTrashMail();
            $this->deleted_mail = $this->getDeletedMail();
            $this->archived_mail = $this->getArchivedMail();
            $this->all_mail = array_merge($this->inbox, $this->archived_mail, $this->trash_mail, $this->deleted_mail);
            $this->starred_mail = $this->getStarredMail();
            $this->unread_mail=$this->getUnreadMail();
            $this->max_id=$this->getMaxId();
        }

        // Hàm đọc mail theo đối tượng là sender or receiver
        private function getMailByType($user_type){
            $query = "SELECT m.*, s.email AS sender_email, r.email AS receiver_email, o.email AS original_sender_email 
            FROM mailbox m JOIN user s ON m.sender = s.id JOIN user r ON m.receiver = r.id
            LEFT JOIN user o ON m.original_sender = o.id 
            WHERE ".$user_type." = ? AND is_trash->>'$.".$user_type."' = '0' AND is_deleted->>'$.".$user_type."' = '0' AND is_archived->>'$.".$user_type."' = '0';";
            $stmt = $this->conn->prepare($query);
            $stmt->bind_param('s',$this->id);
            $stmt->execute();
            $result=$stmt->get_result();
            $datas = array();
            while ($row = $result->fetch_assoc()) {
                foreach ($row as $key => $value) {
                    if($key == "is_read" || $key == "is_starred" ||$key == "is_archived" ||$key == "is_trash" ||$key == "is_deleted"){
                        $data=json_decode($value,true);
                        $row[$key]=$data[$user_type];
                    }
                }
                $datas[]=$row;
            }
            return $datas;
        }

        private function getReceivedMail()    
        {
            return $this->getMailByType('receiver');
        }
        
        // Hàm đọc mail đánh dấu sao
        private function getStarredMail(){
            $data = array();
            foreach ($this->all_mail as $value) {
                if($value['is_starred']=="1"){
                    $data[]=$value;
                }
            }
            return $data;
        }

        // Lấy mail đã gửi
        private function getSentMail(){
           return $this->getMailByType("sender");
        }

        // Lấy mail rác
        private function getTrashMail()
        {
            return $this->typeMail("is_trash");
        }
        
        // Lấy mail đã xoá
        private function getDeletedMail()
        {
            return $this->typeMail("is_deleted");
        }

        // Lấy mail đã lưu
        private function getArchivedMail()
        {
            return $this->typeMail("is_archived");
        }

        private function getUnreadMail()
        {
            $data=array();
            foreach ($this->inbox as $value) {
                if($value['is_read']==1){
                    $data[]=$value;
                }
            }
            return $data;
        }

        // lấy mail theo loại mail
        private function typeMail($typeMail)
        {
            $query = "SELECT m.*, s.email AS sender_email, r.email AS receiver_email, o.email AS original_sender_email 
            FROM mailbox m JOIN user s ON m.sender = s.id JOIN user r ON m.receiver = r.id
            LEFT JOIN user o ON m.original_sender = o.id 
            WHERE (receiver = ? AND ".$typeMail."->>'$.receiver' = '1') OR (sender = ? AND ".$typeMail."->>'$.sender' = '1');";
            $stmt = $this->conn->prepare($query);
            $stmt->bind_param('ss',$this->id,$this->id);
            $stmt->execute();
            $result=$stmt->get_result();
            $datas = array();
            $typeUser="";
            while ($row = $result->fetch_assoc()) {
                foreach ($row as $key => $value) {
                    if($key == "receiver" && $value==$this->id){
                        $typeUser="receiver";
                    }
                    if($key == "sender" && $value==$this->id){
                        $typeUser="sender";
                    }
                    if($key == "is_read" || $key == "is_starred" ||$key == "is_archived" ||$key == "is_trash" ||$key == "is_deleted"){
                        $data=json_decode($value,true);
                        $row[$key]=$data[$typeUser];
                    }
                }
                $datas[]=$row;
            }
            return $datas;
        }

        // hàm tạo mail
        public function getMaxId()    
        {
            $query = "SELECT MAX(CAST(SUBSTRING(id, 2) AS UNSIGNED)) AS max_id FROM mailbox WHERE id REGEXP '^M[0-9]+$';";
            $result = $this->conn->query($query);
            if ($result->num_rows > 0) {
                $row = $result->fetch_assoc();
            }
            return $row["max_id"];
        }   

        public function checkEmail($email) {
            $query = "SELECT id FROM user WHERE email = ?";
            $stmt = $this->conn->prepare($query);
            $stmt->bind_param('s', $email);
            $stmt->execute();
            $result = $stmt->get_result();
            $row = $result->fetch_assoc();
            return ($row) ? $row['id'] : false;
        }

        public function createMail($data=array())
        {
            $new_id="M".$this->max_id+1;
            $query="INSERT INTO mailbox(id, sender, receiver, original_sender, subject, content, is_read, is_starred, is_archived, is_trash, is_deleted) VALUES 
            (?, ?, ?, null, ?, ?, '{\"original_sender\":0,\"receiver\":0,\"sender\":0}', '{\"original_sender\":0,\"receiver\":0,\"sender\":0}', '{\"original_sender\":0,\"receiver\":0,\"sender\":0}', '{\"original_sender\":0,\"receiver\":0,\"sender\":0}', '{\"original_sender\":0,\"receiver\":0,\"sender\":0}');";
            $stmt = $this->conn->prepare($query);
            if(!$stmt->bind_param('sssss',$new_id,$this->id,$data['receiver'],$data['subject'],$data['content']))
            return false;
            return $stmt->execute();
        } 

        function has_badword($str) {
            $url = 'https://api1.webpurify.com/services/rest/';
            $method = 'webpurify.live.check';
            $format = 'json';
            $api_key = '3a0d813ccb7c3c1bc3a13043037543ce';
            $request_url = $url . '?method=' . $method . '&format=' . $format . '&api_key=' . $api_key . '&text=' . urlencode($str);
            $response = file_get_contents($request_url);
            $data = json_decode($response, true);
            $found = (int) $data['rsp']['found'];
            if ($found > 0) {
                return true;
            } else {
                return false;
            }

        }                       
    }
?>
