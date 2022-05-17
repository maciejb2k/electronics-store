<?php

namespace App\Controllers\Administrator;

use App\Classes\Controller;

use \PDOException;

class Adresy extends Controller
{
  public function index()
  {
    $adresy = null;
    $perPage = 30;
    $pages = 1;
    $search = $_GET["search"] ?? null;
    $page = $_GET["page"] ?? 1;

    try {
      if (isset($search)) {
        $this->db->query(
          "SELECT * FROM adresy_paginuj_wyszukaj(:search, :page, :perPage)",
          array(
            "search" => $search,
            "page" => $page,
            "perPage" => $perPage,
          )
        );
        $adresy = $this->db->multipleRows();

        $this->db->query(
          "SELECT COUNT(*) FROM adresy_wyszukaj(:search)",
          array(
            "search" => $search
          )
        );
        $rowCount = $this->db->singleRow();
        $pages = ceil($rowCount["count"] / $perPage);
      } else {
        $this->db->query(
          "SELECT * FROM adresy_pobierz(:page, :perPage)",
          array(
            "page" => $page,
            "perPage" => $perPage,
          )
        );
        $adresy = $this->db->multipleRows();

        $this->db->query("SELECT * FROM adresy_pobierz_ilosc();");
        $rowCount = $this->db->singleRow();

        $pages = ceil($rowCount["adresy_pobierz_ilosc"] / $perPage);
      }
    } catch (PDOException $e) {
      $_SESSION["error__index"] = $this->helpers->formatErrorMsg($e->getMessage());
    };

    // Pagination links builder
    $pagination = $this->helpers->buildPagination($pages, $page);

    return $this->twig->render(
      '/administrator/adresy/index.html.twig',
      [
        'adresy' => $adresy,
        'pagination' => $pagination
      ]
    );
  }

  // Wyświetla stronę do dodawania
  public function create()
  {
    return $this->twig->render(
      '/administrator/adresy/create.html.twig',
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

    try {
      $this->db->query(
        "SELECT * FROM adresy_dodaj(:ulica, :nr_mieszkania, :miasto, :kod_pocztowy, :kraj);",
        array(
          "ulica" => $_POST["ulica"],
          "nr_mieszkania" => $_POST["nr_mieszkania"],
          "miasto" => $_POST["miasto"],
          "kod_pocztowy" => $_POST["kod_pocztowy"],
          "kraj" => $_POST["kraj"],
        )
      );
    } catch (PDOException $e) {
      $_SESSION["error__add"] = $this->helpers->formatErrorMsg($e->getMessage());
      return $this->helpers->redirectNamed("adresy.create");
    };

    $_SESSION["success__index"] = "Poprawnie dodano nowy adres";
    return $this->helpers->redirectNamed("adresy.index");
  }

  // Wyświetla stronę z pojedyńczym rekordem
  public function show($id)
  {
    try {
      $this->db->query(
        "SELECT * FROM adresy_znajdz(:id);",
        array(
          "id" => $id,
        )
      );
      $row = $this->db->singleRow();
    } catch (PDOException $e) {
      // Jeżeli nie istnieje rekord z danym id to wróć na stronę główną.
      $_SESSION["error__index"] = $this->helpers->formatErrorMsg($e->getMessage());
      return $this->helpers->redirectNamed("adresy.index");
    };

    return $this->twig->render(
      '/administrator/adresy/show.html.twig',
      ['data' => $row]
    );
  }

  // Wyświetla stronę do edycji
  public function edit($id)
  {
    try {
      $this->db->query(
        "SELECT * FROM adresy_znajdz(:id);",
        array(
          "id" => $id,
        )
      );
      $row = $this->db->singleRow();
    } catch (PDOException $e) {
      // Jeżeli nie istnieje rekord z danym id to wróć na stronę główną.
      $_SESSION["error__index"] = $this->helpers->formatErrorMsg($e->getMessage());
      return $this->helpers->redirectNamed("adresy.index");
    };

    return $this->twig->render(
      '/administrator/adresy/edit.html.twig',
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
        "CALL adresy_edytuj(:id, :ulica, :nr_mieszkania, :miasto, :kod_pocztowy, :kraj);",
        array(
          "id" => $id,
          "ulica" => $_POST["ulica"],
          "nr_mieszkania" => $_POST["nr_mieszkania"],
          "miasto" => $_POST["miasto"],
          "kod_pocztowy" => $_POST["kod_pocztowy"],
          "kraj" => $_POST["kraj"],
        )
      );
    } catch (PDOException $e) {
      $_SESSION["error__edit"] = $this->helpers->formatErrorMsg($e->getMessage());
      return $this->helpers->redirectNamed("adresy.edit");
    };

    $_SESSION["success__edit"] = "Poprawnie edytowano adres.";
    return $this->helpers->redirectNamed("adresy.edit", $id);
  }

  // Usuwa podany rekord
  public function destroy($id)
  {
    try {
      $this->db->query(
        "DELETE FROM adresy WHERE id = :id",
        array(
          "id" => $id
        )
      );
    } catch (PDOException $e) {
      $_SESSION["error__index"] = $this->helpers->formatErrorMsg($e->getMessage());
      return $this->helpers->redirectNamed("adresy.index");
    };

    $_SESSION["success__index"] = "Poprawnie usunięto adres o id = $id";
    return $this->helpers->redirectNamed("adresy.index");
  }

  // Wyszukiwanie adresu jako endpoint
  public function searchAddreses()
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
        "SELECT * FROM adresy_wyszukaj(:name)",
        array(
          "name" => $name
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
