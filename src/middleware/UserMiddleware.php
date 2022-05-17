<?php

namespace App\Middleware;

use Pecee\Http\Middleware\IMiddleware;
use Pecee\Http\Request;

use App\Classes\Helpers;

class UserMiddleware implements IMiddleware
{
  public function handle(Request $request): void
  {
    $helpers = new Helpers();

    if ($_SESSION["zalogowany"] && $_SESSION["rola"] == "uzytkownik") {
      // echo "pass";
    } else {
      $helpers->redirectNamed('login.index');
    }
  }
}
