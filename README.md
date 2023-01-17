# An online electronics store project

A group project for a Database subject in college, completed by: **Maciej Biel, Karol Bobowski, Kamil Data.**

Technology stack: `PHP 8`, `PostgreSQL`, `PL/pgSQL`

## About the project

NOTE: Polish names in folders and class names appear for the purpose of the subject.

The project is an online electronics store web application. The application allows the administrator to manage customers, products, create new orders, edit them, delete them, etc. It also allows customers to place orders and edit them.

The back-end, or all the business logic, has been **fully transferred to PostgreSQL**. PHP is only used to perform f**unctions and procedures implemented in PostgreSQL**, which return appropriate data or messages, errors, etc.

The front-end was created using **pure PHP without any frameworks**. The MVC pattern was used in the application. Class autoloading complies with **PSR-4**. The Twig template was used, the Faker library was used to generate random user data and addresses, and the X-Kom website was used to help with product data. The pecee/simple-router was used as a router.

## Screeenshots

Homepage

![localhost_projekt-bazy_](https://user-images.githubusercontent.com/6316812/175574896-7768a41f-536a-4741-aa1c-ee1b23a96d83.png)

Login panel

![localhost_projekt-bazy_login_](https://user-images.githubusercontent.com/6316812/175574939-21fe8395-6524-4243-845f-7561c6b0f8f2.png)

Admin panel - home

![localhost_projekt-bazy_admin_ (1)](https://user-images.githubusercontent.com/6316812/175973061-e8b2c0d9-f6ae-41db-b60d-be4414f2848e.png)



Admin panel - all users addresses

![localhost_projekt-bazy_admin_adresy_](https://user-images.githubusercontent.com/6316812/175575310-f0a64851-d61e-470d-9ac5-73334237f0f4.png)



Admin panel - add user address

![localhost_projekt-bazy_admin_adresy_dodaj_](https://user-images.githubusercontent.com/6316812/175578707-d04dd369-3bf0-4105-bda6-b1d9eb78f20f.png)



Admin panel - show user address

![localhost_projekt-bazy_admin_adresy_1](https://user-images.githubusercontent.com/6316812/175577859-f66ddf27-2b2e-45c2-a4c3-cfcf6a5c8007.png)



Admin panel - edit user address

![localhost_projekt-bazy_admin_adresy_edytuj_1](https://user-images.githubusercontent.com/6316812/175575404-7d8e3e4b-1e7b-41c2-bcbb-1f3f4daea560.png)



Admin panel - all users

![localhost_projekt-bazy_admin_uzytkownicy_](https://user-images.githubusercontent.com/6316812/175575496-f04f06fb-fbed-460b-9b6d-17d88cd2d8b4.png)



Admin panel - show user

![localhost_projekt-bazy_admin_uzytkownicy_1](https://user-images.githubusercontent.com/6316812/175576390-03c6c949-88f7-422c-a3f6-01f280ac951a.png)



Admin panel - add user

![localhost_projekt-bazy_admin_uzytkownicy_dodaj_](https://user-images.githubusercontent.com/6316812/175575658-34551202-0cae-47f7-b50c-df4a67c9c415.png)


Admin panel - all products

![localhost_projekt-bazy_admin_produkty_](https://user-images.githubusercontent.com/6316812/175575736-0c8f2f3b-28be-4224-88a3-d0c4b219224a.png)



Admin panel - show product

![localhost_projekt-bazy_admin_produkty_1](https://user-images.githubusercontent.com/6316812/175575813-f6f5a519-1d77-4ca8-bcda-c5ea8797c152.png)


Admin panel - edit product

![localhost_projekt-bazy_admin_produkty_edytuj_1](https://user-images.githubusercontent.com/6316812/175575863-b29e95b1-1965-426c-bced-ea239105fdc2.png)



Admin panel - orders

![localhost_projekt-bazy_admin_zamowienia_](https://user-images.githubusercontent.com/6316812/175575938-e9ebbdfb-2919-4dd8-a447-b3ded0be8bb3.png)



Admin panel - add order

![localhost_projekt-bazy_admin_zamowienia_dodaj_ (1)](https://user-images.githubusercontent.com/6316812/175576001-94406e48-93b5-4ac7-8693-c48c70b49048.png)

Admin panel - add order

![localhost_projekt-bazy_admin_zamowienia_dodaj_](https://user-images.githubusercontent.com/6316812/175575992-501db373-8b07-472f-8765-af9b2beacb58.png)

Admin panel - show order

![localhost_projekt-bazy_admin_zamowienia_edytuj_1](https://user-images.githubusercontent.com/6316812/175576083-47bd4af8-1254-4202-9238-0f076f031b46.png)



Admin panel - show order

![localhost_projekt-bazy_user_](https://user-images.githubusercontent.com/6316812/175614607-435b9003-d754-429f-94aa-ae85918efee5.png)



Admin panel - system logs

![localhost_projekt-bazy_admin_logi_](https://user-images.githubusercontent.com/6316812/175612528-1262b266-c4b7-4f3a-8de6-59b7f46915a5.png)
