<?php

namespace App\Controllers;

use App\Classes\Controller;
use Faker;

class Home extends Controller
{

  public function index()
  {

    return $this->twig->render(
      'home.html.twig',
      []
    );
  }
}
