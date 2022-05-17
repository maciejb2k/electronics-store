<?php

namespace App\Classes;

use \PDO;
use \PDOException;

use App\Config\Config;

class Database
{
  private static $_instance = null;
  private $pdo;

  private function __construct()
  {
    try {
      $dsn = "pgsql:host="  . Config::$DB_SERVER . ";port="  . Config::$DB_PORT . ";dbname="  . Config::$DB_NAME . ";";
      $this->pdo = new PDO($dsn, Config::$DB_USERNAME, Config::$DB_PASSWORD, [PDO::ATTR_ERRMODE => PDO::ERRMODE_EXCEPTION]);
    } catch (PDOException $e) {
      die($e->getMessage());
    }
  }

  public static function getInstance()
  {
    if (!isset(self::$_instance)) {
      self::$_instance = new Database();
    }

    return self::$_instance;
  }

  public function unset()
  {
    $this->stmt = null;
    $this->error = null;
  }

  public function query($query, $bindings = array())
  {
    try {
      $this->unset();
      $this->stmt = $this->pdo->prepare($query);
      $this->stmt->execute($bindings);
    } catch (PDOException $e) {
      throw new PDOException($e->getMessage());
    }
  }

  public function singleRow($option = PDO::FETCH_ASSOC)
  {
    return $this->stmt->fetch($option);
  }

  public function multipleRows($option = PDO::FETCH_ASSOC)
  {
    return $this->stmt->fetchAll($option);
  }

  public function rowCount($option = PDO::FETCH_ASSOC)
  {
    return $this->stmt->rowCount();
  }

  public function fetchColumn($option = PDO::FETCH_ASSOC)
  {
    return $this->stmt->fetchColumn();
  }

  public function returnError()
  {
    return $this->error;
  }
}
