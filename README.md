# Projekt sklepu online z elektroniką

Projekt zaliczeniowy na przedmiot Bazy Danych. Uniwersytet Rzeszowski, I st., 4 semestr.

Projekt wykonali: **Maciej Biel, Karol Bobowski, Kamil Data.**

Technologie: `PHP 8`, `PostgreSQL`



## Opis projektu

Tematem projektu jest aplikacja internetowa sklepu online z elektroniką. Aplikacja ta umożliwia administratorowi obsługę klientów, zarządzanie produktami, tworzenie nowych zamówień, ich edycję, usuwanie itp., Umożliwia również klientom składanie zamówień, oraz ich edycje.

Back-End, czyli cała logika biznesowa została w pełni przeniesiona do PostgreSQL. Z poziomu PHP wykonywane są jedynie funkcje oraz procedury zaimplementowane w PostgreSQL, które zwracają odpowiednie dane lub komunikaty, błędy itp.

Front-End został wykonany w czystym PHP bez żadnych frameworków. W aplikacji został użyty wzorzec MVC. Autoloading klas jest zgodny z PSR-4. Do szablonów wykorzystany został `Twig`, do generowania losowych danych użytkowników i adresów została użyta biblioteka `Faker`, natomiast do danych produktów służyła pomocą strona X-Kom. Jako router wykorzystany został `pecee/simple-router`. 

Polskie nazwy w nazwach folderów i klas występują na potrzeby przedmiotu.



## Funkcjonalności

- Logowanie administratorów oraz użytkowników.
- Dodawanie adresów dla użytkowników (CRUD).
- Dodawanie użytkowników (CRUD).
- Dodawanie produktów (CRUD)
- Dodawanie zamówień (CRUD).
- Nie można usuwać adresów przypisanych do użytkowników, zostanie zwrócony komunikat o naruszeniu więzów integralności.
- Wybieranie adresu dla użytkownika realizowane jest przez asynchroniczne pole tekstowe, który poprzez API z poziomu JavaScriptu odpytuje na bieżąco pole tekstowe podpowiedzią z autouzupełnianiem. Ten sam mechanizm jest zastosowany przy składaniu zamówienia. Dzięki temu, możemy mieć w bazie bardzo obszerną ilość rekordów, która przy wybieraniu z pola tekstowego będzie wyświetlona w przyjaznej dla użytkownika formie.
- Produkty posiadają stan magazynowy.
- Składanie zamówienia:
  - Wybieramy użytkownika z listy użytkowników z autouzupełniania.
  - Wybieramy produkt oraz jego ilość. Jeżeli jego ilość wynosi zero, nie zostanie on wyświetlony na liście. Jeżeli wybierzemy ilość produktu większą niż wynosi jego stan magazynowy, zostanie zwrócony błąd. Nie możemy dwa razy wybrać tego samego produktu.
  - Możemy edytować elementy w koszyku.
  - Po złożeniu zamówienia, zostanie zaktualizowany jego stan magazynowy.
- Zamówienia:
  - Nie można ich usuwać, można tylko zmieniać ich statusy.
    - Jeżeli anulujemy zamówienie, to zostanie przywrócony stan magazynowy zamówionych produktów. Dalsza możliwość zmiany statusu zamówienia zostaje zablokowana.
      - Jeżeli produkt został usunięty, to zostanie ponownie dodany.
      - Jeżeli dane produktu zostały zmienione, to i tak zostanie uzupełniony jego stan na podstawie kodu producenta.
    - Jeżeli ustawimy zamówieniu status zrealizowane, to również dalsza możliwość zmiany statusu zostanie zablokowana.
  - Klient po zalogowaniu się na konto ma podgląd złożonych na niego zamówień, poprzez administratora, lub sam może złożyć dane zamówienie
- Wszystkie modyfikacje tabel oraz akcje w systemie są logowane w specjalnej zakładce.



## Prezentacja fragmentów aplikacji

Strona główna

