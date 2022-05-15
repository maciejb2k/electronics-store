<?php

namespace App\Controllers;

use App\Classes\Controller;
use App\Classes\Config;

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
                $this->db->query("SELECT * FROM adresy_paginuj_wyszukaj('{$search}', {$page}, {$perPage})");
                $adresy = $this->db->multipleRows();

                $this->db->query("SELECT COUNT(*) FROM adresy_wyszukaj('{$search}');");
                $rowCount = $this->db->singleRow();
                $pages = ceil($rowCount["count"] / $perPage);
                // print_r($rowCount);
                // $pages = ceil($rowCount["count"] / $perPage);
            } else {
                $this->db->query("SELECT * FROM adresy_pobierz({$page}, {$perPage})");
                $adresy = $this->db->multipleRows();

                $this->db->query("SELECT * FROM adresy_pobierz_ilosc();");
                $rowCount = $this->db->singleRow();
                $pages = ceil($rowCount["adresy_pobierz_ilosc"] / $perPage);
                // echo $pages;
                // print_r($row["adresy_pobierz_ilosc"]);
            }
        } catch (PDOException $e) {
            $this->db->error = $e->getMessage();
        };

        // Pagination links builder
        $pagination = $this->helpers->buildPagination($pages, $page);

        return $this->twig->render(
            '/adresy/index.html.twig',
            [
                'adresy' => $adresy,
                'pagination' => $pagination
            ]
        );
    }

    public function create()
    {
        return $this->twig->render(
            '/adresy/create.html.twig',
            []
        );
    }

    public function store()
    {
        foreach ($_POST as $key => $value) {
            echo 'Key = ' . $key . '<br />';
            echo 'Value= ' . $value . '<br /><br />';
        }

        try {
            $this->db->query("SELECT * FROM adresy_dodaj('{$_POST["ulica"]}', '{$_POST["nr_mieszkania"]}', '{$_POST["miasto"]}', '{$_POST["kod_pocztowy"]}', '{$_POST["kraj"]}');");
        } catch (PDOException $e) {
            $_SESSION["error__add"] = $this->helpers->formatErrorMsg($e->getMessage());
            return $this->helpers->redirectNamed("adresy.create");
        };

        return $this->helpers->redirectNamed("adresy.index");
    }

    public function show($id)
    {
        try {
            $this->db->query("SELECT * FROM adresy_znajdz('$id');");
            $row = $this->db->singleRow();
        } catch (PDOException $e) {
            $_SESSION["error__index"] = $this->helpers->formatErrorMsg($e->getMessage());
            return $this->helpers->redirectNamed("adresy.index");
        };

        return $this->twig->render('/adresy/show.html.twig', ['data' => $row]);
    }

    public function edit($id)
    {
        try {
            $this->db->query("SELECT * FROM adresy_znajdz('$id');");
            $row = $this->db->singleRow();
        } catch (PDOException $e) {
            $_SESSION["error__index"] = $this->helpers->formatErrorMsg($e->getMessage());
            return $this->helpers->redirectNamed("adresy.index");
        };

        return $this->twig->render('/adresy/edit.html.twig', ['data' => $row]);
    }

    public function update($id)
    {
        foreach ($_POST as $key => $value) {
            echo 'Key = ' . $key . '<br />';
            echo 'Value= ' . $value . '<br /><br />';
        }

        try {
            $this->db->query("CALL adresy_edytuj('$id', '{$_POST["ulica"]}', '{$_POST["nr_mieszkania"]}', '{$_POST["miasto"]}', '{$_POST["kod_pocztowy"]}', '{$_POST["kraj"]}');");
        } catch (PDOException $e) {
            $_SESSION["error__edit"] = $this->helpers->formatErrorMsg($e->getMessage());
            return $this->helpers->redirectNamed("adresy.edit");
            die($e->getMessage());
        };

        $_SESSION["success__edit"] = "Poprawnie edytowano adres.";
        return $this->helpers->redirectNamed("adresy.edit", $id);
    }

    public function destroy($id)
    {
        try {
            $this->db->query("DELETE FROM adresy WHERE id = $id");
        } catch (PDOException $e) {
            $_SESSION["error__index"] = $this->helpers->formatErrorMsg($e->getMessage());
            return $this->helpers->redirectNamed("adresy.index");
        };

        return $this->helpers->redirectNamed("adresy.index");
    }

    public function searchAddreses()
    {
        $request_body = file_get_contents('php://input');
        $data = json_decode($request_body, true);
        $name = $data['name']; // Works!

        if (!isset($name)) {
            return $this->helpers->getResponse()->httpCode(404)->json([
                'message' => "Podaj argument",
            ]);
        }

        try {
            $this->db->query("SELECT * FROM adresy_wyszukaj('$name')");
            $row = $this->db->multipleRows();
        } catch (PDOException $e) {
        };

        return $this->helpers->getResponse()->httpCode(200)->json([
            'array' => json_encode($row),
        ]);
    }
}
