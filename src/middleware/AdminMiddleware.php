<?php

namespace App\Middleware;

use Pecee\Http\Middleware\IMiddleware;
use Pecee\Http\Request;

use App\Classes\Helpers;

class AdminMiddleware implements IMiddleware
{
  public function handle(Request $request): void
  {
    $helpers = new Helpers();

    if ($_SESSION["zalogowany"] && $_SESSION["rola"] == "administrator") {
      // echo "pass";
    } else {
      $helpers->redirectNamed('login.index');
    }
  }
}
