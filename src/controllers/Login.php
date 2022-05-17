<?php

namespace App\Controllers;

use App\Classes\Controller;

use \PDOException;

class Login extends Controller
{
  public function index()
  {
    $zalogowany = $_SESSION['zalogowany'] ?? null;

    if ($zalogowany) {
      return $this->loginRedirect();
    }

    return $this->twig->render(
      '/login.html.twig',
      []
    );
  }

  public function loginRedirect()
  {
    if ($_SESSION['rola'] == 'administrator') {
      return $this->helpers->redirectNamed('admin.index');
    } else if ($_SESSION['rola'] == 'uzytkownik') {
      return $this->helpers->redirectNamed('user.index');
    } else {
      return $this->helpers->redirectNamed('home.index');
    }
  }

  public function login()
  {
    foreach ($_POST as $key => $value) {
      echo 'Key = ' . $key . '<br />';
      echo 'Value= ' . $value . '<br /><br />';
    }

    $email = $_POST["email"];
    $haslo = $_POST["haslo"];

    if (empty($email)) {
      $_SESSION["error__login"] = "Podaj email";
      return $this->helpers->redirectNamed("login.index");
    }

    if (empty($haslo)) {
      $_SESSION["error__login"] = "Podaj hasło";
      return $this->helpers->redirectNamed("login.index");
    }

    try {
      $this->db->query("SELECT * FROM zaloguj(:email, :haslo)", array(
        "email" => $email,
        "haslo" => $haslo
      ));
      $uzytkownik = $this->db->singleRow();
    } catch (PDOException $e) {
      $_SESSION["error__login"] = $this->helpers->formatErrorMsg($e->getMessage());
      return $this->helpers->redirectNamed("login.index");
    }

    $_SESSION['rola'] = $uzytkownik['rola'];
    $_SESSION['zalogowany'] = true;
    $_SESSION['id'] = $uzytkownik['id'];
    $_SESSION['email'] = $uzytkownik['email'];

    return $this->loginRedirect();
  }

  public function logout()
  {
    session_destroy();
    $_SESSION = array();
    return $this->helpers->redirectNamed('login.index');
  }
}
