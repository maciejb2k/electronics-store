<?php

namespace App\Controllers;

use App\Classes\Controller;

class AdminHome extends Controller
{
  public function index()
  {
    return $this->twig->render(
      'index.admin.html.twig',
      []
    );
  }
}
