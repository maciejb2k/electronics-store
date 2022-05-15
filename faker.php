<?php

require_once 'vendor/autoload.php';

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

// Genero
$phoneNumbers = array();
function generatePhone()
{
  global $phoneNumbers;

  while (true) {
    $phone = rand(100000000, 999999999);

    if (!in_array($phone, $phoneNumbers)) {
      array_push($phoneNumbers, $phone);
      return $phone;
    }
  }
}

// Uzytkownicy
for ($i = 1; $i <= 1000; $i++) {
  $firstName = $faker->firstName();
  $lastName = $faker->lastName();
  $username = mb_strtolower($firstName . $lastName . rand(0, 1000000));
  $email = $username . "@" . $faker->safeEmailDomain();
  $phone = generatePhone();
  $password = sha1($faker->password());

  echo "INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('{$faker->dateTimeThisYear()->format('Y-m-d H:i:s')}', '{$email}', '{$password}', '{$firstName}', '{$username}', '{$lastName}', '{$phone}', '{$i}');" . "<br>";
}
