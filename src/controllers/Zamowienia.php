<?php

namespace App\Controllers;

use App\Classes\Controller;

use \PDOException;

class Zamowienia extends Controller
{
  public function index()
  {
    $zamowienia = null;
    $perPage = 30;
    $pages = 1;
    $search = $_GET["search"] ?? null;
    $page = $_GET["page"] ?? 1;

    try {
      if (isset($search)) {
        $this->db->query("SELECT * FROM zamowienia_paginuj_wyszukaj('{$search}', {$page}, {$perPage})");
        $zamowienia = $this->db->multipleRows();

        $this->db->query("SELECT COUNT(*) FROM zamowienia_wyszukaj('{$search}');");
        $rowCount = $this->db->singleRow();
        $pages = ceil($rowCount["count"] / $perPage);
        // print_r($rowCount);
        // $pages = ceil($rowCount["count"] / $perPage);
      } else {
        $this->db->query("SELECT * FROM zamowienia_paginuj({$page}, {$perPage})");
        $zamowienia = $this->db->multipleRows();

        $this->db->query("SELECT * FROM zamowienia_pobierz_ilosc();");
        $rowCount = $this->db->singleRow();
        $pages = ceil($rowCount["zamowienia_pobierz_ilosc"] / $perPage);
        // echo $pages;
        // print_r($row["adresy_pobierz_ilosc"]);
      }
    } catch (PDOException $e) {
      $this->db->error = $e->getMessage();
    };

    // Pagination links builder
    $pagination = $this->helpers->buildPagination($pages, $page);

    return $this->twig->render(
      '/zamowienia/index.html.twig',
      [
        'zamowienia' => $zamowienia,
        'pagination' => $pagination
      ]
    );
  }

  public function create()
  {
    return $this->twig->render(
      '/zamowienia/create.html.twig',
      []
    );
  }

  public function store()
  {
    foreach ($_POST as $key => $value) {
      echo 'Key = ' . $key . '<br />';
      echo 'Value= ' . $value . '<br /><br />';
    }

    if (empty($_POST["cena"])) {
      $_POST["cena"] = 0;
    }

    try {
      $this->db->query("CALL zamowienia_dodaj('{$_POST["nazwa"]}', '{$_POST["kod_producenta"]}', '{$_POST["cena"]}', '{$_POST["opis"]}', '{$_POST["kategoria"]}');");
    } catch (PDOException $e) {
      $_SESSION["error__add"] = $this->helpers->formatErrorMsg($e->getMessage());
      return $this->helpers->redirectNamed("zamowienia.create");
    };

    return $this->helpers->redirectNamed("zamowienia.index");
  }

  public function show($id)
  {
    try {
      $this->db->query("SELECT * FROM zamowienia_pobierz('$id');");
      $row = $this->db->singleRow();
      $row = !empty($row) ? $row : null;
    } catch (PDOException $e) {
      $_SESSION["error__index"] = $this->helpers->formatErrorMsg($e->getMessage());
      return $this->helpers->redirectNamed("zamowienia.index");
    };

    return $this->twig->render('/zamowienia/show.html.twig', ['data' => $row]);
  }

  public function edit($id)
  {
    try {
      // Pobierz zamówienie
      $this->db->query("SELECT * FROM zamowienia_znajdz('$id');");
      $zamowienie = $this->db->singleRow();
      $zamowienie = !empty($zamowienie) ? $zamowienie : null;

      $uzytkownik_id = $zamowienie['uzytkownik_id'];

      // Pobierz użytkownika
      $this->db->query("SELECT * FROM uzytkownicy_pobierz_szczegoly_wszystkie('$uzytkownik_id')");
      $uzytkownik = $this->db->singleRow();

      // Pobierz produkty
      $this->db->query("SELECT * FROM zamowienia_pobierz_produkty('$id')");
      $produkty = $this->db->multipleRows();
    } catch (PDOException $e) {
      $_SESSION["error__index"] = $this->helpers->formatErrorMsg($e->getMessage());
      return $this->helpers->redirectNamed("zamowienia.index");
    };

    return $this->twig->render('/zamowienia/edit.html.twig', [
      'zamowienie' => $zamowienie,
      'uzytkownik' => $uzytkownik,
      'produkty' => $produkty,
    ]);
  }

  public function update($id)
  {
    foreach ($_POST as $key => $value) {
      echo 'Key = ' . $key . '<br />';
      echo 'Value= ' . $value . '<br /><br />';
    }

    try {
      $this->db->query("CALL zamowienia_zmien_status('$id', '{$_POST["status_zamowienia"]}');");
    } catch (PDOException $e) {
      $_SESSION["error__edit"] = $this->helpers->formatErrorMsg($e->getMessage());
      return $this->helpers->redirectNamed("zamowienia.edit");
      die($e->getMessage());
    };

    $_SESSION["success__edit"] = "Poprawnie edytowano status zamówienia";
    return $this->helpers->redirectNamed("zamowienia.edit", $id);
  }

  public function destroy($id)
  {
    try {
      $this->db->query("DELETE FROM zamowienia WHERE id = $id");
    } catch (PDOException $e) {
      $_SESSION["error__index"] = $this->helpers->formatErrorMsg($e->getMessage());
      return $this->helpers->redirectNamed("zamowienia.index");
    };

    return $this->helpers->redirectNamed("zamowienia.index");
  }

  public function storeApi()
  {
    $request_body = file_get_contents('php://input');
    $data = json_decode($request_body, true);

    $id_uzytkownika = $data['id_uzytkownika'] ?? null;
    $array_produkty = $data['array_produkty'] ?? null;
    $array_ilosci = $data['array_ilosci'] ?? null;
    $forma_platnosci = $data['forma_platnosci'] ?? null;

    if (!isset($id_uzytkownika)) {
      return $this->helpers->getResponse()->httpCode(404)->json([
        'message' => "Podaj id_uzytkownika",
      ]);
    }
    if (!isset($array_produkty)) {
      return $this->helpers->getResponse()->httpCode(404)->json([
        'message' => "Podaj array_produkty",
      ]);
    }
    if (!isset($array_ilosci)) {
      return $this->helpers->getResponse()->httpCode(404)->json([
        'message' => "Podaj array_ilosci",
      ]);
    }
    if (!isset($forma_platnosci)) {
      return $this->helpers->getResponse()->httpCode(404)->json([
        'message' => "Podaj forma_platnosci",
      ]);
    }

    $id_uzytkownika = trim($id_uzytkownika);
    $array_produkty = trim($array_produkty);
    $array_ilosci = trim($array_ilosci);
    $forma_platnosci = trim($forma_platnosci);

    try {
      $this->db->query("SELECT * FROM dodaj_zamowienie('$id_uzytkownika', '$forma_platnosci', '$array_produkty', '$array_ilosci');");
      $row = $this->db->singleRow();
    } catch (PDOException $e) {
      return $this->helpers->getResponse()->httpCode(404)->json([
        'array' => json_encode($e->getMessage()),
      ]);
    };

    return $this->helpers->getResponse()->httpCode(200)->json([
      'id' => $row["dodaj_zamowienie"],
    ]);
  }
}
