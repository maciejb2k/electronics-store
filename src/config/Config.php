<?php

namespace App\Config;

class Config
{
  static $DB_SERVER    = 'localhost';
  static $DB_PORT      = '5432';
  static $DB_NAME      = 'projekt-bazy';
  static $DB_USERNAME  = 'postgres';
  static $DB_PASSWORD  = 'admin';

  static $SUBDIR = "/projekt-bazy";

  static $DIR_ROOT;
  static $ACTUAL_LINK;
  static $LINK_ROOT;
  static $LINK_ASSETS;

  static function init()
  {
    self::$DIR_ROOT = realpath($_SERVER['DOCUMENT_ROOT'] . self::$SUBDIR . "\\src\\");
    self::$ACTUAL_LINK = "http://$_SERVER[HTTP_HOST]$_SERVER[REQUEST_URI]";
    self::$LINK_ROOT = "http://$_SERVER[HTTP_HOST]";
    self::$LINK_ASSETS = "http://$_SERVER[HTTP_HOST]" . self::$SUBDIR . "/public/";
  }
}
