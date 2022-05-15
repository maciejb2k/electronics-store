<?php

namespace App\Controllers;

use App\Classes\Controller;
use App\Classes\Config;

use \PDOException;

class Uzytkownicy extends Controller
{
  public function index()
  {
    $uzytkownicy = null;
    $perPage = 30;
    $pages = 1;
    $search = $_GET["search"] ?? null;
    $page = $_GET["page"] ?? 1;

    try {
      if (isset($search)) {
        $this->db->query("SELECT * FROM uzytkownicy_paginuj_wyszukaj('{$search}', {$page}, {$perPage})");
        $uzytkownicy = $this->db->multipleRows();

        $this->db->query("SELECT COUNT(*) FROM uzytkownicy_wyszukaj('{$search}');");
        $rowCount = $this->db->singleRow();
        $pages = ceil($rowCount["count"] / $perPage);
        // print_r($rowCount);
        // $pages = ceil($rowCount["count"] / $perPage);
      } else {
        $this->db->query("SELECT * FROM uzytkownicy_pobierz({$page}, {$perPage})");
        $uzytkownicy = $this->db->multipleRows();

        $this->db->query("SELECT * FROM uzytkownicy_pobierz_ilosc();");
        $rowCount = $this->db->singleRow();
        $pages = ceil($rowCount["uzytkownicy_pobierz_ilosc"] / $perPage);
        // echo $pages;
        // print_r($row["adresy_pobierz_ilosc"]);
      }
    } catch (PDOException $e) {
      $this->db->error = $e->getMessage();
    };

    // Pagination links builder
    $pagination = $this->helpers->buildPagination($pages, $page);

    return $this->twig->render(
      '/uzytkownicy/index.html.twig',
      [
        'uzytkownicy' => $uzytkownicy,
        'pagination' => $pagination
      ]
    );
  }

  public function create()
  {
    return $this->twig->render(
      '/uzytkownicy/create.html.twig',
      []
    );
  }

  public function store()
  {
    foreach ($_POST as $key => $value) {
      echo 'Key = ' . $key . '<br />';
      echo 'Value= ' . $value . '<br /><br />';
    }

    try {
      $this->db->query("CALL uzytkownicy_dodaj('{$_POST["imie"]}', '{$_POST["nazwisko"]}', '{$_POST["nazwa_uzytkownika"]}', '{$_POST["email"]}', '{$_POST["telefon"]}', '{$_POST["haslo"]}', '{$_POST["adres_id"]}');");
    } catch (PDOException $e) {
      $_SESSION["error__add"] = $this->helpers->formatErrorMsg($e->getMessage());
      return $this->helpers->redirectNamed("uzytkownicy.create");
    };

    return $this->helpers->redirectNamed("uzytkownicy.index");
  }

  public function show($id)
  {
    try {
      $this->db->query("SELECT * FROM uzytkownicy_pobierz_szczegoly_wszystkie('$id');");
      $uzytkownik = $this->db->singleRow();
      $uzytkownik = !empty($uzytkownik) ? $uzytkownik : null;

      $id_uzytkownika = $uzytkownik["id"];

      $this->db->query("SELECT * FROM zamowienia_znajdz_po_uid($id_uzytkownika);");
      $zamowienia = $this->db->multipleRows();
    } catch (PDOException $e) {
      $_SESSION["error__index"] = $this->helpers->formatErrorMsg($e->getMessage());
      return $this->helpers->redirectNamed("uzytkownicy.index");
    };

    return $this->twig->render('/uzytkownicy/show.html.twig', [
      'uzytkownik' => $uzytkownik,
      'zamowienia' => $zamowienia,
    ]);
  }

  public function edit($id)
  {
    try {
      $this->db->query("SELECT * FROM uzytkownicy_pobierz_szczegoly_wszystkie('$id');");
      $row = $this->db->singleRow();
      $row = !empty($row) ? $row : null;
    } catch (PDOException $e) {
      $_SESSION["error__index"] = $this->helpers->formatErrorMsg($e->getMessage());
      return $this->helpers->redirectNamed("uzytkownicy.index");
    };

    return $this->twig->render('/uzytkownicy/edit.html.twig', ['data' => $row]);
  }

  public function update($id)
  {
    foreach ($_POST as $key => $value) {
      echo 'Key = ' . $key . '<br />';
      echo 'Value= ' . $value . '<br /><br />';
    }

    try {
      $this->db->query("CALL uzytkownicy_edytuj('{$id}', '{$_POST["imie"]}', '{$_POST["nazwisko"]}', '{$_POST["nazwa_uzytkownika"]}', '{$_POST["email"]}', '{$_POST["telefon"]}', '{$_POST["haslo"]}', '{$_POST["adres_id"]}');");
    } catch (PDOException $e) {
      $_SESSION["error__add"] = $this->helpers->formatErrorMsg($e->getMessage());
      return $this->helpers->redirectNamed("uzytkownicy.edit");
      die($e->getMessage());
    };

    return $this->helpers->redirectNamed("uzytkownicy.index");
  }

  public function destroy($id)
  {
    try {
      $this->db->query("DELETE FROM uzytkownicy WHERE id = $id");
    } catch (PDOException $e) {
      $_SESSION["error__index"] = $this->helpers->formatErrorMsg($e->getMessage());
      return $this->helpers->redirectNamed("uzytkownicy.index");
    };

    return $this->helpers->redirectNamed("uzytkownicy.index");
  }

  public function searchUser()
  {
    $request_body = file_get_contents('php://input');
    $data = json_decode($request_body, true);
    $name = $data['name'];

    if (!isset($name)) {
      return $this->helpers->getResponse()->httpCode(404)->json([
        'message' => "Podaj argument",
      ]);
    }

    $name = trim($name);

    try {
      $this->db->query("SELECT * FROM uzytkownicy_wyszukaj('$name')");
      $row = $this->db->multipleRows();
    } catch (PDOException $e) {
    };

    return $this->helpers->getResponse()->httpCode(200)->json([
      'array' => json_encode($row),
    ]);
  }
}
