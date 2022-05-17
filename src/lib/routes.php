<?php

namespace App\Lib;

use App\Controllers\Administrator;
use App\Controllers\Uzytkownik;

use App\Controllers\Home;
use App\Controllers\Login;

use App\Middleware\AdminMiddleware;
use App\Middleware\UserMiddleware;

use App\Config\Config;

use Pecee\SimpleRouter\SimpleRouter;
use Pecee\Http\Request;


SimpleRouter::group(['prefix' => Config::$SUBDIR], function () {
  // Homepage
  SimpleRouter::get('/', [Home::class, 'index'])->name("home.index");

  // Logowanie
  SimpleRouter::get('/login', [Login::class, 'index'])->name("login.index");
  SimpleRouter::post('/login', [Login::class, 'login'])->name("login.post");
  SimpleRouter::get('/logout', [Login::class, 'logout'])->name("login.logout");

  // Panel Usera
  SimpleRouter::group(['prefix' => '/user', 'middleware' => UserMiddleware::class], function () {
    // Home usera
    SimpleRouter::get('/', [Uzytkownik\Home::class, 'index'])->name("user.index");
    SimpleRouter::get('/zamowienie', [Uzytkownik\Home::class, 'orderCreate'])->name("user.zamowienie.create");
    SimpleRouter::post('/zamowienie', [Uzytkownik\Home::class, 'orderStore'])->name("user.zamowienie.store");
    SimpleRouter::get('/zamowienie/{id}', [Uzytkownik\Home::class, 'orderShow'])->name("user.zamowienie.show");
    SimpleRouter::post('/produkty/szukaj/', [Uzytkownik\Home::class, 'searchProduct'])->name("user.produkty.search");
    SimpleRouter::get('/', [Uzytkownik\Home::class, 'editData'])->name("user.edit");
  });

  // Panel admina
  SimpleRouter::group(['prefix' => '/admin', 'middleware' => AdminMiddleware::class], function () {
    // Home admina
    SimpleRouter::get('/', [Administrator\Home::class, 'index'])->name("admin.index");
    SimpleRouter::get('/seed', [Administrator\Home::class, 'generateSeed'])->name("admin.seed");

    // Logi
    SimpleRouter::get('/logi/', [Administrator\Logi::class, 'index'])->name("logi.index");

    // Adresy
    SimpleRouter::get('/adresy/', [Administrator\Adresy::class, 'index'])->name("adresy.index");
    SimpleRouter::get('/adresy/dodaj/', [Administrator\Adresy::class, 'create'])->name("adresy.create");
    SimpleRouter::post('/adresy/dodaj/', [Administrator\Adresy::class, 'store'])->name("adresy.store");
    SimpleRouter::post('/adresy/szukaj/', [Administrator\Adresy::class, 'searchAddreses'])->name("adresy.search");
    SimpleRouter::get('/adresy/{id}', [Administrator\Adresy::class, 'show'])->name("adresy.show");
    SimpleRouter::get('/adresy/edytuj/{id}', [Administrator\Adresy::class, 'edit'])->name("adresy.edit");
    SimpleRouter::post('/adresy/edytuj/{id}', [Administrator\Adresy::class, 'update'])->name("adresy.update");
    SimpleRouter::post('/adresy/usun/{id}', [Administrator\Adresy::class, 'destroy'])->name("adresy.destroy");

    // Uzytkownicy
    SimpleRouter::get('/uzytkownicy/', [Administrator\Uzytkownicy::class, 'index'])->name("uzytkownicy.index");
    SimpleRouter::get('/uzytkownicy/dodaj/', [Administrator\Uzytkownicy::class, 'create'])->name("uzytkownicy.create");
    SimpleRouter::post('/uzytkownicy/dodaj/', [Administrator\Uzytkownicy::class, 'store'])->name("uzytkownicy.store");
    SimpleRouter::post('/uzytkownicy/szukaj/', [Administrator\Uzytkownicy::class, 'searchUser'])->name("uzytkownicy.search");
    SimpleRouter::get('/uzytkownicy/{id}', [Administrator\Uzytkownicy::class, 'show'])->name("uzytkownicy.show");
    SimpleRouter::get('/uzytkownicy/edytuj/{id}', [Administrator\Uzytkownicy::class, 'edit'])->name("uzytkownicy.edit");
    SimpleRouter::post('/uzytkownicy/edytuj/{id}', [Administrator\Uzytkownicy::class, 'update'])->name("uzytkownicy.update");
    SimpleRouter::post('/uzytkownicy/usun/{id}', [Administrator\Uzytkownicy::class, 'destroy'])->name("uzytkownicy.destroy");

    // Produkty
    SimpleRouter::get('/produkty/', [Administrator\Produkty::class, 'index'])->name("produkty.index");
    SimpleRouter::get('/produkty/dodaj/', [Administrator\Produkty::class, 'create'])->name("produkty.create");
    SimpleRouter::post('/produkty/dodaj/', [Administrator\Produkty::class, 'store'])->name("produkty.store");
    SimpleRouter::post('/produkty/szukaj/', [Administrator\Produkty::class, 'searchProduct'])->name("produkty.search");
    SimpleRouter::get('/produkty/{id}', [Administrator\Produkty::class, 'show'])->name("produkty.show");
    SimpleRouter::get('/produkty/edytuj/{id}', [Administrator\Produkty::class, 'edit'])->name("produkty.edit");
    SimpleRouter::post('/produkty/edytuj/{id}', [Administrator\Produkty::class, 'update'])->name("produkty.update");
    SimpleRouter::post('/produkty/usun/{id}', [Administrator\Produkty::class, 'destroy'])->name("produkty.destroy");

    // Produkty
    SimpleRouter::get('/zamowienia/', [Administrator\Zamowienia::class, 'index'])->name("zamowienia.index");
    SimpleRouter::get('/zamowienia/dodaj/', [Administrator\Zamowienia::class, 'create'])->name("zamowienia.create");
    SimpleRouter::post('/zamowienia/dodaj/', [Administrator\Zamowienia::class, 'storeApi'])->name("zamowienia.store");
    SimpleRouter::get('/zamowienia/edytuj/{id}', [Administrator\Zamowienia::class, 'edit'])->name("zamowienia.edit");
    SimpleRouter::post('/zamowienia/edytuj/{id}', [Administrator\Zamowienia::class, 'update'])->name("zamowienia.update");
  });
});

SimpleRouter::error(function (Request $request, \Exception $exception) {
  switch ($exception->getCode()) {
    case 404:
      response()->redirect(Config::$SUBDIR);
  }
});
