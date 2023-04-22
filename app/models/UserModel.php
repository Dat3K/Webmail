<?php
    require_once 'Connection.php';
    

    class User {
        private $conn;
        private $table_name = "user";
       
        private $id;
        private $username;
        private $email;
        private $password;
        private $created_at;
        private $locked;
       
        public function __construct(){
           $this->conn=DBConnection::getConnection();
        }

        public function get_user()
        {
          return array("id"=>$this->id,"username"=>$this->username,"password"=>$this->password,"create_at"=>$this->create_at,"locked"=>$this->locked);
        }

        public function set_user($data=array())  
        {
          $this->id=$data['id'];
          $this->username=$data['username'];
          $this->email=$data['email'];
          $this->password=$data['password'];
          $this->create_at=$data['created_at'];
          $this->locked=$data['locked'];
        }

        public function get_id() {
          return $this->id;
        }
    
        public function set_id($id) {
            $this->id = $id;
        }
    
        public function get_username() {
            return $this->username;
        }
    
        public function set_username($username) {
            $this->username = $username;
        }
    
        public function get_email() {
            return $this->email;
        }
    
        public function set_email($email) {
            $this->email = $email;
        }
    
        public function get_password() {
            return $this->password;
        }
    
        public function set_password($password) {
            $this->password = $password;
        }
    
        public function get_created_at() {
            return $this->created_at;
        }
    
        public function set_create_at($created_at) {
            $this->created_at = $created_at;
        }  

        public function get_locked() {
          return $this->locked;
        }
    
        public function set_locked($locked) {
            $this->locked = $locked;
        }  

        public function create(){
          $query = "INSERT INTO " . $this->table_name . " SET username=?, email=?, password=?";
      
          $stmt = $this->conn->prepare($query);
      
          $this->username=htmlspecialchars(strip_tags($this->username));
          $this->email=htmlspecialchars(strip_tags($this->email));
          $this->password=htmlspecialchars(strip_tags($this->password));
       
          if($stmt->bind_param("sss", $this->username, $this->email, $this->password)){
            return $stmt->execute();
          }
          return false;
        }
      
        public function read(){
            $query = "SELECT * FROM " . $this->table_name;
            $stmt = $this->conn->query($query);
            $data = array();
            while ($row = $stmt->fetch_assoc()) {
                $data[] = $row;
            }
            return $data;
        }
      
        public function read_one(){
            $query = "SELECT * FROM " . $this->table_name . " WHERE id = ? LIMIT 0,1";
            $stmt = $this->conn->prepare( $query );
            $stmt->bind_param("i", $this->id);
            $stmt->execute();
            $row = $stmt->fetch_assoc();
            $this->username = $row['username'];
            $this->email = $row['email'];
            $this->password = $row['password'];
            $this->created_at = $row['created_at'];
        }

        public function read_by_email(){
          $query = "SELECT * FROM " . $this->table_name . " WHERE email = ? LIMIT 0,1";
          $stmt = $this->conn->prepare( $query );
          $stmt->bind_param("s", $this->email);
          $stmt->execute();
          $result = $stmt->get_result();
          if($result->num_rows>0){
            $this->set_user($result->fetch_assoc());
            return true;
          }
          return false;
        }
      
        public function checkEmail($email){
          $query = "SELECT id FROM user WHERE email = ?";
          $stmt = $this->conn->prepare($query);
          $stmt->bind_param('s', $email);
          $stmt->execute();
          $result = $stmt->get_result();
          $row = $result->fetch_assoc();
          return ($row) ? $row['id'] : false;
        }

        public function update(){
          $query = "UPDATE " . $this->table_name . " SET username=?, email=?, password=? WHERE id=?";
      
          $stmt = $this->conn->prepare($query);
       
          $this->username=htmlspecialchars(strip_tags($this->username));
          $this->email=htmlspecialchars(strip_tags($this->email));
          $this->password=htmlspecialchars(strip_tags($this->password));
          $this->id=htmlspecialchars(strip_tags($this->id));
       
          $stmt->bind_param("sssi", $this->username, $this->email, $this->password, $this->id);
      
          if($stmt->execute()){
              return true;
          }
       
          return false;
        }
      
        public function delete(){
          $query = "DELETE FROM " . $this->table_name . " WHERE id = ?";
      
          $stmt = $this->conn->prepare($query);
       
          $this->id=htmlspecialchars(strip_tags($this->id));
       
          $stmt->bind_param("i", $this->id);
      
          if($stmt->execute()){
              return true;
          }
          return false; 
        }
      }
      
    
?>