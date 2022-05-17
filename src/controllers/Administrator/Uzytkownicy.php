<?php

namespace App\Controllers\Administrator;

use App\Classes\Controller;
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
        $this->db->query(
          "SELECT * FROM uzytkownicy_paginuj_wyszukaj(:search, :page, :perPage)",
          array(
            "search" => $search,
            "page" => $page,
            "perPage" => $perPage,
          )
        );
        $uzytkownicy = $this->db->multipleRows();

        $this->db->query(
          "SELECT COUNT(*) FROM uzytkownicy_wyszukaj(:search)",
          array(
            "search" => $search
          )
        );
        $rowCount = $this->db->singleRow();
        $pages = ceil($rowCount["count"] / $perPage);
      } else {
        $this->db->query(
          "SELECT * FROM uzytkownicy_pobierz(:page, :perPage)",
          array(
            "page" => $page,
            "perPage" => $perPage,
          )
        );
        $uzytkownicy = $this->db->multipleRows();

        $this->db->query("SELECT * FROM uzytkownicy_pobierz_ilosc();");
        $rowCount = $this->db->singleRow();

        $pages = ceil($rowCount["uzytkownicy_pobierz_ilosc"] / $perPage);
      }
    } catch (PDOException $e) {
      $_SESSION["error__index"] = $this->helpers->formatErrorMsg($e->getMessage());
    };

    // Pagination links builder
    $pagination = $this->helpers->buildPagination($pages, $page);

    return $this->twig->render(
      '/administrator/uzytkownicy/index.html.twig',
      [
        'uzytkownicy' => $uzytkownicy,
        'pagination' => $pagination
      ]
    );
  }

  // Wyświetla stronę do dodawania
  public function create()
  {
    return $this->twig->render(
      '/administrator/uzytkownicy/create.html.twig',
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
        "CALL uzytkownicy_dodaj(:imie, :nazwisko, :nazwa_uzytkownika, :email, :telefon, :haslo, :adres_id);",
        array(
          "imie" => $_POST["imie"],
          "nazwisko" => $_POST["nazwisko"],
          "nazwa_uzytkownika" => $_POST["nazwa_uzytkownika"],
          "email" => $_POST["email"],
          "telefon" => $_POST["telefon"],
          "haslo" => $_POST["haslo"],
          "adres_id" => $_POST["adres_id"],
        )
      );
    } catch (PDOException $e) {
      $_SESSION["error__add"] = $this->helpers->formatErrorMsg($e->getMessage());
      return $this->helpers->redirectNamed("uzytkownicy.create");
    };

    $_SESSION["success__index"] = "Poprawnie dodano nowego użytkownika";
    return $this->helpers->redirectNamed("uzytkownicy.index");
  }

  // Wyświetla stronę z pojedyńczym rekordem
  public function show($id)
  {
    try {
      $this->db->query(
        "SELECT * FROM uzytkownicy_pobierz_szczegoly_wszystkie(:id);",
        array(
          "id" => $id,
        )
      );
      $uzytkownik = $this->db->singleRow();

      $this->db->query(
        "SELECT * FROM zamowienia_znajdz_po_uid(:id_uzytkownika);",
        array(
          "id_uzytkownika" => $uzytkownik["id"]
        )
      );
      $zamowienia = $this->db->multipleRows();
    } catch (PDOException $e) {
      // Jeżeli nie istnieje rekord z danym id to wróć na stronę główną.
      $_SESSION["error__index"] = $this->helpers->formatErrorMsg($e->getMessage());
      return $this->helpers->redirectNamed("uzytkownicy.index");
    };

    return $this->twig->render('/administrator/uzytkownicy/show.html.twig', [
      'uzytkownik' => $uzytkownik,
      'zamowienia' => $zamowienia,
    ]);
  }

  // Wyświetla stronę do edycji
  public function edit($id)
  {
    try {
      $this->db->query(
        "SELECT * FROM uzytkownicy_pobierz_szczegoly_wszystkie(:id);",
        array(
          "id" => $id,
        )
      );
      $row = $this->db->singleRow();
    } catch (PDOException $e) {
      // Jeżeli nie istnieje rekord z danym id to wróć na stronę główną.
      $_SESSION["error__index"] = $this->helpers->formatErrorMsg($e->getMessage());
      return $this->helpers->redirectNamed("uzytkownicy.index");
    };

    return $this->twig->render(
      '/administrator/uzytkownicy/edit.html.twig',
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
        "CALL uzytkownicy_edytuj(:id, :imie, :nazwisko, :nazwa_uzytkownika, :email, :telefon, :haslo, :adres_id);",
        array(
          "id" => $id,
          "imie" => $_POST["imie"],
          "nazwisko" => $_POST["nazwisko"],
          "nazwa_uzytkownika" => $_POST["nazwa_uzytkownika"],
          "email" => $_POST["email"],
          "telefon" => $_POST["telefon"],
          "haslo" => $_POST["haslo"],
          "adres_id" => $_POST["adres_id"],
        )
      );
    } catch (PDOException $e) {
      $_SESSION["error__edit"] = $this->helpers->formatErrorMsg($e->getMessage());
      return $this->helpers->redirectNamed("uzytkownicy.edit");
    };

    $_SESSION["success__edit"] = "Poprawnie edytowano użytkownika.";
    return $this->helpers->redirectNamed("uzytkownicy.edit");
  }

  // Usuwa podany rekord
  public function destroy($id)
  {
    if ($id == $_SESSION["id"]) {
      $_SESSION["error__index"] = "Nie możesz usunąć samego siebie";
      return $this->helpers->redirectNamed("uzytkownicy.index");
    }

    try {
      $this->db->query(
        "DELETE FROM uzytkownicy WHERE id = :id",
        array(
          "id" => $id
        )
      );
    } catch (PDOException $e) {
      $_SESSION["error__index"] = $this->helpers->formatErrorMsg($e->getMessage());
      return $this->helpers->redirectNamed("uzytkownicy.index");
    };

    $_SESSION["success__index"] = "Poprawnie usunięto uzytkownika o id = $id";
    return $this->helpers->redirectNamed("uzytkownicy.index");
  }

  // Wyszukiwanie użytkownika jako endpoint
  public function searchUser()
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
        "SELECT * FROM uzytkownicy_wyszukaj(:name)",
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
