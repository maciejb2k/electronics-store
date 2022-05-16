<?php

namespace App\Controllers;

use App\Classes\Controller;

class UserHome extends Controller
{
  public function index()
  {
    return $this->twig->render(
      '/uzytkownik/index.html.twig',
      []
    );
  }
}