![localhost_projekt-bazy_](https://user-images.githubusercontent.com/6316812/175574896-7768a41f-536a-4741-aa1c-ee1b23a96d83.png)



Panel logowania

![localhost_projekt-bazy_login_](https://user-images.githubusercontent.com/6316812/175574939-21fe8395-6524-4243-845f-7561c6b0f8f2.png)



Panel administratora

![localhost_projekt-bazy_admin_ (1)](C:\Users\gigachad\Desktop\bazy ssy\localhost_projekt-bazy_admin_ (1).png)



Panel administratora - adresy użytkowników

![localhost_projekt-bazy_admin_adresy_](https://user-images.githubusercontent.com/6316812/175575310-f0a64851-d61e-470d-9ac5-73334237f0f4.png)



Panel administratora - dodawanie adresów

![localhost_projekt-bazy_admin_adresy_dodaj_](https://user-images.githubusercontent.com/6316812/175578707-d04dd369-3bf0-4105-bda6-b1d9eb78f20f.png)



Panel administratora - podgląd adresu

![localhost_projekt-bazy_admin_adresy_1](https://user-images.githubusercontent.com/6316812/175577859-f66ddf27-2b2e-45c2-a4c3-cfcf6a5c8007.png)



Panel administratora - edytowanie adresów

![localhost_projekt-bazy_admin_adresy_edytuj_1](https://user-images.githubusercontent.com/6316812/175575404-7d8e3e4b-1e7b-41c2-bcbb-1f3f4daea560.png)



Panel administratora - użytkownicy

![localhost_projekt-bazy_admin_uzytkownicy_](https://user-images.githubusercontent.com/6316812/175575496-f04f06fb-fbed-460b-9b6d-17d88cd2d8b4.png)



Panel administratora - podgląd użytkownika

![localhost_projekt-bazy_admin_uzytkownicy_1](https://user-images.githubusercontent.com/6316812/175576390-03c6c949-88f7-422c-a3f6-01f280ac951a.png)



Panel administratora - dodawanie użytkownika

![localhost_projekt-bazy_admin_uzytkownicy_dodaj_](https://user-images.githubusercontent.com/6316812/175575658-34551202-0cae-47f7-b50c-df4a67c9c415.png)



Panel administratora - edytowanie użytkownika



Panel administratora - produkty

![localhost_projekt-bazy_admin_produkty_](https://user-images.githubusercontent.com/6316812/175575736-0c8f2f3b-28be-4224-88a3-d0c4b219224a.png)



Panel administratora - podgląd produktu

![localhost_projekt-bazy_admin_produkty_1](https://user-images.githubusercontent.com/6316812/175575813-f6f5a519-1d77-4ca8-bcda-c5ea8797c152.png)



Panel administratora - edytowanie produktu

![localhost_projekt-bazy_admin_produkty_edytuj_1](https://user-images.githubusercontent.com/6316812/175575863-b29e95b1-1965-426c-bced-ea239105fdc2.png)



Panel administratora - zamówienia

![localhost_projekt-bazy_admin_zamowienia_](https://user-images.githubusercontent.com/6316812/175575938-e9ebbdfb-2919-4dd8-a447-b3ded0be8bb3.png)



Panel administratora - dodawanie zamówienia

![localhost_projekt-bazy_admin_zamowienia_dodaj_ (1)](https://user-images.githubusercontent.com/6316812/175576001-94406e48-93b5-4ac7-8693-c48c70b49048.png)


![localhost_projekt-bazy_admin_zamowienia_dodaj_](https://user-images.githubusercontent.com/6316812/175575992-501db373-8b07-472f-8765-af9b2beacb58.png)



Panel administratora - podgląd zamówienia

![localhost_projekt-bazy_admin_zamowienia_edytuj_1](https://user-images.githubusercontent.com/6316812/175576083-47bd4af8-1254-4202-9238-0f076f031b46.png)



Panel użytkownika - podgląd zamówienia

![localhost_projekt-bazy_user_](https://user-images.githubusercontent.com/6316812/175614607-435b9003-d754-429f-94aa-ae85918efee5.png)



Panel administratora - logi systemowe

![localhost_projekt-bazy_admin_logi_](https://user-images.githubusercontent.com/6316812/175612528-1262b266-c4b7-4f3a-8de6-59b7f46915a5.png)
