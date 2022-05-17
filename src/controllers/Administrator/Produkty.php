<?php

namespace App\Controllers\Administrator;

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
        $this->db->query(
          "SELECT * FROM produkty_paginuj_wyszukaj(:search, :page, :perPage, :showAll)",
          array(
            "search" => $search,
            "page" => $page,
            "perPage" => $perPage,
            "showAll" => "true"
          )
        );
        $produkty = $this->db->multipleRows();

        $this->db->query(
          "SELECT COUNT(*) FROM produkty_wyszukaj(:search, :showAll)",
          array(
            "search" => $search,
            "showAll" => "true",
          )
        );
        $rowCount = $this->db->singleRow();
        $pages = ceil($rowCount["count"] / $perPage);
      } else {
        $this->db->query(
          "SELECT * FROM produkty_pobierz(:page, :perPage)",
          array(
            "page" => $page,
            "perPage" => $perPage,
          )
        );
        $produkty = $this->db->multipleRows();

        $this->db->query("SELECT * FROM produkty_pobierz_ilosc();");
        $rowCount = $this->db->singleRow();

        $pages = ceil($rowCount["produkty_pobierz_ilosc"] / $perPage);
      }
    } catch (PDOException $e) {
      $_SESSION["error__index"] = $this->helpers->formatErrorMsg($e->getMessage());
    };

    // Pagination links builder
    $pagination = $this->helpers->buildPagination($pages, $page);

    return $this->twig->render(
      '/administrator/produkty/index.html.twig',
      [
        'produkty' => $produkty,
        'pagination' => $pagination
      ]
    );
  }

  // Wyświetla stronę do dodawania
  public function create()
  {
    return $this->twig->render(
      '/administrator/produkty/create.html.twig',
      []
    );
  }

  // Wykonuje dodawanie na stronę główną
  public function store()
  {
    // TODO! debug - usunac
    foreach ($_POST as $key => $value) {
      echo 'Key = ' . $key . '<br />';
      echo 'Value= ' . $value . '<br /><br />';
    }

    // Jeżeli nie ustawilismy ceny, to musi mieć wartość domyślną
    if (empty($_POST["cena"])) {
      $_POST["cena"] = 0;
    }

    try {
      $this->db->query(
        "CALL produkty_dodaj(:nazwa, :kod_producenta, :cena, :opis, :kategoria, :ilosc);",
        array(
          "nazwa" => $_POST["nazwa"],
          "kod_producenta" => $_POST["kod_producenta"],
          "cena" => $_POST["cena"],
          "opis" => $_POST["opis"],
          "kategoria" => $_POST["kategoria"],
          "ilosc" => $_POST["ilosc"],
        )
      );
    } catch (PDOException $e) {
      $_SESSION["error__add"] = $this->helpers->formatErrorMsg($e->getMessage());
      return $this->helpers->redirectNamed("produkty.create");
    };

    $_SESSION["success__index"] = "Poprawnie dodano nowy produkt";
    return $this->helpers->redirectNamed("produkty.index");
  }

  // Wyświetla stronę z pojedyńczym rekordem
  public function show($id)
  {
    try {
      $this->db->query(
        "SELECT * FROM produkty_znajdz(:id);",
        array(
          "id" => $id,
        )
      );
      $row = $this->db->singleRow();
    } catch (PDOException $e) {
      // Jeżeli nie istnieje rekord z danym id to wróć na stronę główną.
      $_SESSION["error__index"] = $this->helpers->formatErrorMsg($e->getMessage());
      return $this->helpers->redirectNamed("produkty.index");
    };

    return $this->twig->render(
      '/administrator/produkty/show.html.twig',
      ['data' => $row]
    );
  }

  // Wyświetla stronę do edycji
  public function edit($id)
  {
    try {
      $this->db->query(
        "SELECT * FROM produkty_znajdz(:id);",
        array(
          "id" => $id,
        )
      );
      $row = $this->db->singleRow();
    } catch (PDOException $e) {
      // Jeżeli nie istnieje rekord z danym id to wróć na stronę główną.
      $_SESSION["error__index"] = $this->helpers->formatErrorMsg($e->getMessage());
      return $this->helpers->redirectNamed("produkty.index");
    };

    return $this->twig->render(
      '/administrator/produkty/edit.html.twig',
      ['data' => $row]
    );
  }

  // Wykonuje update danych, które zmieniamy
  public function update($id)
  {
    // TODO! debug - usunac
    foreach ($_POST as $key => $value) {
      echo 'Key = ' . $key . '<br />';
      echo 'Value= ' . $value . '<br /><br />';
    }

    try {
      $this->db->query(
        "CALL produkty_edytuj(:id, :nazwa, :kod_producenta, :cena, :opis, :kategoria, :ilosc);",
        array(
          "id" => $id,
          "nazwa" => $_POST["nazwa"],
          "kod_producenta" => $_POST["kod_producenta"],
          "cena" => $_POST["cena"],
          "opis" => $_POST["opis"],
          "kategoria" => $_POST["kategoria"],
          "ilosc" => $_POST["ilosc"],
        )
      );
    } catch (PDOException $e) {
      $_SESSION["error__edit"] = $this->helpers->formatErrorMsg($e->getMessage());
      return $this->helpers->redirectNamed("produkty.edit");
    };

    $_SESSION["success__edit"] = "Poprawnie edytowano produkt.";
    return $this->helpers->redirectNamed("produkty.edit", $id);
  }

  // Usuwa podany rekord
  public function destroy($id)
  {
    try {
      $this->db->query(
        "DELETE FROM produkty WHERE id = :id",
        array(
          "id" => $id
        )
      );
    } catch (PDOException $e) {
      $_SESSION["error__index"] = $this->helpers->formatErrorMsg($e->getMessage());
      return $this->helpers->redirectNamed("produkty.index");
    };

    $_SESSION["success__index"] = "Poprawnie usunięto produkt o id = $id";
    return $this->helpers->redirectNamed("produkty.index");
  }

  // Wyszukiwanie adresu jako endpoint
  public function searchProduct()
  {
    // Pobranie parametrów przekazanych w body
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
      $this->db->query(
        "SELECT * FROM produkty_wyszukaj(:name, :showAll)",
        array(
          "name" => $name,
          "showAll" => "false",
        )
      );
      $row = $this->db->multipleRows();
    } catch (PDOException $e) {
      return $this->helpers->getResponse()->httpCode(404)->json([
        'error' => $this->helpers->formatErrorMsg($e->getMessage())
      ]);
    };

    return $this->helpers->getResponse()->httpCode(200)->json([
      'array' => json_encode($row),
    ]);
  }
}
