<?php

namespace App\Controllers;

use App\Classes\Controller;

use \PDOException;

class Logi extends Controller
{
  public function index()
  {
    try {
      $this->db->query(
        "SELECT * FROM logi;",
      );
      $logi = $this->db->multipleRows();
    } catch (PDOException $e) {
      $_SESSION["error__index"] = $this->helpers->formatErrorMsg($e->getMessage());
    };

    return $this->twig->render(
      '/logi.html.twig',
      [
        'logi' => $logi,
      ]
    );
  }
}
