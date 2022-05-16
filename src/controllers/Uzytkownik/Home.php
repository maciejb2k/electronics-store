<?php

namespace App\Controllers\Uzytkownik;

use App\Classes\Controller;

use \PDOException;

class Home extends Controller
{
  public function index()
  {
    try {
      $this->db->query(
        "SELECT * FROM uzytkownicy_pobierz_szczegoly_wszystkie(:id);",
        array(
          "id" => $_SESSION['id'],
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

    return $this->twig->render('/uzytkownik/index.html.twig', [
      'uzytkownik' => $uzytkownik,
      'zamowienia' => $zamowienia,
    ]);
  }

  public function orderCreate()
  {
    return $this->twig->render('/uzytkownik/zamowienia/create.html.twig', []);
  }

  public function orderStore()
  {
    // Pobranie parametrów przekazanych w body
    $request_body = file_get_contents('php://input');
    $data = json_decode($request_body, true);
    $array_produkty = $data['array_produkty'] ?? null;
    $array_ilosci = $data['array_ilosci'] ?? null;
    $forma_platnosci = $data['forma_platnosci'] ?? null;

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

    $array_produkty = trim($array_produkty);
    $array_ilosci = trim($array_ilosci);
    $forma_platnosci = trim($forma_platnosci);

    try {
      $this->db->query(
        "SELECT * FROM dodaj_zamowienie(:id_uzytkownika, :forma_platnosci, :array_produkty, :array_ilosci);",
        array(
          "id_uzytkownika" => $_SESSION["id"],
          "forma_platnosci" => $forma_platnosci,
          "array_produkty" => $array_produkty,
          "array_ilosci" => $array_ilosci,
        )
      );
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

  // Wyświetla stronę do edycji
  public function orderShow($id)
  {
    try {
      // Pobierz zamówienie
      $this->db->query(
        "SELECT * FROM zamowienia_znajdz(:id) WHERE uzytkownik_id = :userid",
        array(
          "id" => $id,
          "userid" => $_SESSION["id"]
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

    return $this->twig->render('/uzytkownik/zamowienia/show.html.twig', [
      'zamowienie' => $zamowienie,
      'uzytkownik' => $uzytkownik,
      'produkty' => $produkty,
    ]);
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
