# Projekt Bazy Danych

Projekt zaliczeniowy na bazy danych, UR III semestr.

## Wymagania

- PostgreSQL
- PHP 8
- Composer
- XAMPP

## Instalacja

Stworzyć bazę w PgAdmin, stworzyć tabele (w dobrej kolejności by klucze się zgadzały), funkcje, procedury i na koniec zaseedować bazę.

Przenieść folder projektu do jakiegoś serwera www (htdocs w xampp).

Włączyć `php.ini`:

```
extension=pdo_pgsql
extension=pgsql
```

Następnie instalujemy zależności z composera:

```
composer install
```

Wygenerować autoloader composer jak nie został zrobiony (by można było automatycznie wywoływać klasy).

```
composer dump-autoload -o
```

Pozmieniać w pliku `src/classes/Config.php` to co nas interesuje.

Strona jest dostosowana do wyświetlania w podstronie np: `localhost/projekt-bazy/`
