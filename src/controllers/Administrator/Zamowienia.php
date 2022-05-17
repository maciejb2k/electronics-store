<?php

namespace App\Controllers\Administrator;

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
        $this->db->query(
          "SELECT * FROM zamowienia_paginuj_wyszukaj(:search, :page, :perPage)",
          array(
            "search" => $search,
            "page" => $page,
            "perPage" => $perPage,
          )
        );
        $zamowienia = $this->db->multipleRows();

        $this->db->query(
          "SELECT COUNT(*) FROM zamowienia_wyszukaj(:search)",
          array(
            "search" => $search
          )
        );
        $rowCount = $this->db->singleRow();
        $pages = ceil($rowCount["count"] / $perPage);
      } else {
        $this->db->query(
          "SELECT * FROM zamowienia_paginuj(:page, :perPage)",
          array(
            "page" => $page,
            "perPage" => $perPage,
          )
        );
        $zamowienia = $this->db->multipleRows();

        $this->db->query("SELECT * FROM zamowienia_pobierz_ilosc();");
        $rowCount = $this->db->singleRow();

        $pages = ceil($rowCount["zamowienia_pobierz_ilosc"] / $perPage);
      }
    } catch (PDOException $e) {
      $_SESSION["error__index"] = $this->helpers->formatErrorMsg($e->getMessage());
    };

    // Pagination links builder
    $pagination = $this->helpers->buildPagination($pages, $page);

    return $this->twig->render(
      '/administrator/zamowienia/index.html.twig',
      [
        'zamowienia' => $zamowienia,
        'pagination' => $pagination
      ]
    );
  }

  // Wyświetla stronę do dodawania
  public function create()
  {
    return $this->twig->render(
      '/administrator/zamowienia/create.html.twig',
      []
    );
  }

  // Wyświetla stronę do edycji
  public function edit($id)
  {
    try {
      // Pobierz zamówienie
      $this->db->query(
        "SELECT * FROM zamowienia_znajdz(:id);",
        array(
          "id" => $id
        )
      );
      $zamowienie = $this->db->singleRow();

      // Pobierz użytkownika
      $this->db->query(
        "SELECT * FROM uzytkownicy_pobierz_szczegoly_wszystkie(:uzytkownik_id)",
        array(
          "uzytkownik_id" => $zamowienie['uzytkownik_id']
        )
      );
      $uzytkownik = $this->db->singleRow();

      // Pobierz produkty
      $this->db->query(
        "SELECT * FROM zamowienia_pobierz_produkty(:id)",
        array(
          "id" => $id
        )
      );
      $produkty = $this->db->multipleRows();
    } catch (PDOException $e) {
      $_SESSION["error__index"] = $this->helpers->formatErrorMsg($e->getMessage());
      return $this->helpers->redirectNamed("zamowienia.index");
    };

    return $this->twig->render('/administrator/zamowienia/edit.html.twig', [
      'zamowienie' => $zamowienie,
      'uzytkownik' => $uzytkownik,
      'produkty' => $produkty,
    ]);
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
        "CALL zamowienia_zmien_status(:id, :status_zamowienia);",
        array(
          "id" => $id,
          "status_zamowienia" => $_POST["status_zamowienia"]
        )
      );
    } catch (PDOException $e) {
      $_SESSION["error__edit"] = $this->helpers->formatErrorMsg($e->getMessage());
      return $this->helpers->redirectNamed("zamowienia.edit");
    };

    $_SESSION["success__edit"] = "Poprawnie edytowano status zamówienia";
    return $this->helpers->redirectNamed("zamowienia.edit", $id);
  }

  public function storeApi()
  {
    // Pobranie parametrów przekazanych w body
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
      $this->db->query(
        "SELECT * FROM dodaj_zamowienie(:id_uzytkownika, :forma_platnosci, :array_produkty, :array_ilosci);",
        array(
          "id_uzytkownika" => $id_uzytkownika,
          "forma_platnosci" => $forma_platnosci,
          "array_produkty" => $array_produkty,
          "array_ilosci" => $array_ilosci,
        )
      );
      $row = $this->db->singleRow();
    } catch (PDOException $e) {
      return $this->helpers->getResponse()->httpCode(404)->json([
        'message' => $e->getMessage(),
      ]);
    };

    return $this->helpers->getResponse()->httpCode(200)->json([
      'id' => $row["dodaj_zamowienie"],
    ]);
  }
}
