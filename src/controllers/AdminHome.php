<?php

namespace App\Controllers;

use App\Classes\Controller;
use App\Classes\Config;

use \PDOException;

class AdminHome extends Controller
{
  public function index()
  {
    return $this->twig->render(
      'index.admin.html.twig',
      []
    );
  }

  public function show($id)
  {
    echo $id;
  }
}
