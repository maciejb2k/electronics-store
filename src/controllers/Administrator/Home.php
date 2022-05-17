<?php

namespace App\Controllers\Administrator;

use App\Classes\Controller;
use Faker;

class Home extends Controller
{
  private $phoneNumbers = array();

  public function index()
  {
    $this->db->query("SELECT COUNT(*) FROM produkty");
    $iloscProduktow = $this->db->singleRow();

    $this->db->query("SELECT COUNT(*) FROM uzytkownicy");
    $iloscUzytkownikow = $this->db->singleRow();

    $this->db->query("SELECT COUNT(*) FROM zamowienia");
    $iloscZamowien = $this->db->singleRow();

    $this->db->query("SELECT COUNT(*) FROM logi");
    $iloscLogow = $this->db->singleRow();

    $this->db->query("SELECT SUM(ilosc) FROM zamowienia_produkty;");
    $iloscZamowionychProduktow = $this->db->singleRow();

    return $this->twig->render(
      '/administrator/index.html.twig',
      [
        "iloscProduktow" => $iloscProduktow["count"],
        "iloscUzytkownikow" => $iloscUzytkownikow["count"],
        "iloscZamowien" => $iloscZamowien["count"],
        "iloscLogow" => $iloscLogow["count"],
        "iloscZamowionychProduktow" => $iloscZamowionychProduktow["sum"],
      ]
    );
  }

  public function generateSeed()
  {
    $faker = new Faker\Generator();
    $faker->addProvider(new Faker\Provider\pl_PL\Address($faker));
    $faker->addProvider(new Faker\Provider\pl_PL\Person($faker));
    $faker->addProvider(new Faker\Provider\DateTime($faker));
    $faker->addProvider(new Faker\Provider\Internet($faker));
    $faker->addProvider(new Faker\Provider\en_US\PhoneNumber($faker));

    // Adresy
    for ($i = 0; $i < 1000; $i++) {
      echo "INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('{$faker->postcode()}', '{$faker->country()}', '{$faker->city()}', '{$faker->buildingNumber()}', '{$faker->streetName()}');" . "<br>";
    }

    // Uzytkownicy
    for ($i = 1; $i <= 1000; $i++) {
      $firstName = $faker->firstName();
      $lastName = $faker->lastName();
      $username = mb_strtolower($firstName . $lastName . rand(0, 1000000));
      $email = $username . "@" . $faker->safeEmailDomain();
      $phone = $this->generatePhone();
      $password = sha1("password");

      echo "INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('{$faker->dateTimeThisYear()->format('Y-m-d H:i:s')}', '{$email}', '{$password}', '{$firstName}', '{$username}', '{$lastName}', '{$phone}', '{$i}');" . "<br>";
    }
  }

  private function generatePhone()
  {
    while (true) {
      $phone = rand(100000000, 999999999);

      if (!in_array($phone, $this->phoneNumbers)) {
        array_push($this->phoneNumbers, $phone);
        return $phone;
      }
    }
  }
}
