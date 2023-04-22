<?php
session_start();
class DBConnection {
  private static $conn;
  private static $host = "localhost";
  private static $username = "root";
  private static $password = "12345";
  private static $dbname = "webmail";

  public static function getConnection() {
      if (!self::$conn) {
          self::$conn = new mysqli(self::$host, self::$username, self::$password, self::$dbname);
          if (self::$conn->connect_error) {
              die("Connection failed: " . self::$conn->connect_error);
          }
      }
      return self::$conn;
  }
}
?>