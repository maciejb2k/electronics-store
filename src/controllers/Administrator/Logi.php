<?php

namespace App\Controllers\Administrator;

use App\Classes\Controller;

use \PDOException;

class Logi extends Controller
{
  public function index()
  {
    $perPage = 30;
    $pages = 1;
    $page = $_GET["page"] ?? 1;

    try {
      $this->db->query(
        "SELECT * FROM logi_pobierz(:page, :perPage)",
        array(
          "page" => $page,
          "perPage" => $perPage,
        )
      );
      $logi = $this->db->multipleRows();

      $this->db->query("SELECT * FROM logi_pobierz_ilosc();");
      $rowCount = $this->db->singleRow();
      $pages = ceil($rowCount["logi_pobierz_ilosc"] / $perPage);
    } catch (PDOException $e) {
      $_SESSION["error__index"] = $this->helpers->formatErrorMsg($e->getMessage());
    };

    // Pagination links builder
    $pagination = $this->helpers->buildPagination($pages, $page);

    return $this->twig->render(
      '/administrator/logi.html.twig',
      [
        'logi' => $logi,
        'pagination' => $pagination
      ]
    );
  }
}
