<?php

namespace App\Lib;

use App\Controllers\AdminHome;
use App\Controllers\Adresy;
use App\Controllers\Uzytkownicy;
use App\Controllers\Produkty;
use App\Controllers\Zamowienia;
use App\Controllers\Logi;

use Pecee\SimpleRouter\SimpleRouter;
use Pecee\Http\Request;

SimpleRouter::group(['prefix' => '/projekt-bazy/admin'], function () {
  SimpleRouter::get('/', [AdminHome::class, 'index'])->name("admin.index");
  SimpleRouter::get('/seed', [AdminHome::class, 'generateSeed'])->name("admin.seed");

  // Logi
  SimpleRouter::get('/logi/', [Logi::class, 'index'])->name("logi.index");

  // Adresy
  SimpleRouter::get('/adresy/', [Adresy::class, 'index'])->name("adresy.index");
  SimpleRouter::get('/adresy/dodaj/', [Adresy::class, 'create'])->name("adresy.create");
  SimpleRouter::post('/adresy/dodaj/', [Adresy::class, 'store'])->name("adresy.store");
  SimpleRouter::post('/adresy/szukaj/', [Adresy::class, 'searchAddreses'])->name("adresy.search");
  SimpleRouter::get('/adresy/{id}', [Adresy::class, 'show'])->name("adresy.show");
  SimpleRouter::get('/adresy/edytuj/{id}', [Adresy::class, 'edit'])->name("adresy.edit");
  SimpleRouter::post('/adresy/edytuj/{id}', [Adresy::class, 'update'])->name("adresy.update");
  SimpleRouter::post('/adresy/usun/{id}', [Adresy::class, 'destroy'])->name("adresy.destroy");

  // Uzytkownicy
  SimpleRouter::get('/uzytkownicy/', [Uzytkownicy::class, 'index'])->name("uzytkownicy.index");
  SimpleRouter::get('/uzytkownicy/dodaj/', [Uzytkownicy::class, 'create'])->name("uzytkownicy.create");
  SimpleRouter::post('/uzytkownicy/dodaj/', [Uzytkownicy::class, 'store'])->name("uzytkownicy.store");
  SimpleRouter::post('/uzytkownicy/szukaj/', [Uzytkownicy::class, 'searchUser'])->name("uzytkownicy.search");
  SimpleRouter::get('/uzytkownicy/{id}', [Uzytkownicy::class, 'show'])->name("uzytkownicy.show");
  SimpleRouter::get('/uzytkownicy/edytuj/{id}', [Uzytkownicy::class, 'edit'])->name("uzytkownicy.edit");
  SimpleRouter::post('/uzytkownicy/edytuj/{id}', [Uzytkownicy::class, 'update'])->name("uzytkownicy.update");
  SimpleRouter::post('/uzytkownicy/usun/{id}', [Uzytkownicy::class, 'destroy'])->name("uzytkownicy.destroy");

  // Produkty
  SimpleRouter::get('/produkty/', [Produkty::class, 'index'])->name("produkty.index");
  SimpleRouter::get('/produkty/dodaj/', [Produkty::class, 'create'])->name("produkty.create");
  SimpleRouter::post('/produkty/dodaj/', [Produkty::class, 'store'])->name("produkty.store");
  SimpleRouter::post('/produkty/szukaj/', [Produkty::class, 'searchProduct'])->name("produkty.search");
  SimpleRouter::get('/produkty/{id}', [Produkty::class, 'show'])->name("produkty.show");
  SimpleRouter::get('/produkty/edytuj/{id}', [Produkty::class, 'edit'])->name("produkty.edit");
  SimpleRouter::post('/produkty/edytuj/{id}', [Produkty::class, 'update'])->name("produkty.update");
  SimpleRouter::post('/produkty/usun/{id}', [Produkty::class, 'destroy'])->name("produkty.destroy");

  // Produkty
  SimpleRouter::get('/zamowienia/', [Zamowienia::class, 'index'])->name("zamowienia.index");
  SimpleRouter::get('/zamowienia/dodaj/', [Zamowienia::class, 'create'])->name("zamowienia.create");
  SimpleRouter::post('/zamowienia/dodaj/', [Zamowienia::class, 'storeApi'])->name("zamowienia.store");
  SimpleRouter::get('/zamowienia/edytuj/{id}', [Zamowienia::class, 'edit'])->name("zamowienia.edit");
  SimpleRouter::post('/zamowienia/edytuj/{id}', [Zamowienia::class, 'update'])->name("zamowienia.update");
});

SimpleRouter::error(function (Request $request, \Exception $exception) {
  switch ($exception->getCode()) {
    case 404:
      response()->redirect('/projekt-bazy/admin');
  }
});
