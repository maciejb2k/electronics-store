<?php

namespace App;

use Pecee\SimpleRouter\SimpleRouter;
use App\Config\Config;

require_once realpath("vendor/autoload.php");

Config::init();

require_once Config::$DIR_ROOT . '\\lib\routes.php';
require_once Config::$DIR_ROOT . '\\lib\helpers.php';

session_start();

SimpleRouter::setDefaultNamespace('App\Controllers');
SimpleRouter::start();
