# Projekt Bazy Danych

Projekt zaliczeniowy na bazy danych, UR III semestr.

## Wymagania

- PostgreSQL
- PHP 8
- Composer
- XAMPP

## Instalacja

Stworzyć bazę danych w pgAdmin np. "projekt-bazy" i w query builder z pliku `final.sql` wkleić cały kod i zbudować bazę.

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

Pozmieniać w pliku `src/config/Config.php` to co nas interesuje.

Strona jest dostosowana do wyświetlania w podstronie np: `localhost/projekt-bazy/`. Jeżeli strona będzie wyświetlana w folderze głównym, czyli pod domeną np. `localhost/` to zmienną `$SUBDIR` w `Config.php` trzeba ustawić na pusty string, lub jak w innej nazwie podfolderu to na taką samą nazwę w `Config.php` w tej zmiennej.

Po wykonaniu powyższych kroków projekt powinien działać.
