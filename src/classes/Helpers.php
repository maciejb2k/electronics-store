<?php

namespace App\Classes;

use App\Config\Config;

use Pecee\SimpleRouter\SimpleRouter;

class Helpers
{
  public function redirectNamed($name)
  {
    return SimpleRouter::response()->redirect(SimpleRouter::getUrl($name));
  }

  public function getRouteByName($name)
  {
    return Config::$LINK_ROOT . SimpleRouter::getUrl($name);
  }

  public function getRoute($url)
  {
    return Config::$LINK_ROOT . "/projekt-bazy" . $url;
  }

  public function getAssets()
  {
    return Config::$LINK_ASSETS;
  }

  public function getUrlWihoutParams()
  {
    return rtrim(strtok(Config::$ACTUAL_LINK, '?'), "/");
  }

  public function getRequest()
  {
    return SimpleRouter::request();
  }

  public function getResponse()
  {
    return SimpleRouter::response();
  }

  public function getGetValue($key)
  {
    return $this->getInput()->get($key, $defaultValue = null);
  }

  public function getInput($index = null, $defaultValue = null, ...$methods)
  {
    if ($index !== null) {
      return $this->getRequest()->getInputHandler()->value($index, $defaultValue, ...$methods);
    }

    return $this->getRequest()->getInputHandler();
  }

  public function redirect($url)
  {
    return SimpleRouter::response()->redirect($url);
  }

  public function formatErrorMsg($msg)
  {
    return str_replace("CONTEXT", "", trim(explode(":", $msg)[3]));
  }

  public function sessionShow($name)
  {
    $msg = $this->sessionGet($name);
    unset($_SESSION[$name]);
    return $msg;
  }

  public function sessionGet($name)
  {
    return $_SESSION[$name] ?? null;
  }

  public function isLogged()
  {
    return $_SESSION['rola'] ?? null;
  }

  public function buildPagination($pages, $currentPage)
  {
    $links = array();

    for ($i = 1; $i <= $pages; $i++) {
      $_GET["page"] = $i;
      $url = strtok(Config::$ACTUAL_LINK, '?') . "?" . http_build_query($_GET, '', '&');
      array_push($links, $url);
    }

    return [
      "currentPage" => $currentPage,
      "links" => $links
    ];
  }
}
