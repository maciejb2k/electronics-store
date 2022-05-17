<?php

namespace App\Classes;

use App\Config\Config;
use App\Classes\Database;

use Twig\Loader\FilesystemLoader;
use Twig\Environment;

class Controller
{
  protected $twig;
  protected $db;
  protected $helpers;

  public function __construct()
  {
    $this->db = Database::getInstance();
    $this->helpers = new Helpers();

    $loader = new FilesystemLoader(Config::$DIR_ROOT . "\\templates");
    $this->twig = new Environment($loader);
    $this->setupTwig();
  }

  public function setupTwig()
  {
    $routeFn = new \Twig\TwigFunction('route', function ($name, $param = null) {
      return $this->helpers->getRouteByName($name) . $param;
    });

    $urlFn = new \Twig\TwigFunction('url', function ($url) {
      return $this->helpers->getRoute($url);
    });

    $assetsFn = new \Twig\TwigFunction('assets', function ($url) {
      return $this->helpers->getAssets() . $url;
    });

    $urlParamFn = new \Twig\TwigFunction('urlParam', function ($key) {
      return $this->helpers->getGetValue($key);
    });

    $sessionGetFn = new \Twig\TwigFunction('sessionGet', function ($name) {
      return $this->helpers->sessionGet($name);
    });

    $sessionShowFn = new \Twig\TwigFunction('sessionShow', function ($name) {
      return $this->helpers->sessionShow($name);
    });

    $isLoggedFn = new \Twig\TwigFunction('isLogged', function () {
      return $this->helpers->isLogged();
    });

    $this->twig->addFunction($routeFn);
    $this->twig->addFunction($urlFn);
    $this->twig->addFunction($assetsFn);
    $this->twig->addFunction($urlParamFn);
    $this->twig->addFunction($sessionGetFn);
    $this->twig->addFunction($sessionShowFn);
    $this->twig->addFunction($isLoggedFn);
  }
}
