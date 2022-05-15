<?php

namespace App\Controllers;

use App\Classes\Controller;

use \PDOException;

class Produkty extends Controller
{
  public function index()
  {
    $produkty = null;
    $perPage = 30;
    $pages = 1;
    $search = $_GET["search"] ?? null;
    $page = $_GET["page"] ?? 1;

    try {
      if (isset($search)) {
        $this->db->query("SELECT * FROM produkty_paginuj_wyszukaj('{$search}', {$page}, {$perPage})");
        $produkty = $this->db->multipleRows();

        $this->db->query("SELECT COUNT(*) FROM produkty_wyszukaj('{$search}');");
        $rowCount = $this->db->singleRow();
        $pages = ceil($rowCount["count"] / $perPage);
        // print_r($rowCount);
        // $pages = ceil($rowCount["count"] / $perPage);
      } else {
        $this->db->query("SELECT * FROM produkty_pobierz({$page}, {$perPage})");
        $produkty = $this->db->multipleRows();

        $this->db->query("SELECT * FROM produkty_pobierz_ilosc();");
        $rowCount = $this->db->singleRow();
        $pages = ceil($rowCount["produkty_pobierz_ilosc"] / $perPage);
        // echo $pages;
        // print_r($row["adresy_pobierz_ilosc"]);
      }
    } catch (PDOException $e) {
      $this->db->error = $e->getMessage();
    };

    // Pagination links builder
    $pagination = $this->helpers->buildPagination($pages, $page);

    return $this->twig->render(
      '/produkty/index.html.twig',
      [
        'produkty' => $produkty,
        'pagination' => $pagination
      ]
    );
  }

  public function create()
  {
    return $this->twig->render(
      '/produkty/create.html.twig',
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
      $this->db->query("CALL produkty_dodaj('{$_POST["nazwa"]}', '{$_POST["kod_producenta"]}', '{$_POST["cena"]}', '{$_POST["opis"]}', '{$_POST["kategoria"]}');");
    } catch (PDOException $e) {
      $_SESSION["error__add"] = $this->helpers->formatErrorMsg($e->getMessage());
      return $this->helpers->redirectNamed("produkty.create");
    };

    return $this->helpers->redirectNamed("produkty.index");
  }

  public function show($id)
  {
    try {
      $this->db->query("SELECT * FROM produkty_znajdz('$id');");
      $row = $this->db->singleRow();
      $row = !empty($row) ? $row : null;
    } catch (PDOException $e) {
      $_SESSION["error__index"] = $this->helpers->formatErrorMsg($e->getMessage());
      return $this->helpers->redirectNamed("produkty.index");
    };

    return $this->twig->render('/produkty/show.html.twig', ['data' => $row]);
  }

  public function edit($id)
  {
    try {
      $this->db->query("SELECT * FROM produkty_pobierz('$id');");
      $row = $this->db->singleRow();
      $row = !empty($row) ? $row : null;
    } catch (PDOException $e) {
      $_SESSION["error__index"] = $this->helpers->formatErrorMsg($e->getMessage());
      return $this->helpers->redirectNamed("produkty.index");
    };

    return $this->twig->render('/produkty/edit.html.twig', ['data' => $row]);
  }

  public function update($id)
  {
    foreach ($_POST as $key => $value) {
      echo 'Key = ' . $key . '<br />';
      echo 'Value= ' . $value . '<br /><br />';
    }

    try {
      $this->db->query("CALL produkty_edytuj('{$_POST["id"]}', '{$_POST["nazwa"]}', '{$_POST["kod_producenta"]}', '{$_POST["cena"]}', '{$_POST["opis"]}', '{$_POST["kategoria"]}');");
    } catch (PDOException $e) {
      $_SESSION["error__add"] = $this->helpers->formatErrorMsg($e->getMessage());
      return $this->helpers->redirectNamed("produkty.edit");
      die($e->getMessage());
    };

    return $this->helpers->redirectNamed("produkty.index");
  }

  public function destroy($id)
  {
    try {
      $this->db->query("DELETE FROM produkty WHERE id = $id");
    } catch (PDOException $e) {
      $_SESSION["error__index"] = $this->helpers->formatErrorMsg($e->getMessage());
      return $this->helpers->redirectNamed("produkty.index");
    };

    return $this->helpers->redirectNamed("produkty.index");
  }

  public function searchProduct()
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
      $this->db->query("SELECT * FROM produkty_wyszukaj('$name')");
      $row = $this->db->multipleRows();
    } catch (PDOException $e) {
    };

    return $this->helpers->getResponse()->httpCode(200)->json([
      'array' => json_encode($row),
    ]);
  }
}
