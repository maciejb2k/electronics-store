/*
    =========================================== INCLUDE'y ===========================================
*/
CREATE EXTENSION IF NOT EXISTS pgcrypto;
/*
    =========================================== BAZA DANYCH ===========================================
*/

DROP TABLE IF EXISTS uzytkownicy;
DROP TABLE IF EXISTS adresy;
DROP TABLE IF EXISTS produkty_historyczne;
DROP TABLE IF EXISTS zamowienia_produkty;
DROP TABLE IF EXISTS produkty;
DROP TABLE IF EXISTS zamowienia;
DROP TABLE IF EXISTS logi;
DROP TABLE IF EXISTS _t_zamowienia_produkty;


CREATE TABLE adresy (
	id				serial 			PRIMARY KEY,
	ulica			VARCHAR (64)	NOT NULL,
	nr_mieszkania 	VARCHAR (32)	NOT NULL,
	miasto 			VARCHAR (64)	NOT NULL,
	kod_pocztowy 	VARCHAR (6)		NOT NULL,
	kraj 			VARCHAR (64)	NOT NULL
);

CREATE TABLE produkty (
	id				serial 			PRIMARY KEY,
	nazwa			VARCHAR (128)	NOT NULL,
	kod_producenta	VARCHAR (64)	UNIQUE NOT NULL,
	cena			FLOAT			NOT NULL,
	opis			TEXT 			NOT NULL,
	kategoria		VARCHAR (32)	NOT NULL,
	ilosc			INT				NOT NULL DEFAULT floor(random() * 10 + 1)::int
);

CREATE TABLE produkty_historyczne (
	id				serial 			PRIMARY KEY,
	nazwa			VARCHAR (128)	NOT NULL,
	kod_producenta	VARCHAR (64)	NOT NULL,
	cena			FLOAT			NOT NULL,
	opis			TEXT 			NOT NULL,
	kategoria		VARCHAR (32)	NOT NULL
);

CREATE TABLE uzytkownicy (
	id					serial					PRIMARY KEY,
	adres_id			serial					NOT NULL,
	imie				VARCHAR (64)			NOT NULL,
	nazwisko			VARCHAR (64)			NOT NULL,
	nazwa_uzytkownika	VARCHAR (64)			UNIQUE NOT NULL,
	email 				VARCHAR (64)			UNIQUE NOT NULL,
	telefon				VARCHAR (11)			UNIQUE NOT NULL,
	haslo				VARCHAR (255)			NOT NULL,
	data_rejestracji	TIMESTAMP				NOT NULL DEFAULT CURRENT_TIMESTAMP,
	rola				VARCHAR(64)				DEFAULT 'uzytkownik',
	CONSTRAINT fk_adres	FOREIGN KEY(adres_id)	REFERENCES adresy(id)
);

CREATE TABLE zamowienia (
	id					serial 			PRIMARY KEY,
	uzytkownik_id		serial			NOT NULL,
	forma_platnosci		VARCHAR (32)	NOT NULL,
	data_zamowienia		TIMESTAMP		NOT NULL DEFAULT CURRENT_TIMESTAMP,
	status_zamowienia	VARCHAR (32)	NOT NULL DEFAULT 'Złożone',
	zrealizowano		BOOLEAN			NOT NULL DEFAULT FALSE,
	kwota				FLOAT			NOT NULL,
	usuniete			BOOLEAN			NOT NULL DEFAULT FALSE,
	CONSTRAINT fk_uzytkownik	FOREIGN KEY(uzytkownik_id)	REFERENCES uzytkownicy(id)
);

CREATE TABLE zamowienia_produkty (
	id				serial	 PRIMARY KEY,
	produkt_id		serial	 NOT NULL,
	zamowienie_id	serial	 NOT NULL,
	ilosc			int		 NOT NULL CHECK (ilosc > 0),
	CONSTRAINT fk_produkt 	 FOREIGN KEY(produkt_id) REFERENCES produkty_historyczne(id),
	CONSTRAINT fk_zamowienie FOREIGN KEY(zamowienie_id) REFERENCES zamowienia(id)
);

CREATE TABLE logi (
	id					serial			PRIMARY KEY,
	data_utworzenia		TIMESTAMP		NOT NULL DEFAULT CURRENT_TIMESTAMP,
	tabela				VARCHAR (32)	NOT NULL,
	akcja				VARCHAR (32)	NOT NULL,
	uzytkownik			VARCHAR (32)	NOT NULL,
	opis				VARCHAR (255)	NOT NULL
);

CREATE TABLE _t_zamowienia_produkty (
	nazwa			VARCHAR (128)	NOT NULL,
	kod_producenta	VARCHAR (64)	UNIQUE NOT NULL,
	cena			FLOAT			NOT NULL,
	opis			TEXT 			NOT NULL,
	kategoria		VARCHAR (32)	NOT NULL,
	ilosc			int				NOT NULL
);

/*
    =========================================== SEEDERY BAZY ===========================================
*/

INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('16-571', 'Polska', 'Mikołów', '34/00', 'Poziomkowa');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('74-013', 'Polska', 'Cieszyn', '36A/70', 'Wrocławska');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('61-239', 'Polska', 'Mokrzyska', '29', 'Tulipanów');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('44-055', 'Polska', 'Ostróda', '54A/19', 'Miedziana');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('36-092', 'Polska', 'Czaplinek', '66A', 'Ułańska');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('94-611', 'Polska', 'Józefów', '00', 'Lompy Józefa');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('35-367', 'Polska', 'Kłodzko', '91A', 'Karpacka');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('16-456', 'Polska', 'Inowrocław', '35A', 'Kwiatkowskiego Eugeniusza');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('52-775', 'Polska', 'Rumia', '57/66', 'Batalionów Chłopskich');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('70-321', 'Polska', 'Police', '99/47', 'Wrocławska');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('02-966', 'Polska', 'Kłobuck', '66', 'Prusa Bolesława');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('30-011', 'Polska', 'Oświęcim', '47A', 'Żółkiewskiego Stanisława');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('67-959', 'Polska', 'Dzierżoniów', '17A/36', 'Kochanowskiego Jana');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('98-323', 'Polska', 'Przędzel', '78A/30', 'Agrestowa');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('48-576', 'Polska', 'Szczecin', '14', 'Kolorowa');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('45-704', 'Polska', 'Łomża', '11', 'Sokola');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('94-421', 'Polska', 'Wągrowiec', '96', 'Zamkowa');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('39-873', 'Polska', 'Ostrów Wielkopolski', '11/18', 'Lelewela Joachima');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('62-067', 'Polska', 'Gliwice', '82', 'Łagiewnicka');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('02-568', 'Polska', 'Pruszków', '43A/60', 'Piaskowa');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('60-122', 'Polska', 'Lubliniec', '39/77', 'Sadowa');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('45-049', 'Polska', 'Iława', '48', 'Plebiscytowa');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('19-644', 'Polska', 'Kościan', '55A/33', 'Plater Emilii');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('29-575', 'Polska', 'Dzierżoniów', '12', 'Podgórna');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('89-856', 'Polska', 'Olkusz', '71A/97', 'Kopalniana');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('92-593', 'Polska', 'Nowy Sącz', '43A/61', 'Karłowicza Mieczysława');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('31-024', 'Polska', 'Tarnobrzeg', '99/19', 'Łanowa');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('85-629', 'Polska', 'Suwałki', '17A/32', 'Żwirki i Wigury');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('96-570', 'Polska', 'Szwecja', '56A/63', 'Chmielna');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('88-019', 'Polska', 'Szwecja', '18A', 'Dąbrowskiego Jana Henryka');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('17-752', 'Polska', 'Sulejówek', '21', 'Broniewskiego Władysława');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('90-428', 'Polska', 'Łódź', '62/45', 'Torowa');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('32-596', 'Polska', 'Swarzędz', '13', 'Lechicka');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('34-060', 'Polska', 'Pieszyce', '55A/42', 'Bohaterów Westerplatte');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('78-057', 'Polska', 'Warszawa', '91A/48', 'Konarskiego Stanisława');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('83-361', 'Polska', 'Będzin', '33A', 'Spółdzielcza');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('71-827', 'Polska', 'Żary', '33A/50', 'Sienna');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('93-861', 'Polska', 'Dębica', '27A/78', 'Dolna');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('20-897', 'Polska', 'Toruń', '83A', 'Niedziałkowskiego Mieczysława');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('56-166', 'Polska', 'Świdnik', '86A/05', 'Płocka');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('24-694', 'Polska', 'Kędzierzyn-Koźle', '96', 'Przyjaźni');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('06-757', 'Polska', 'Nowa Ruda', '54A', 'Batorego Stefana');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('72-659', 'Polska', 'Żyrardów', '19A/86', 'Gdyńska');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('56-139', 'Polska', 'Bielsko-Biała', '57A', 'Siewna');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('98-476', 'Polska', 'Pszczyna', '86A', 'Małopolska');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('09-397', 'Polska', 'Władysławowo', '49A', 'Skargi Piotra');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('16-495', 'Polska', 'Gliwice', '40', 'Skośna');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('71-454', 'Polska', 'Wodzisław Śląski', '00', 'Przybyszewskiego Stanisława');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('48-227', 'Polska', 'Grodzisk Mazowiecki', '48/41', 'Błękitna');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('93-903', 'Polska', 'Iława', '51A', 'Krasickiego Ignacego');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('20-023', 'Polska', 'Mysłowice', '50', 'Kilińskiego Jana');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('64-518', 'Polska', 'Szwecja', '30A/85', 'Staszica Stanisława');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('68-904', 'Polska', 'Będzin', '62', 'Kolejowa');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('42-577', 'Polska', 'Bochnia', '33', 'Puszkina Aleksandra');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('09-029', 'Polska', 'Iława', '61A/51', 'Karłowicza Mieczysława');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('17-515', 'Polska', 'Zborowskie', '82/18', 'Żurawia');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('99-940', 'Polska', 'Pruszków', '47/90', 'Żeglarska');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('30-073', 'Polska', 'Pęcice', '38/14', 'Jerozolimskie Al.');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('01-745', 'Polska', 'Swarzędz', '48A', 'Górna');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('21-733', 'Polska', 'Jelenia Góra', '55A', 'Jarzębinowa');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('10-683', 'Polska', 'Wągrowiec', '40', 'Kosynierów');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('68-208', 'Polska', 'Pszczyna', '37A/65', 'Cedrowa');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('55-186', 'Polska', 'Wola Kiedrzyńska', '94A', 'Porzeczkowa');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('19-232', 'Polska', 'Poznań', '55A/65', 'Porzeczkowa');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('63-800', 'Polska', 'Nowa Ruda', '92A', 'Bieszczadzka');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('69-576', 'Polska', 'Nowy Sącz', '85A/69', 'Zdrojowa');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('27-534', 'Polska', 'Kozienice', '60/43', 'Kilińskiego Jana');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('62-884', 'Polska', 'Mysłowice', '66', 'Lotnicza');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('48-117', 'Polska', 'Żory', '67A/66', 'Mokra');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('40-692', 'Polska', 'Turek', '41', 'Dąbrowskiej Marii');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('12-747', 'Polska', 'Sulejówek', '74A', 'Piotrkowska');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('68-078', 'Polska', 'Tomaszów Mazowiecki', '47A', 'Senatorska');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('07-126', 'Polska', 'Szteklin', '98A', 'Tulipanowa');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('87-091', 'Polska', 'Cieszyn', '17/56', 'Paderewskiego Ignacego');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('32-852', 'Polska', 'Głogów', '09/61', 'Jerozolimskie Al.');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('83-606', 'Polska', 'Jastrzębie-Zdrój', '22/07', 'Wyzwolenia');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('43-978', 'Polska', 'Czechowice-Dziedzice', '21A/45', 'Okrzei Stefana');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('33-885', 'Polska', 'Pieszyce', '23', 'Kosynierów');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('71-406', 'Polska', 'Tarnowskie Góry', '97', 'Zapolskiej Gabrieli');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('82-204', 'Polska', 'Bartoszyce', '34/71', 'Ogrodowa');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('86-459', 'Polska', 'Tarnowskie Góry', '79A/10', 'Dobra');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('65-798', 'Polska', 'Sulejówek', '43A', 'Wojska Polskiego Al.');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('40-598', 'Polska', 'Bogatynia', '07A', 'Mickiewicza Adama');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('70-197', 'Polska', 'Leszno', '87A/78', 'Kopalniana');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('70-542', 'Polska', 'Szteklin', '70A/27', 'Sportowa');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('35-083', 'Polska', 'Bełchatów', '14A/32', 'Gościnna');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('88-308', 'Polska', 'Kozienice', '51/25', 'Robotnicza');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('50-277', 'Polska', 'Bochnia', '60/39', 'Armii Krajowej');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('88-276', 'Polska', 'Tarnów', '64A/14', 'Wańkowicza Melchiora');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('66-232', 'Polska', 'Zgorzelec', '54/89', 'Czwartaków');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('01-612', 'Polska', 'Tomaszów Mazowiecki', '00A/09', 'Zielona');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('49-230', 'Polska', 'Oświęcim', '29', 'Jaśminowa');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('18-934', 'Polska', 'Warszawa', '55', 'Małachowskiego Stanisława');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('08-801', 'Polska', 'Wrocław', '55A', 'Żwirki i Wigury');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('58-647', 'Polska', 'Chorzów', '43/96', 'Dworska');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('23-315', 'Polska', 'Skalbmierz', '19', 'Koszykowa');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('62-006', 'Polska', 'Skarżysko-Kamienna', '03A', 'Chmielna');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('75-127', 'Polska', 'Świdnik', '05', 'Kościuszki Tadeusza Pl.');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('62-957', 'Polska', 'Wola Kiedrzyńska', '62A', 'Nadrzeczna');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('18-661', 'Polska', 'Jawor', '68', 'Sądowa');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('98-467', 'Polska', 'Bydgoszcz', '16A', 'Żeromskiego Stefana');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('19-923', 'Polska', 'Marylka', '99A', 'Kazimierza Wielkiego');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('75-084', 'Polska', 'Ostrów Mazowiecka', '41/27', 'Pola Wincentego');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('91-656', 'Polska', 'Białystok', '50A', 'Solidarności Al.');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('44-447', 'Polska', 'Jastarnia', '14A', 'Karłowicza Mieczysława');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('78-704', 'Polska', 'Świdwin', '81/81', 'Gołębia');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('75-462', 'Polska', 'Bogaczów', '39/37', 'Kruczkowskiego Leona');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('82-740', 'Polska', 'Zawiercie', '28/64', 'Koszykowa');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('11-241', 'Polska', 'Ostrzeszów', '40/61', 'Magazynowa');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('33-329', 'Polska', 'Kwidzyn', '90', 'Narutowicza Gabriela');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('71-989', 'Polska', 'Wrocław', '20', 'Turkusowa');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('65-862', 'Polska', 'Zakopane', '45A', 'Łanowa');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('37-668', 'Polska', 'Sieradz', '50/37', 'Wspólna');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('67-645', 'Polska', 'Olkusz', '51A/55', 'Jaworowa');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('99-964', 'Polska', 'Ciechanów', '71/28', 'Jagodowa');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('20-836', 'Polska', 'Stargard Szczeciński', '26A/36', 'Widok');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('76-264', 'Polska', 'Piaseczno', '11/32', 'Stroma');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('47-493', 'Polska', 'Wilkowice', '35/51', 'Jarzębinowa');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('89-898', 'Polska', 'Tarnów', '30A', 'Diamentowa');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('72-904', 'Polska', 'Chrzanów', '87/05', 'Nadbrzeżna');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('95-191', 'Polska', 'Tczew', '71A', 'Zajęcza');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('01-655', 'Polska', 'Chrzanów', '27', 'Górna');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('90-612', 'Polska', 'Ustka', '90', 'Warmińska');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('43-482', 'Polska', 'Pruszków', '88/99', 'Piastowska');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('62-995', 'Polska', 'Czarna Woda', '83/07', 'Rycerska');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('81-399', 'Polska', 'Bytom', '44A', 'Cieszyńska');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('35-310', 'Polska', 'Bydgoszcz', '71/02', 'Jasna');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('06-850', 'Polska', 'Świdnica', '31', 'Pola Wincentego');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('27-911', 'Polska', 'Pieszyce', '52A', 'Sikorskiego Władysława');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('84-091', 'Polska', 'Częstochowa', '12A', 'Kamienna');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('72-457', 'Polska', 'Lubojenka', '65', 'Żabia');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('99-750', 'Polska', 'Kętrzyn', '23A/60', 'Stroma');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('87-597', 'Polska', 'Jelcz-Laskowice', '65A/07', 'Rejtana Tadeusza');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('26-027', 'Polska', 'Brodnica', '37A/99', 'Szewska');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('66-879', 'Polska', 'Opole', '24/94', 'Stawowa');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('52-011', 'Polska', 'Wilkowice', '47A', 'Inżynierska');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('82-667', 'Polska', 'Łomża', '81', 'Błękitna');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('11-155', 'Polska', 'Czaplinek', '10A', 'Rycerska');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('23-211', 'Polska', 'Bartoszyce', '29A', 'Patriotów');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('59-961', 'Polska', 'Wrocław', '34/39', 'Drzymały Michała');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('94-386', 'Polska', 'Kętrzyn', '66/18', 'Żurawia');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('61-289', 'Polska', 'Łódź', '65', 'Kwiatkowskiego Eugeniusza');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('48-777', 'Polska', 'Siemianowice Śląskie', '59A', 'Baczyńskiego Krzysztofa Kamila');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('78-590', 'Polska', 'Sochaczew', '09/48', 'Legionów');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('48-833', 'Polska', 'Świdwin', '50A/03', 'Piekarska');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('24-233', 'Polska', 'Świdnik', '66A', 'Tatrzańska');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('39-531', 'Polska', 'Sochaczew', '79', 'Modra');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('74-204', 'Polska', 'Orzesze', '75A/35', 'Gołębia');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('96-017', 'Polska', 'Kościan', '52A/27', 'Poziomkowa');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('96-890', 'Polska', 'Oświęcim', '30A', 'Czarnieckiego Stefana');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('34-875', 'Polska', 'Jawor', '49', 'Bydgoska');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('40-271', 'Polska', 'Kościan', '84A', 'Sucharskiego Henryka');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('17-313', 'Polska', 'Będzin', '00', 'Piastowskie Os.');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('84-569', 'Polska', 'Przędzel', '66/44', 'Zwycięstwa');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('97-745', 'Polska', 'Opole', '31A', 'Żółkiewskiego Stanisława');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('65-083', 'Polska', 'Rybnik', '73/73', 'Piłsudskiego Józefa Al.');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('29-236', 'Polska', 'Legnica', '84A', 'Lipowa');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('54-779', 'Polska', 'Jaworzno', '49A', 'Szkolna');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('58-017', 'Polska', 'Władysławowo', '79/47', 'Topolowa');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('26-963', 'Polska', 'Jelcz-Laskowice', '87A', 'Leśna');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('91-858', 'Polska', 'Gliwice', '34/48', 'Poniatowskiego Józefa');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('69-121', 'Polska', 'Piotrków Trybunalski', '34', 'Ptasia');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('20-935', 'Polska', 'Jemielnica', '31A/06', 'Lisia');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('31-257', 'Polska', 'Łódź', '48A', '1 Maja');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('31-080', 'Polska', 'Kielce', '60A', 'Niepodległości');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('04-500', 'Polska', 'Gdynia', '47', 'Zajęcza');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('02-245', 'Polska', 'Pęcice', '54A', 'Zapolskiej Gabrieli');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('30-544', 'Polska', 'Kętrzyn', '01', 'Jodłowa');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('91-599', 'Polska', 'Krapkowice', '44', 'Szymanowskiego Karola');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('57-333', 'Polska', 'Łowicz', '41A', 'Kręta');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('78-920', 'Polska', 'Bogaczów', '25A/09', 'Reymonta Władysława Stanisława');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('94-970', 'Polska', 'Świecie', '69', 'Rynek Rynek');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('64-751', 'Polska', 'Jarosław', '23/80', 'Wróblewskiego Walerego');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('88-560', 'Polska', 'Brzeg', '85A/40', 'Wałowa');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('81-658', 'Polska', 'Kamień', '93A/19', 'Jastrzębia');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('40-149', 'Polska', 'Łęczna', '18', 'Rynek Rynek');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('01-071', 'Polska', 'Ełk', '16/41', 'Nowa');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('46-584', 'Polska', 'Katowice', '59A/14', 'Portowa');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('64-931', 'Polska', 'Łódź', '70A', 'Olsztyńska');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('39-841', 'Polska', 'Sochaczew', '08A/77', 'Zbożowa');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('79-945', 'Polska', 'Mokrzyska', '52/90', 'Sucharskiego Henryka');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('25-159', 'Polska', 'Jaworzno', '19A/46', 'Konopnickiej Marii');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('81-654', 'Polska', 'Boguszów-Gorce', '37A', 'Stwosza Wita');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('71-900', 'Polska', 'Jarosław', '83A', 'Wielkopolska');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('78-526', 'Polska', 'Bolesławiec', '01A/41', 'Warszawska');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('45-622', 'Polska', 'Tczew', '17/53', 'Przyjaźni');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('77-025', 'Polska', 'Wola Kiedrzyńska', '33A/03', 'Przyjaźni');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('12-224', 'Polska', 'Kamieniec Ząbkowicki', '58A', 'Wołodyjowskiego Michała');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('95-904', 'Polska', 'Kłobuck', '98/71', 'Bolesława Krzywoustego');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('14-598', 'Polska', 'Cieszyn', '17', 'Pszenna');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('52-485', 'Polska', 'Jarosław', '51A/18', 'Opolska');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('95-919', 'Polska', 'Gorzów Wielkopolski', '42A', '3 Maja');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('85-720', 'Polska', 'Przemyśl', '41/34', 'Poprzeczna');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('67-545', 'Polska', 'Osówiec', '48A', 'Poniatowskiego Józefa');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('06-587', 'Polska', 'Łomża', '21A/12', 'Kościuszki Tadeusza');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('67-859', 'Polska', 'Cieszyn', '72A', 'Siemiradzkiego Henryka');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('36-803', 'Polska', 'Świdnica', '40', 'Jana Pawła II Al.');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('44-032', 'Polska', 'Sieradz', '87/62', 'Małachowskiego Stanisława');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('63-573', 'Polska', 'Chorzów', '63', 'Limanowskiego Bolesława');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('23-702', 'Polska', 'Kamień', '37/58', 'Nowy Świat');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('81-598', 'Polska', 'Sochaczew', '86A', 'Węglowa');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('56-470', 'Polska', 'Giżycko', '19', 'Jesienna');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('55-608', 'Polska', 'Jawor', '67A/45', 'Dworska');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('36-209', 'Polska', 'Łoś', '43A', 'Sportowa');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('02-311', 'Polska', 'Radom', '55/83', 'Konwaliowa');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('51-565', 'Polska', 'Toruń', '10A', 'Krakowska');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('18-655', 'Polska', 'Boguszów-Gorce', '89/01', 'Maczka Stanisława');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('99-102', 'Polska', 'Sochaczew', '16', 'Reymonta Władysława');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('67-461', 'Polska', 'Żywiec', '71A/60', 'Zakopiańska');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('62-462', 'Polska', 'Ustka', '30', 'Wilcza');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('19-922', 'Polska', 'Żary', '33/81', 'Dąbrowszczaków');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('35-553', 'Polska', 'Skierniewice', '89A', 'Czereśniowa');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('72-885', 'Polska', 'Bogatynia', '69', 'Struga Andrzeja');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('82-560', 'Polska', 'Koszalin', '05/23', 'Hetmańska');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('88-203', 'Polska', 'Suwałki', '71A/45', 'Beskidzka');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('80-113', 'Polska', 'Pułtusk', '06A/73', 'Lisia');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('27-890', 'Polska', 'Toruń', '27', 'Starowiejska');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('56-394', 'Polska', 'Brodnica', '85', 'Górnicza');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('01-990', 'Polska', 'Siemianowice Śląskie', '78A/04', 'Gnieźnieńska');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('81-535', 'Polska', 'Kolonowskie', '70A/59', 'Malinowa');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('95-930', 'Polska', 'Braniewo', '63A/63', 'Głogowska');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('57-057', 'Polska', 'Łomża', '92A', 'Błękitna');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('16-434', 'Polska', 'Tomaszów Mazowiecki', '96', 'Modrzejewskiej Heleny');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('55-368', 'Polska', 'Sieradz', '70A', 'Korfantego Wojciecha');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('13-507', 'Polska', 'Wągrowiec', '30/96', 'Lwowska');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('31-704', 'Polska', 'Bielawa', '00A/49', 'Nowowiejskiego Feliksa');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('51-184', 'Polska', 'Tczew', '32A', 'Marszałkowska');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('42-947', 'Polska', 'Knurów', '02', 'Jaworowa');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('31-007', 'Polska', 'Sieradz', '98', 'Sucharskiego Henryka');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('18-926', 'Polska', 'Ławy', '29', 'Łomżyńska');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('51-591', 'Polska', 'Lublin', '22A', 'Reymonta Władysława');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('63-985', 'Polska', 'Nowy Sącz', '04/10', 'Targowa');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('50-064', 'Polska', 'Rynarzewo', '49/35', 'Węglowa');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('48-919', 'Polska', 'Magdalenka', '17', 'Drzymały Michała');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('90-489', 'Polska', 'Szczytno', '87', 'Piastowskie Os.');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('45-147', 'Polska', 'Nysa', '63/39', 'Poprzeczna');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('28-624', 'Polska', 'Gdynia', '35/63', 'Warmińska');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('76-404', 'Polska', 'Kamień', '40A', 'Skargi Piotra');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('70-710', 'Polska', 'Bydgoszcz', '83/30', 'Kartuska');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('78-142', 'Polska', 'Police', '70A/03', 'Bema Józefa');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('00-206', 'Polska', 'Kielce', '19A', 'Patriotów');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('29-240', 'Polska', 'Kędzierzyn-Koźle', '52', 'Wielkopolska');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('69-187', 'Polska', 'Chrzanów', '03A/97', 'Olimpijska');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('35-970', 'Polska', 'Mikołów', '02A/46', 'Wyzwolenia');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('70-414', 'Polska', 'Władysławowo', '55A', 'Brzoskwiniowa');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('48-089', 'Polska', 'Ząbki', '22A/72', 'Kwiatkowskiego Eugeniusza');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('64-237', 'Polska', 'Opole', '46/50', 'Bratków');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('33-995', 'Polska', 'Mokrzyska', '87A/16', 'Kaliska');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('81-320', 'Polska', 'Jadowniki', '85', 'Rynek');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('82-469', 'Polska', 'Mysłowice', '06', 'Krakowska');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('06-587', 'Polska', 'Zakopane', '32/07', 'Robotnicza');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('25-444', 'Polska', 'Pruszcz Gdański', '07A/32', 'Kruczkowskiego Leona');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('60-308', 'Polska', 'Kluczbork', '58A', 'Szkolna');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('44-848', 'Polska', 'Bytom', '26A/12', 'Piastowska');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('97-160', 'Polska', 'Szczytno', '06/49', 'Jarzębinowa');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('10-368', 'Polska', 'Radomsko', '19/94', 'Poniatowskiego Józefa');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('49-110', 'Polska', 'Sulejówek', '85A', 'Waryńskiego Ludwika');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('28-958', 'Polska', 'Sandomierz', '49A', 'Krzywa');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('70-863', 'Polska', 'Kwidzyn', '66A', 'Krótka');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('15-234', 'Polska', 'Nowa Ruda', '63A', 'Cieszyńska');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('61-045', 'Polska', 'Mikołów', '60', 'Dąbrowszczaków');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('53-639', 'Polska', 'Suwałki', '34', 'Żeglarska');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('49-526', 'Polska', 'Nowe Kramsko', '69A', 'Daleka');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('57-416', 'Polska', 'Piekary Śląskie', '70/88', 'Żwirki i Wigury');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('11-828', 'Polska', 'Luboń', '02/15', 'Hetmańska');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('54-312', 'Polska', 'Mokrzyska', '10/10', 'Piekarska');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('08-804', 'Polska', 'Konin', '93', 'Chłopska');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('11-577', 'Polska', 'Pilchowo', '08', 'Kossaka Juliusza');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('15-533', 'Polska', 'Police', '65A/98', 'Korczaka Janusza');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('93-903', 'Polska', 'Jarosław', '98', 'Zamkowa');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('26-473', 'Polska', 'Wejherowo', '85', 'Dąbrowskiego Jana Henryka');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('92-818', 'Polska', 'Jemielnica', '52A/67', 'Stroma');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('87-645', 'Polska', 'Gliwice', '59A/26', 'Stwosza Wita');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('27-503', 'Polska', 'Brodnica', '17A', 'Zakątek');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('53-739', 'Polska', 'Lubliniec', '32A', 'Małopolska');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('88-627', 'Polska', 'Bolesławiec', '43/38', 'Krasińskiego Zygmunta');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('53-931', 'Polska', 'Babienica', '53', 'Zacisze');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('81-985', 'Polska', 'Mielec', '96A/41', 'Beskidzka');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('30-251', 'Polska', 'Ostrowiec Świętokrzyski', '82A/46', 'Wandy');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('83-172', 'Polska', 'Szczecinek', '35', 'Toruńska');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('88-994', 'Polska', 'Ostrów Wielkopolski', '44A', 'Wierzbowa');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('05-202', 'Polska', 'Bezrzecze', '57A/38', 'Wapienna');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('54-919', 'Polska', 'Czarna Woda', '80/96', 'Orla');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('51-143', 'Polska', 'Nowa Sól', '45A', 'Perłowa');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('30-742', 'Polska', 'Jaworzno', '87', 'Saperów');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('73-026', 'Polska', 'Rybnik', '24A', 'Targowa');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('81-811', 'Polska', 'Bielawa', '50', 'Baczyńskiego Krzysztofa Kamila');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('22-167', 'Polska', 'Kołobrzeg', '16A', 'Piłsudskiego Józefa Al.');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('95-096', 'Polska', 'Łomianki', '76A/04', 'Krakowska');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('36-792', 'Polska', 'Katowice', '04A', 'Bema Józefa');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('29-445', 'Polska', 'Kościan', '18A', 'Skargi Piotra');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('51-422', 'Polska', 'Piaseczno', '52/56', 'Ludowa');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('72-728', 'Polska', 'Józefów', '69', 'Ogrodowa');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('43-207', 'Polska', 'Jarosław', '61A/62', 'Armii Krajowej');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('22-151', 'Polska', 'Pruszków', '84A', 'Spacerowa');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('27-074', 'Polska', 'Jadowniki', '97', 'Wolności');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('82-674', 'Polska', 'Koszalin', '39A/90', 'Kaszubska');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('41-982', 'Polska', 'Włocławek', '08A', 'Dolna');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('30-757', 'Polska', 'Kielce', '10/52', 'Botaniczna');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('92-958', 'Polska', 'Police', '85/84', 'Mazowiecka');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('08-471', 'Polska', 'Łoś', '55', 'Bracka');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('44-106', 'Polska', 'Elbląg', '55/85', 'Malinowa');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('60-915', 'Polska', 'Świdnik', '80A/28', 'Modrzewiowa');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('77-358', 'Polska', 'Świebodzice', '52A', 'Koralowa');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('00-821', 'Polska', 'Kamień', '45', 'Morska');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('89-470', 'Polska', 'Cieszyn', '08', 'Szmaragdowa');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('66-249', 'Polska', 'Pruszków', '85A/35', 'Warszawska');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('87-042', 'Polska', 'Olkusz', '11A/48', 'Orzechowa');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('07-093', 'Polska', 'Dąbrowa Górnicza', '85A/80', 'Skargi Piotra');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('90-605', 'Polska', 'Ostrów Wielkopolski', '74A', 'Sąsiedzka');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('13-603', 'Polska', 'Czarna Woda', '37A', 'Kielecka');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('95-544', 'Polska', 'Słupsk', '92A', 'Odrodzenia');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('71-152', 'Polska', 'Łoś', '71/56', 'Płocka');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('90-564', 'Polska', 'Boguszów-Gorce', '51', 'Szczęśliwa');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('73-551', 'Polska', 'Ostrzeszów', '34', 'Dmowskiego Romana');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('50-133', 'Polska', 'Szówsko', '60', 'Gdyńska');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('39-919', 'Polska', 'Magdalenka', '20/61', 'Kujawska');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('16-512', 'Polska', 'Koło', '81A/28', 'Świętokrzyska');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('16-184', 'Polska', 'Tczew', '61A', 'Kazimierza Wielkiego');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('82-025', 'Polska', 'Elbląg', '88A', 'Dąbrowskiego Jarosława');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('46-677', 'Polska', 'Zduńska Wola', '24A', 'Polna');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('37-657', 'Polska', 'Siemianowice Śląskie', '68A', 'Kłosowa');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('66-657', 'Polska', 'Dąbrowa Górnicza', '47', 'Topolowa');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('21-106', 'Polska', 'Krosno', '16/15', 'Skrajna');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('61-127', 'Polska', 'Trzebiatów', '53A/17', 'Nadrzeczna');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('92-940', 'Polska', 'Lubojenka', '22', 'Długa');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('69-112', 'Polska', 'Żyrardów', '31A', 'Karłowicza Mieczysława');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('88-353', 'Polska', 'Sanok', '77', 'Lisia');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('97-900', 'Polska', 'Ostrzeszów', '15A/29', 'Sportowa');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('59-499', 'Polska', 'Ełk', '00/77', 'Handlowa');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('58-983', 'Polska', 'Krępiec', '19A', 'Żurawia');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('13-439', 'Polska', 'Mielec', '50A/75', 'Fabryczna');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('52-223', 'Polska', 'Kuźnica Masłońska', '09/89', 'Hetmańska');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('95-316', 'Polska', 'Gorzów Wielkopolski', '35/62', 'Rolna');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('73-590', 'Polska', 'Płazów', '02/68', 'Płocka');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('84-630', 'Polska', 'Nowy Dwór Mazowiecki', '15/23', 'Zielona');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('11-322', 'Polska', 'Kutno', '16/57', 'Leśmiana Bolesława');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('31-134', 'Polska', 'Busko-Zdrój', '35', 'Staromiejska');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('88-263', 'Polska', 'Sulejówek', '76', 'Spokojna');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('01-619', 'Polska', 'Starachowice', '84A', 'Nowa');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('76-086', 'Polska', 'Tczew', '59', 'Świętojańska');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('76-379', 'Polska', 'Koszwały', '63A', 'Zielona');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('79-020', 'Polska', 'Zabrze', '85', 'Barlickiego Norberta');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('21-313', 'Polska', 'Skarżysko-Kamienna', '08A/41', 'Jałowcowa');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('72-962', 'Polska', 'Tomaszów Mazowiecki', '07', 'Dębowa');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('48-873', 'Polska', 'Suwałki', '84/58', 'Osiedlowa');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('91-801', 'Polska', 'Wałbrzych', '87A', 'Kamienna');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('67-929', 'Polska', 'Kościerzyna', '70A/25', 'Szczecińska');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('66-281', 'Polska', 'Lębork', '52A/67', 'Solna');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('55-072', 'Polska', 'Knurów', '76', 'Robotnicza');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('36-599', 'Polska', 'Pabianice', '84A', 'Dworska');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('71-665', 'Polska', 'Koło', '73/74', 'Broniewskiego Władysława');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('21-708', 'Polska', 'Iława', '79', 'Kłosowa');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('13-009', 'Polska', 'Płock', '25', 'Szymanowskiego Karola');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('02-528', 'Polska', 'Sopot', '02/84', 'Czarnieckiego Stefana');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('65-957', 'Polska', 'Kłodzko', '28A', 'Małachowskiego Stanisława');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('41-502', 'Polska', 'Bielsko-Biała', '17/32', 'Ogrodowa');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('73-001', 'Polska', 'Bartoszyce', '15', 'Patriotów');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('61-456', 'Polska', 'Krotoszyn', '73A/24', 'Franciszkańska');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('45-767', 'Polska', 'Zgierz', '79A', 'Azaliowa');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('49-831', 'Polska', 'Krotoszyn', '42/41', 'Jesionowa');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('39-248', 'Polska', 'Czerwionka-Leszczyny', '40A', 'Puławska');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('20-407', 'Polska', 'Kamień', '59/75', 'Letnia');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('78-494', 'Polska', 'Mielec', '59A', 'Agrestowa');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('42-166', 'Polska', 'Jasło', '97/53', 'Ligonia Juliusza');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('39-746', 'Polska', 'Gniezno', '84', 'Lotnicza');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('03-646', 'Polska', 'Suwałki', '09/50', 'Sadowa');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('98-729', 'Polska', 'Nowy Targ', '66', 'Bema Józefa');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('36-340', 'Polska', 'Bytom', '87A/63', 'Żwirki Franciszka i Wigury Stanisława');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('99-864', 'Polska', 'Giżycko', '31/67', 'Morska');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('64-531', 'Polska', 'Żory', '72A/42', 'Sikorskiego Władysława');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('85-298', 'Polska', 'Malbork', '94A', 'Saperów');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('83-456', 'Polska', 'Bolesławiec', '16', 'Kamienna');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('94-269', 'Polska', 'Łaziska Górne', '73A/72', 'Tatrzańska');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('34-529', 'Polska', 'Gorzów Wielkopolski', '35A', 'Batorego Stefana');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('38-533', 'Polska', 'Białystok', '36A', 'Zacisze');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('27-299', 'Polska', 'Luboń', '74/01', 'Dębowa');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('79-280', 'Polska', 'Bieruń', '92A/99', 'Solna');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('60-482', 'Polska', 'Puławy', '47A/67', 'Stwosza Wita');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('51-384', 'Polska', 'Lubliniec', '06A', 'Równa');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('89-177', 'Polska', 'Legionowo', '59A/79', 'Torowa');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('39-325', 'Polska', 'Iława', '44', 'Chłopska');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('41-715', 'Polska', 'Ławy', '90A/83', 'Ceglana');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('00-927', 'Polska', 'Myszków', '47', 'Miarki Karola');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('12-666', 'Polska', 'Brodnica', '86/85', 'Widok');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('34-932', 'Polska', 'Świdnik', '73/52', 'Dąbrowskiego Jarosława');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('69-710', 'Polska', 'Szczecinek', '42A/94', 'Gliwicka');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('46-793', 'Polska', 'Skarżysko-Kamienna', '02/12', 'Hoża');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('20-996', 'Polska', 'Opole', '50', 'Hoża');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('50-737', 'Polska', 'Legnica', '32/84', 'Pocztowa');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('64-759', 'Polska', 'Radomsko', '75A', 'Ligonia Juliusza');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('01-034', 'Polska', 'Krosno', '95A', 'Owocowa');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('13-926', 'Polska', 'Piaseczno', '20A/48', 'Sądowa');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('14-536', 'Polska', 'Radomsko', '19', 'Obrońców Westerplatte');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('70-181', 'Polska', 'Gorzów Wielkopolski', '31A/52', 'Tęczowa');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('61-136', 'Polska', 'Darłowo', '38A', 'Podleśna');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('90-085', 'Polska', 'Bogatynia', '51/25', 'Koralowa');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('13-092', 'Polska', 'Świecie', '56A/20', 'Wrzosowa');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('42-359', 'Polska', 'Ostrzeszów', '61/96', 'Bytomska');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('85-715', 'Polska', 'Puławy', '53', 'Jaracza Stefana');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('03-501', 'Polska', 'Chorzów', '67A', 'Leszczynowa');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('28-938', 'Polska', 'Szówsko', '88A', 'Sosnowa');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('07-005', 'Polska', 'Warszawa', '56/70', 'Częstochowska');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('21-236', 'Polska', 'Września', '18', 'Podhalańska');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('27-973', 'Polska', 'Pruszcz Gdański', '41/08', 'Kleeberga Franciszka');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('23-097', 'Polska', 'Gdańsk', '53/63', 'Skłodowskiej-Curie Marii');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('12-082', 'Polska', 'Chrzanów', '74A/16', 'Górnośląska');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('70-971', 'Polska', 'Wyszków', '19/55', 'Lotnicza');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('34-047', 'Polska', 'Kluczbork', '53A', 'Bałtycka');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('30-413', 'Polska', 'Świebodzice', '51A/60', 'Truskawkowa');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('75-573', 'Polska', 'Siedlce', '15/74', 'Wąska');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('39-265', 'Polska', 'Legnica', '18A/89', 'Łanowa');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('91-248', 'Polska', 'Knurów', '32/35', 'Bukowa');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('96-180', 'Polska', 'Busko-Zdrój', '43/26', 'Długa');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('59-748', 'Polska', 'Krępiec', '29A/59', 'Władysława IV');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('35-213', 'Polska', 'Piaseczno', '19A', 'Jana Pawła II');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('61-652', 'Polska', 'Żywiec', '65/31', 'Dobra');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('72-102', 'Polska', 'Skarżysko-Kamienna', '06/65', 'Bratków');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('06-040', 'Polska', 'Sieradz', '22', 'Bohaterów Westerplatte');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('66-056', 'Polska', 'Bytom', '58', 'Sportowa');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('02-542', 'Polska', 'Łoś', '16', 'Szarych Szeregów');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('83-098', 'Polska', 'Gliwice', '13A', 'Energetyków');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('55-356', 'Polska', 'Ostrów Wielkopolski', '84A', 'Sandomierska');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('95-256', 'Polska', 'Trzebiatów', '14A', 'Słonecznikowa');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('73-620', 'Polska', 'Bogaczów', '39A/47', 'Długa');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('12-314', 'Polska', 'Pruszcz Gdański', '94/89', 'Husarska');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('60-794', 'Polska', 'Piotrków Trybunalski', '93', 'Modrzejewskiej Heleny');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('66-726', 'Polska', 'Sulejówek', '02/29', 'Mazurska');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('80-002', 'Polska', 'Piła', '10/18', 'Partyzantów');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('77-294', 'Polska', 'Kalisz', '56A/53', 'Łokietka Władysława');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('35-728', 'Polska', 'Tarnowskie Góry', '01', 'Kazimierza Wielkiego');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('87-123', 'Polska', 'Kościan', '06A/10', 'Cicha');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('49-898', 'Polska', 'Rzeszów', '47', 'Partyzantów');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('25-650', 'Polska', 'Władysławowo', '69/93', 'Władysława IV');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('98-495', 'Polska', 'Kędzierzyn-Koźle', '66', 'Broniewskiego Władysława');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('73-906', 'Polska', 'Bezrzecze', '26A/21', 'Łódzka');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('83-794', 'Polska', 'Zakopane', '64/26', 'Tulipanów');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('76-347', 'Polska', 'Ustka', '07A', 'Cieszyńska');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('37-175', 'Polska', 'Jemielnica', '98', 'Lazurowa');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('43-943', 'Polska', 'Kolonowskie', '86', 'Kolejowa');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('78-174', 'Polska', 'Bytom', '97', 'Złota');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('16-314', 'Polska', 'Sieradz', '88', 'Górnicza');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('16-622', 'Polska', 'Gorzów Wielkopolski', '30A', 'Hallera Józefa');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('93-849', 'Polska', 'Pruszcz Gdański', '51', 'Turkusowa');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('71-825', 'Polska', 'Kołobrzeg', '09A', 'Pola Wincentego');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('59-463', 'Polska', 'Sanok', '23A/11', 'Warmińska');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('16-460', 'Polska', 'Pęcice', '29A', 'Pomorska');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('25-088', 'Polska', 'Tomaszów Mazowiecki', '33A/65', 'Spacerowa');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('03-002', 'Polska', 'Malbork', '78/61', 'Szafirowa');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('48-355', 'Polska', 'Malbork', '86', 'Niepodległości');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('98-916', 'Polska', 'Jasło', '83A/85', 'Olchowa');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('38-939', 'Polska', 'Zduńska Wola', '24A/19', 'Kopalniana');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('93-286', 'Polska', 'Szteklin', '88/84', 'Mazowiecka');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('48-702', 'Polska', 'Zgierz', '65/93', 'Topolowa');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('09-324', 'Polska', 'Władysławowo', '87/84', 'Gałczyńskiego Konstantego Ildefonsa');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('19-016', 'Polska', 'Boguszów-Gorce', '18A/85', 'Słoneczna');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('46-922', 'Polska', 'Mikołów', '70A/89', 'Kasprzaka Marcina');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('32-492', 'Polska', 'Zabrze', '55A/26', 'Różana');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('27-901', 'Polska', 'Chorzów', '25A/19', 'Truskawkowa');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('48-978', 'Polska', 'Kościerzyna', '60/34', 'Karpacka');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('06-007', 'Polska', 'Lubojenka', '47', 'Rzeczna');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('16-237', 'Polska', 'Zabrze', '96A', 'Dąbrowszczaków');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('99-672', 'Polska', 'Opole', '17', 'Lazurowa');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('32-880', 'Polska', 'Radomsko', '78A/38', 'Wiejska');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('20-957', 'Polska', 'Lidzbark Warmiński', '99A', 'Popiełuszki Jerzego');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('82-090', 'Polska', 'Pilchowo', '48', 'Litewska');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('73-563', 'Polska', 'Skarżysko-Kamienna', '10A', 'Olchowa');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('63-284', 'Polska', 'Pruszków', '83A/88', 'Krucza');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('95-615', 'Polska', 'Lublin', '94A/55', 'Sucha');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('02-294', 'Polska', 'Chojnice', '48A/15', 'Nałkowskiej Zofii');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('68-577', 'Polska', 'Piotrków Trybunalski', '70', 'Franciszkańska');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('93-914', 'Polska', 'Bogaczów', '45', 'Pola Wincentego');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('98-758', 'Polska', 'Pieszyce', '72A/58', 'Łanowa');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('10-033', 'Polska', 'Świecie', '59A/85', 'Białostocka');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('76-421', 'Polska', 'Lidzbark Warmiński', '58/54', 'Dębowa');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('29-978', 'Polska', 'Jelenia Góra', '29A/96', 'Prosta');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('23-390', 'Polska', 'Luboń', '25A', 'Orzeszkowej Elizy');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('18-477', 'Polska', 'Świebodzice', '33', 'Torowa');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('12-264', 'Polska', 'Kamienica Królewska', '91/81', 'Łomżyńska');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('26-647', 'Polska', 'Braniewo', '62/11', 'Łódzka');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('96-483', 'Polska', 'Sanok', '98/85', 'Legnicka');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('30-844', 'Polska', 'Malbork', '77A/96', 'Piwna');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('86-918', 'Polska', 'Szczecin', '80A/95', 'Patriotów');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('85-742', 'Polska', 'Radom', '62', 'Reja Mikołaja');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('92-170', 'Polska', 'Nowa Sól', '63A/12', 'Harcerska');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('15-848', 'Polska', 'Siemianowice Śląskie', '20A', 'Okopowa');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('81-034', 'Polska', 'Sopot', '08', 'Franciszkańska');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('73-695', 'Polska', 'Chorzów', '23/87', 'Legionów');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('72-457', 'Polska', 'Gniezno', '08/80', 'Folwarczna');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('03-136', 'Polska', 'Kołobrzeg', '27A/13', 'Nowy Świat');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('38-525', 'Polska', 'Piotrków Trybunalski', '11/59', 'Dworcowa');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('40-113', 'Polska', 'Świdwin', '05A', 'Lubelska');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('66-814', 'Polska', 'Krotoszyn', '38/91', 'Cmentarna');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('53-514', 'Polska', 'Jaroszowa Wola', '27A', 'Asnyka Adama');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('42-815', 'Polska', 'Kuźnica Masłońska', '78/34', 'Portowa');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('43-146', 'Polska', 'Sulejówek', '05A/51', 'Łączna');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('35-956', 'Polska', 'Wrocław', '39A/15', 'Łączna');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('81-737', 'Polska', 'Sopot', '18/83', 'Spokojna');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('29-743', 'Polska', 'Żyrardów', '47A', 'Myśliwska');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('97-345', 'Polska', 'Gdańsk', '55/84', 'Rybnicka');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('95-754', 'Polska', 'Łoś', '77A', 'Jeżynowa');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('72-784', 'Polska', 'Kościan', '91A', 'Grochowska');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('99-146', 'Polska', 'Rybnik', '50/65', 'Modrzewiowa');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('46-689', 'Polska', 'Sosnowiec', '66A/68', 'Gościnna');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('37-588', 'Polska', 'Świdnica', '77', 'Oświęcimska');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('13-032', 'Polska', 'Kamień', '36', 'Wiosenna');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('05-075', 'Polska', 'Szówsko', '21A/70', 'Pułaskiego Kazimierza');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('79-490', 'Polska', 'Żary', '19A/06', 'Ogrodowa');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('52-028', 'Polska', 'Radomsko', '86A', 'Prusa Bolesława');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('88-541', 'Polska', 'Szczecin', '47A/94', 'Racławicka');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('19-309', 'Polska', 'Mysłowice', '64A', 'Olchowa');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('64-681', 'Polska', 'Jawor', '77/05', 'Miarki Karola');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('83-561', 'Polska', 'Jastarnia', '34A/19', 'Skargi Piotra');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('38-594', 'Polska', 'Starachowice', '57', 'Kazimierza Wielkiego');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('71-019', 'Polska', 'Konin', '26A', 'Niska');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('39-018', 'Polska', 'Pszczyna', '80A/65', 'Sawickiej Hanki');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('77-415', 'Polska', 'Starogard Gdański', '99A', 'Zdrojowa');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('44-121', 'Polska', 'Słupsk', '54', 'Szczecińska');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('30-166', 'Polska', 'Mokrzyska', '26/65', 'Wyzwolenia Al.');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('96-977', 'Polska', 'Lębork', '45', 'Przyjaźni');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('81-485', 'Polska', 'Chojnice', '38A/33', 'Norwida Cypriana Kamila');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('94-592', 'Polska', 'Lębork', '22A/62', 'Szymanowskiego Karola');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('63-567', 'Polska', 'Łomianki', '09A/70', 'Jaśminowa');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('01-727', 'Polska', 'Częstochowa', '14/80', 'Słowicza');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('90-599', 'Polska', 'Mielec', '34A', 'Łódzka');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('02-306', 'Polska', 'Koło', '34A/82', 'Gminna');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('43-236', 'Polska', 'Bełchatów', '85/83', 'Jałowcowa');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('33-968', 'Polska', 'Siedlce', '33A', 'Łomżyńska');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('84-282', 'Polska', 'Inowrocław', '43A', 'Wybickiego Józefa');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('46-662', 'Polska', 'Jelcz-Laskowice', '51/01', 'Kielecka');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('71-095', 'Polska', 'Kamienica Królewska', '61', 'Nowa');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('15-336', 'Polska', 'Grudziądz', '45A/19', 'Pawia');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('52-174', 'Polska', 'Rzeszów', '63A/36', 'Jesionowa');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('22-367', 'Polska', 'Czarna Woda', '17A/61', 'Lazurowa');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('07-299', 'Polska', 'Turek', '75', 'Partyzantów');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('18-305', 'Polska', 'Mysłowice', '63A/50', 'Grabowa');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('78-885', 'Polska', 'Kościerzyna', '10/69', 'Kraszewskiego Józefa Ignacego');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('99-692', 'Polska', 'Jaworzno', '90A/41', 'Powstańców Wielkopolskich');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('81-832', 'Polska', 'Przemyśl', '53A', 'Niepodległości Al.');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('75-342', 'Polska', 'Nowe Kramsko', '72/82', 'Wieniawskiego Henryka');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('89-170', 'Polska', 'Lidzbark Warmiński', '50', 'Batorego Stefana');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('27-251', 'Polska', 'Ustka', '99', 'Jeżynowa');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('91-073', 'Polska', 'Poznań', '63A', 'Rataja Macieja');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('28-371', 'Polska', 'Sosnowiec', '05A', 'Husarska');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('96-674', 'Polska', 'Tczew', '57A/70', 'Graniczna');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('57-760', 'Polska', 'Czaplinek', '39', 'Kopalniana');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('74-861', 'Polska', 'Świdnica', '22/44', 'Liliowa');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('04-919', 'Polska', 'Ełk', '82/69', 'Czwartaków');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('69-367', 'Polska', 'Wrocław', '29A/76', 'Brzoskwiniowa');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('16-553', 'Polska', 'Jaroszowa Wola', '25A/12', 'Królowej Jadwigi');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('70-759', 'Polska', 'Bartoszyce', '05A/51', 'Towarowa');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('59-533', 'Polska', 'Wałbrzych', '42A/62', 'Diamentowa');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('80-953', 'Polska', 'Elbląg', '69A/57', 'Norwida Cypriana Kamila');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('55-132', 'Polska', 'Tarnobrzeg', '70A/75', 'Przybyszewskiego Stanisława');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('62-893', 'Polska', 'Luboń', '58A', 'Jastrzębia');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('85-634', 'Polska', 'Grudziądz', '90A/43', 'Handlowa');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('72-148', 'Polska', 'Jaworzno', '80A', 'Jastrzębia');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('48-238', 'Polska', 'Bogatynia', '16A', 'Daleka');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('29-096', 'Polska', 'Szwecja', '77A/56', 'Hetmańska');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('59-636', 'Polska', 'Skierniewice', '02', 'Sosnowa');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('17-882', 'Polska', 'Kalisz', '27', 'Wronia');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('32-956', 'Polska', 'Trzebiatów', '25A', 'Pola Wincentego');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('72-404', 'Polska', 'Szwecja', '18', 'Bałtycka');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('92-800', 'Polska', 'Szczecin', '56/55', 'Niska');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('60-704', 'Polska', 'Franciszków', '47A', 'Stalowa');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('29-745', 'Polska', 'Ząbki', '59', 'Jerozolimskie Al.');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('20-791', 'Polska', 'Katowice', '60/39', 'Jana Pawła II');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('22-168', 'Polska', 'Sopot', '96A/66', '11 Listopada');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('52-018', 'Polska', 'Luboń', '57A', 'Maczka Stanisława');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('32-525', 'Polska', 'Krapkowice', '12A', 'Niepodległości Al.');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('50-546', 'Polska', 'Kętrzyn', '25', 'Pola Wincentego');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('51-327', 'Polska', 'Ostrołęka', '49A/84', 'Rejtana Tadeusza');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('28-560', 'Polska', 'Siemianowice Śląskie', '58A', 'Powstańców Wielkopolskich');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('96-272', 'Polska', 'Bogaczów', '89/85', 'Puławska');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('18-672', 'Polska', 'Zgierz', '51A', 'Struga Andrzeja');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('96-580', 'Polska', 'Kluczbork', '21A', 'Wolności');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('52-918', 'Polska', 'Cieszyn', '14A', 'Wiejska');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('53-327', 'Polska', 'Zduńska Wola', '94/67', 'Kamienna');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('79-410', 'Polska', 'Świdnica', '96', 'Słowackiego Juliusza');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('65-448', 'Polska', 'Legionowo', '13/73', 'Żeromskiego Stefana');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('98-547', 'Polska', 'Świdwin', '54/06', 'Morcinka Gustawa');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('94-208', 'Polska', 'Iława', '16/70', 'Plebiscytowa');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('65-423', 'Polska', 'Kołobrzeg', '13/24', 'Piłsudskiego Józefa');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('48-024', 'Polska', 'Zabrze', '12', 'Królewska');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('28-568', 'Polska', 'Koszalin', '26', 'Młynarska');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('02-267', 'Polska', 'Ruda Śląska', '19/99', 'Konwaliowa');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('83-577', 'Polska', 'Leszno', '22/56', 'Torowa');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('73-858', 'Polska', 'Sopot', '96', 'Tylna');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('40-058', 'Polska', 'Gorlice', '61/56', 'Karpacka');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('28-695', 'Polska', 'Żary', '07A', 'Rzeczna');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('68-507', 'Polska', 'Krotoszyn', '06', 'Łukasiewicza Ignacego');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('49-638', 'Polska', 'Wejherowo', '33/50', 'Żabia');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('35-963', 'Polska', 'Piekary Śląskie', '29A/08', 'Podleśna');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('93-307', 'Polska', 'Tczew', '48A/93', 'Płocka');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('69-327', 'Polska', 'Zakopane', '08A', 'Siemiradzkiego Henryka');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('96-774', 'Polska', 'Zgorzelec', '20', 'Klonowa');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('12-072', 'Polska', 'Pabianice', '54A', 'Niepodległości Al.');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('87-542', 'Polska', 'Świętochłowice', '92', 'Zwycięstwa');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('07-860', 'Polska', 'Lublin', '99A', 'Graniczna');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('05-175', 'Polska', 'Dąbrowa Górnicza', '94A/01', 'Wąska');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('67-309', 'Polska', 'Września', '51', 'Senatorska');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('43-685', 'Polska', 'Bieruń', '40A', 'Wesoła');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('67-991', 'Polska', 'Zborowskie', '19', 'Poziomkowa');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('74-740', 'Polska', 'Świdwin', '03', 'Dworska');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('44-534', 'Polska', 'Żory', '04', 'Bydgoska');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('84-963', 'Polska', 'Olkusz', '96', 'Łanowa');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('02-788', 'Polska', 'Przemyśl', '85/95', 'Brzoskwiniowa');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('73-872', 'Polska', 'Świdnik', '95A', 'Radomska');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('63-384', 'Polska', 'Bochnia', '27A', 'Karpacka');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('46-960', 'Polska', 'Będzin', '35A', 'Kaszubska');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('84-773', 'Polska', 'Zawiercie', '73A', 'Majowa');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('84-269', 'Polska', 'Trzebiatów', '07A', 'Pawia');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('22-481', 'Polska', 'Tychy', '32A/76', 'Lompy Józefa');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('36-948', 'Polska', 'Koszwały', '19/48', 'Mazowiecka');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('08-462', 'Polska', 'Koszalin', '65A', 'Kilińskiego Jana');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('46-096', 'Polska', 'Wrocław', '77A', 'Wielkopolska');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('99-638', 'Polska', 'Wodzisław Śląski', '95A/39', 'Makowa');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('09-210', 'Polska', 'Piotrków Trybunalski', '21A/35', 'Kasprowicza Jana');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('84-253', 'Polska', 'Kościan', '63/83', 'Oświęcimska');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('02-344', 'Polska', 'Tychy', '41', 'Rolna');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('51-587', 'Polska', 'Piekary Śląskie', '27/11', 'Środkowa');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('23-456', 'Polska', 'Sochaczew', '91A/06', 'Lelewela Joachima');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('56-238', 'Polska', 'Wyszków', '23A/44', 'Traugutta Romualda');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('30-671', 'Polska', 'Kamienica Królewska', '17/33', 'Dobra');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('89-181', 'Polska', 'Lędziny', '69A', 'Krucza');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('45-301', 'Polska', 'Konin', '75A/54', 'Żwirki Franciszka i Wigury Stanisława');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('62-511', 'Polska', 'Kutno', '76A/85', 'Szkolna');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('94-296', 'Polska', 'Zgierz', '10A/79', 'Tęczowa');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('86-793', 'Polska', 'Police', '66A/64', 'Jaworowa');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('69-610', 'Polska', 'Lidzbark Warmiński', '16/43', 'Gminna');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('55-200', 'Polska', 'Kędzierzyn-Koźle', '06/90', 'Patriotów');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('55-813', 'Polska', 'Rynarzewo', '59', 'Prusa Bolesława');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('59-896', 'Polska', 'Nowy Dwór Mazowiecki', '11', 'Botaniczna');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('72-332', 'Polska', 'Dzierżoniów', '05A', 'Korczaka Janusza');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('83-765', 'Polska', 'Pilchowo', '69A', 'Ceglana');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('13-721', 'Polska', 'Pęcice', '25A', 'Północna');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('95-478', 'Polska', 'Kraśnik', '25/60', 'Łódzka');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('51-162', 'Polska', 'Łęczna', '21A/44', 'Górnicza');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('68-913', 'Polska', 'Krotoszyn', '55/22', 'Kosynierów');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('56-734', 'Polska', 'Będzin', '45/20', 'Boczna');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('43-654', 'Polska', 'Łódź', '81', 'Tatrzańska');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('26-492', 'Polska', 'Poznań', '04/34', 'Promienna');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('40-124', 'Polska', 'Pieszyce', '70/38', 'Szymanowskiego Karola');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('32-200', 'Polska', 'Szczawin', '02A/55', 'Kalinowa');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('87-919', 'Polska', 'Franciszków', '56', 'Sokola');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('95-314', 'Polska', 'Trzebiatów', '05/40', 'Moniuszki Stanisława');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('74-187', 'Polska', 'Śrem', '12/49', 'Kowalska');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('94-107', 'Polska', 'Bieruń', '73A/81', 'Jana Pawła II Al.');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('85-072', 'Polska', 'Mikołów', '89/72', 'Gołębia');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('82-022', 'Polska', 'Wągrowiec', '31A/11', 'Krzywa');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('71-397', 'Polska', 'Knurów', '96', 'Kłosowa');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('00-846', 'Polska', 'Olkusz', '16/81', 'Węglowa');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('79-789', 'Polska', 'Radom', '51/82', 'Głogowa');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('01-953', 'Polska', 'Lębork', '56', 'Towarowa');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('47-263', 'Polska', 'Jaroszowa Wola', '70', 'Skargi Piotra');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('57-606', 'Polska', 'Sochaczew', '54A/07', 'Kasprzaka Marcina');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('33-353', 'Polska', 'Łoś', '45A/87', 'Wałowa');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('38-029', 'Polska', 'Puławy', '13/27', 'Odrzańska');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('18-220', 'Polska', 'Żyrardów', '68/90', 'Kalinowa');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('07-650', 'Polska', 'Jastrzębie-Zdrój', '55A', 'Bracka');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('36-979', 'Polska', 'Łoś', '04A/62', 'Ceglana');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('46-937', 'Polska', 'Iława', '93A/31', 'Jeżynowa');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('15-060', 'Polska', 'Chrzanów', '51', 'Głowackiego Bartosza');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('20-591', 'Polska', 'Starachowice', '94/51', 'Towarowa');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('12-878', 'Polska', 'Wilkowice', '34/40', 'Wysoka');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('65-920', 'Polska', 'Iława', '54/28', 'Baczyńskiego Krzysztofa Kamila');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('06-431', 'Polska', 'Przędzel', '61A/74', 'Bielska');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('18-748', 'Polska', 'Czeladź', '77A/11', 'Strażacka');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('95-217', 'Polska', 'Mokrzyska', '87', 'Okulickiego Leopolda');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('94-947', 'Polska', 'Tarnobrzeg', '86/40', 'Wilcza');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('37-594', 'Polska', 'Koszwały', '54/74', 'Zakopiańska');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('22-716', 'Polska', 'Wola Kiedrzyńska', '63A', 'Legionów');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('39-301', 'Polska', 'Krosno', '43A/82', 'Majowa');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('85-639', 'Polska', 'Łoś', '60A', 'Rybacka');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('41-562', 'Polska', 'Tarnowskie Góry', '62/47', 'Długa');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('14-041', 'Polska', 'Koszalin', '94/06', 'Bracka');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('21-083', 'Polska', 'Zborowskie', '15A/37', 'Bratków');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('38-546', 'Polska', 'Pruszcz Gdański', '07', 'Przyjaźni');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('95-554', 'Polska', 'Mokrzyska', '41/36', 'Kruczkowskiego Leona');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('47-361', 'Polska', 'Siedlce', '77A/79', 'Towarowa');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('53-905', 'Polska', 'Bolesławiec', '49/44', 'Sienna');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('70-769', 'Polska', 'Jastrzębie-Zdrój', '39/58', 'Lwowska');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('17-466', 'Polska', 'Warszawa', '17A', 'Brzechwy Jana');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('18-503', 'Polska', 'Świdnik', '67', 'Turkusowa');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('00-668', 'Polska', 'Września', '17A/85', 'Karpacka');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('62-634', 'Polska', 'Grodzisk Mazowiecki', '06A', 'Wyszyńskiego Stefana');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('53-677', 'Polska', 'Konstancin-Jeziorna', '79', 'Morelowa');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('23-019', 'Polska', 'Tychy', '27', 'Staffa Leopolda');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('39-509', 'Polska', 'Ostrowiec Świętokrzyski', '01/26', 'Wilcza');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('99-399', 'Polska', 'Konin', '52', 'Kruczkowskiego Leona');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('22-436', 'Polska', 'Chojnice', '70A', 'Dąbrowskiego Jana Henryka');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('60-675', 'Polska', 'Magdalenka', '82A', 'Solna');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('45-477', 'Polska', 'Zgorzelec', '57A/44', 'Bracka');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('47-939', 'Polska', 'Przemyśl', '03A', 'Niedziałkowskiego Mieczysława');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('01-059', 'Polska', 'Pruszcz Gdański', '06A', 'Łokietka Władysława');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('11-309', 'Polska', 'Ostrów Mazowiecka', '45', 'Konwaliowa');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('23-952', 'Polska', 'Szczecin', '93', 'Lipowa');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('38-138', 'Polska', 'Kuźnica Masłońska', '22/96', 'Lawendowa');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('87-138', 'Polska', 'Lubliniec', '02A', 'Niemcewicza Juliana Ursyna');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('25-455', 'Polska', 'Szczecin', '42', 'Żwirki i Wigury');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('22-010', 'Polska', 'Darłowo', '63A', 'Niska');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('71-657', 'Polska', 'Nowy Dwór Mazowiecki', '99A/37', 'Studzienna');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('65-032', 'Polska', 'Sandomierz', '04', '3 Maja');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('37-497', 'Polska', 'Grudziądz', '32', 'Bolesława Krzywoustego');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('45-558', 'Polska', 'Września', '05A', 'Batalionów Chłopskich');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('80-996', 'Polska', 'Zawiercie', '87A/90', 'Przemysłowa');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('74-026', 'Polska', 'Katowice', '74A', 'Lompy Józefa');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('82-969', 'Polska', 'Sandomierz', '85/90', 'Krasickiego Ignacego');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('31-317', 'Polska', 'Świdnik', '50/12', 'Kowalska');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('95-383', 'Polska', 'Żary', '87A', 'Batalionów Chłopskich');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('08-457', 'Polska', 'Bogaczów', '57A', 'Rolna');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('13-247', 'Polska', 'Wejherowo', '60/11', 'Wronia');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('79-811', 'Polska', 'Kościerzyna', '78', 'Ceglana');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('99-879', 'Polska', 'Lubartów', '66A/31', 'Norwida Cypriana Kamila');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('69-090', 'Polska', 'Ostrowiec Świętokrzyski', '16A/20', 'Podhalańska');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('01-508', 'Polska', 'Szwecja', '98A', 'Okólna');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('38-162', 'Polska', 'Żyrardów', '19A', 'Dworcowa');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('80-701', 'Polska', 'Łódź', '05A', 'Słoneczna');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('51-882', 'Polska', 'Bogatynia', '78', 'Bałtycka');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('32-886', 'Polska', 'Poznań', '15', 'Sowińskiego Józefa');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('72-809', 'Polska', 'Białystok', '57', 'Śląska');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('26-504', 'Polska', 'Będzin', '10A', 'Piaskowa');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('99-376', 'Polska', 'Postęp', '20/03', 'Rolnicza');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('61-523', 'Polska', 'Świdnica', '04A', 'Wysoka');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('39-940', 'Polska', 'Bydgoszcz', '86', 'Targowa');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('99-227', 'Polska', 'Jastrzębie-Zdrój', '83A/61', 'Fiołkowa');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('42-438', 'Polska', 'Czarna Woda', '73A', 'Bema Józefa');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('91-535', 'Polska', 'Warszawa', '81A', 'Senatorska');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('48-537', 'Polska', 'Pawłowice', '10A', 'Poznańska');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('08-280', 'Polska', 'Radomsko', '70', 'Bałtycka');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('23-953', 'Polska', 'Trzebiatów', '70/87', 'Rynek');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('05-470', 'Polska', 'Rynarzewo', '79A/68', 'Jasna');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('53-140', 'Polska', 'Bielawa', '67', 'Spółdzielcza');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('94-963', 'Polska', 'Otwock', '03A/24', 'Małopolska');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('63-305', 'Polska', 'Łoś', '02/17', 'Długa');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('72-736', 'Polska', 'Świnoujście', '89A', 'Gnieźnieńska');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('45-980', 'Polska', 'Kozienice', '45', 'Krucza');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('77-160', 'Polska', 'Sandomierz', '14A/71', 'Przemysłowa');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('19-660', 'Polska', 'Swarzędz', '19', 'Rybnicka');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('41-860', 'Polska', 'Kamień', '50A/48', 'Rzeczna');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('48-025', 'Polska', 'Radom', '60', 'Radosna');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('46-759', 'Polska', 'Nowe Kramsko', '66A', 'Bogusławskiego Wojciecha');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('34-518', 'Polska', 'Police', '35', 'Kopernika Mikołaja');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('54-555', 'Polska', 'Jarosław', '96A/79', 'Bolesława Krzywoustego');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('24-842', 'Polska', 'Inowrocław', '50', 'Fabryczna');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('18-250', 'Polska', 'Sosnowiec', '61A', 'Grójecka');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('70-577', 'Polska', 'Lubojenka', '36A', 'Zdrojowa');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('74-114', 'Polska', 'Orzesze', '40/46', 'Kopernika Mikołaja');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('55-552', 'Polska', 'Krosno', '22/28', 'Różana');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('19-183', 'Polska', 'Nowa Ruda', '04A/88', 'Brzechwy Jana');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('06-454', 'Polska', 'Jastrzębie', '47A/50', 'Płocka');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('44-938', 'Polska', 'Ciechanów', '72/22', 'Budowlanych');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('05-490', 'Polska', 'Lidzbark Warmiński', '99/02', 'Wronia');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('80-053', 'Polska', 'Grodzisk Mazowiecki', '16', 'Plebiscytowa');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('08-322', 'Polska', 'Chorzów', '44A/06', 'Sowia');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('65-104', 'Polska', 'Zduńska Wola', '85', 'Krakowska');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('32-440', 'Polska', 'Łomża', '85A/14', 'Częstochowska');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('25-489', 'Polska', 'Pułtusk', '99', 'Słowackiego Juliusza');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('54-903', 'Polska', 'Malbork', '52A', 'Krótka');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('44-918', 'Polska', 'Sanok', '57A', 'Letnia');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('68-187', 'Polska', 'Bochnia', '07', 'Wojska Polskiego Al.');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('36-139', 'Polska', 'Darłowo', '80', 'Mazurska');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('32-665', 'Polska', 'Jelcz-Laskowice', '36A/40', 'Dąbrowskiego Jarosława');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('97-805', 'Polska', 'Bezrzecze', '41/92', 'Jasna');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('23-213', 'Polska', 'Grudziądz', '22', 'Błękitna');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('56-376', 'Polska', 'Zborowskie', '10/17', 'Zachodnia');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('16-113', 'Polska', 'Radom', '55A/59', 'Cicha');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('47-311', 'Polska', 'Konin', '70', 'Reymonta Władysława');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('86-031', 'Polska', 'Szteklin', '35/34', 'Zakopiańska');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('46-679', 'Polska', 'Czarna Woda', '69A/83', 'Składowa');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('53-787', 'Polska', 'Czechowice-Dziedzice', '54/62', 'Zwierzyniecka');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('71-983', 'Polska', 'Busko-Zdrój', '78', 'Reymonta Władysława Stanisława');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('33-251', 'Polska', 'Ostrów Mazowiecka', '81A', 'Willowa');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('03-103', 'Polska', 'Dzierżoniów', '48', 'Jerozolimskie Al.');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('93-457', 'Polska', 'Jastrzębie-Zdrój', '00A/00', 'Węglowa');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('44-175', 'Polska', 'Jasło', '46', 'Świerkowa');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('06-241', 'Polska', 'Mielec', '17/20', 'Wierzbowa');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('05-054', 'Polska', 'Zakopane', '48A', 'Zielona');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('58-909', 'Polska', 'Lębork', '91/32', 'Rolna');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('62-338', 'Polska', 'Bogaczów', '37A/10', 'Modrzewiowa');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('75-850', 'Polska', 'Pabianice', '48A/42', 'Zwierzyniecka');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('96-530', 'Polska', 'Sieradz', '23', 'Kosynierów');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('61-794', 'Polska', 'Świdnica', '35A', 'Pułaskiego Kazimierza');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('98-724', 'Polska', 'Rzeszów', '29/64', 'Puławska');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('29-980', 'Polska', 'Śrem', '16', 'Kochanowskiego Jana');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('90-748', 'Polska', 'Sosnowiec', '05A', 'Przemysłowa');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('73-135', 'Polska', 'Studzienice', '03', 'Żniwna');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('63-553', 'Polska', 'Sulejówek', '13A', 'Jagodowa');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('05-046', 'Polska', 'Gniezno', '67A', 'Orzechowa');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('94-931', 'Polska', 'Dębica', '10A/68', 'Cmentarna');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('55-689', 'Polska', 'Tarnów', '43A/26', 'Bursztynowa');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('66-209', 'Polska', 'Bochnia', '95/08', 'Skargi Piotra');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('29-710', 'Polska', 'Czarna Woda', '22A/68', 'Czarnieckiego Stefana');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('41-622', 'Polska', 'Łomża', '88A/96', 'Sąsiedzka');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('27-681', 'Polska', 'Orzesze', '96/94', 'Limanowskiego Bolesława');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('74-976', 'Polska', 'Piotrków Trybunalski', '13A', 'Patriotów');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('17-792', 'Polska', 'Zamość', '23A', 'Kołobrzeska');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('89-787', 'Polska', 'Starogard Gdański', '93A', 'Kręta');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('37-429', 'Polska', 'Pszczyna', '19A/44', 'Sucharskiego Henryka');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('21-384', 'Polska', 'Łomża', '85A/15', 'Lubelska');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('09-750', 'Polska', 'Nowe Kramsko', '31A', 'Karpacka');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('65-744', 'Polska', 'Dąbrowa Górnicza', '50/86', 'Gojawiczyńskiej Poli');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('79-172', 'Polska', 'Nowy Sącz', '24', 'Morelowa');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('24-242', 'Polska', 'Koszwały', '32A/81', 'Piastowska');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('66-657', 'Polska', 'Police', '44A/26', 'Kopalniana');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('02-534', 'Polska', 'Bogaczów', '58', 'Spokojna');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('12-119', 'Polska', 'Wejherowo', '31A', 'Torowa');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('53-449', 'Polska', 'Łomianki', '61/14', 'Niepodległości Al.');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('47-862', 'Polska', 'Kuźnica Masłońska', '67', 'Stroma');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('24-732', 'Polska', 'Ilkowice', '66', 'Dąbrowskiej Marii');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('42-565', 'Polska', 'Grodzisk Mazowiecki', '04/83', 'Wiśniowa');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('90-196', 'Polska', 'Darłowo', '93', 'Bracka');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('99-428', 'Polska', 'Kamienica Królewska', '85', 'Kruczkowskiego Leona');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('85-926', 'Polska', 'Malbork', '75A', 'Gliwicka');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('20-959', 'Polska', 'Krapkowice', '36A/09', 'Sikorskiego Władysława');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('68-067', 'Polska', 'Stargard Szczeciński', '40A', 'Makowa');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('29-417', 'Polska', 'Piotrków Trybunalski', '76/52', 'Jana Pawła II');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('88-603', 'Polska', 'Lubin', '89', 'Lompy Józefa');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('50-075', 'Polska', 'Mielec', '38', 'Ułańska');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('10-444', 'Polska', 'Gołubie', '24/72', 'Mokra');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('98-202', 'Polska', 'Kamienica Królewska', '01', 'Staffa Leopolda');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('99-932', 'Polska', 'Studzienice', '05A', 'Bema Józefa');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('85-477', 'Polska', 'Osówiec', '50A', 'Malczewskiego Jacka');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('02-912', 'Polska', 'Bieruń', '89A/86', 'Bytomska');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('07-655', 'Polska', 'Świdnik', '56A', 'Ułańska');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('78-014', 'Polska', 'Ciechanów', '81/05', 'Wolności');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('86-562', 'Polska', 'Sandomierz', '40/25', 'Grota-Roweckiego Stefana');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('32-418', 'Polska', 'Żory', '66', 'Małopolska');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('68-742', 'Polska', 'Świebodzice', '88/89', 'Górna');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('61-436', 'Polska', 'Nowy Dwór Mazowiecki', '40A', 'Gdańska');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('08-408', 'Polska', 'Piekary Śląskie', '12A/56', 'Jasna');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('21-450', 'Polska', 'Czeladź', '14/53', 'Wesoła');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('07-084', 'Polska', 'Kamień', '80A', 'Chorzowska');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('21-197', 'Polska', 'Stargard Szczeciński', '79A/59', 'Rybnicka');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('22-449', 'Polska', 'Radom', '17A', 'Turystyczna');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('74-756', 'Polska', 'Kamień', '70', 'Solidarności Al.');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('48-400', 'Polska', 'Szczecinek', '80A/16', 'Chłopska');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('68-426', 'Polska', 'Jastrzębie', '33/50', 'Działkowa');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('04-919', 'Polska', 'Bolesławiec', '85A', 'Lompy Józefa');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('84-625', 'Polska', 'Kalisz', '61A/04', 'Kołłątaja Hugo');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('37-935', 'Polska', 'Wrocław', '97/05', 'Czereśniowa');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('47-634', 'Polska', 'Kościerzyna', '12/47', 'Zielona');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('28-317', 'Polska', 'Franciszków', '68A/74', 'Wałowa');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('52-505', 'Polska', 'Brodnica', '26A', 'Makowa');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('89-373', 'Polska', 'Żory', '95', 'Błękitna');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('42-717', 'Polska', 'Ustka', '45A', 'Szarych Szeregów');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('14-465', 'Polska', 'Siedlce', '97A', 'Saperów');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('84-374', 'Polska', 'Łowicz', '26A/21', 'Poziomkowa');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('74-601', 'Polska', 'Gniezno', '81', 'Węglowa');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('36-002', 'Polska', 'Ostrów Wielkopolski', '77A/90', 'Tulipanów');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('43-857', 'Polska', 'Wejherowo', '92A', 'Budowlanych');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('32-149', 'Polska', 'Zgorzelec', '79A', 'Narutowicza Gabriela');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('79-181', 'Polska', 'Łaziska Górne', '45', 'Boczna');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('96-286', 'Polska', 'Brzeg', '90', 'Siewna');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('68-466', 'Polska', 'Gdańsk', '42A', 'Senatorska');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('86-376', 'Polska', 'Ostrzeszów', '18', 'Bema Józefa');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('12-350', 'Polska', 'Kościerzyna', '47/09', 'Skłodowskiej-Curie Marii');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('59-005', 'Polska', 'Knurów', '08A', 'Wrocławska');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('37-655', 'Polska', 'Łódź', '50/64', 'Dmowskiego Romana');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('31-471', 'Polska', 'Dębogórze', '08A/29', 'Królewska');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('42-244', 'Polska', 'Jelcz-Laskowice', '42A', 'Bema Józefa');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('81-679', 'Polska', 'Postęp', '95A/04', 'Rybnicka');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('61-862', 'Polska', 'Racibórz', '49', 'Dąbrowskiego Jana Henryka');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('24-716', 'Polska', 'Chorzów', '21/44', 'Wyzwolenia');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('67-383', 'Polska', 'Opole', '57', 'Kościuszki Tadeusza');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('44-189', 'Polska', 'Kędzierzyn-Koźle', '81A/54', 'Malinowa');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('43-841', 'Polska', 'Pułtusk', '34A', 'Piekarska');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('21-096', 'Polska', 'Szczecinek', '54A', 'Jeżynowa');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('07-601', 'Polska', 'Olkusz', '83A', 'Długosza Jana');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('22-432', 'Polska', 'Nowa Ruda', '43A/46', 'Rodzinna');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('38-777', 'Polska', 'Kolonowskie', '05/57', 'Kilińskiego Jana');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('25-985', 'Polska', 'Koło', '86A', 'Nałkowskiej Zofii');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('80-454', 'Polska', 'Józefów', '14/98', 'Wojska Polskiego Al.');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('79-042', 'Polska', 'Ostrów Mazowiecka', '83A', 'Jastrzębia');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('31-152', 'Polska', 'Marylka', '94A', 'Jesienna');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('90-487', 'Polska', 'Lędziny', '28A', 'Gołębia');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('27-068', 'Polska', 'Inowrocław', '62', 'Brzechwy Jana');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('14-230', 'Polska', 'Kutno', '35A/22', 'Skośna');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('75-245', 'Polska', 'Ostrołęka', '74A', 'Górnośląska');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('95-322', 'Polska', 'Bartoszyce', '82A', 'Dożynkowa');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('20-625', 'Polska', 'Gołubie', '40/10', 'Wybickiego Józefa');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('40-604', 'Polska', 'Kamieniec Ząbkowicki', '29A', 'Powstańców Wielkopolskich');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('86-532', 'Polska', 'Opole', '17A/39', 'Wrocławska');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('95-424', 'Polska', 'Tczew', '64', 'Modrzewiowa');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('50-260', 'Polska', 'Czerwionka-Leszczyny', '81', 'Przechodnia');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('91-458', 'Polska', 'Wyszków', '95A', 'Wczasowa');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('92-924', 'Polska', 'Ławy', '79A', 'Krzywa');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('51-149', 'Polska', 'Jastrzębie-Zdrój', '57A', 'Wierzbowa');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('89-758', 'Polska', 'Zduńska Wola', '42/77', 'Szpitalna');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('30-450', 'Polska', 'Lubin', '97A/01', 'Gnieźnieńska');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('57-831', 'Polska', 'Gniezno', '26', 'Paderewskiego Ignacego');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('18-747', 'Polska', 'Żyrardów', '09A', 'Wschodnia');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('31-127', 'Polska', 'Tomaszów Mazowiecki', '20A/95', 'Rybacka');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('12-682', 'Polska', 'Malbork', '08/21', 'Dworska');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('80-920', 'Polska', 'Zielona Góra', '35/84', 'Korfantego Wojciecha');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('09-998', 'Polska', 'Zawiercie', '74A/21', 'Pomorska');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('07-765', 'Polska', 'Dębogórze', '13A', 'Solidarności Al.');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('60-371', 'Polska', 'Będzin', '74A', 'Łowicka');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('21-217', 'Polska', 'Świecie', '77A/76', 'Tysiąclecia');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('15-534', 'Polska', 'Kraków', '83/73', 'Rycerska');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('32-560', 'Polska', 'Łęczna', '59/49', 'Wileńska');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('55-415', 'Polska', 'Katowice', '97', 'Działkowa');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('95-044', 'Polska', 'Zamość', '40', 'Sportowa');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('01-324', 'Polska', 'Szówsko', '68/93', 'Urocza');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('35-107', 'Polska', 'Jawor', '22A/79', 'Staszica Stanisława');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('72-463', 'Polska', 'Przędzel', '82A', 'Brzoskwiniowa');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('26-945', 'Polska', 'Kozienice', '76', 'Kołłątaja Hugo');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('32-588', 'Polska', 'Łódź', '01', 'Wąska');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('85-057', 'Polska', 'Jaworzno', '98/22', 'Jeżynowa');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('06-813', 'Polska', 'Lubliniec', '51', 'Żelazna');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('81-663', 'Polska', 'Jemielnica', '69', 'Okrzei Stefana');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('20-716', 'Polska', 'Kozienice', '35/08', 'Cegielniana');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('15-311', 'Polska', 'Nowa Sól', '74A', 'Piwna');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('93-512', 'Polska', 'Mikołów', '83', 'Kaliska');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('00-931', 'Polska', 'Ostrów Mazowiecka', '12', 'Puszkina Aleksandra');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('70-474', 'Polska', 'Skalbmierz', '36', 'Dąbrówki');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('19-356', 'Polska', 'Bochnia', '92', 'Podleśna');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('04-220', 'Polska', 'Grudziądz', '28/89', 'Zakątek');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('64-793', 'Polska', 'Dzierżoniów', '17A/62', 'Karłowicza Mieczysława');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('16-857', 'Polska', 'Łomża', '20/24', 'Barlickiego Norberta');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('92-546', 'Polska', 'Jastrzębie-Zdrój', '99A', 'Mickiewicza Adama');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('91-405', 'Polska', 'Wola Kiedrzyńska', '22A/88', 'Fredry Aleksandra');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('91-990', 'Polska', 'Ostrowiec Świętokrzyski', '96', 'Tęczowa');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('91-543', 'Polska', 'Rynarzewo', '73/29', 'Czarnieckiego Stefana');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('39-941', 'Polska', 'Pieszyce', '67A/29', 'Lotnicza');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('73-938', 'Polska', 'Wałbrzych', '44', 'Jaracza Stefana');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('22-150', 'Polska', 'Radom', '28/30', 'Fabryczna');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('11-546', 'Polska', 'Racibórz', '32', 'Husarska');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('49-330', 'Polska', 'Olkusz', '67', 'Bursztynowa');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('94-641', 'Polska', 'Inowrocław', '74A', 'Maczka Stanisława');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('49-787', 'Polska', 'Wyszków', '13', 'Niemcewicza Juliana Ursyna');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('36-055', 'Polska', 'Żyrardów', '29A', 'Granitowa');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('71-209', 'Polska', 'Mikołów', '52A', 'Malczewskiego Jacka');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('37-232', 'Polska', 'Tarnobrzeg', '11A/83', 'Wrocławska');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('80-549', 'Polska', 'Olsztyn', '09', 'Gnieźnieńska');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('30-492', 'Polska', 'Tarnobrzeg', '61A', 'Średnia');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('96-919', 'Polska', 'Sochaczew', '71/02', 'Jaskółcza');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('35-866', 'Polska', 'Lubliniec', '85/45', 'Kaliska');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('35-638', 'Polska', 'Józefów', '94', 'Podgórna');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('92-463', 'Polska', 'Turek', '42', 'Nadrzeczna');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('83-599', 'Polska', 'Lubliniec', '69A/14', 'Iwaszkiewicza Jarosława');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('43-468', 'Polska', 'Lubartów', '35', 'Wschodnia');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('09-505', 'Polska', 'Kluczbork', '62/20', 'Bieszczadzka');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('07-014', 'Polska', 'Pszczyna', '78/86', 'Złota');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('79-427', 'Polska', 'Kraków', '34/92', 'Kopalniana');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('20-850', 'Polska', 'Legionowo', '28A/72', 'Zacisze');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('09-334', 'Polska', 'Szwecja', '03A/51', 'Norwida Cypriana Kamila');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('17-497', 'Polska', 'Szwecja', '36', 'Beskidzka');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('85-390', 'Polska', 'Zduńska Wola', '84', 'Hoża');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('93-551', 'Polska', 'Katowice', '61A', 'Kościelna');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('72-716', 'Polska', 'Ciechanów', '87', 'Wybickiego Józefa');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('68-118', 'Polska', 'Konin', '70A/19', 'Wodna');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('11-804', 'Polska', 'Trzebiatów', '10A', 'Żołnierska');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('58-288', 'Polska', 'Bogaczów', '88A/77', 'Poniatowskiego Józefa');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('87-050', 'Polska', 'Tychy', '96A/28', 'Iwaszkiewicza Jarosława');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('04-351', 'Polska', 'Starogard Gdański', '77', 'Grochowska');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('50-269', 'Polska', 'Nowa Ruda', '32/13', 'Lwowska');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('89-090', 'Polska', 'Magdalenka', '85A/77', 'Jaracza Stefana');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('82-680', 'Polska', 'Żary', '06', 'Orkana Władysława');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('51-896', 'Polska', 'Piotrków Trybunalski', '57', 'Dożynkowa');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('92-608', 'Polska', 'Szczecin', '89/50', 'Kościuszki Tadeusza');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('26-778', 'Polska', 'Kościerzyna', '18', 'Widok');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('79-609', 'Polska', 'Krępiec', '85A/28', 'Wysoka');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('75-236', 'Polska', 'Sieradz', '06A', 'Bydgoska');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('59-403', 'Polska', 'Racibórz', '80A/30', 'Lelewela Joachima');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('94-694', 'Polska', 'Ząbki', '64A', 'Bursztynowa');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('68-943', 'Polska', 'Lubliniec', '73A', 'Kolberga Oskara');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('38-599', 'Polska', 'Radom', '26A/00', 'Kamienna');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('31-811', 'Polska', 'Krępiec', '35', 'Długosza Jana');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('45-291', 'Polska', 'Starogard Gdański', '32A', 'Rynek');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('71-685', 'Polska', 'Gołubie', '87/58', 'Środkowa');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('76-134', 'Polska', 'Czeladź', '40A', 'Matejki Jana');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('94-704', 'Polska', 'Starogard Gdański', '71', 'Żwirowa');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('67-153', 'Polska', 'Krępiec', '42A/13', 'Powstańców Wielkopolskich');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('78-156', 'Polska', 'Szczecin', '19', 'Przyjaźni');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('13-081', 'Polska', 'Radom', '61', 'Towarowa');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('00-437', 'Polska', 'Pruszcz Gdański', '27/04', 'Porzeczkowa');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('52-171', 'Polska', 'Sopot', '86/93', 'Jagiellońskie Os.');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('26-553', 'Polska', 'Iława', '40/45', 'Pszenna');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('50-000', 'Polska', 'Ustka', '07A', 'Leśna');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('00-403', 'Polska', 'Katowice', '51A/69', 'Kopalniana');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('61-674', 'Polska', 'Siemianowice Śląskie', '58A', 'Długosza Jana');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('95-450', 'Polska', 'Świebodzin', '43/90', 'Grota-Roweckiego Stefana');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('62-700', 'Polska', 'Rynarzewo', '48A', 'Legionów');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('77-626', 'Polska', 'Braniewo', '54/53', 'Paderewskiego Ignacego');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('37-947', 'Polska', 'Kielce', '33A/75', 'Gałczyńskiego Konstantego Ildefonsa');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('14-104', 'Polska', 'Czarna Woda', '20A/75', 'Jesionowa');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('50-243', 'Polska', 'Kędzierzyn-Koźle', '44A/02', 'Lotników');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('78-808', 'Polska', 'Kozienice', '09/29', 'Litewska');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('73-412', 'Polska', 'Szówsko', '38/76', 'Spacerowa');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('34-686', 'Polska', 'Żory', '91A/75', 'Wolska');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('66-178', 'Polska', 'Lubartów', '35', 'Limanowskiego Bolesława');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('50-626', 'Polska', 'Mysłowice', '06', 'Obrońców Westerplatte');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('11-030', 'Polska', 'Stalowa Wola', '72A/29', 'Puławska');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('19-693', 'Polska', 'Ostrowiec Świętokrzyski', '62', 'Prusa Bolesława');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('53-759', 'Polska', 'Piła', '27A/59', 'Spółdzielcza');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('87-982', 'Polska', 'Kędzierzyn-Koźle', '65', 'Jerozolimskie Al.');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('99-320', 'Polska', 'Tarnowskie Góry', '98A', 'Rybnicka');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('05-046', 'Polska', 'Siemianowice Śląskie', '21A', 'Podmiejska');
INSERT INTO adresy (kod_pocztowy, kraj, miasto, nr_mieszkania, ulica) VALUES ('46-735', 'Polska', 'Gorzów Wielkopolski', '28', 'Środkowa');

INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id, rola) VALUES ('2021-07-20 13:48:45', 'karol@admin.com', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Karol', 'admin1', 'Bobowski', '525381239', '18', 'administrator');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id, rola) VALUES ('2021-07-20 13:48:45', 'maciek@admin.com', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Maciej', 'admin2', 'Biel', '535381229', '18', 'administrator');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id, rola) VALUES ('2021-07-20 13:48:45', 'kamil@admin.com', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Kamil', 'admin3', 'Data', '555381219', '18', 'administrator');

INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2022-05-10 16:43:21', 'paulinapietrzak953480@example.com', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Paulina', 'paulinapietrzak953480', 'Pietrzak', '723175464', '1');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2021-05-23 02:34:15', 'stanisławbłaszczyk886438@example.com', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Stanisław', 'stanisławbłaszczyk886438', 'Błaszczyk', '946749052', '2');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2021-10-09 18:02:24', 'adaborowski393354@example.com', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Ada', 'adaborowski393354', 'Borowski', '987417287', '3');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2021-08-13 12:23:08', 'dominikamazurek58886@example.net', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Dominika', 'dominikamazurek58886', 'Mazurek', '338477616', '4');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2021-06-20 05:02:52', 'martynamazurek461084@example.net', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Martyna', 'martynamazurek461084', 'Mazurek', '728926223', '5');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2021-07-11 13:31:53', 'urszulasikora264056@example.net', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Urszula', 'urszulasikora264056', 'Sikora', '906201146', '6');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2021-07-03 06:19:05', 'konstantysobczak392308@example.org', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Konstanty', 'konstantysobczak392308', 'Sobczak', '270606010', '7');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2022-05-09 23:08:33', 'marikakalinowski622028@example.org', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Marika', 'marikakalinowski622028', 'Kalinowski', '571834953', '8');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2022-01-31 01:14:20', 'matyldakwiatkowska544036@example.com', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Matylda', 'matyldakwiatkowska544036', 'Kwiatkowska', '530787764', '9');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2022-03-16 13:54:43', 'oliwierjankowski153515@example.org', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Oliwier', 'oliwierjankowski153515', 'Jankowski', '921290250', '10');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2021-11-16 21:45:01', 'julitagrabowska352358@example.org', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Julita', 'julitagrabowska352358', 'Grabowska', '201280034', '11');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2021-08-06 10:11:43', 'oliwiergórska163467@example.net', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Oliwier', 'oliwiergórska163467', 'Górska', '451359766', '12');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2021-12-07 09:15:01', 'stefanwalczak365532@example.net', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Stefan', 'stefanwalczak365532', 'Walczak', '958416913', '13');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2022-03-19 14:08:27', 'danielpawłowski65983@example.net', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Daniel', 'danielpawłowski65983', 'Pawłowski', '397990255', '14');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2021-06-19 17:43:45', 'zofiamróz864341@example.org', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Zofia', 'zofiamróz864341', 'Mróz', '829855170', '15');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2022-04-13 19:31:53', 'hubertolszewski264591@example.com', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Hubert', 'hubertolszewski264591', 'Olszewski', '209929762', '16');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2021-09-26 04:11:17', 'justynamajewski997505@example.org', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Justyna', 'justynamajewski997505', 'Majewski', '541966975', '17');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2021-07-20 13:48:45', 'tomaszkrupa751580@example.com', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Tomasz', 'tomaszkrupa751580', 'Krupa', '545381289', '18');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2022-02-15 08:10:08', 'olafbaranowska959324@example.com', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Olaf', 'olafbaranowska959324', 'Baranowska', '160566142', '19');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2021-12-22 05:47:33', 'nelamichalak28273@example.org', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Nela', 'nelamichalak28273', 'Michalak', '189111944', '20');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2022-02-18 21:53:45', 'mariasawicki35867@example.net', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Maria', 'mariasawicki35867', 'Sawicki', '321053833', '21');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2021-08-13 16:21:56', 'hubertsikora671721@example.net', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Hubert', 'hubertsikora671721', 'Sikora', '551466115', '22');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2021-08-02 18:19:13', 'agnieszkawłodarczyk841857@example.net', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Agnieszka', 'agnieszkawłodarczyk841857', 'Włodarczyk', '172434930', '23');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2021-06-05 16:30:24', 'roksanawysocki864273@example.org', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Roksana', 'roksanawysocki864273', 'Wysocki', '311648119', '24');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2021-06-11 12:22:33', 'adriannowak866337@example.com', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Adrian', 'adriannowak866337', 'Nowak', '576584637', '25');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2021-09-12 17:32:27', 'elżbietajankowska304225@example.org', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Elżbieta', 'elżbietajankowska304225', 'Jankowska', '563742573', '26');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2022-02-19 11:07:24', 'nadiajaworski280754@example.org', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Nadia', 'nadiajaworski280754', 'Jaworski', '989328177', '27');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2021-05-18 16:57:45', 'natanielzając884631@example.com', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Nataniel', 'natanielzając884631', 'Zając', '697490875', '28');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2021-09-21 13:02:31', 'annamazurek511079@example.net', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Anna', 'annamazurek511079', 'Mazurek', '884807740', '29');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2021-06-23 02:34:48', 'dominikkaźmierczak41752@example.com', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Dominik', 'dominikkaźmierczak41752', 'Kaźmierczak', '836551730', '30');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2021-09-15 16:40:54', 'elżbietawróbel217552@example.com', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Elżbieta', 'elżbietawróbel217552', 'Wróbel', '665542424', '31');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2022-01-11 04:27:15', 'maurycyborowska236318@example.org', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Maurycy', 'maurycyborowska236318', 'Borowska', '348394836', '32');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2022-03-08 03:03:32', 'biankazieliński744122@example.com', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Bianka', 'biankazieliński744122', 'Zieliński', '791858466', '33');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2021-12-13 20:07:11', 'dariuszkubiak172092@example.com', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Dariusz', 'dariuszkubiak172092', 'Kubiak', '659031612', '34');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2021-12-31 05:28:55', 'cezaryszewczyk915658@example.org', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Cezary', 'cezaryszewczyk915658', 'Szewczyk', '357754840', '35');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2022-03-22 20:17:51', 'adamkamińska522472@example.org', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Adam', 'adamkamińska522472', 'Kamińska', '354974251', '36');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2021-10-20 02:01:43', 'gustawmakowski972939@example.net', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Gustaw', 'gustawmakowski972939', 'Makowski', '140023760', '37');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2022-01-06 18:16:39', 'miłoszjabłońska494125@example.net', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Miłosz', 'miłoszjabłońska494125', 'Jabłońska', '585519872', '38');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2021-07-06 20:31:23', 'elżbietakucharska289722@example.org', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Elżbieta', 'elżbietakucharska289722', 'Kucharska', '686283360', '39');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2022-05-08 16:50:33', 'mikołajtomaszewski778590@example.com', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Mikołaj', 'mikołajtomaszewski778590', 'Tomaszewski', '547493818', '40');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2022-01-05 05:43:47', 'ewakubiak122375@example.com', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Ewa', 'ewakubiak122375', 'Kubiak', '681867629', '41');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2021-08-18 12:09:43', 'lilianasawicki299565@example.net', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Liliana', 'lilianasawicki299565', 'Sawicki', '858178282', '42');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2021-10-12 11:14:40', 'tadeuszszczepańska632774@example.com', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Tadeusz', 'tadeuszszczepańska632774', 'Szczepańska', '269006158', '43');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2022-01-19 01:04:52', 'patrycjawalczak306325@example.org', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Patrycja', 'patrycjawalczak306325', 'Walczak', '226291533', '44');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2021-05-25 02:15:00', 'idawróbel85942@example.net', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Ida', 'idawróbel85942', 'Wróbel', '724013438', '45');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2021-05-29 15:24:11', 'zofiawojciechowska363285@example.net', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Zofia', 'zofiawojciechowska363285', 'Wojciechowska', '250183842', '46');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2022-03-31 01:19:29', 'mariakwiatkowski258698@example.org', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Maria', 'mariakwiatkowski258698', 'Kwiatkowski', '332611667', '47');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2021-12-24 18:23:07', 'blankawalczak787442@example.net', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Blanka', 'blankawalczak787442', 'Walczak', '737447890', '48');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2022-04-26 08:57:55', 'majawieczorek534766@example.org', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Maja', 'majawieczorek534766', 'Wieczorek', '112592794', '49');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2021-09-20 14:37:44', 'fryderykmajewska728914@example.com', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Fryderyk', 'fryderykmajewska728914', 'Majewska', '363244741', '50');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2022-04-18 23:16:41', 'matyldajabłoński107593@example.org', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Matylda', 'matyldajabłoński107593', 'Jabłoński', '825514264', '51');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2021-07-31 04:16:11', 'błażejkamińska196296@example.com', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Błażej', 'błażejkamińska196296', 'Kamińska', '681604445', '52');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2022-01-26 02:21:41', 'anitawitkowska331378@example.net', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Anita', 'anitawitkowska331378', 'Witkowska', '471248149', '53');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2021-08-27 08:23:08', 'olgawróblewski475885@example.com', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Olga', 'olgawróblewski475885', 'Wróblewski', '432874922', '54');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2022-01-12 07:58:22', 'biankasokołowski573524@example.net', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Bianka', 'biankasokołowski573524', 'Sokołowski', '297728673', '55');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2021-06-15 09:19:22', 'kornelkołodziej437782@example.org', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Kornel', 'kornelkołodziej437782', 'Kołodziej', '111540468', '56');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2022-02-07 11:41:17', 'mariazalewska388805@example.net', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Maria', 'mariazalewska388805', 'Zalewska', '333542644', '57');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2021-11-29 10:24:01', 'antonizakrzewska769707@example.org', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Antoni', 'antonizakrzewska769707', 'Zakrzewska', '399814366', '58');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2021-09-10 19:06:35', 'jagodabaran770235@example.com', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Jagoda', 'jagodabaran770235', 'Baran', '406886843', '59');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2021-11-06 10:38:40', 'jakubwiśniewska780610@example.com', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Jakub', 'jakubwiśniewska780610', 'Wiśniewska', '835840688', '60');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2022-01-29 17:34:24', 'makssawicki654531@example.com', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Maks', 'makssawicki654531', 'Sawicki', '284876757', '61');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2022-02-08 08:15:29', 'marcinpietrzak250112@example.com', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Marcin', 'marcinpietrzak250112', 'Pietrzak', '265143798', '62');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2021-06-18 01:25:07', 'tomaszczerwiński709718@example.org', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Tomasz', 'tomaszczerwiński709718', 'Czerwiński', '678543281', '63');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2022-03-17 06:46:09', 'krystynakalinowski167736@example.org', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Krystyna', 'krystynakalinowski167736', 'Kalinowski', '167342486', '64');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2021-10-22 19:09:34', 'robertkaźmierczak859076@example.com', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Robert', 'robertkaźmierczak859076', 'Kaźmierczak', '803996874', '65');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2021-12-10 10:04:44', 'klaralaskowska435065@example.net', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Klara', 'klaralaskowska435065', 'Laskowska', '482317500', '66');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2021-11-16 12:48:13', 'zofiamróz860346@example.com', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Zofia', 'zofiamróz860346', 'Mróz', '836994460', '67');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2021-10-09 10:40:14', 'iwoszczepański632475@example.org', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Iwo', 'iwoszczepański632475', 'Szczepański', '553412376', '68');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2022-01-15 19:07:28', 'dagmaragrabowski154017@example.net', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Dagmara', 'dagmaragrabowski154017', 'Grabowski', '438854589', '69');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2021-07-28 01:35:35', 'kamilnowak732741@example.org', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Kamil', 'kamilnowak732741', 'Nowak', '835206722', '70');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2021-11-18 06:50:46', 'jerzynowakowski196533@example.net', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Jerzy', 'jerzynowakowski196533', 'Nowakowski', '132242734', '71');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2021-12-20 23:15:09', 'stefangórska263599@example.com', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Stefan', 'stefangórska263599', 'Górska', '835747513', '72');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2022-01-26 21:56:07', 'krystynasobczak859399@example.net', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Krystyna', 'krystynasobczak859399', 'Sobczak', '362266374', '73');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2021-08-24 05:57:54', 'konstantyjankowski647278@example.org', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Konstanty', 'konstantyjankowski647278', 'Jankowski', '838184754', '74');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2021-10-25 23:09:23', 'polastępień112119@example.com', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Pola', 'polastępień112119', 'Stępień', '356088140', '75');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2022-02-24 02:35:47', 'zofiaurbański490055@example.org', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Zofia', 'zofiaurbański490055', 'Urbański', '938804863', '76');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2021-12-09 12:54:31', 'gabrielaczarnecka44473@example.org', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Gabriela', 'gabrielaczarnecka44473', 'Czarnecka', '185139809', '77');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2021-10-05 20:11:04', 'krzysztofkrupa106417@example.com', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Krzysztof', 'krzysztofkrupa106417', 'Krupa', '676358898', '78');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2021-07-14 06:36:36', 'tadeuszzawadzki380470@example.com', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Tadeusz', 'tadeuszzawadzki380470', 'Zawadzki', '164179170', '79');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2022-03-17 17:53:02', 'lauradudek676016@example.org', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Laura', 'lauradudek676016', 'Dudek', '543658341', '80');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2021-12-23 00:25:16', 'dariuszziółkowski833955@example.com', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Dariusz', 'dariuszziółkowski833955', 'Ziółkowski', '911090847', '81');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2021-10-23 08:00:07', 'franciszekzieliński658578@example.org', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Franciszek', 'franciszekzieliński658578', 'Zieliński', '955183401', '82');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2021-09-17 09:52:49', 'martynamalinowski788412@example.org', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Martyna', 'martynamalinowski788412', 'Malinowski', '807409915', '83');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2022-02-23 05:55:58', 'witoldkowalska68588@example.com', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Witold', 'witoldkowalska68588', 'Kowalska', '668103116', '84');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2022-01-18 12:54:18', 'joannajankowski153927@example.com', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Joanna', 'joannajankowski153927', 'Jankowski', '436051075', '85');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2021-06-21 04:40:47', 'sylwiaprzybylska844495@example.com', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Sylwia', 'sylwiaprzybylska844495', 'Przybylska', '445764535', '86');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2021-05-19 03:26:45', 'witoldzawadzka597293@example.com', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Witold', 'witoldzawadzka597293', 'Zawadzka', '208661799', '87');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2021-08-08 19:39:41', 'jankrawczyk547792@example.net', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Jan', 'jankrawczyk547792', 'Krawczyk', '635690958', '88');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2022-02-19 05:54:42', 'ernestmalinowski495353@example.org', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Ernest', 'ernestmalinowski495353', 'Malinowski', '902185637', '89');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2021-08-10 04:17:37', 'laurawójcik682718@example.net', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Laura', 'laurawójcik682718', 'Wójcik', '718402268', '90');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2022-05-03 16:29:25', 'iwocieślak384954@example.net', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Iwo', 'iwocieślak384954', 'Cieślak', '758017844', '91');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2022-01-17 15:02:41', 'pawełostrowski723887@example.net', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Paweł', 'pawełostrowski723887', 'Ostrowski', '563502495', '92');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2022-01-20 00:12:11', 'robertwójcik144700@example.net', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Robert', 'robertwójcik144700', 'Wójcik', '254463868', '93');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2021-12-11 10:13:51', 'alexszymańska583201@example.com', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Alex', 'alexszymańska583201', 'Szymańska', '875294029', '94');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2022-01-20 13:57:40', 'miłoszszymczak1497@example.net', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Miłosz', 'miłoszszymczak1497', 'Szymczak', '538226723', '95');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2021-06-08 12:30:44', 'jagodakowalski586048@example.net', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Jagoda', 'jagodakowalski586048', 'Kowalski', '800534828', '96');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2022-02-25 10:32:56', 'marcinbąk366369@example.net', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Marcin', 'marcinbąk366369', 'Bąk', '694105018', '97');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2021-11-19 12:25:28', 'liwiapawłowski629829@example.com', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Liwia', 'liwiapawłowski629829', 'Pawłowski', '585159226', '98');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2022-03-14 18:20:11', 'marekpietrzak207087@example.com', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Marek', 'marekpietrzak207087', 'Pietrzak', '221997198', '99');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2022-05-16 06:14:29', 'emiliakubiak774355@example.com', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Emilia', 'emiliakubiak774355', 'Kubiak', '251314618', '100');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2022-03-31 21:23:58', 'oskargłowacka422213@example.com', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Oskar', 'oskargłowacka422213', 'Głowacka', '868813996', '101');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2021-06-20 16:21:23', 'nadiawojciechowski851808@example.com', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Nadia', 'nadiawojciechowski851808', 'Wojciechowski', '153883722', '102');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2021-08-23 19:15:04', 'wiktorszczepańska95055@example.org', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Wiktor', 'wiktorszczepańska95055', 'Szczepańska', '984959139', '103');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2022-03-15 11:51:18', 'malwinawłodarczyk523987@example.org', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Malwina', 'malwinawłodarczyk523987', 'Włodarczyk', '560199227', '104');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2021-09-15 12:29:20', 'ewelinaadamski498373@example.org', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Ewelina', 'ewelinaadamski498373', 'Adamski', '526610990', '105');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2021-05-20 03:38:42', 'kamilanowakowski183119@example.net', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Kamila', 'kamilanowakowski183119', 'Nowakowski', '806955780', '106');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2022-04-15 04:03:31', 'szymonwieczorek437104@example.org', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Szymon', 'szymonwieczorek437104', 'Wieczorek', '353806323', '107');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2021-10-22 06:09:35', 'alansadowski627447@example.com', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Alan', 'alansadowski627447', 'Sadowski', '901227398', '108');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2021-06-27 16:46:05', 'makslewandowski305128@example.com', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Maks', 'makslewandowski305128', 'Lewandowski', '754041789', '109');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2022-04-24 09:50:50', 'igakrupa197242@example.com', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Iga', 'igakrupa197242', 'Krupa', '889784440', '110');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2022-05-06 09:15:25', 'ameliastępień406045@example.org', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Amelia', 'ameliastępień406045', 'Stępień', '516942265', '111');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2021-06-13 09:25:04', 'gabrielamajewski847448@example.org', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Gabriela', 'gabrielamajewski847448', 'Majewski', '168786411', '112');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2021-08-18 22:05:24', 'jerzywojciechowska801418@example.org', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Jerzy', 'jerzywojciechowska801418', 'Wojciechowska', '457856319', '113');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2021-12-03 23:33:32', 'mikołajbrzezińska102604@example.org', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Mikołaj', 'mikołajbrzezińska102604', 'Brzezińska', '980934847', '114');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2021-05-20 03:19:19', 'boryskamińska824795@example.org', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Borys', 'boryskamińska824795', 'Kamińska', '546054369', '115');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2021-09-30 12:20:39', 'igorsokołowska232371@example.org', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Igor', 'igorsokołowska232371', 'Sokołowska', '288034167', '116');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2022-01-13 07:57:24', 'dominikacieślak427765@example.net', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Dominika', 'dominikacieślak427765', 'Cieślak', '918649924', '117');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2021-08-25 07:21:25', 'wiktoriazawadzka865276@example.com', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Wiktoria', 'wiktoriazawadzka865276', 'Zawadzka', '631492046', '118');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2021-05-26 03:55:36', 'cyprianszczepańska310631@example.org', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Cyprian', 'cyprianszczepańska310631', 'Szczepańska', '682531892', '119');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2021-08-14 22:48:45', 'mikołajwieczorek771055@example.net', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Mikołaj', 'mikołajwieczorek771055', 'Wieczorek', '352603701', '120');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2021-07-11 11:13:07', 'marcelgórecka755741@example.net', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Marcel', 'marcelgórecka755741', 'Górecka', '318626425', '121');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2021-08-30 17:10:59', 'fabiansokołowska983378@example.com', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Fabian', 'fabiansokołowska983378', 'Sokołowska', '710746183', '122');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2021-09-26 07:48:48', 'leonardkozłowska520060@example.net', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Leonard', 'leonardkozłowska520060', 'Kozłowska', '679240467', '123');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2022-03-23 11:00:13', 'matyldasokołowska493102@example.org', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Matylda', 'matyldasokołowska493102', 'Sokołowska', '644511601', '124');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2022-01-31 03:23:03', 'dawidgłowacki109499@example.net', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Dawid', 'dawidgłowacki109499', 'Głowacki', '222252822', '125');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2022-04-19 20:47:43', 'tolalewandowski721075@example.org', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Tola', 'tolalewandowski721075', 'Lewandowski', '397451215', '126');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2022-05-06 17:36:58', 'brunoolszewska576643@example.net', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Bruno', 'brunoolszewska576643', 'Olszewska', '358185578', '127');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2022-02-26 04:02:09', 'gustawwróbel98352@example.com', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Gustaw', 'gustawwróbel98352', 'Wróbel', '319761405', '128');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2021-08-03 02:34:05', 'roksanabaranowski297624@example.net', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Roksana', 'roksanabaranowski297624', 'Baranowski', '149283113', '129');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2021-12-22 22:39:14', 'zofiaczerwińska148706@example.net', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Zofia', 'zofiaczerwińska148706', 'Czerwińska', '693672208', '130');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2021-07-14 17:24:30', 'roksanazielińska1874@example.net', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Roksana', 'roksanazielińska1874', 'Zielińska', '164282212', '131');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2022-04-14 15:51:52', 'ingawieczorek371166@example.org', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Inga', 'ingawieczorek371166', 'Wieczorek', '907983635', '132');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2022-03-08 06:12:38', 'arturbrzeziński539375@example.net', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Artur', 'arturbrzeziński539375', 'Brzeziński', '302334026', '133');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2021-06-26 14:52:43', 'oliwiakucharski149681@example.net', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Oliwia', 'oliwiakucharski149681', 'Kucharski', '865706443', '134');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2022-01-13 22:50:32', 'mariuszsadowski668333@example.net', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Mariusz', 'mariuszsadowski668333', 'Sadowski', '707236978', '135');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2021-09-04 16:23:23', 'maurycykalinowski305802@example.org', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Maurycy', 'maurycykalinowski305802', 'Kalinowski', '387820118', '136');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2022-02-14 02:01:45', 'tomaszbłaszczyk323255@example.com', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Tomasz', 'tomaszbłaszczyk323255', 'Błaszczyk', '260241469', '137');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2022-05-05 11:50:00', 'adrianwilk213926@example.org', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Adrian', 'adrianwilk213926', 'Wilk', '354038886', '138');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2022-01-06 13:46:09', 'sylwiawiśniewski122753@example.net', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Sylwia', 'sylwiawiśniewski122753', 'Wiśniewski', '451975116', '139');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2021-10-14 21:56:56', 'sylwiawłodarczyk126439@example.org', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Sylwia', 'sylwiawłodarczyk126439', 'Włodarczyk', '938343209', '140');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2021-06-09 09:11:08', 'tadeuszmazur518457@example.org', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Tadeusz', 'tadeuszmazur518457', 'Mazur', '619553921', '141');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2021-10-06 17:43:42', 'emiliagajewska944775@example.net', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Emilia', 'emiliagajewska944775', 'Gajewska', '559600098', '142');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2021-12-07 01:19:01', 'zofiazalewski527758@example.com', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Zofia', 'zofiazalewski527758', 'Zalewski', '817628687', '143');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2022-02-13 14:25:08', 'krzysztofkrupa981362@example.net', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Krzysztof', 'krzysztofkrupa981362', 'Krupa', '431661056', '144');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2021-12-26 01:18:07', 'martajabłońska645464@example.net', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Marta', 'martajabłońska645464', 'Jabłońska', '149839889', '145');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2022-05-08 06:53:38', 'michałmakowski564722@example.net', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Michał', 'michałmakowski564722', 'Makowski', '726018020', '146');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2022-03-16 23:05:54', 'barbaragórecka361002@example.net', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Barbara', 'barbaragórecka361002', 'Górecka', '914722599', '147');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2021-09-20 06:52:50', 'natanwłodarczyk784431@example.net', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Natan', 'natanwłodarczyk784431', 'Włodarczyk', '457441768', '148');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2022-04-26 17:09:20', 'leonardjakubowska431945@example.org', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Leonard', 'leonardjakubowska431945', 'Jakubowska', '315407678', '149');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2021-10-25 16:00:40', 'majaduda608683@example.net', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Maja', 'majaduda608683', 'Duda', '232221225', '150');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2021-06-02 06:07:28', 'jagodaszymczak537328@example.net', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Jagoda', 'jagodaszymczak537328', 'Szymczak', '185991574', '151');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2021-08-05 13:40:11', 'lenabłaszczyk258841@example.org', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Lena', 'lenabłaszczyk258841', 'Błaszczyk', '733170387', '152');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2021-07-06 13:40:20', 'sebastianwoźniak204522@example.com', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Sebastian', 'sebastianwoźniak204522', 'Woźniak', '489164524', '153');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2021-06-02 19:34:51', 'nikodemlaskowski579908@example.org', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Nikodem', 'nikodemlaskowski579908', 'Laskowski', '576589377', '154');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2021-05-26 09:57:54', 'dominikkalinowska532606@example.net', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Dominik', 'dominikkalinowska532606', 'Kalinowska', '741715779', '155');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2021-11-06 16:18:47', 'łucjasawicki889671@example.org', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Łucja', 'łucjasawicki889671', 'Sawicki', '735734031', '156');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2021-10-25 11:51:14', 'lauraprzybylska397162@example.org', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Laura', 'lauraprzybylska397162', 'Przybylska', '275577940', '157');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2022-01-08 09:00:17', 'leonkucharska611593@example.net', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Leon', 'leonkucharska611593', 'Kucharska', '469488478', '158');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2021-11-29 19:46:36', 'miłosznowicka355514@example.org', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Miłosz', 'miłosznowicka355514', 'Nowicka', '550930364', '159');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2021-09-21 14:12:19', 'patrykmazur651205@example.net', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Patryk', 'patrykmazur651205', 'Mazur', '997780235', '160');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2021-07-02 08:20:33', 'ninawitkowska971765@example.org', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Nina', 'ninawitkowska971765', 'Witkowska', '931569483', '161');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2022-01-01 05:25:12', 'martynaszulc292954@example.net', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Martyna', 'martynaszulc292954', 'Szulc', '337791185', '162');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2022-02-05 11:58:05', 'dariuszzając801783@example.net', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Dariusz', 'dariuszzając801783', 'Zając', '583601573', '163');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2021-08-08 04:14:36', 'tomaszduda819840@example.net', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Tomasz', 'tomaszduda819840', 'Duda', '681892556', '164');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2022-01-14 18:34:13', 'ignacykaczmarczyk826388@example.net', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Ignacy', 'ignacykaczmarczyk826388', 'Kaczmarczyk', '884954548', '165');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2021-06-06 02:13:03', 'cezaryjasiński494648@example.com', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Cezary', 'cezaryjasiński494648', 'Jasiński', '362813795', '166');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2021-06-07 16:40:52', 'igorwiśniewska361851@example.net', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Igor', 'igorwiśniewska361851', 'Wiśniewska', '359120713', '167');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2022-05-09 05:46:32', 'boryszawadzka809820@example.net', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Borys', 'boryszawadzka809820', 'Zawadzka', '887719872', '168');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2022-01-06 00:57:12', 'michałkrawczyk129578@example.com', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Michał', 'michałkrawczyk129578', 'Krawczyk', '327515952', '169');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2021-05-25 22:29:43', 'zuzannasikora655741@example.net', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Zuzanna', 'zuzannasikora655741', 'Sikora', '740589357', '170');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2022-03-18 03:04:34', 'karolinasikora326276@example.net', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Karolina', 'karolinasikora326276', 'Sikora', '929981745', '171');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2022-01-26 13:56:29', 'malwinaandrzejewska459468@example.net', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Malwina', 'malwinaandrzejewska459468', 'Andrzejewska', '600285295', '172');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2022-01-31 15:52:21', 'brunosikora327221@example.net', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Bruno', 'brunosikora327221', 'Sikora', '801122558', '173');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2021-06-06 15:43:19', 'dawidkrupa495687@example.org', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Dawid', 'dawidkrupa495687', 'Krupa', '871340076', '174');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2021-10-13 03:43:08', 'nikolamróz950700@example.net', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Nikola', 'nikolamróz950700', 'Mróz', '852541726', '175');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2021-05-26 22:05:32', 'witoldchmielewski856238@example.net', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Witold', 'witoldchmielewski856238', 'Chmielewski', '920061857', '176');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2021-05-25 02:19:40', 'natanieljakubowski791399@example.net', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Nataniel', 'natanieljakubowski791399', 'Jakubowski', '253023372', '177');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2022-02-06 21:03:24', 'dagmaragrabowska835372@example.org', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Dagmara', 'dagmaragrabowska835372', 'Grabowska', '685147400', '178');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2021-12-04 22:44:00', 'ewaborkowska571552@example.com', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Ewa', 'ewaborkowska571552', 'Borkowska', '806828738', '179');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2022-03-21 04:13:46', 'julitaszulc59735@example.org', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Julita', 'julitaszulc59735', 'Szulc', '298111741', '180');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2022-05-11 18:10:33', 'nikodemmazurek679780@example.net', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Nikodem', 'nikodemmazurek679780', 'Mazurek', '246593020', '181');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2021-12-24 04:56:55', 'mariawojciechowski641263@example.com', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Maria', 'mariawojciechowski641263', 'Wojciechowski', '994120899', '182');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2022-04-20 17:30:43', 'nicolelaskowska948111@example.net', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Nicole', 'nicolelaskowska948111', 'Laskowska', '376229494', '183');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2021-10-02 12:52:16', 'adaborowska413690@example.net', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Ada', 'adaborowska413690', 'Borowska', '507548523', '184');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2022-02-28 06:55:34', 'ksawerykrupa135004@example.org', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Ksawery', 'ksawerykrupa135004', 'Krupa', '674388775', '185');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2022-04-09 17:05:29', 'mariuszczerwińska195616@example.com', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Mariusz', 'mariuszczerwińska195616', 'Czerwińska', '199155156', '186');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2022-01-24 10:56:38', 'jędrzejbąk205420@example.org', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Jędrzej', 'jędrzejbąk205420', 'Bąk', '467681005', '187');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2021-05-29 20:02:24', 'alankalinowski338673@example.net', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Alan', 'alankalinowski338673', 'Kalinowski', '226501192', '188');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2022-03-09 09:07:38', 'ignacydudek297465@example.com', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Ignacy', 'ignacydudek297465', 'Dudek', '494083732', '189');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2021-09-21 06:02:22', 'aleksandrawróblewska312513@example.org', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Aleksandra', 'aleksandrawróblewska312513', 'Wróblewska', '809145650', '190');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2021-10-25 20:50:10', 'julitaduda370437@example.net', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Julita', 'julitaduda370437', 'Duda', '304474158', '191');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2022-01-30 09:41:20', 'wiktormazur167202@example.com', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Wiktor', 'wiktormazur167202', 'Mazur', '783398834', '192');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2021-08-04 14:45:29', 'elizakalinowski446889@example.org', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Eliza', 'elizakalinowski446889', 'Kalinowski', '650486170', '193');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2021-05-21 03:03:04', 'jerzystępień328427@example.org', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Jerzy', 'jerzystępień328427', 'Stępień', '268125042', '194');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2021-09-29 09:18:21', 'łucjabaran424168@example.com', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Łucja', 'łucjabaran424168', 'Baran', '769566188', '195');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2021-07-28 11:17:16', 'stefanbaranowski63323@example.org', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Stefan', 'stefanbaranowski63323', 'Baranowski', '844826457', '196');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2022-02-19 20:50:20', 'julialaskowska708017@example.com', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Julia', 'julialaskowska708017', 'Laskowska', '446227598', '197');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2021-12-29 08:26:45', 'adamwróblewska241422@example.org', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Adam', 'adamwróblewska241422', 'Wróblewska', '734540048', '198');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2022-02-04 16:00:40', 'zuzannazawadzka832973@example.net', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Zuzanna', 'zuzannazawadzka832973', 'Zawadzka', '238453662', '199');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2022-05-15 01:26:54', 'leonsokołowska929974@example.com', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Leon', 'leonsokołowska929974', 'Sokołowska', '604608367', '200');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2022-02-15 09:28:42', 'mariaadamczyk267075@example.net', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Maria', 'mariaadamczyk267075', 'Adamczyk', '485625981', '201');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2021-11-30 01:40:58', 'majawasilewski266498@example.org', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Maja', 'majawasilewski266498', 'Wasilewski', '185974528', '202');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2022-03-08 16:12:53', 'dariuszchmielewska24196@example.net', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Dariusz', 'dariuszchmielewska24196', 'Chmielewska', '415749951', '203');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2022-04-17 02:38:57', 'melaniaziółkowski48291@example.org', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Melania', 'melaniaziółkowski48291', 'Ziółkowski', '908305522', '204');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2021-06-12 02:07:41', 'stefanwójcik365837@example.com', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Stefan', 'stefanwójcik365837', 'Wójcik', '535901771', '205');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2022-04-30 00:12:34', 'juliannastępień329768@example.net', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Julianna', 'juliannastępień329768', 'Stępień', '422492221', '206');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2021-06-03 20:38:51', 'anielaostrowski47883@example.com', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Aniela', 'anielaostrowski47883', 'Ostrowski', '757300043', '207');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2021-10-12 19:22:19', 'kacperwilk226562@example.com', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Kacper', 'kacperwilk226562', 'Wilk', '225152333', '208');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2021-11-10 01:56:34', 'aleksandracieślak681888@example.net', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Aleksandra', 'aleksandracieślak681888', 'Cieślak', '648176558', '209');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2021-11-14 12:55:29', 'mikołajrutkowski162154@example.org', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Mikołaj', 'mikołajrutkowski162154', 'Rutkowski', '805514335', '210');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2021-08-03 10:31:15', 'iwojabłońska96719@example.com', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Iwo', 'iwojabłońska96719', 'Jabłońska', '912589986', '211');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2021-09-24 04:21:16', 'annakucharski945664@example.net', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Anna', 'annakucharski945664', 'Kucharski', '485867056', '212');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2021-05-22 22:40:55', 'franciszekgłowacki18173@example.net', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Franciszek', 'franciszekgłowacki18173', 'Głowacki', '893098728', '213');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2022-01-20 20:52:09', 'pawełwieczorek366867@example.com', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Paweł', 'pawełwieczorek366867', 'Wieczorek', '953793109', '214');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2021-08-05 09:56:09', 'jędrzejmazurek980393@example.org', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Jędrzej', 'jędrzejmazurek980393', 'Mazurek', '225979692', '215');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2022-01-13 23:54:23', 'maksymilianszymczak6656@example.net', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Maksymilian', 'maksymilianszymczak6656', 'Szymczak', '753058435', '216');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2021-06-11 06:45:40', 'kajetanbaranowska746464@example.com', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Kajetan', 'kajetanbaranowska746464', 'Baranowska', '736540731', '217');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2021-07-06 12:40:55', 'szymonsobczak32915@example.com', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Szymon', 'szymonsobczak32915', 'Sobczak', '665528226', '218');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2021-07-07 14:03:02', 'kamilmalinowska738206@example.net', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Kamil', 'kamilmalinowska738206', 'Malinowska', '480689754', '219');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2021-10-02 03:29:36', 'cyprianbłaszczyk263444@example.com', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Cyprian', 'cyprianbłaszczyk263444', 'Błaszczyk', '832183784', '220');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2022-04-27 15:05:04', 'igadąbrowska855657@example.net', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Iga', 'igadąbrowska855657', 'Dąbrowska', '239226266', '221');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2022-03-29 11:13:28', 'gustawsadowski547143@example.com', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Gustaw', 'gustawsadowski547143', 'Sadowski', '593254017', '222');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2021-10-04 14:03:49', 'józefszymańska526248@example.com', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Józef', 'józefszymańska526248', 'Szymańska', '936311456', '223');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2021-06-14 19:43:57', 'jereminowakowski773486@example.com', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Jeremi', 'jereminowakowski773486', 'Nowakowski', '292239681', '224');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2021-11-23 16:14:01', 'apoloniakubiak667752@example.net', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Apolonia', 'apoloniakubiak667752', 'Kubiak', '141651813', '225');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2022-05-08 07:49:35', 'patrycjakról597498@example.net', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Patrycja', 'patrycjakról597498', 'Król', '521278033', '226');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2021-11-04 10:21:34', 'wiktorkubiak117061@example.net', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Wiktor', 'wiktorkubiak117061', 'Kubiak', '327337361', '227');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2021-12-31 15:00:25', 'julianbaranowska590836@example.net', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Julian', 'julianbaranowska590836', 'Baranowska', '293731372', '228');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2021-09-30 10:57:05', 'zuzannaduda205719@example.org', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Zuzanna', 'zuzannaduda205719', 'Duda', '469264758', '229');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2022-01-22 20:11:17', 'alicjapawłowski544908@example.org', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Alicja', 'alicjapawłowski544908', 'Pawłowski', '154088356', '230');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2021-06-10 14:16:47', 'ernestmarciniak676677@example.org', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Ernest', 'ernestmarciniak676677', 'Marciniak', '277765415', '231');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2022-05-09 22:44:05', 'ksawerykrajewska400984@example.net', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Ksawery', 'ksawerykrajewska400984', 'Krajewska', '841955445', '232');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2022-03-10 06:05:26', 'adajakubowski195605@example.com', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Ada', 'adajakubowski195605', 'Jakubowski', '149916218', '233');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2021-10-23 15:10:01', 'ewawojciechowski121934@example.org', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Ewa', 'ewawojciechowski121934', 'Wojciechowski', '561302796', '234');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2021-06-27 17:50:11', 'dominikwysocka52265@example.org', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Dominik', 'dominikwysocka52265', 'Wysocka', '421969824', '235');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2021-12-29 15:19:06', 'piotrkucharski259910@example.net', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Piotr', 'piotrkucharski259910', 'Kucharski', '300675574', '236');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2021-05-19 00:30:26', 'ninawilk911320@example.com', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Nina', 'ninawilk911320', 'Wilk', '794869425', '237');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2022-03-25 06:34:39', 'nikodemolszewska281166@example.com', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Nikodem', 'nikodemolszewska281166', 'Olszewska', '335312493', '238');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2022-04-08 03:31:15', 'damiankucharska304827@example.org', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Damian', 'damiankucharska304827', 'Kucharska', '518059788', '239');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2021-08-01 02:03:21', 'hannawróbel930554@example.org', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Hanna', 'hannawróbel930554', 'Wróbel', '458949851', '240');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2021-11-01 17:51:00', 'krzysztofostrowski419455@example.org', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Krzysztof', 'krzysztofostrowski419455', 'Ostrowski', '628420975', '241');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2021-09-11 11:43:22', 'sarabaran877767@example.com', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Sara', 'sarabaran877767', 'Baran', '799686353', '242');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2022-05-02 00:28:56', 'oliwiaduda207559@example.net', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Oliwia', 'oliwiaduda207559', 'Duda', '808675131', '243');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2021-05-23 23:49:57', 'patryktomaszewska992624@example.net', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Patryk', 'patryktomaszewska992624', 'Tomaszewska', '391697250', '244');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2022-05-07 06:21:06', 'natanielkaźmierczak618232@example.org', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Nataniel', 'natanielkaźmierczak618232', 'Kaźmierczak', '976489436', '245');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2021-10-26 21:21:31', 'liwiamróz238199@example.net', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Liwia', 'liwiamróz238199', 'Mróz', '557849662', '246');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2021-12-01 14:16:57', 'weronikapawłowski911068@example.net', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Weronika', 'weronikapawłowski911068', 'Pawłowski', '872565720', '247');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2022-01-05 03:46:09', 'marcelinapietrzak707673@example.org', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Marcelina', 'marcelinapietrzak707673', 'Pietrzak', '339286523', '248');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2022-03-27 11:01:00', 'marekkaźmierczak187860@example.net', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Marek', 'marekkaźmierczak187860', 'Kaźmierczak', '830672978', '249');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2022-02-09 22:52:42', 'mateuszmarciniak566488@example.org', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Mateusz', 'mateuszmarciniak566488', 'Marciniak', '392211776', '250');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2021-08-23 19:31:22', 'norbertkaczmarczyk102037@example.org', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Norbert', 'norbertkaczmarczyk102037', 'Kaczmarczyk', '523621085', '251');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2021-11-08 19:54:24', 'mariabrzeziński937115@example.com', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Maria', 'mariabrzeziński937115', 'Brzeziński', '777904843', '252');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2021-12-24 23:19:06', 'magdalenakrajewska441076@example.net', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Magdalena', 'magdalenakrajewska441076', 'Krajewska', '235381195', '253');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2021-06-02 12:44:40', 'aleksbłaszczyk758845@example.org', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Aleks', 'aleksbłaszczyk758845', 'Błaszczyk', '538585452', '254');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2021-06-03 07:36:32', 'tolanowakowski852996@example.com', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Tola', 'tolanowakowski852996', 'Nowakowski', '361950440', '255');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2022-04-26 14:00:14', 'tadeuszbłaszczyk448273@example.net', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Tadeusz', 'tadeuszbłaszczyk448273', 'Błaszczyk', '580415409', '256');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2022-03-03 08:32:54', 'ryszardkamińska565829@example.net', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Ryszard', 'ryszardkamińska565829', 'Kamińska', '727298179', '257');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2021-10-21 16:19:38', 'wiktorkaźmierczak706821@example.net', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Wiktor', 'wiktorkaźmierczak706821', 'Kaźmierczak', '421492813', '258');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2022-01-26 22:29:10', 'zofiasawicki381980@example.org', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Zofia', 'zofiasawicki381980', 'Sawicki', '125495453', '259');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2021-12-23 07:08:57', 'milenaczarnecka737926@example.net', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Milena', 'milenaczarnecka737926', 'Czarnecka', '702646646', '260');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2021-12-19 16:06:20', 'jędrzejdąbrowska334277@example.org', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Jędrzej', 'jędrzejdąbrowska334277', 'Dąbrowska', '618251272', '261');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2021-11-08 09:32:59', 'michalinatomaszewska333792@example.org', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Michalina', 'michalinatomaszewska333792', 'Tomaszewska', '819372999', '262');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2022-03-10 23:42:51', 'annakamińska397299@example.org', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Anna', 'annakamińska397299', 'Kamińska', '124571522', '263');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2022-03-06 02:09:58', 'patrycjamarciniak579446@example.com', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Patrycja', 'patrycjamarciniak579446', 'Marciniak', '365532700', '264');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2021-09-20 22:30:44', 'katarzynapiotrowski762073@example.net', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Katarzyna', 'katarzynapiotrowski762073', 'Piotrowski', '789800206', '265');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2022-01-05 01:06:56', 'witoldkaczmarek75379@example.net', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Witold', 'witoldkaczmarek75379', 'Kaczmarek', '120921712', '266');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2022-02-06 09:05:02', 'bartekrutkowska976785@example.net', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Bartek', 'bartekrutkowska976785', 'Rutkowska', '797018477', '267');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2021-09-08 04:01:56', 'wiktorandrzejewski310778@example.org', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Wiktor', 'wiktorandrzejewski310778', 'Andrzejewski', '402627053', '268');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2021-10-14 22:30:32', 'pawełjabłońska979490@example.net', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Paweł', 'pawełjabłońska979490', 'Jabłońska', '352487462', '269');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2021-10-26 01:17:30', 'dorotajaworski485473@example.net', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Dorota', 'dorotajaworski485473', 'Jaworski', '180555988', '270');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2021-06-27 06:23:09', 'pawełgajewski907390@example.net', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Paweł', 'pawełgajewski907390', 'Gajewski', '678807927', '271');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2021-12-27 22:56:32', 'joannachmielewski542193@example.net', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Joanna', 'joannachmielewski542193', 'Chmielewski', '457859624', '272');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2021-09-01 22:21:10', 'jacekolszewski356146@example.org', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Jacek', 'jacekolszewski356146', 'Olszewski', '903485457', '273');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2022-01-13 09:39:30', 'malwinamarciniak551836@example.com', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Malwina', 'malwinamarciniak551836', 'Marciniak', '325014329', '274');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2021-05-27 15:40:53', 'marikazakrzewska571158@example.net', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Marika', 'marikazakrzewska571158', 'Zakrzewska', '892735248', '275');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2021-11-04 21:19:23', 'gabrielurbańska490556@example.com', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Gabriel', 'gabrielurbańska490556', 'Urbańska', '509148025', '276');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2022-02-18 19:59:13', 'sebastianchmielewska127651@example.org', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Sebastian', 'sebastianchmielewska127651', 'Chmielewska', '163686590', '277');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2022-04-04 06:34:32', 'krystianwoźniak820719@example.com', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Krystian', 'krystianwoźniak820719', 'Woźniak', '553492261', '278');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2021-07-24 09:22:58', 'klaudiaziółkowska638602@example.org', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Klaudia', 'klaudiaziółkowska638602', 'Ziółkowska', '976884154', '279');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2021-07-23 08:14:40', 'jacekjabłoński632271@example.net', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Jacek', 'jacekjabłoński632271', 'Jabłoński', '596585334', '280');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2022-05-10 18:03:48', 'adriannaurbański482575@example.net', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Adrianna', 'adriannaurbański482575', 'Urbański', '629168488', '281');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2021-08-08 19:09:26', 'kamilszulc223304@example.com', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Kamil', 'kamilszulc223304', 'Szulc', '743337902', '282');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2021-06-14 00:41:20', 'karinarutkowska670536@example.org', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Karina', 'karinarutkowska670536', 'Rutkowska', '333139921', '283');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2021-09-29 09:40:33', 'błażejszczepańska727229@example.net', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Błażej', 'błażejszczepańska727229', 'Szczepańska', '366134929', '284');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2022-04-25 07:14:29', 'natanielpiotrowski171367@example.com', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Nataniel', 'natanielpiotrowski171367', 'Piotrowski', '865530331', '285');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2021-06-14 07:47:09', 'mariachmielewska62511@example.net', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Maria', 'mariachmielewska62511', 'Chmielewska', '155390782', '286');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2022-04-14 09:45:59', 'danieladamczyk907470@example.org', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Daniel', 'danieladamczyk907470', 'Adamczyk', '226593763', '287');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2021-09-16 17:16:10', 'robertborowska706361@example.org', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Robert', 'robertborowska706361', 'Borowska', '741328215', '288');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2022-02-11 10:40:45', 'dagmarawilk12833@example.com', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Dagmara', 'dagmarawilk12833', 'Wilk', '830560839', '289');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2022-01-09 14:50:06', 'karolinakalinowski264954@example.com', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Karolina', 'karolinakalinowski264954', 'Kalinowski', '309993490', '290');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2021-05-18 11:08:51', 'malwinakaczmarek58102@example.org', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Malwina', 'malwinakaczmarek58102', 'Kaczmarek', '240845865', '291');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2021-11-28 02:06:28', 'stanisławprzybylska762437@example.com', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Stanisław', 'stanisławprzybylska762437', 'Przybylska', '108941697', '292');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2022-02-18 03:47:01', 'wojciechkrupa466139@example.com', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Wojciech', 'wojciechkrupa466139', 'Krupa', '932963808', '293');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2021-11-22 11:15:13', 'mariakaczmarek422851@example.net', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Maria', 'mariakaczmarek422851', 'Kaczmarek', '289573376', '294');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2021-09-15 03:51:22', 'angelikasikora354046@example.com', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Angelika', 'angelikasikora354046', 'Sikora', '229522038', '295');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2022-03-31 11:14:36', 'kajagłowacka759903@example.org', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Kaja', 'kajagłowacka759903', 'Głowacka', '217023454', '296');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2022-02-01 23:56:51', 'tadeusznowicka393366@example.net', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Tadeusz', 'tadeusznowicka393366', 'Nowicka', '635030301', '297');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2021-07-05 14:55:20', 'roksanaadamska722467@example.org', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Roksana', 'roksanaadamska722467', 'Adamska', '943233525', '298');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2022-05-07 17:05:36', 'barbaragrabowska966670@example.org', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Barbara', 'barbaragrabowska966670', 'Grabowska', '297168321', '299');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2022-04-02 09:47:36', 'nataliaandrzejewski627289@example.net', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Natalia', 'nataliaandrzejewski627289', 'Andrzejewski', '663820708', '300');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2021-10-18 23:37:01', 'gabrielawróbel686305@example.com', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Gabriela', 'gabrielawróbel686305', 'Wróbel', '167636258', '301');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2021-10-09 06:31:36', 'maksymiliankalinowska236404@example.net', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Maksymilian', 'maksymiliankalinowska236404', 'Kalinowska', '762661981', '302');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2021-11-06 11:25:44', 'joannaszczepańska178311@example.net', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Joanna', 'joannaszczepańska178311', 'Szczepańska', '663925472', '303');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2021-11-20 09:50:09', 'nataszaprzybylska918077@example.com', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Natasza', 'nataszaprzybylska918077', 'Przybylska', '828223508', '304');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2021-08-01 09:07:33', 'mateuszszymczak804116@example.net', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Mateusz', 'mateuszszymczak804116', 'Szymczak', '399763565', '305');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2021-12-08 13:31:20', 'łucjalis828914@example.net', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Łucja', 'łucjalis828914', 'Lis', '991436572', '306');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2021-12-07 03:00:28', 'ameliaborowska366685@example.net', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Amelia', 'ameliaborowska366685', 'Borowska', '556337153', '307');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2022-05-03 03:08:55', 'weronikastępień528183@example.net', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Weronika', 'weronikastępień528183', 'Stępień', '491853802', '308');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2021-11-15 10:08:26', 'sebastianmarciniak922413@example.org', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Sebastian', 'sebastianmarciniak922413', 'Marciniak', '949666478', '309');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2021-06-27 14:19:02', 'sylwiabłaszczyk961765@example.com', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Sylwia', 'sylwiabłaszczyk961765', 'Błaszczyk', '843608407', '310');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2022-01-28 12:27:51', 'magdalenaczarnecka949231@example.com', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Magdalena', 'magdalenaczarnecka949231', 'Czarnecka', '657157134', '311');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2022-01-08 04:40:34', 'michałszczepańska700069@example.org', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Michał', 'michałszczepańska700069', 'Szczepańska', '783275062', '312');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2021-10-18 02:32:54', 'nataszapawlak445164@example.com', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Natasza', 'nataszapawlak445164', 'Pawlak', '365705521', '313');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2021-05-23 18:48:11', 'robertbrzezińska387846@example.net', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Robert', 'robertbrzezińska387846', 'Brzezińska', '253234319', '314');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2022-02-13 10:31:26', 'tadeuszwysocki228544@example.org', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Tadeusz', 'tadeuszwysocki228544', 'Wysocki', '960981769', '315');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2022-05-04 08:50:23', 'dariuszmazur925651@example.org', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Dariusz', 'dariuszmazur925651', 'Mazur', '971043042', '316');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2022-05-10 19:25:28', 'juliuszwysocki920386@example.net', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Juliusz', 'juliuszwysocki920386', 'Wysocki', '382958531', '317');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2021-09-24 17:03:38', 'sylwianowicka962776@example.com', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Sylwia', 'sylwianowicka962776', 'Nowicka', '309116194', '318');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2021-05-29 08:27:03', 'dominikazawadzki731952@example.net', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Dominika', 'dominikazawadzki731952', 'Zawadzki', '332560307', '319');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2021-12-31 20:29:40', 'dominikzalewski45418@example.com', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Dominik', 'dominikzalewski45418', 'Zalewski', '155154737', '320');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2021-08-05 21:09:39', 'adampiotrowski488079@example.com', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Adam', 'adampiotrowski488079', 'Piotrowski', '952266060', '321');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2022-04-25 15:00:54', 'janinakaźmierczak906073@example.com', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Janina', 'janinakaźmierczak906073', 'Kaźmierczak', '846573269', '322');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2021-08-20 08:40:07', 'maciejwojciechowska424339@example.net', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Maciej', 'maciejwojciechowska424339', 'Wojciechowska', '850697685', '323');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2021-07-18 21:03:01', 'filippawlak51102@example.com', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Filip', 'filippawlak51102', 'Pawlak', '186820201', '324');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2021-09-04 23:26:11', 'różawróblewska693136@example.com', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Róża', 'różawróblewska693136', 'Wróblewska', '838893614', '325');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2021-08-04 06:01:16', 'ewelinaszulc846053@example.org', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Ewelina', 'ewelinaszulc846053', 'Szulc', '654692395', '326');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2021-11-29 03:49:21', 'arkadiuszborkowski124951@example.net', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Arkadiusz', 'arkadiuszborkowski124951', 'Borkowski', '923328369', '327');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2021-08-27 13:04:36', 'klaudiamaciejewska707135@example.net', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Klaudia', 'klaudiamaciejewska707135', 'Maciejewska', '761920248', '328');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2022-02-25 10:53:23', 'sebastiankaczmarczyk27706@example.org', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Sebastian', 'sebastiankaczmarczyk27706', 'Kaczmarczyk', '710066959', '329');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2022-05-01 10:20:28', 'lilianabłaszczyk992095@example.com', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Liliana', 'lilianabłaszczyk992095', 'Błaszczyk', '954713881', '330');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2022-04-06 04:02:36', 'marikawysocki759339@example.net', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Marika', 'marikawysocki759339', 'Wysocki', '518481649', '331');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2022-04-22 04:06:06', 'łucjazalewska970589@example.net', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Łucja', 'łucjazalewska970589', 'Zalewska', '947433982', '332');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2021-11-18 00:34:10', 'katarzynanowak527680@example.net', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Katarzyna', 'katarzynanowak527680', 'Nowak', '493416440', '333');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2021-11-26 04:03:07', 'karinawasilewski753934@example.org', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Karina', 'karinawasilewski753934', 'Wasilewski', '364865864', '334');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2022-03-16 23:32:34', 'krystianjakubowska18104@example.org', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Krystian', 'krystianjakubowska18104', 'Jakubowska', '408765674', '335');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2022-05-10 08:38:09', 'erykszczepańska27381@example.org', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Eryk', 'erykszczepańska27381', 'Szczepańska', '275173244', '336');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2022-05-05 08:06:56', 'cypriankubiak105024@example.org', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Cyprian', 'cypriankubiak105024', 'Kubiak', '858939416', '337');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2022-04-03 03:55:10', 'oliwierdąbrowska512068@example.net', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Oliwier', 'oliwierdąbrowska512068', 'Dąbrowska', '366793955', '338');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2021-12-15 21:29:10', 'tymontomaszewski647243@example.org', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Tymon', 'tymontomaszewski647243', 'Tomaszewski', '454115637', '339');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2021-12-17 13:29:16', 'mikołajmarciniak887815@example.net', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Mikołaj', 'mikołajmarciniak887815', 'Marciniak', '665057100', '340');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2021-05-25 08:51:08', 'dariapiotrowska829454@example.net', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Daria', 'dariapiotrowska829454', 'Piotrowska', '730342204', '341');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2021-10-12 13:33:26', 'różadudek90810@example.net', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Róża', 'różadudek90810', 'Dudek', '672343621', '342');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2022-05-04 11:23:31', 'nelawysocki832071@example.com', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Nela', 'nelawysocki832071', 'Wysocki', '139419857', '343');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2021-07-02 10:17:30', 'katarzynasobczak222296@example.net', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Katarzyna', 'katarzynasobczak222296', 'Sobczak', '893752149', '344');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2021-12-29 18:27:51', 'natanielgajewska672971@example.org', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Nataniel', 'natanielgajewska672971', 'Gajewska', '262640444', '345');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2021-07-28 04:15:59', 'krystianzakrzewska545958@example.org', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Krystian', 'krystianzakrzewska545958', 'Zakrzewska', '765906150', '346');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2021-10-06 02:51:10', 'mateuszszulc11314@example.com', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Mateusz', 'mateuszszulc11314', 'Szulc', '741059409', '347');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2021-07-22 08:02:04', 'krzysztofbaranowski204903@example.org', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Krzysztof', 'krzysztofbaranowski204903', 'Baranowski', '655447497', '348');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2021-05-17 19:52:02', 'zuzannawasilewski711608@example.com', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Zuzanna', 'zuzannawasilewski711608', 'Wasilewski', '864252915', '349');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2021-10-26 18:25:20', 'aleksanderkowalczyk164530@example.org', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Aleksander', 'aleksanderkowalczyk164530', 'Kowalczyk', '238020589', '350');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2021-11-22 12:11:23', 'karolgajewski113893@example.com', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Karol', 'karolgajewski113893', 'Gajewski', '396281952', '351');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2021-12-20 23:31:49', 'tolazając748276@example.com', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Tola', 'tolazając748276', 'Zając', '997353188', '352');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2022-04-10 19:49:31', 'helenawróblewska653118@example.org', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Helena', 'helenawróblewska653118', 'Wróblewska', '724585882', '353');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2022-02-23 13:52:19', 'leonwalczak873043@example.org', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Leon', 'leonwalczak873043', 'Walczak', '321235530', '354');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2021-07-13 12:30:06', 'błażejbrzezińska810597@example.com', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Błażej', 'błażejbrzezińska810597', 'Brzezińska', '653002203', '355');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2021-09-11 04:31:09', 'jeremiwróblewski754151@example.net', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Jeremi', 'jeremiwróblewski754151', 'Wróblewski', '339341933', '356');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2021-07-05 16:00:47', 'ingaurbańska826586@example.com', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Inga', 'ingaurbańska826586', 'Urbańska', '895027770', '357');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2021-06-24 04:12:43', 'janinawojciechowska61993@example.com', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Janina', 'janinawojciechowska61993', 'Wojciechowska', '257750627', '358');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2021-07-15 12:54:46', 'sylwiawalczak763993@example.net', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Sylwia', 'sylwiawalczak763993', 'Walczak', '870170330', '359');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2021-08-11 08:40:12', 'arkadiuszkucharski663966@example.net', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Arkadiusz', 'arkadiuszkucharski663966', 'Kucharski', '637692850', '360');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2021-12-24 05:56:42', 'zofiamichalak162936@example.com', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Zofia', 'zofiamichalak162936', 'Michalak', '748286015', '361');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2021-08-24 03:48:50', 'boryskrajewski300004@example.org', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Borys', 'boryskrajewski300004', 'Krajewski', '470202093', '362');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2022-05-14 23:45:23', 'antoniwoźniak921091@example.net', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Antoni', 'antoniwoźniak921091', 'Woźniak', '114389131', '363');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2021-05-21 23:18:44', 'szymonziółkowski306704@example.net', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Szymon', 'szymonziółkowski306704', 'Ziółkowski', '345980383', '364');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2021-09-09 05:11:00', 'martynakamińska6959@example.org', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Martyna', 'martynakamińska6959', 'Kamińska', '691680624', '365');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2021-09-07 09:05:31', 'malwinaszczepańska679766@example.net', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Malwina', 'malwinaszczepańska679766', 'Szczepańska', '447306619', '366');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2021-10-15 22:08:05', 'norbertsawicka60547@example.com', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Norbert', 'norbertsawicka60547', 'Sawicka', '461298442', '367');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2022-01-04 15:17:03', 'milenaprzybylska236298@example.com', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Milena', 'milenaprzybylska236298', 'Przybylska', '266209994', '368');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2022-03-16 05:18:12', 'igazawadzki140058@example.com', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Iga', 'igazawadzki140058', 'Zawadzki', '550179188', '369');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2021-07-03 19:36:51', 'norberturbańska532267@example.com', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Norbert', 'norberturbańska532267', 'Urbańska', '385280600', '370');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2021-11-03 08:24:23', 'agnieszkaborkowski172149@example.com', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Agnieszka', 'agnieszkaborkowski172149', 'Borkowski', '529280137', '371');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2021-12-31 18:37:17', 'łukaszostrowski485072@example.org', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Łukasz', 'łukaszostrowski485072', 'Ostrowski', '873019680', '372');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2022-01-14 11:17:21', 'janinaborowska773266@example.net', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Janina', 'janinaborowska773266', 'Borowska', '283213845', '373');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2021-09-09 22:48:18', 'patrycjaduda206849@example.net', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Patrycja', 'patrycjaduda206849', 'Duda', '305429156', '374');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2022-04-14 22:35:30', 'lilianamazur380469@example.com', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Liliana', 'lilianamazur380469', 'Mazur', '405542699', '375');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2022-04-25 15:11:24', 'juliuszlaskowski912255@example.com', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Juliusz', 'juliuszlaskowski912255', 'Laskowski', '730397128', '376');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2021-12-22 14:58:57', 'nikolabaran436252@example.org', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Nikola', 'nikolabaran436252', 'Baran', '675767299', '377');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2021-11-18 04:40:54', 'karolrutkowski600665@example.org', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Karol', 'karolrutkowski600665', 'Rutkowski', '948137369', '378');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2021-12-24 17:48:01', 'sonianowakowska882430@example.com', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Sonia', 'sonianowakowska882430', 'Nowakowska', '537719318', '379');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2022-02-21 15:22:05', 'kamilajasińska2413@example.com', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Kamila', 'kamilajasińska2413', 'Jasińska', '228652907', '380');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2022-03-14 09:33:13', 'martacieślak979943@example.org', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Marta', 'martacieślak979943', 'Cieślak', '668310192', '381');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2021-10-14 08:42:54', 'janduda565051@example.org', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Jan', 'janduda565051', 'Duda', '164418562', '382');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2022-05-14 04:37:01', 'anielabąk548199@example.com', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Aniela', 'anielabąk548199', 'Bąk', '871750988', '383');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2022-05-02 01:04:40', 'agnieszkagajewska291650@example.org', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Agnieszka', 'agnieszkagajewska291650', 'Gajewska', '340992489', '384');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2021-11-26 05:54:10', 'nataszaurbański730659@example.org', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Natasza', 'nataszaurbański730659', 'Urbański', '701549383', '385');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2022-02-05 11:55:50', 'joannakozłowska115338@example.org', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Joanna', 'joannakozłowska115338', 'Kozłowska', '703392140', '386');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2022-05-06 23:22:44', 'jędrzejwalczak943119@example.com', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Jędrzej', 'jędrzejwalczak943119', 'Walczak', '781071244', '387');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2021-09-28 17:10:44', 'tolawieczorek565351@example.com', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Tola', 'tolawieczorek565351', 'Wieczorek', '500442618', '388');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2022-01-04 10:37:14', 'oliwiakowalczyk930912@example.org', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Oliwia', 'oliwiakowalczyk930912', 'Kowalczyk', '724779581', '389');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2022-02-23 02:58:58', 'mariannasawicka572679@example.com', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Marianna', 'mariannasawicka572679', 'Sawicka', '457341904', '390');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2021-05-17 17:46:29', 'rafałwróbel797079@example.com', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Rafał', 'rafałwróbel797079', 'Wróbel', '414486387', '391');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2021-11-19 11:04:38', 'maksymilianborowski449090@example.org', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Maksymilian', 'maksymilianborowski449090', 'Borowski', '792672250', '392');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2021-10-22 00:07:00', 'erykwalczak935472@example.net', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Eryk', 'erykwalczak935472', 'Walczak', '440652117', '393');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2022-03-22 21:23:38', 'filipkrawczyk100482@example.com', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Filip', 'filipkrawczyk100482', 'Krawczyk', '339141965', '394');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2022-02-26 21:18:51', 'ksawerymarciniak852520@example.com', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Ksawery', 'ksawerymarciniak852520', 'Marciniak', '451447794', '395');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2022-03-02 06:59:00', 'martakołodziej134896@example.com', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Marta', 'martakołodziej134896', 'Kołodziej', '640545728', '396');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2022-02-01 09:03:19', 'jakubpawłowski353478@example.net', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Jakub', 'jakubpawłowski353478', 'Pawłowski', '313706756', '397');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2021-10-14 01:21:06', 'dariuszkrawczyk655695@example.org', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Dariusz', 'dariuszkrawczyk655695', 'Krawczyk', '408767530', '398');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2022-05-02 23:03:56', 'miłoszurbańska505257@example.net', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Miłosz', 'miłoszurbańska505257', 'Urbańska', '115005206', '399');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2021-10-15 16:10:40', 'boryswysocki426466@example.com', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Borys', 'boryswysocki426466', 'Wysocki', '819819334', '400');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2021-09-02 23:29:32', 'elizaprzybylski3940@example.net', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Eliza', 'elizaprzybylski3940', 'Przybylski', '114966902', '401');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2021-06-30 14:18:46', 'ksaweryczerwińska405102@example.org', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Ksawery', 'ksaweryczerwińska405102', 'Czerwińska', '872080061', '402');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2021-07-16 07:02:09', 'olgierdborkowski927238@example.com', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Olgierd', 'olgierdborkowski927238', 'Borkowski', '270056891', '403');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2022-04-12 13:47:23', 'annakrupa590007@example.com', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Anna', 'annakrupa590007', 'Krupa', '796844098', '404');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2021-05-26 10:55:15', 'franciszekzawadzki877340@example.org', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Franciszek', 'franciszekzawadzki877340', 'Zawadzki', '566557317', '405');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2021-10-04 01:18:25', 'fabianadamski91902@example.org', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Fabian', 'fabianadamski91902', 'Adamski', '770239546', '406');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2021-07-30 18:05:06', 'dariuszmarciniak441588@example.net', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Dariusz', 'dariuszmarciniak441588', 'Marciniak', '852192883', '407');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2021-12-01 04:37:12', 'julitawojciechowski89000@example.com', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Julita', 'julitawojciechowski89000', 'Wojciechowski', '336717972', '408');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2022-04-23 17:42:20', 'olgakrajewska485382@example.com', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Olga', 'olgakrajewska485382', 'Krajewska', '694416408', '409');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2022-01-13 02:16:07', 'piotrmaciejewski290946@example.org', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Piotr', 'piotrmaciejewski290946', 'Maciejewski', '785579970', '410');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2021-08-15 05:53:13', 'jakubkaczmarczyk836986@example.com', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Jakub', 'jakubkaczmarczyk836986', 'Kaczmarczyk', '521768080', '411');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2021-11-27 03:05:49', 'dagmarastępień425950@example.net', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Dagmara', 'dagmarastępień425950', 'Stępień', '544014548', '412');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2022-04-27 21:48:53', 'jakubpawłowska858190@example.net', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Jakub', 'jakubpawłowska858190', 'Pawłowska', '856589449', '413');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2021-09-03 09:36:45', 'kacpersawicka682480@example.com', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Kacper', 'kacpersawicka682480', 'Sawicka', '664349423', '414');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2022-01-02 10:27:34', 'ksaweryjabłoński951226@example.net', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Ksawery', 'ksaweryjabłoński951226', 'Jabłoński', '287605636', '415');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2022-05-05 13:00:15', 'melaniakonieczny752417@example.org', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Melania', 'melaniakonieczny752417', 'Konieczny', '878119267', '416');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2021-12-18 18:31:49', 'majawójcik589125@example.org', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Maja', 'majawójcik589125', 'Wójcik', '408567570', '417');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2022-01-21 07:19:56', 'oliwiajankowska233483@example.net', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Oliwia', 'oliwiajankowska233483', 'Jankowska', '774531982', '418');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2021-06-05 07:22:41', 'dagmarakaźmierczak954188@example.net', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Dagmara', 'dagmarakaźmierczak954188', 'Kaźmierczak', '436140211', '419');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2022-01-11 21:51:38', 'krystynamazurek629089@example.com', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Krystyna', 'krystynamazurek629089', 'Mazurek', '516755005', '420');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2022-02-22 11:50:48', 'miłoszzakrzewski585821@example.net', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Miłosz', 'miłoszzakrzewski585821', 'Zakrzewski', '849047722', '421');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2021-07-03 06:02:56', 'krystianwieczorek372236@example.com', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Krystian', 'krystianwieczorek372236', 'Wieczorek', '779205973', '422');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2022-03-18 13:06:09', 'juliuszmichalska607057@example.net', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Juliusz', 'juliuszmichalska607057', 'Michalska', '614179535', '423');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2021-11-27 23:36:07', 'agnieszkadąbrowska855811@example.com', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Agnieszka', 'agnieszkadąbrowska855811', 'Dąbrowska', '512963500', '424');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2021-07-14 13:55:44', 'stanisławkubiak550603@example.net', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Stanisław', 'stanisławkubiak550603', 'Kubiak', '658044307', '425');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2021-12-18 14:13:13', 'annacieślak597785@example.net', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Anna', 'annacieślak597785', 'Cieślak', '268500374', '426');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2021-07-14 22:26:02', 'elizakaczmarczyk646132@example.org', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Eliza', 'elizakaczmarczyk646132', 'Kaczmarczyk', '273504666', '427');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2021-10-30 09:06:39', 'hannakubiak466691@example.com', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Hanna', 'hannakubiak466691', 'Kubiak', '940682453', '428');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2021-10-22 23:31:22', 'zofiaszymczak16654@example.org', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Zofia', 'zofiaszymczak16654', 'Szymczak', '961723119', '429');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2021-06-27 15:50:16', 'stefanandrzejewski881638@example.org', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Stefan', 'stefanandrzejewski881638', 'Andrzejewski', '899376315', '430');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2021-07-22 12:58:26', 'melaniamichalak764090@example.com', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Melania', 'melaniamichalak764090', 'Michalak', '130721510', '431');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2021-10-17 22:54:54', 'wiktorlewandowski475542@example.com', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Wiktor', 'wiktorlewandowski475542', 'Lewandowski', '593444741', '432');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2022-04-11 01:03:23', 'brunokowalczyk950296@example.net', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Bruno', 'brunokowalczyk950296', 'Kowalczyk', '496127408', '433');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2022-01-08 07:59:35', 'sylwialaskowski461731@example.com', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Sylwia', 'sylwialaskowski461731', 'Laskowski', '545687412', '434');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2021-10-10 04:30:06', 'helenamakowski130623@example.com', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Helena', 'helenamakowski130623', 'Makowski', '924838361', '435');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2022-02-10 01:19:15', 'arkadiuszzalewski982946@example.com', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Arkadiusz', 'arkadiuszzalewski982946', 'Zalewski', '498811027', '436');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2022-03-24 22:43:00', 'apoloniatomaszewski708313@example.com', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Apolonia', 'apoloniatomaszewski708313', 'Tomaszewski', '144368480', '437');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2022-03-05 10:31:06', 'danielcieślak876376@example.com', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Daniel', 'danielcieślak876376', 'Cieślak', '593523774', '438');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2022-05-07 15:52:09', 'bartekmazurek506532@example.com', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Bartek', 'bartekmazurek506532', 'Mazurek', '535982750', '439');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2021-11-30 20:51:22', 'ameliagłowacka567567@example.org', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Amelia', 'ameliagłowacka567567', 'Głowacka', '693917024', '440');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2021-11-11 11:16:21', 'marcelborowski30223@example.com', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Marcel', 'marcelborowski30223', 'Borowski', '318305258', '441');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2022-03-30 15:05:27', 'michałzawadzki537024@example.org', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Michał', 'michałzawadzki537024', 'Zawadzki', '301343015', '442');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2022-02-14 02:51:14', 'zuzannawoźniak727045@example.com', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Zuzanna', 'zuzannawoźniak727045', 'Woźniak', '242239723', '443');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2021-06-28 17:33:10', 'patrycjakaźmierczak121658@example.net', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Patrycja', 'patrycjakaźmierczak121658', 'Kaźmierczak', '423328029', '444');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2021-12-28 04:04:34', 'lauraostrowska139438@example.net', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Laura', 'lauraostrowska139438', 'Ostrowska', '758232274', '445');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2021-07-01 06:20:47', 'karinaszymczak325408@example.net', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Karina', 'karinaszymczak325408', 'Szymczak', '923800560', '446');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2021-09-25 08:51:43', 'aleksandrabaran242630@example.net', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Aleksandra', 'aleksandrabaran242630', 'Baran', '412140959', '447');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2021-09-27 15:39:03', 'tomaszszczepańska247870@example.org', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Tomasz', 'tomaszszczepańska247870', 'Szczepańska', '838647713', '448');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2021-06-11 12:20:24', 'jacekwilk408598@example.org', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Jacek', 'jacekwilk408598', 'Wilk', '275223916', '449');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2022-01-04 20:06:16', 'paulinadudek302886@example.org', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Paulina', 'paulinadudek302886', 'Dudek', '868000341', '450');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2021-08-21 21:54:01', 'alicjajabłoński346532@example.net', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Alicja', 'alicjajabłoński346532', 'Jabłoński', '876621572', '451');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2021-10-19 23:53:12', 'radosławnowak682141@example.org', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Radosław', 'radosławnowak682141', 'Nowak', '667624257', '452');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2021-08-05 22:09:03', 'albertborkowski726432@example.org', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Albert', 'albertborkowski726432', 'Borkowski', '912992012', '453');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2022-01-29 19:55:21', 'marcelinawłodarczyk807147@example.com', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Marcelina', 'marcelinawłodarczyk807147', 'Włodarczyk', '520090482', '454');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2022-01-14 14:42:42', 'paulinatomaszewska601310@example.org', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Paulina', 'paulinatomaszewska601310', 'Tomaszewska', '183405161', '455');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2021-07-06 15:51:51', 'mateusznowicka686090@example.net', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Mateusz', 'mateusznowicka686090', 'Nowicka', '122818269', '456');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2021-09-28 08:37:42', 'kornelwójcik256054@example.com', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Kornel', 'kornelwójcik256054', 'Wójcik', '175448589', '457');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2021-11-18 14:51:49', 'nataliagajewski549832@example.net', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Natalia', 'nataliagajewski549832', 'Gajewski', '357147720', '458');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2021-09-29 14:20:09', 'makssikorski220259@example.org', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Maks', 'makssikorski220259', 'Sikorski', '627778143', '459');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2021-06-14 22:01:20', 'szymonrutkowski215056@example.net', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Szymon', 'szymonrutkowski215056', 'Rutkowski', '890225187', '460');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2021-07-05 08:31:01', 'bartekkołodziej592668@example.com', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Bartek', 'bartekkołodziej592668', 'Kołodziej', '381737563', '461');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2022-03-03 05:46:43', 'ernestostrowska720139@example.org', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Ernest', 'ernestostrowska720139', 'Ostrowska', '516175035', '462');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2021-12-03 06:45:56', 'wiktoriadudek461312@example.com', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Wiktoria', 'wiktoriadudek461312', 'Dudek', '110429512', '463');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2022-01-11 16:26:18', 'marcelpiotrowska455455@example.com', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Marcel', 'marcelpiotrowska455455', 'Piotrowska', '117088475', '464');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2021-07-31 21:02:59', 'melaniamazur726560@example.net', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Melania', 'melaniamazur726560', 'Mazur', '554686088', '465');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2021-09-29 12:00:54', 'angelikakrajewska305349@example.net', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Angelika', 'angelikakrajewska305349', 'Krajewska', '754635338', '466');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2022-01-17 15:34:43', 'ignacysadowski189026@example.com', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Ignacy', 'ignacysadowski189026', 'Sadowski', '735051212', '467');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2021-10-08 16:46:27', 'sebastianwróbel902470@example.net', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Sebastian', 'sebastianwróbel902470', 'Wróbel', '114926617', '468');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2022-03-03 13:14:48', 'juliuszwiśniewski440970@example.org', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Juliusz', 'juliuszwiśniewski440970', 'Wiśniewski', '938563014', '469');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2021-12-26 06:22:06', 'marikakozłowski620402@example.com', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Marika', 'marikakozłowski620402', 'Kozłowski', '834179904', '470');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2021-09-04 11:02:36', 'ewalewandowski825297@example.com', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Ewa', 'ewalewandowski825297', 'Lewandowski', '628933647', '471');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2021-06-23 04:46:41', 'kajetanbrzezińska40258@example.net', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Kajetan', 'kajetanbrzezińska40258', 'Brzezińska', '573132718', '472');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2022-03-13 12:31:17', 'danielmichalski538779@example.net', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Daniel', 'danielmichalski538779', 'Michalski', '479425049', '473');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2021-07-17 08:20:43', 'ernestlis40294@example.org', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Ernest', 'ernestlis40294', 'Lis', '267495219', '474');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2021-11-30 15:36:15', 'dominikawróbel739403@example.org', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Dominika', 'dominikawróbel739403', 'Wróbel', '206525806', '475');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2022-03-20 09:38:04', 'justynamazurek428471@example.net', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Justyna', 'justynamazurek428471', 'Mazurek', '353660700', '476');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2022-01-16 00:52:10', 'maurycylaskowska689352@example.org', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Maurycy', 'maurycylaskowska689352', 'Laskowska', '570606128', '477');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2022-03-14 16:15:08', 'melaniawalczak736585@example.net', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Melania', 'melaniawalczak736585', 'Walczak', '961932579', '478');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2021-06-08 19:56:54', 'anastazjanowicka173762@example.net', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Anastazja', 'anastazjanowicka173762', 'Nowicka', '239919036', '479');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2022-01-17 10:02:36', 'martynagrabowski10264@example.org', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Martyna', 'martynagrabowski10264', 'Grabowski', '299491112', '480');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2021-11-05 20:40:15', 'antoninaprzybylska302241@example.net', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Antonina', 'antoninaprzybylska302241', 'Przybylska', '781072125', '481');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2021-12-25 08:00:25', 'ernestkowalczyk391000@example.com', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Ernest', 'ernestkowalczyk391000', 'Kowalczyk', '808173442', '482');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2021-09-22 13:38:27', 'milenakalinowski323255@example.org', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Milena', 'milenakalinowski323255', 'Kalinowski', '130697673', '483');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2021-08-05 22:44:24', 'leonardsikora685841@example.com', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Leonard', 'leonardsikora685841', 'Sikora', '528921176', '484');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2021-10-08 17:06:34', 'damianwasilewski478065@example.org', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Damian', 'damianwasilewski478065', 'Wasilewski', '678697446', '485');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2021-06-08 19:15:12', 'błażejmaciejewski639357@example.com', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Błażej', 'błażejmaciejewski639357', 'Maciejewski', '567646128', '486');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2021-10-02 16:52:08', 'angelikapiotrowski391728@example.org', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Angelika', 'angelikapiotrowski391728', 'Piotrowski', '705604327', '487');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2021-08-18 14:45:50', 'lenagórecka418791@example.org', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Lena', 'lenagórecka418791', 'Górecka', '243772788', '488');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2022-04-18 09:19:19', 'łukaszwróbel215592@example.org', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Łukasz', 'łukaszwróbel215592', 'Wróbel', '830355516', '489');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2021-08-27 08:36:21', 'agatapawłowska796205@example.net', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Agata', 'agatapawłowska796205', 'Pawłowska', '687790906', '490');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2022-05-09 06:28:22', 'juliamarciniak360712@example.net', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Julia', 'juliamarciniak360712', 'Marciniak', '602046455', '491');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2021-06-18 15:52:08', 'juliaduda631821@example.org', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Julia', 'juliaduda631821', 'Duda', '752638933', '492');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2021-10-11 08:38:31', 'agnieszkamaciejewska553020@example.org', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Agnieszka', 'agnieszkamaciejewska553020', 'Maciejewska', '998374990', '493');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2021-06-09 11:36:15', 'soniabrzezińska382846@example.net', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Sonia', 'soniabrzezińska382846', 'Brzezińska', '313688944', '494');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2022-02-14 08:23:50', 'michałurbańska395588@example.org', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Michał', 'michałurbańska395588', 'Urbańska', '747533686', '495');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2021-08-10 16:15:20', 'patrykkubiak898175@example.org', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Patryk', 'patrykkubiak898175', 'Kubiak', '738302570', '496');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2022-04-24 19:02:54', 'gustawkról230524@example.net', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Gustaw', 'gustawkról230524', 'Król', '917725404', '497');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2021-12-16 16:58:00', 'piotrsadowska245364@example.com', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Piotr', 'piotrsadowska245364', 'Sadowska', '210798665', '498');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2022-01-24 00:22:50', 'kacpermaciejewska889085@example.net', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Kacper', 'kacpermaciejewska889085', 'Maciejewska', '781854411', '499');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2021-07-03 01:22:41', 'kalinawojciechowska931902@example.com', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Kalina', 'kalinawojciechowska931902', 'Wojciechowska', '912320255', '500');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2022-04-18 21:42:04', 'melaniasikorski691352@example.com', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Melania', 'melaniasikorski691352', 'Sikorski', '989573485', '501');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2022-02-16 14:53:09', 'blankakubiak594935@example.org', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Blanka', 'blankakubiak594935', 'Kubiak', '375296064', '502');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2021-05-22 16:52:40', 'roksanamaciejewska410573@example.com', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Roksana', 'roksanamaciejewska410573', 'Maciejewska', '464653969', '503');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2021-10-31 10:13:28', 'magdalenapawłowska826101@example.org', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Magdalena', 'magdalenapawłowska826101', 'Pawłowska', '660697021', '504');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2021-08-24 00:46:15', 'alanmazur276522@example.org', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Alan', 'alanmazur276522', 'Mazur', '137480663', '505');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2021-06-18 06:45:34', 'igorlewandowski939256@example.org', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Igor', 'igorlewandowski939256', 'Lewandowski', '183333175', '506');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2021-07-02 18:51:07', 'oliwiastępień976148@example.com', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Oliwia', 'oliwiastępień976148', 'Stępień', '964278759', '507');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2022-02-23 02:07:13', 'arturmichalska748874@example.com', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Artur', 'arturmichalska748874', 'Michalska', '236751881', '508');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2021-11-08 17:14:41', 'kacperurbańska136141@example.net', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Kacper', 'kacperurbańska136141', 'Urbańska', '284974428', '509');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2021-12-01 18:11:49', 'dariuszmaciejewski969062@example.net', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Dariusz', 'dariuszmaciejewski969062', 'Maciejewski', '511080486', '510');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2021-05-18 10:45:07', 'dominikazawadzki886234@example.com', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Dominika', 'dominikazawadzki886234', 'Zawadzki', '395220340', '511');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2021-10-23 23:15:11', 'nicolecieślak504044@example.org', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Nicole', 'nicolecieślak504044', 'Cieślak', '899777636', '512');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2022-02-06 08:35:15', 'tadeuszmróz898049@example.org', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Tadeusz', 'tadeuszmróz898049', 'Mróz', '421272051', '513');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2022-02-05 21:05:28', 'juliuszwilk831060@example.com', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Juliusz', 'juliuszwilk831060', 'Wilk', '666491532', '514');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2021-10-24 07:00:38', 'patrycjakaczmarczyk627948@example.com', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Patrycja', 'patrycjakaczmarczyk627948', 'Kaczmarczyk', '817627887', '515');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2022-01-11 06:23:21', 'agataostrowski117421@example.net', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Agata', 'agataostrowski117421', 'Ostrowski', '265419083', '516');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2021-12-16 11:51:51', 'dorotasikora31262@example.org', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Dorota', 'dorotasikora31262', 'Sikora', '839104498', '517');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2022-03-12 19:03:15', 'danielmazur199943@example.net', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Daniel', 'danielmazur199943', 'Mazur', '502727640', '518');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2021-12-11 18:27:48', 'stanisławkrajewski920065@example.org', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Stanisław', 'stanisławkrajewski920065', 'Krajewski', '157317502', '519');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2022-04-05 09:23:05', 'jankról21016@example.net', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Jan', 'jankról21016', 'Król', '461329493', '520');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2021-09-22 08:48:25', 'błażejgłowacki479224@example.com', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Błażej', 'błażejgłowacki479224', 'Głowacki', '698624038', '521');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2021-06-16 23:57:45', 'emilmazur535227@example.net', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Emil', 'emilmazur535227', 'Mazur', '675963856', '522');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2021-12-27 09:36:21', 'brunoostrowski15024@example.org', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Bruno', 'brunoostrowski15024', 'Ostrowski', '741999329', '523');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2022-05-10 22:19:23', 'biankabaran27871@example.net', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Bianka', 'biankabaran27871', 'Baran', '955759102', '524');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2021-10-19 20:18:18', 'andrzejsadowski704167@example.net', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Andrzej', 'andrzejsadowski704167', 'Sadowski', '462125378', '525');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2022-01-21 03:52:51', 'marcinsokołowski166106@example.com', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Marcin', 'marcinsokołowski166106', 'Sokołowski', '908129468', '526');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2022-04-22 23:18:18', 'aleksandramarciniak762332@example.com', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Aleksandra', 'aleksandramarciniak762332', 'Marciniak', '237141445', '527');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2021-06-27 05:36:40', 'brunowysocka829855@example.com', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Bruno', 'brunowysocka829855', 'Wysocka', '673210153', '528');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2021-07-05 12:07:22', 'ameliaduda101667@example.org', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Amelia', 'ameliaduda101667', 'Duda', '634285883', '529');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2022-04-28 10:37:12', 'konstantypawlak386570@example.com', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Konstanty', 'konstantypawlak386570', 'Pawlak', '194009912', '530');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2022-02-20 10:22:50', 'anielakucharski982833@example.com', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Aniela', 'anielakucharski982833', 'Kucharski', '543116657', '531');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2021-07-27 21:18:11', 'alanwróbel464346@example.org', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Alan', 'alanwróbel464346', 'Wróbel', '118367699', '532');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2021-10-28 07:35:24', 'soniaborkowski493593@example.org', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Sonia', 'soniaborkowski493593', 'Borkowski', '825359426', '533');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2021-12-07 12:12:19', 'damianjankowski39952@example.com', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Damian', 'damianjankowski39952', 'Jankowski', '973925554', '534');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2021-08-21 12:53:36', 'tomaszkowalczyk851020@example.net', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Tomasz', 'tomaszkowalczyk851020', 'Kowalczyk', '806548158', '535');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2021-07-25 14:53:31', 'hubertkucharski494275@example.com', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Hubert', 'hubertkucharski494275', 'Kucharski', '769152278', '536');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2021-07-24 00:47:35', 'sandrawójcik298388@example.com', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Sandra', 'sandrawójcik298388', 'Wójcik', '270926683', '537');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2021-10-09 13:13:03', 'witoldzawadzki268315@example.com', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Witold', 'witoldzawadzki268315', 'Zawadzki', '859219892', '538');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2021-12-18 01:27:32', 'marcelnowak410874@example.net', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Marcel', 'marcelnowak410874', 'Nowak', '652220088', '539');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2021-06-01 16:13:06', 'annawysocka222764@example.com', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Anna', 'annawysocka222764', 'Wysocka', '515949783', '540');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2021-08-16 14:00:19', 'józefmazurek637372@example.org', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Józef', 'józefmazurek637372', 'Mazurek', '310188031', '541');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2022-05-08 19:38:04', 'sylwiabąk532135@example.org', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Sylwia', 'sylwiabąk532135', 'Bąk', '399697553', '542');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2022-01-31 17:17:25', 'kacperwysocka472181@example.org', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Kacper', 'kacperwysocka472181', 'Wysocka', '656329384', '543');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2021-07-08 07:27:12', 'nicolewłodarczyk927207@example.com', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Nicole', 'nicolewłodarczyk927207', 'Włodarczyk', '563981893', '544');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2022-03-27 11:55:15', 'anastazjakrawczyk754705@example.org', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Anastazja', 'anastazjakrawczyk754705', 'Krawczyk', '548047562', '545');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2022-01-13 16:03:46', 'cypriankonieczny446797@example.org', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Cyprian', 'cypriankonieczny446797', 'Konieczny', '791840449', '546');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2021-11-16 03:09:07', 'małgorzatawłodarczyk696470@example.org', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Małgorzata', 'małgorzatawłodarczyk696470', 'Włodarczyk', '993388149', '547');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2022-04-24 18:16:05', 'antoninowicki541287@example.com', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Antoni', 'antoninowicki541287', 'Nowicki', '479038613', '548');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2022-03-30 00:23:06', 'wiktorjankowska821249@example.com', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Wiktor', 'wiktorjankowska821249', 'Jankowska', '321487895', '549');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2022-04-08 00:54:55', 'marcelpietrzak982890@example.org', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Marcel', 'marcelpietrzak982890', 'Pietrzak', '349021243', '550');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2022-03-26 16:11:38', 'weronikanowakowska535060@example.com', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Weronika', 'weronikanowakowska535060', 'Nowakowska', '573462526', '551');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2022-01-17 21:48:52', 'roksanasikorska737060@example.net', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Roksana', 'roksanasikorska737060', 'Sikorska', '128823851', '552');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2022-05-03 20:11:46', 'dariakrajewska868733@example.org', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Daria', 'dariakrajewska868733', 'Krajewska', '646690834', '553');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2021-08-03 15:10:49', 'justynamazurek443231@example.com', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Justyna', 'justynamazurek443231', 'Mazurek', '574404206', '554');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2021-10-06 18:56:55', 'barbaradąbrowski822013@example.com', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Barbara', 'barbaradąbrowski822013', 'Dąbrowski', '512276057', '555');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2022-04-21 17:13:58', 'kazimierzziółkowski551782@example.org', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Kazimierz', 'kazimierzziółkowski551782', 'Ziółkowski', '630656516', '556');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2022-04-27 22:39:47', 'maciejmarciniak306279@example.net', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Maciej', 'maciejmarciniak306279', 'Marciniak', '847190885', '557');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2022-02-24 11:57:53', 'milenawróblewska150473@example.net', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Milena', 'milenawróblewska150473', 'Wróblewska', '285030033', '558');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2021-10-30 13:38:43', 'cyprianpawłowski941195@example.org', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Cyprian', 'cyprianpawłowski941195', 'Pawłowski', '756113618', '559');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2021-10-28 21:43:29', 'krystynazalewski786702@example.net', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Krystyna', 'krystynazalewski786702', 'Zalewski', '648310605', '560');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2022-03-04 22:34:38', 'anastazjapawlak259970@example.com', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Anastazja', 'anastazjapawlak259970', 'Pawlak', '100239325', '561');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2021-05-27 20:56:47', 'marcelborowska473155@example.com', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Marcel', 'marcelborowska473155', 'Borowska', '378447189', '562');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2021-12-20 14:28:14', 'marekwoźniak794065@example.com', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Marek', 'marekwoźniak794065', 'Woźniak', '442338269', '563');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2021-10-06 20:48:24', 'martynakrawczyk888108@example.net', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Martyna', 'martynakrawczyk888108', 'Krawczyk', '731105504', '564');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2022-03-23 19:58:01', 'julitaszewczyk433615@example.com', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Julita', 'julitaszewczyk433615', 'Szewczyk', '636806669', '565');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2022-03-12 06:40:05', 'nikolawojciechowski155889@example.net', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Nikola', 'nikolawojciechowski155889', 'Wojciechowski', '763430967', '566');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2021-10-08 00:25:52', 'leonmajewski258661@example.net', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Leon', 'leonmajewski258661', 'Majewski', '705341929', '567');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2021-10-04 01:17:40', 'brunokubiak447145@example.com', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Bruno', 'brunokubiak447145', 'Kubiak', '734497888', '568');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2022-05-03 23:16:15', 'kamilbąk71466@example.com', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Kamil', 'kamilbąk71466', 'Bąk', '304493047', '569');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2022-05-15 16:38:20', 'justynakalinowski266325@example.net', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Justyna', 'justynakalinowski266325', 'Kalinowski', '821893278', '570');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2021-07-17 16:37:17', 'alekschmielewski114272@example.net', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Aleks', 'alekschmielewski114272', 'Chmielewski', '524468226', '571');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2021-06-03 22:13:31', 'michałsobczak975469@example.org', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Michał', 'michałsobczak975469', 'Sobczak', '426233845', '572');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2021-06-11 15:52:25', 'malwinazalewski383689@example.org', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Malwina', 'malwinazalewski383689', 'Zalewski', '588091138', '573');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2021-10-31 14:18:49', 'maciejkalinowska979816@example.org', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Maciej', 'maciejkalinowska979816', 'Kalinowska', '929637890', '574');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2022-05-07 22:06:12', 'nicolemazurek981481@example.net', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Nicole', 'nicolemazurek981481', 'Mazurek', '755412976', '575');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2021-07-21 02:04:30', 'zofiawójcik184259@example.net', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Zofia', 'zofiawójcik184259', 'Wójcik', '961366888', '576');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2021-09-09 21:21:10', 'korneliaszewczyk149884@example.org', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Kornelia', 'korneliaszewczyk149884', 'Szewczyk', '985814139', '577');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2021-11-18 01:23:48', 'ignacypawlak389500@example.org', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Ignacy', 'ignacypawlak389500', 'Pawlak', '355183107', '578');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2022-04-16 10:42:55', 'witoldkaźmierczak815750@example.net', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Witold', 'witoldkaźmierczak815750', 'Kaźmierczak', '699118894', '579');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2022-05-07 06:59:23', 'gabrieltomaszewski139173@example.net', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Gabriel', 'gabrieltomaszewski139173', 'Tomaszewski', '199503895', '580');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2022-03-16 16:16:45', 'helenamróz486277@example.net', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Helena', 'helenamróz486277', 'Mróz', '936306283', '581');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2021-09-18 21:08:50', 'justynagrabowski916171@example.com', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Justyna', 'justynagrabowski916171', 'Grabowski', '581568179', '582');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2021-12-02 04:19:06', 'justynasikora346890@example.net', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Justyna', 'justynasikora346890', 'Sikora', '839735887', '583');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2021-05-22 06:09:06', 'blankapawłowska570283@example.org', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Blanka', 'blankapawłowska570283', 'Pawłowska', '524364749', '584');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2021-09-19 00:39:42', 'ernestwysocka349374@example.net', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Ernest', 'ernestwysocka349374', 'Wysocka', '552152705', '585');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2022-05-09 20:37:17', 'andrzejpiotrowska714657@example.net', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Andrzej', 'andrzejpiotrowska714657', 'Piotrowska', '842323704', '586');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2021-09-30 03:42:38', 'ryszardkozłowska337919@example.com', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Ryszard', 'ryszardkozłowska337919', 'Kozłowska', '578241625', '587');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2021-12-03 18:08:04', 'biankamaciejewska201262@example.org', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Bianka', 'biankamaciejewska201262', 'Maciejewska', '752755809', '588');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2022-04-22 06:40:44', 'oliwierwieczorek299938@example.net', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Oliwier', 'oliwierwieczorek299938', 'Wieczorek', '357724929', '589');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2021-10-31 10:00:15', 'elżbietabąk577625@example.net', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Elżbieta', 'elżbietabąk577625', 'Bąk', '928043262', '590');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2022-02-01 20:47:55', 'mariuszmaciejewska276839@example.com', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Mariusz', 'mariuszmaciejewska276839', 'Maciejewska', '501003247', '591');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2021-12-02 09:40:45', 'erykjaworska483133@example.net', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Eryk', 'erykjaworska483133', 'Jaworska', '572578184', '592');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2021-11-28 03:04:47', 'patrycjawieczorek698167@example.net', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Patrycja', 'patrycjawieczorek698167', 'Wieczorek', '259233795', '593');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2022-03-24 20:46:03', 'marikawójcik386113@example.net', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Marika', 'marikawójcik386113', 'Wójcik', '664662280', '594');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2021-07-14 05:59:25', 'mariakalinowski419257@example.org', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Maria', 'mariakalinowski419257', 'Kalinowski', '408317119', '595');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2021-08-06 06:30:06', 'marikasokołowska73538@example.com', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Marika', 'marikasokołowska73538', 'Sokołowska', '377592174', '596');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2021-08-11 10:51:57', 'alankonieczny60141@example.net', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Alan', 'alankonieczny60141', 'Konieczny', '288172597', '597');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2022-02-05 12:31:49', 'andrzejkowalczyk498201@example.net', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Andrzej', 'andrzejkowalczyk498201', 'Kowalczyk', '656044228', '598');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2021-06-18 08:12:12', 'bartekgrabowski162004@example.com', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Bartek', 'bartekgrabowski162004', 'Grabowski', '275513041', '599');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2021-08-28 21:21:28', 'igabrzeziński100825@example.org', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Iga', 'igabrzeziński100825', 'Brzeziński', '413702958', '600');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2022-03-28 22:11:08', 'boryskowalczyk197007@example.net', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Borys', 'boryskowalczyk197007', 'Kowalczyk', '473606136', '601');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2022-02-18 04:49:06', 'kazimierzzawadzka78295@example.net', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Kazimierz', 'kazimierzzawadzka78295', 'Zawadzka', '380067060', '602');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2022-02-13 19:44:28', 'julitadudek178870@example.org', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Julita', 'julitadudek178870', 'Dudek', '297697795', '603');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2022-05-03 17:32:15', 'elizaprzybylski946255@example.net', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Eliza', 'elizaprzybylski946255', 'Przybylski', '692464404', '604');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2021-08-10 23:15:45', 'sylwiawójcik888407@example.org', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Sylwia', 'sylwiawójcik888407', 'Wójcik', '992626730', '605');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2021-07-02 11:40:29', 'marcelzając981966@example.com', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Marcel', 'marcelzając981966', 'Zając', '795838986', '606');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2021-10-13 01:11:42', 'adamwasilewska623521@example.com', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Adam', 'adamwasilewska623521', 'Wasilewska', '921812783', '607');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2022-02-16 01:45:21', 'idamichalski194147@example.org', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Ida', 'idamichalski194147', 'Michalski', '757213036', '608');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2022-03-04 09:37:47', 'kajaprzybylski614075@example.com', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Kaja', 'kajaprzybylski614075', 'Przybylski', '681507645', '609');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2021-08-28 06:36:19', 'pawełjakubowski985460@example.net', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Paweł', 'pawełjakubowski985460', 'Jakubowski', '202696599', '610');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2022-05-07 22:26:02', 'marikaborowski107886@example.org', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Marika', 'marikaborowski107886', 'Borowski', '171107883', '611');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2021-10-12 15:28:10', 'fabiansokołowski293330@example.net', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Fabian', 'fabiansokołowski293330', 'Sokołowski', '963655863', '612');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2021-12-26 00:50:09', 'hannawiśniewski501052@example.org', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Hanna', 'hannawiśniewski501052', 'Wiśniewski', '480936749', '613');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2021-12-03 13:33:47', 'martapietrzak715805@example.org', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Marta', 'martapietrzak715805', 'Pietrzak', '278320576', '614');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2021-11-29 20:00:55', 'antonigajewska691322@example.org', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Antoni', 'antonigajewska691322', 'Gajewska', '748068603', '615');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2022-03-02 18:22:06', 'tymonduda186662@example.net', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Tymon', 'tymonduda186662', 'Duda', '155029250', '616');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2022-01-14 06:53:10', 'aureliawieczorek242172@example.com', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Aurelia', 'aureliawieczorek242172', 'Wieczorek', '535164255', '617');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2021-11-17 00:50:44', 'biankaprzybylski545613@example.org', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Bianka', 'biankaprzybylski545613', 'Przybylski', '843852875', '618');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2021-07-17 04:22:04', 'maurycyzakrzewska630087@example.org', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Maurycy', 'maurycyzakrzewska630087', 'Zakrzewska', '242149439', '619');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2021-06-17 14:36:04', 'erykbrzezińska398818@example.com', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Eryk', 'erykbrzezińska398818', 'Brzezińska', '610413959', '620');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2022-04-10 16:27:53', 'agatawitkowski301827@example.net', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Agata', 'agatawitkowski301827', 'Witkowski', '112821445', '621');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2022-01-24 21:10:31', 'angelikaandrzejewski155810@example.com', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Angelika', 'angelikaandrzejewski155810', 'Andrzejewski', '451802553', '622');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2021-12-31 10:45:07', 'melaniajakubowski726506@example.org', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Melania', 'melaniajakubowski726506', 'Jakubowski', '617696454', '623');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2021-12-31 15:17:57', 'patrycjaborkowska535301@example.org', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Patrycja', 'patrycjaborkowska535301', 'Borkowska', '112244895', '624');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2022-02-02 14:03:07', 'marcelinaurbańska130191@example.net', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Marcelina', 'marcelinaurbańska130191', 'Urbańska', '892818311', '625');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2022-02-05 13:39:09', 'hannasawicka155564@example.net', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Hanna', 'hannasawicka155564', 'Sawicka', '886385146', '626');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2021-07-24 21:33:49', 'nelabłaszczyk421993@example.com', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Nela', 'nelabłaszczyk421993', 'Błaszczyk', '887551219', '627');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2021-12-16 22:03:48', 'adamakowski315513@example.com', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Ada', 'adamakowski315513', 'Makowski', '819251646', '628');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2021-10-22 08:21:32', 'erykszewczyk514179@example.com', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Eryk', 'erykszewczyk514179', 'Szewczyk', '274679522', '629');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2022-01-09 11:25:56', 'wiktorsawicka14642@example.com', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Wiktor', 'wiktorsawicka14642', 'Sawicka', '934670921', '630');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2021-10-10 18:03:10', 'marcelinakonieczny532364@example.com', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Marcelina', 'marcelinakonieczny532364', 'Konieczny', '892400394', '631');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2021-12-25 21:19:47', 'danielkowalczyk918143@example.org', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Daniel', 'danielkowalczyk918143', 'Kowalczyk', '916579299', '632');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2021-10-05 08:35:50', 'boryskaźmierczak163177@example.org', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Borys', 'boryskaźmierczak163177', 'Kaźmierczak', '576783099', '633');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2022-02-11 07:21:37', 'konradmakowski361026@example.com', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Konrad', 'konradmakowski361026', 'Makowski', '279112947', '634');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2021-05-27 14:48:28', 'mateuszcieślak179042@example.net', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Mateusz', 'mateuszcieślak179042', 'Cieślak', '489359141', '635');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2021-12-06 18:28:31', 'lauraczarnecki814649@example.com', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Laura', 'lauraczarnecki814649', 'Czarnecki', '676197047', '636');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2022-03-01 13:09:11', 'kajamakowski767359@example.net', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Kaja', 'kajamakowski767359', 'Makowski', '528628461', '637');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2021-11-06 19:59:27', 'fryderykprzybylski412958@example.com', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Fryderyk', 'fryderykprzybylski412958', 'Przybylski', '321560255', '638');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2021-12-15 10:20:22', 'majaczerwińska895447@example.net', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Maja', 'majaczerwińska895447', 'Czerwińska', '200357425', '639');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2021-10-23 02:22:58', 'zuzannamaciejewska858226@example.org', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Zuzanna', 'zuzannamaciejewska858226', 'Maciejewska', '250987747', '640');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2021-10-09 02:14:37', 'kamilaostrowska184487@example.net', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Kamila', 'kamilaostrowska184487', 'Ostrowska', '825529748', '641');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2022-01-28 17:22:49', 'justynapiotrowska649838@example.net', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Justyna', 'justynapiotrowska649838', 'Piotrowska', '426023775', '642');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2021-11-09 02:21:01', 'helenakaczmarczyk579475@example.net', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Helena', 'helenakaczmarczyk579475', 'Kaczmarczyk', '926929248', '643');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2021-07-15 23:30:45', 'wiktorlis598750@example.org', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Wiktor', 'wiktorlis598750', 'Lis', '717839452', '644');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2021-09-11 08:25:44', 'monikajabłońska994083@example.net', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Monika', 'monikajabłońska994083', 'Jabłońska', '807251193', '645');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2021-10-02 10:25:44', 'tolabłaszczyk946148@example.com', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Tola', 'tolabłaszczyk946148', 'Błaszczyk', '538971031', '646');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2022-01-26 14:38:12', 'aleksanderjaworska326833@example.com', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Aleksander', 'aleksanderjaworska326833', 'Jaworska', '746379428', '647');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2021-11-15 13:40:50', 'majaurbański654246@example.org', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Maja', 'majaurbański654246', 'Urbański', '699544462', '648');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2022-01-07 20:21:43', 'nataszazalewska846064@example.org', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Natasza', 'nataszazalewska846064', 'Zalewska', '474054499', '649');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2021-12-07 00:22:48', 'kajetantomaszewska636611@example.org', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Kajetan', 'kajetantomaszewska636611', 'Tomaszewska', '124756612', '650');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2022-02-15 17:32:11', 'justynamichalak437417@example.com', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Justyna', 'justynamichalak437417', 'Michalak', '444995601', '651');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2021-06-18 21:33:56', 'adrianjabłoński606573@example.com', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Adrian', 'adrianjabłoński606573', 'Jabłoński', '753650628', '652');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2022-01-23 11:52:42', 'sebastiandąbrowska824771@example.com', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Sebastian', 'sebastiandąbrowska824771', 'Dąbrowska', '634370630', '653');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2021-11-17 21:22:32', 'monikawróbel854625@example.com', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Monika', 'monikawróbel854625', 'Wróbel', '559472912', '654');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2021-08-17 03:26:30', 'nikodemkaczmarczyk102508@example.com', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Nikodem', 'nikodemkaczmarczyk102508', 'Kaczmarczyk', '824585714', '655');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2021-11-27 16:14:34', 'jerzymarciniak678863@example.com', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Jerzy', 'jerzymarciniak678863', 'Marciniak', '826592773', '656');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2021-09-28 11:53:30', 'oliwiajankowski63544@example.org', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Oliwia', 'oliwiajankowski63544', 'Jankowski', '958418740', '657');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2021-12-11 13:25:18', 'ernestbrzeziński329596@example.net', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Ernest', 'ernestbrzeziński329596', 'Brzeziński', '988135213', '658');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2021-06-06 16:54:30', 'klaramróz719503@example.com', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Klara', 'klaramróz719503', 'Mróz', '731664286', '659');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2022-01-03 22:21:14', 'natanieladamczyk647485@example.org', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Nataniel', 'natanieladamczyk647485', 'Adamczyk', '226240463', '660');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2022-03-01 10:50:06', 'ewelinawoźniak614619@example.com', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Ewelina', 'ewelinawoźniak614619', 'Woźniak', '115415755', '661');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2021-05-21 02:42:21', 'julitapiotrowski271593@example.com', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Julita', 'julitapiotrowski271593', 'Piotrowski', '160405070', '662');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2021-09-20 15:19:40', 'stefanpawlak670724@example.net', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Stefan', 'stefanpawlak670724', 'Pawlak', '981047064', '663');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2022-01-24 19:10:19', 'dariuszmazur99977@example.net', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Dariusz', 'dariuszmazur99977', 'Mazur', '150045011', '664');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2021-08-21 13:00:49', 'oskarsikora21714@example.net', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Oskar', 'oskarsikora21714', 'Sikora', '807365618', '665');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2021-12-15 19:31:28', 'michałduda791663@example.net', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Michał', 'michałduda791663', 'Duda', '307812423', '666');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2022-03-26 13:03:42', 'agnieszkawieczorek949104@example.org', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Agnieszka', 'agnieszkawieczorek949104', 'Wieczorek', '944676085', '667');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2022-04-07 16:26:25', 'ewelinagłowacka323894@example.org', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Ewelina', 'ewelinagłowacka323894', 'Głowacka', '786627492', '668');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2022-01-08 06:12:16', 'olgierdadamczyk128238@example.com', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Olgierd', 'olgierdadamczyk128238', 'Adamczyk', '325383801', '669');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2021-09-24 23:41:31', 'kazimierzmazur983791@example.com', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Kazimierz', 'kazimierzmazur983791', 'Mazur', '498909158', '670');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2021-08-24 00:42:35', 'milenawojciechowska2692@example.net', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Milena', 'milenawojciechowska2692', 'Wojciechowska', '675819368', '671');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2022-05-03 11:46:41', 'ryszardostrowska674663@example.com', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Ryszard', 'ryszardostrowska674663', 'Ostrowska', '678159328', '672');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2021-07-27 19:49:20', 'wiktormichalski203185@example.net', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Wiktor', 'wiktormichalski203185', 'Michalski', '352431667', '673');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2022-03-17 23:47:15', 'zuzannamarciniak406045@example.org', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Zuzanna', 'zuzannamarciniak406045', 'Marciniak', '830110889', '674');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2022-01-14 02:23:52', 'biankakalinowska818105@example.net', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Bianka', 'biankakalinowska818105', 'Kalinowska', '562815903', '675');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2022-02-04 23:35:22', 'alicjawłodarczyk629441@example.com', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Alicja', 'alicjawłodarczyk629441', 'Włodarczyk', '289525467', '676');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2021-08-03 00:49:30', 'nadiaszewczyk611758@example.com', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Nadia', 'nadiaszewczyk611758', 'Szewczyk', '710721777', '677');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2021-07-08 03:07:44', 'mikołajjaworski918816@example.net', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Mikołaj', 'mikołajjaworski918816', 'Jaworski', '811026138', '678');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2021-08-14 00:25:27', 'krzysztofsikorska897102@example.net', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Krzysztof', 'krzysztofsikorska897102', 'Sikorska', '185059625', '679');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2022-01-10 08:56:32', 'adamkrajewska476757@example.com', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Adam', 'adamkrajewska476757', 'Krajewska', '990204641', '680');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2021-12-17 23:53:36', 'marcellaskowska954547@example.org', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Marcel', 'marcellaskowska954547', 'Laskowska', '965130933', '681');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2021-08-11 15:21:42', 'elżbietaczerwińska696757@example.net', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Elżbieta', 'elżbietaczerwińska696757', 'Czerwińska', '437895766', '682');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2021-07-22 03:45:53', 'marcintomaszewska620467@example.net', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Marcin', 'marcintomaszewska620467', 'Tomaszewska', '483741507', '683');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2021-11-07 06:08:19', 'gustawjankowska321383@example.org', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Gustaw', 'gustawjankowska321383', 'Jankowska', '343068423', '684');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2021-12-30 11:06:30', 'juliasikora953512@example.org', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Julia', 'juliasikora953512', 'Sikora', '547548317', '685');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2021-12-01 17:59:11', 'soniakaczmarek704376@example.com', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Sonia', 'soniakaczmarek704376', 'Kaczmarek', '604005604', '686');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2022-04-30 19:10:16', 'sebastiankrawczyk310087@example.com', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Sebastian', 'sebastiankrawczyk310087', 'Krawczyk', '712712637', '687');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2022-04-08 06:19:05', 'katarzynaczarnecka534528@example.com', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Katarzyna', 'katarzynaczarnecka534528', 'Czarnecka', '363766551', '688');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2022-02-18 14:20:52', 'julianpawłowski464617@example.com', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Julian', 'julianpawłowski464617', 'Pawłowski', '358781749', '689');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2022-04-02 11:49:28', 'fryderykandrzejewski622611@example.org', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Fryderyk', 'fryderykandrzejewski622611', 'Andrzejewski', '538314061', '690');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2022-01-02 15:25:16', 'elizawojciechowski701314@example.net', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Eliza', 'elizawojciechowski701314', 'Wojciechowski', '143276311', '691');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2022-02-14 14:44:05', 'gabrielbąk249251@example.net', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Gabriel', 'gabrielbąk249251', 'Bąk', '800308540', '692');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2021-05-20 21:46:35', 'stefanwitkowska44075@example.org', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Stefan', 'stefanwitkowska44075', 'Witkowska', '817994039', '693');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2021-09-21 23:06:17', 'liwiaolszewski280769@example.net', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Liwia', 'liwiaolszewski280769', 'Olszewski', '706331008', '694');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2021-10-13 01:02:58', 'biankagórska680621@example.net', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Bianka', 'biankagórska680621', 'Górska', '240548165', '695');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2021-06-25 09:58:39', 'adriannajabłoński961340@example.com', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Adrianna', 'adriannajabłoński961340', 'Jabłoński', '650284605', '696');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2022-05-14 16:16:50', 'katarzynakonieczny259474@example.org', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Katarzyna', 'katarzynakonieczny259474', 'Konieczny', '436437170', '697');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2022-03-06 20:14:12', 'antoninowakowski918302@example.com', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Antoni', 'antoninowakowski918302', 'Nowakowski', '600257180', '698');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2022-03-01 04:06:52', 'małgorzatawitkowska43944@example.net', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Małgorzata', 'małgorzatawitkowska43944', 'Witkowska', '745882003', '699');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2021-07-06 02:33:36', 'aleksanderczerwińska550329@example.org', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Aleksander', 'aleksanderczerwińska550329', 'Czerwińska', '576942029', '700');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2022-04-01 10:04:01', 'kornelwysocka93698@example.net', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Kornel', 'kornelwysocka93698', 'Wysocka', '191792327', '701');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2021-11-25 14:52:32', 'natannowakowska886953@example.org', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Natan', 'natannowakowska886953', 'Nowakowska', '566074785', '702');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2021-11-25 14:59:43', 'miłoszwieczorek725600@example.net', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Miłosz', 'miłoszwieczorek725600', 'Wieczorek', '271948563', '703');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2021-11-04 09:37:57', 'lenazakrzewski807701@example.org', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Lena', 'lenazakrzewski807701', 'Zakrzewski', '470233529', '704');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2021-10-31 02:13:44', 'weronikamróz375112@example.com', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Weronika', 'weronikamróz375112', 'Mróz', '949369584', '705');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2022-03-06 10:01:39', 'rafałmazur123202@example.org', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Rafał', 'rafałmazur123202', 'Mazur', '385735112', '706');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2021-10-22 11:08:30', 'natankubiak739794@example.net', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Natan', 'natankubiak739794', 'Kubiak', '672048984', '707');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2021-11-03 13:01:10', 'anitamajewska294556@example.net', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Anita', 'anitamajewska294556', 'Majewska', '905911206', '708');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2021-11-27 16:34:45', 'józefwilk402596@example.com', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Józef', 'józefwilk402596', 'Wilk', '458082591', '709');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2021-07-22 22:42:06', 'konradzalewska581608@example.com', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Konrad', 'konradzalewska581608', 'Zalewska', '155468508', '710');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2021-09-17 07:56:14', 'juliuszkaczmarczyk368980@example.net', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Juliusz', 'juliuszkaczmarczyk368980', 'Kaczmarczyk', '301220277', '711');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2021-07-30 14:19:50', 'wiktorszulc358792@example.org', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Wiktor', 'wiktorszulc358792', 'Szulc', '202760455', '712');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2021-07-09 00:16:10', 'marekduda456546@example.net', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Marek', 'marekduda456546', 'Duda', '455278327', '713');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2022-01-28 05:32:16', 'ameliawiśniewska398703@example.com', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Amelia', 'ameliawiśniewska398703', 'Wiśniewska', '126135280', '714');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2021-09-15 05:39:51', 'damianrutkowska292965@example.net', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Damian', 'damianrutkowska292965', 'Rutkowska', '355013729', '715');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2021-09-25 14:00:12', 'kazimierzkozłowski537003@example.net', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Kazimierz', 'kazimierzkozłowski537003', 'Kozłowski', '839228386', '716');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2021-06-05 18:17:30', 'alicjaszewczyk606403@example.org', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Alicja', 'alicjaszewczyk606403', 'Szewczyk', '184349917', '717');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2021-07-02 03:28:01', 'robertbłaszczyk854187@example.org', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Robert', 'robertbłaszczyk854187', 'Błaszczyk', '183830478', '718');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2022-01-31 09:37:45', 'mateuszbaran137996@example.net', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Mateusz', 'mateuszbaran137996', 'Baran', '662818471', '719');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2021-06-10 15:03:17', 'olgadąbrowska123381@example.com', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Olga', 'olgadąbrowska123381', 'Dąbrowska', '249790073', '720');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2021-10-24 12:49:03', 'dagmarazawadzki878632@example.net', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Dagmara', 'dagmarazawadzki878632', 'Zawadzki', '856886203', '721');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2021-08-27 16:18:44', 'błażejmarciniak254224@example.net', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Błażej', 'błażejmarciniak254224', 'Marciniak', '758011814', '722');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2022-03-09 23:15:18', 'lidiamaciejewski621962@example.org', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Lidia', 'lidiamaciejewski621962', 'Maciejewski', '274596535', '723');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2021-06-23 11:06:12', 'fryderykmarciniak93637@example.net', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Fryderyk', 'fryderykmarciniak93637', 'Marciniak', '355451964', '724');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2021-12-15 01:41:11', 'sebastiangórecka337067@example.net', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Sebastian', 'sebastiangórecka337067', 'Górecka', '762954216', '725');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2021-08-10 06:47:03', 'jeremimakowski734303@example.com', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Jeremi', 'jeremimakowski734303', 'Makowski', '189741166', '726');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2021-09-01 04:02:52', 'dominikzawadzka982722@example.org', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Dominik', 'dominikzawadzka982722', 'Zawadzka', '681330526', '727');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2021-09-16 15:41:36', 'korneliakonieczny258585@example.com', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Kornelia', 'korneliakonieczny258585', 'Konieczny', '930117250', '728');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2021-07-20 02:37:46', 'igawilk347416@example.net', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Iga', 'igawilk347416', 'Wilk', '380116612', '729');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2022-01-01 21:46:36', 'lenazalewska929800@example.com', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Lena', 'lenazalewska929800', 'Zalewska', '908822540', '730');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2022-04-07 08:49:01', 'juliaszewczyk713372@example.org', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Julia', 'juliaszewczyk713372', 'Szewczyk', '266227404', '731');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2021-06-26 18:59:36', 'magdalenawłodarczyk265181@example.net', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Magdalena', 'magdalenawłodarczyk265181', 'Włodarczyk', '413531222', '732');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2021-08-22 20:44:51', 'kornelgrabowska356368@example.net', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Kornel', 'kornelgrabowska356368', 'Grabowska', '478439529', '733');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2021-07-13 03:34:33', 'juliankozłowska456373@example.com', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Julian', 'juliankozłowska456373', 'Kozłowska', '934022673', '734');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2021-05-20 23:13:51', 'lilianaszewczyk576225@example.net', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Liliana', 'lilianaszewczyk576225', 'Szewczyk', '672732638', '735');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2022-04-20 16:12:02', 'iwoszymczak396306@example.net', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Iwo', 'iwoszymczak396306', 'Szymczak', '606114477', '736');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2021-05-25 17:23:56', 'karolinaandrzejewski703709@example.net', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Karolina', 'karolinaandrzejewski703709', 'Andrzejewski', '461257079', '737');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2021-07-08 15:21:42', 'tymonmazur974812@example.org', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Tymon', 'tymonmazur974812', 'Mazur', '882531974', '738');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2022-02-08 22:27:30', 'maurycypietrzak815583@example.org', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Maurycy', 'maurycypietrzak815583', 'Pietrzak', '110878718', '739');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2021-11-25 16:37:33', 'apoloniasawicka694430@example.net', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Apolonia', 'apoloniasawicka694430', 'Sawicka', '919065466', '740');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2022-04-13 17:43:27', 'robertmazur196456@example.com', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Robert', 'robertmazur196456', 'Mazur', '387739695', '741');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2021-05-23 01:04:59', 'kazimierzwitkowska960576@example.com', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Kazimierz', 'kazimierzwitkowska960576', 'Witkowska', '791506252', '742');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2022-01-22 23:03:26', 'michalinaszewczyk260561@example.com', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Michalina', 'michalinaszewczyk260561', 'Szewczyk', '974335748', '743');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2021-06-04 22:09:35', 'magdalenakrajewska435687@example.org', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Magdalena', 'magdalenakrajewska435687', 'Krajewska', '678985918', '744');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2021-11-14 14:30:52', 'cezaryborowski148036@example.org', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Cezary', 'cezaryborowski148036', 'Borowski', '417407273', '745');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2022-01-27 22:26:00', 'aleksanderkalinowska541970@example.org', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Aleksander', 'aleksanderkalinowska541970', 'Kalinowska', '758554338', '746');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2021-07-23 02:25:33', 'olgakrupa657140@example.net', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Olga', 'olgakrupa657140', 'Krupa', '578069924', '747');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2022-03-15 21:23:02', 'konstantyszymańska589837@example.org', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Konstanty', 'konstantyszymańska589837', 'Szymańska', '316083270', '748');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2021-07-21 09:47:11', 'tymoteuszkrawczyk542153@example.net', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Tymoteusz', 'tymoteuszkrawczyk542153', 'Krawczyk', '426269174', '749');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2022-04-30 18:42:37', 'sylwiadudek229030@example.com', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Sylwia', 'sylwiadudek229030', 'Dudek', '950648831', '750');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2021-10-09 12:36:59', 'matyldaprzybylski426475@example.net', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Matylda', 'matyldaprzybylski426475', 'Przybylski', '123871907', '751');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2021-08-04 10:33:54', 'alanpawlak134196@example.net', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Alan', 'alanpawlak134196', 'Pawlak', '122920902', '752');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2021-08-02 03:54:29', 'kajabaran249497@example.net', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Kaja', 'kajabaran249497', 'Baran', '177218598', '753');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2021-08-17 04:58:00', 'idaczerwińska904841@example.net', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Ida', 'idaczerwińska904841', 'Czerwińska', '856865638', '754');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2021-10-03 06:23:00', 'laurasokołowski179206@example.org', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Laura', 'laurasokołowski179206', 'Sokołowski', '134836670', '755');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2022-04-26 15:28:31', 'zofiakowalczyk626929@example.com', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Zofia', 'zofiakowalczyk626929', 'Kowalczyk', '874154314', '756');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2021-12-17 19:08:20', 'juliannamazur940493@example.net', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Julianna', 'juliannamazur940493', 'Mazur', '814958064', '757');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2021-10-14 22:57:15', 'ewelinabłaszczyk142063@example.com', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Ewelina', 'ewelinabłaszczyk142063', 'Błaszczyk', '931730641', '758');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2022-05-02 23:36:28', 'antoninawilk523506@example.net', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Antonina', 'antoninawilk523506', 'Wilk', '955849325', '759');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2021-12-02 13:52:30', 'arkadiuszbłaszczyk841734@example.org', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Arkadiusz', 'arkadiuszbłaszczyk841734', 'Błaszczyk', '461841830', '760');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2021-07-05 08:02:04', 'olafwiśniewski770205@example.com', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Olaf', 'olafwiśniewski770205', 'Wiśniewski', '207373270', '761');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2022-03-15 11:19:56', 'liwiakołodziej91162@example.org', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Liwia', 'liwiakołodziej91162', 'Kołodziej', '537394059', '762');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2021-11-10 14:10:37', 'maurycynowakowska86335@example.net', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Maurycy', 'maurycynowakowska86335', 'Nowakowska', '983195499', '763');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2021-06-14 20:08:57', 'olaflewandowski45474@example.net', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Olaf', 'olaflewandowski45474', 'Lewandowski', '767357509', '764');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2021-07-22 07:23:06', 'hubertkaźmierczak945985@example.com', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Hubert', 'hubertkaźmierczak945985', 'Kaźmierczak', '712590907', '765');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2021-11-19 03:30:48', 'wiktormichalska909437@example.com', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Wiktor', 'wiktormichalska909437', 'Michalska', '908827421', '766');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2021-08-11 19:51:50', 'arturandrzejewski997689@example.net', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Artur', 'arturandrzejewski997689', 'Andrzejewski', '281550949', '767');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2021-09-05 02:13:22', 'tymoteuszjasińska820156@example.org', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Tymoteusz', 'tymoteuszjasińska820156', 'Jasińska', '188483193', '768');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2021-10-21 19:19:53', 'dawidborkowski817542@example.com', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Dawid', 'dawidborkowski817542', 'Borkowski', '615223153', '769');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2021-10-05 08:01:30', 'filipmazur595491@example.net', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Filip', 'filipmazur595491', 'Mazur', '422279999', '770');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2021-08-02 02:21:05', 'tadeuszdąbrowski279684@example.com', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Tadeusz', 'tadeuszdąbrowski279684', 'Dąbrowski', '154907837', '771');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2022-01-15 16:18:49', 'marcelchmielewska418686@example.org', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Marcel', 'marcelchmielewska418686', 'Chmielewska', '473197097', '772');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2022-01-27 00:00:33', 'angelikasobczak603716@example.com', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Angelika', 'angelikasobczak603716', 'Sobczak', '894848607', '773');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2022-03-30 12:54:51', 'juliapawłowski597134@example.net', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Julia', 'juliapawłowski597134', 'Pawłowski', '739294525', '774');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2021-07-12 04:08:51', 'alekswojciechowska382294@example.net', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Aleks', 'alekswojciechowska382294', 'Wojciechowska', '303213833', '775');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2021-09-03 14:11:50', 'elżbietalis848694@example.com', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Elżbieta', 'elżbietalis848694', 'Lis', '255079614', '776');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2021-12-15 11:44:50', 'liwiamazur581472@example.org', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Liwia', 'liwiamazur581472', 'Mazur', '462357639', '777');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2021-06-15 05:39:01', 'nataszadudek348905@example.com', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Natasza', 'nataszadudek348905', 'Dudek', '650410681', '778');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2021-10-15 11:00:48', 'jędrzejwysocki468665@example.org', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Jędrzej', 'jędrzejwysocki468665', 'Wysocki', '751080507', '779');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2022-03-09 03:58:41', 'blankasikora175194@example.net', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Blanka', 'blankasikora175194', 'Sikora', '367030546', '780');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2022-04-27 07:11:53', 'lenamajewski471353@example.com', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Lena', 'lenamajewski471353', 'Majewski', '893755075', '781');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2021-10-25 23:13:54', 'andrzejtomaszewski65769@example.net', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Andrzej', 'andrzejtomaszewski65769', 'Tomaszewski', '612923825', '782');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2021-06-25 09:35:17', 'jędrzejszymczak226842@example.com', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Jędrzej', 'jędrzejszymczak226842', 'Szymczak', '413143050', '783');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2022-05-06 21:57:29', 'alexlaskowska945403@example.net', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Alex', 'alexlaskowska945403', 'Laskowska', '939532840', '784');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2021-08-02 10:10:21', 'nataliaszymański424174@example.net', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Natalia', 'nataliaszymański424174', 'Szymański', '997232563', '785');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2021-08-29 19:37:14', 'marcelinamichalak446126@example.com', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Marcelina', 'marcelinamichalak446126', 'Michalak', '641895835', '786');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2022-01-12 12:00:52', 'martynakołodziej847587@example.com', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Martyna', 'martynakołodziej847587', 'Kołodziej', '709752265', '787');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2022-01-11 15:23:09', 'lilianakonieczny724686@example.org', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Liliana', 'lilianakonieczny724686', 'Konieczny', '699943814', '788');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2021-10-25 16:44:59', 'kajetanwojciechowska884319@example.org', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Kajetan', 'kajetanwojciechowska884319', 'Wojciechowska', '759757106', '789');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2022-01-19 02:25:11', 'dawidszczepański885957@example.org', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Dawid', 'dawidszczepański885957', 'Szczepański', '865546894', '790');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2021-10-18 08:19:19', 'gabrielmichalska688079@example.net', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Gabriel', 'gabrielmichalska688079', 'Michalska', '531622019', '791');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2021-11-04 00:51:32', 'ryszardkubiak761571@example.com', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Ryszard', 'ryszardkubiak761571', 'Kubiak', '392192844', '792');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2021-07-01 14:24:10', 'eryksikora87760@example.com', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Eryk', 'eryksikora87760', 'Sikora', '399058655', '793');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2022-01-29 02:03:28', 'ingaszymańska300279@example.org', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Inga', 'ingaszymańska300279', 'Szymańska', '261298539', '794');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2021-11-05 23:25:34', 'nataszawojciechowski867357@example.com', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Natasza', 'nataszawojciechowski867357', 'Wojciechowski', '290441622', '795');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2022-05-11 06:58:26', 'martamarciniak910144@example.org', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Marta', 'martamarciniak910144', 'Marciniak', '334669944', '796');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2021-09-03 12:30:12', 'kajetanwojciechowski152282@example.net', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Kajetan', 'kajetanwojciechowski152282', 'Wojciechowski', '185692480', '797');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2021-06-23 15:57:51', 'wojciechgajewski972913@example.com', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Wojciech', 'wojciechgajewski972913', 'Gajewski', '684731635', '798');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2021-09-28 22:36:16', 'józefkowalski65581@example.com', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Józef', 'józefkowalski65581', 'Kowalski', '359366461', '799');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2021-09-27 10:41:00', 'kacperostrowska202883@example.net', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Kacper', 'kacperostrowska202883', 'Ostrowska', '366984364', '800');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2021-10-05 09:21:44', 'małgorzatawysocki776702@example.org', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Małgorzata', 'małgorzatawysocki776702', 'Wysocki', '777384677', '801');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2022-03-05 02:01:27', 'adakamińska659121@example.com', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Ada', 'adakamińska659121', 'Kamińska', '424022895', '802');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2021-08-13 10:26:23', 'mariannamakowski83616@example.net', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Marianna', 'mariannamakowski83616', 'Makowski', '814407981', '803');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2021-07-12 14:39:32', 'elizabaranowski389595@example.net', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Eliza', 'elizabaranowski389595', 'Baranowski', '133766653', '804');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2021-08-16 02:06:50', 'matyldajankowska152826@example.com', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Matylda', 'matyldajankowska152826', 'Jankowska', '682480333', '805');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2021-09-27 08:26:53', 'pawełszewczyk410408@example.com', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Paweł', 'pawełszewczyk410408', 'Szewczyk', '665186116', '806');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2021-08-22 13:24:37', 'różazakrzewska990579@example.net', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Róża', 'różazakrzewska990579', 'Zakrzewska', '856336967', '807');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2021-09-06 03:49:22', 'saranowak935152@example.net', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Sara', 'saranowak935152', 'Nowak', '482349465', '808');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2022-03-11 05:58:43', 'ingawłodarczyk52298@example.org', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Inga', 'ingawłodarczyk52298', 'Włodarczyk', '563234064', '809');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2022-05-02 14:05:46', 'sylwiaszymczak451834@example.net', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Sylwia', 'sylwiaszymczak451834', 'Szymczak', '238607193', '810');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2021-06-29 09:30:45', 'filipbaran953486@example.net', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Filip', 'filipbaran953486', 'Baran', '260074891', '811');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2021-05-21 17:52:32', 'stanisławostrowski86576@example.net', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Stanisław', 'stanisławostrowski86576', 'Ostrowski', '675432125', '812');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2022-02-12 09:50:42', 'tymonmichalska257010@example.org', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Tymon', 'tymonmichalska257010', 'Michalska', '808000134', '813');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2021-09-28 20:39:03', 'fryderykchmielewska116955@example.org', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Fryderyk', 'fryderykchmielewska116955', 'Chmielewska', '456513960', '814');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2021-09-26 17:48:11', 'brunomróz873099@example.net', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Bruno', 'brunomróz873099', 'Mróz', '912211533', '815');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2021-09-05 21:02:08', 'stefanmarciniak932135@example.net', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Stefan', 'stefanmarciniak932135', 'Marciniak', '279979175', '816');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2021-07-26 03:17:56', 'igaadamczyk786221@example.com', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Iga', 'igaadamczyk786221', 'Adamczyk', '594855158', '817');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2022-02-23 11:12:09', 'michałkowalski465038@example.com', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Michał', 'michałkowalski465038', 'Kowalski', '389651213', '818');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2022-03-23 23:16:42', 'mateuszwróbel68972@example.com', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Mateusz', 'mateuszwróbel68972', 'Wróbel', '280546441', '819');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2022-02-01 01:32:13', 'polawróblewska629024@example.com', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Pola', 'polawróblewska629024', 'Wróblewska', '411211727', '820');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2021-07-22 22:04:22', 'nadiaurbańska408672@example.org', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Nadia', 'nadiaurbańska408672', 'Urbańska', '897024728', '821');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2022-04-16 06:00:22', 'aleksandrawoźniak173146@example.org', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Aleksandra', 'aleksandrawoźniak173146', 'Woźniak', '983125257', '822');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2022-03-28 00:22:21', 'patrycjajabłoński428194@example.com', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Patrycja', 'patrycjajabłoński428194', 'Jabłoński', '580730167', '823');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2022-05-07 03:32:57', 'matyldaostrowska476872@example.net', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Matylda', 'matyldaostrowska476872', 'Ostrowska', '255721679', '824');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2022-03-31 19:50:49', 'emillis446024@example.net', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Emil', 'emillis446024', 'Lis', '976899572', '825');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2021-06-10 22:24:47', 'kazimierzstępień36502@example.net', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Kazimierz', 'kazimierzstępień36502', 'Stępień', '143860635', '826');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2021-06-20 22:07:14', 'marcelinamichalska39493@example.org', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Marcelina', 'marcelinamichalska39493', 'Michalska', '415583990', '827');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2021-11-04 16:22:35', 'małgorzatawojciechowski504798@example.com', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Małgorzata', 'małgorzatawojciechowski504798', 'Wojciechowski', '270560462', '828');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2021-12-25 22:24:07', 'karolmaciejewska506807@example.com', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Karol', 'karolmaciejewska506807', 'Maciejewska', '363123921', '829');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2022-03-05 05:46:40', 'aleksbrzezińska388743@example.org', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Aleks', 'aleksbrzezińska388743', 'Brzezińska', '401427703', '830');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2021-11-02 05:05:31', 'ameliapiotrowska623015@example.com', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Amelia', 'ameliapiotrowska623015', 'Piotrowska', '976807209', '831');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2021-09-15 23:44:00', 'gabrielastępień345862@example.net', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Gabriela', 'gabrielastępień345862', 'Stępień', '405145531', '832');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2022-03-22 03:19:15', 'tymonkaźmierczak97612@example.net', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Tymon', 'tymonkaźmierczak97612', 'Kaźmierczak', '897820340', '833');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2022-01-20 06:40:53', 'maksdudek513213@example.org', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Maks', 'maksdudek513213', 'Dudek', '211203594', '834');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2021-08-13 22:45:59', 'danieladamczyk589968@example.com', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Daniel', 'danieladamczyk589968', 'Adamczyk', '320224822', '835');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2021-12-31 08:33:03', 'łukaszzając667532@example.org', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Łukasz', 'łukaszzając667532', 'Zając', '832174331', '836');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2021-06-15 04:53:06', 'mariannazakrzewska107793@example.org', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Marianna', 'mariannazakrzewska107793', 'Zakrzewska', '521827740', '837');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2022-03-05 04:22:58', 'aleksgrabowska650286@example.net', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Aleks', 'aleksgrabowska650286', 'Grabowska', '121204413', '838');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2021-11-29 16:11:01', 'adrianjakubowski947217@example.com', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Adrian', 'adrianjakubowski947217', 'Jakubowski', '604084975', '839');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2022-01-18 04:34:26', 'anielagórska140833@example.net', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Aniela', 'anielagórska140833', 'Górska', '419541551', '840');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2022-03-10 02:38:07', 'gabrielaszulc939177@example.com', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Gabriela', 'gabrielaszulc939177', 'Szulc', '118095600', '841');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2022-04-06 19:56:20', 'klaudiawitkowski894146@example.net', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Klaudia', 'klaudiawitkowski894146', 'Witkowski', '683981191', '842');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2022-01-09 19:47:32', 'stanisławwójcik971830@example.net', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Stanisław', 'stanisławwójcik971830', 'Wójcik', '873882602', '843');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2022-05-16 15:25:50', 'aleksolszewska50144@example.org', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Aleks', 'aleksolszewska50144', 'Olszewska', '848908621', '844');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2021-08-15 18:29:00', 'weronikaandrzejewska671273@example.com', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Weronika', 'weronikaandrzejewska671273', 'Andrzejewska', '182900018', '845');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2021-05-29 08:24:00', 'gustawtomaszewska85146@example.net', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Gustaw', 'gustawtomaszewska85146', 'Tomaszewska', '660748389', '846');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2021-11-07 20:01:11', 'agatamalinowska965107@example.net', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Agata', 'agatamalinowska965107', 'Malinowska', '237378176', '847');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2022-02-20 05:06:42', 'erykbaran48236@example.org', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Eryk', 'erykbaran48236', 'Baran', '788801616', '848');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2021-07-03 15:48:00', 'norbertszymczak79862@example.net', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Norbert', 'norbertszymczak79862', 'Szymczak', '811722519', '849');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2021-06-19 18:38:15', 'rozaliaszczepańska583467@example.org', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Rozalia', 'rozaliaszczepańska583467', 'Szczepańska', '469914687', '850');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2022-05-04 00:54:13', 'ernestbaran114426@example.com', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Ernest', 'ernestbaran114426', 'Baran', '136148721', '851');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2022-04-10 22:41:55', 'aleksanderkowalczyk704254@example.net', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Aleksander', 'aleksanderkowalczyk704254', 'Kowalczyk', '432223419', '852');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2021-06-29 21:09:00', 'sebastianborowski178071@example.net', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Sebastian', 'sebastianborowski178071', 'Borowski', '479524831', '853');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2022-02-27 16:29:42', 'michalinagrabowski659470@example.net', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Michalina', 'michalinagrabowski659470', 'Grabowski', '618734028', '854');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2022-05-06 23:54:19', 'mikołajwłodarczyk182026@example.net', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Mikołaj', 'mikołajwłodarczyk182026', 'Włodarczyk', '983572982', '855');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2021-08-13 20:57:23', 'michałgłowacka351496@example.com', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Michał', 'michałgłowacka351496', 'Głowacka', '888093398', '856');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2022-05-04 00:45:28', 'krzysztofostrowski571423@example.net', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Krzysztof', 'krzysztofostrowski571423', 'Ostrowski', '127968518', '857');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2021-05-26 21:53:15', 'gabrielakrajewska244762@example.com', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Gabriela', 'gabrielakrajewska244762', 'Krajewska', '193676417', '858');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2021-12-11 04:18:37', 'maurycyjakubowska683541@example.net', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Maurycy', 'maurycyjakubowska683541', 'Jakubowska', '663236405', '859');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2022-05-06 21:28:58', 'leonborowski16518@example.net', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Leon', 'leonborowski16518', 'Borowski', '951140273', '860');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2022-03-28 23:26:46', 'alanszymański727592@example.org', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Alan', 'alanszymański727592', 'Szymański', '617753439', '861');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2021-07-10 22:02:19', 'elizakrajewski268486@example.net', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Eliza', 'elizakrajewski268486', 'Krajewski', '637041790', '862');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2022-04-16 01:50:16', 'anielasikora442907@example.net', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Aniela', 'anielasikora442907', 'Sikora', '925144651', '863');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2022-02-18 11:48:00', 'dominikmalinowska201212@example.com', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Dominik', 'dominikmalinowska201212', 'Malinowska', '131561920', '864');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2021-12-28 22:54:31', 'jerzybrzeziński711101@example.org', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Jerzy', 'jerzybrzeziński711101', 'Brzeziński', '639868474', '865');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2021-07-13 15:36:26', 'alanmichalska997812@example.org', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Alan', 'alanmichalska997812', 'Michalska', '154576599', '866');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2021-09-07 03:18:46', 'stanisławzawadzka505775@example.com', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Stanisław', 'stanisławzawadzka505775', 'Zawadzka', '714666882', '867');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2021-08-10 23:47:39', 'elizagrabowska463757@example.com', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Eliza', 'elizagrabowska463757', 'Grabowska', '740209351', '868');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2022-03-15 03:47:12', 'mieszkogłowacka389427@example.org', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Mieszko', 'mieszkogłowacka389427', 'Głowacka', '326324872', '869');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2021-12-29 17:17:28', 'ameliaczarnecki609601@example.net', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Amelia', 'ameliaczarnecki609601', 'Czarnecki', '253621560', '870');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2021-08-07 21:12:59', 'nikodemkwiatkowska338653@example.com', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Nikodem', 'nikodemkwiatkowska338653', 'Kwiatkowska', '116469592', '871');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2021-09-19 18:58:46', 'adriannaprzybylska471646@example.net', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Adrianna', 'adriannaprzybylska471646', 'Przybylska', '458524826', '872');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2021-07-22 06:12:12', 'józefwysocka869403@example.org', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Józef', 'józefwysocka869403', 'Wysocka', '361543718', '873');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2021-10-12 06:59:09', 'miłoszwoźniak956116@example.net', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Miłosz', 'miłoszwoźniak956116', 'Woźniak', '513921878', '874');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2021-10-24 08:42:29', 'grzegorzkaczmarek960735@example.org', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Grzegorz', 'grzegorzkaczmarek960735', 'Kaczmarek', '716181126', '875');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2021-09-04 01:47:47', 'elizagórski677464@example.org', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Eliza', 'elizagórski677464', 'Górski', '982074746', '876');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2022-01-27 03:20:10', 'kalinatomaszewska569048@example.com', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Kalina', 'kalinatomaszewska569048', 'Tomaszewska', '992469150', '877');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2021-06-15 18:11:55', 'ewagrabowska890452@example.org', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Ewa', 'ewagrabowska890452', 'Grabowska', '610019488', '878');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2021-09-01 12:07:29', 'anitabłaszczyk658811@example.org', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Anita', 'anitabłaszczyk658811', 'Błaszczyk', '802683314', '879');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2022-04-29 15:17:35', 'józefjasiński993503@example.net', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Józef', 'józefjasiński993503', 'Jasiński', '254487655', '880');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2021-09-11 19:09:45', 'liwiazalewska601283@example.com', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Liwia', 'liwiazalewska601283', 'Zalewska', '244645337', '881');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2021-06-22 15:18:27', 'marcinmichalak562352@example.org', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Marcin', 'marcinmichalak562352', 'Michalak', '484732203', '882');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2021-09-29 00:59:57', 'franciszekkwiatkowski726728@example.com', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Franciszek', 'franciszekkwiatkowski726728', 'Kwiatkowski', '971597326', '883');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2021-06-15 14:06:35', 'nataszagłowacki113510@example.com', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Natasza', 'nataszagłowacki113510', 'Głowacki', '335684520', '884');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2021-12-03 17:37:40', 'marcelkucharska54741@example.org', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Marcel', 'marcelkucharska54741', 'Kucharska', '215457764', '885');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2021-05-31 06:43:04', 'mariajabłoński926622@example.net', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Maria', 'mariajabłoński926622', 'Jabłoński', '724153306', '886');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2021-09-01 01:01:27', 'jeremigajewski581651@example.com', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Jeremi', 'jeremigajewski581651', 'Gajewski', '927190391', '887');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2021-09-24 12:33:43', 'kamilkrupa753852@example.org', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Kamil', 'kamilkrupa753852', 'Krupa', '857275887', '888');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2021-07-19 20:11:23', 'ryszardgłowacka578329@example.com', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Ryszard', 'ryszardgłowacka578329', 'Głowacka', '908481908', '889');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2021-10-02 20:38:25', 'matyldakrupa790444@example.com', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Matylda', 'matyldakrupa790444', 'Krupa', '836592245', '890');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2021-10-09 10:33:14', 'karinagórecka909333@example.net', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Karina', 'karinagórecka909333', 'Górecka', '111230030', '891');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2021-11-17 02:28:31', 'malwinakwiatkowska187663@example.com', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Malwina', 'malwinakwiatkowska187663', 'Kwiatkowska', '224262556', '892');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2021-07-15 11:44:21', 'jagodakrupa15325@example.com', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Jagoda', 'jagodakrupa15325', 'Krupa', '849499906', '893');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2021-05-26 15:58:29', 'polamakowska981160@example.org', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Pola', 'polamakowska981160', 'Makowska', '197169087', '894');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2021-12-01 15:52:51', 'marcelinazalewski240168@example.org', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Marcelina', 'marcelinazalewski240168', 'Zalewski', '277187497', '895');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2021-11-21 04:48:27', 'alanmichalak485587@example.com', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Alan', 'alanmichalak485587', 'Michalak', '103919878', '896');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2022-04-17 19:47:06', 'grzegorzkołodziej342205@example.net', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Grzegorz', 'grzegorzkołodziej342205', 'Kołodziej', '857251059', '897');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2022-04-25 17:27:14', 'sandramalinowska582341@example.com', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Sandra', 'sandramalinowska582341', 'Malinowska', '638622886', '898');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2022-03-20 13:38:42', 'olgierdbaranowska914107@example.com', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Olgierd', 'olgierdbaranowska914107', 'Baranowska', '851059934', '899');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2021-11-12 02:49:05', 'melaniabłaszczyk881903@example.org', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Melania', 'melaniabłaszczyk881903', 'Błaszczyk', '511554407', '900');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2022-04-05 14:07:35', 'korneliaszczepański399670@example.org', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Kornelia', 'korneliaszczepański399670', 'Szczepański', '304285263', '901');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2021-07-05 20:23:37', 'błażejbaran274738@example.org', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Błażej', 'błażejbaran274738', 'Baran', '247075313', '902');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2021-10-10 02:36:37', 'mateuszbrzeziński586831@example.com', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Mateusz', 'mateuszbrzeziński586831', 'Brzeziński', '638728803', '903');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2022-02-14 00:20:05', 'mariannaziółkowski580031@example.net', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Marianna', 'mariannaziółkowski580031', 'Ziółkowski', '495568074', '904');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2022-05-02 19:06:47', 'annazając581175@example.net', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Anna', 'annazając581175', 'Zając', '537862707', '905');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2021-11-18 04:03:36', 'martawalczak284860@example.org', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Marta', 'martawalczak284860', 'Walczak', '744019857', '906');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2021-07-05 10:40:19', 'pawełnowak379304@example.net', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Paweł', 'pawełnowak379304', 'Nowak', '409515138', '907');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2022-05-14 02:18:28', 'mieszkosadowska69811@example.com', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Mieszko', 'mieszkosadowska69811', 'Sadowska', '350234203', '908');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2021-08-10 21:04:02', 'matyldastępień10892@example.com', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Matylda', 'matyldastępień10892', 'Stępień', '972959347', '909');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2022-04-22 13:23:47', 'olafjankowski88645@example.net', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Olaf', 'olafjankowski88645', 'Jankowski', '195127336', '910');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2021-07-24 09:16:03', 'blankamakowski906243@example.com', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Blanka', 'blankamakowski906243', 'Makowski', '510739519', '911');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2021-09-02 22:45:41', 'karolinajakubowski759941@example.com', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Karolina', 'karolinajakubowski759941', 'Jakubowski', '581785601', '912');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2021-11-08 11:39:13', 'ewaolszewska214528@example.com', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Ewa', 'ewaolszewska214528', 'Olszewska', '232306145', '913');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2021-05-21 05:19:51', 'ernestgłowacka198317@example.org', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Ernest', 'ernestgłowacka198317', 'Głowacka', '841767055', '914');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2022-04-29 22:29:55', 'iwogłowacka882452@example.com', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Iwo', 'iwogłowacka882452', 'Głowacka', '565348550', '915');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2021-10-22 03:52:47', 'witoldduda734508@example.net', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Witold', 'witoldduda734508', 'Duda', '487757994', '916');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2021-09-08 05:57:37', 'brunokwiatkowski391150@example.com', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Bruno', 'brunokwiatkowski391150', 'Kwiatkowski', '791211058', '917');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2022-04-16 06:46:58', 'arturkowalczyk657070@example.net', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Artur', 'arturkowalczyk657070', 'Kowalczyk', '923401425', '918');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2022-03-16 09:38:28', 'dominikpietrzak842975@example.net', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Dominik', 'dominikpietrzak842975', 'Pietrzak', '844720500', '919');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2022-01-18 14:55:51', 'jankaźmierczak617166@example.com', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Jan', 'jankaźmierczak617166', 'Kaźmierczak', '888091337', '920');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2021-07-02 18:26:57', 'mateuszmarciniak591070@example.net', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Mateusz', 'mateuszmarciniak591070', 'Marciniak', '759606662', '921');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2021-09-06 17:22:58', 'rozaliagrabowska580369@example.com', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Rozalia', 'rozaliagrabowska580369', 'Grabowska', '767057920', '922');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2021-10-04 06:20:12', 'erykkwiatkowski443153@example.net', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Eryk', 'erykkwiatkowski443153', 'Kwiatkowski', '981191932', '923');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2022-02-23 09:06:15', 'jakubwojciechowska627830@example.org', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Jakub', 'jakubwojciechowska627830', 'Wojciechowska', '112637283', '924');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2021-05-19 02:24:47', 'adriannakubiak604224@example.com', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Adrianna', 'adriannakubiak604224', 'Kubiak', '700072993', '925');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2022-04-17 00:57:18', 'radosławprzybylska509040@example.com', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Radosław', 'radosławprzybylska509040', 'Przybylska', '121129726', '926');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2021-06-20 08:35:01', 'nikolachmielewska893722@example.org', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Nikola', 'nikolachmielewska893722', 'Chmielewska', '610224058', '927');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2022-04-01 18:57:21', 'magdalenawitkowska598703@example.org', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Magdalena', 'magdalenawitkowska598703', 'Witkowska', '410453435', '928');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2022-04-02 11:03:27', 'rafałzakrzewski492645@example.net', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Rafał', 'rafałzakrzewski492645', 'Zakrzewski', '582465745', '929');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2021-06-02 08:25:34', 'filipsikorski932122@example.net', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Filip', 'filipsikorski932122', 'Sikorski', '691237045', '930');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2021-09-15 09:21:55', 'julitakamiński941420@example.com', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Julita', 'julitakamiński941420', 'Kamiński', '882991031', '931');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2021-12-11 09:38:33', 'elizakowalczyk345091@example.com', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Eliza', 'elizakowalczyk345091', 'Kowalczyk', '717473763', '932');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2022-05-05 22:33:31', 'annazakrzewska274537@example.org', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Anna', 'annazakrzewska274537', 'Zakrzewska', '528824246', '933');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2022-01-17 19:21:27', 'tolakwiatkowski790977@example.com', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Tola', 'tolakwiatkowski790977', 'Kwiatkowski', '907964759', '934');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2021-05-20 22:04:14', 'mariannagłowacki882899@example.net', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Marianna', 'mariannagłowacki882899', 'Głowacki', '863572197', '935');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2022-03-10 06:58:34', 'biankaszewczyk689137@example.org', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Bianka', 'biankaszewczyk689137', 'Szewczyk', '958750868', '936');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2022-02-14 01:57:06', 'mariamakowska701636@example.com', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Maria', 'mariamakowska701636', 'Makowska', '819150467', '937');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2022-02-18 23:54:22', 'zofiawalczak960909@example.com', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Zofia', 'zofiawalczak960909', 'Walczak', '140695924', '938');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2022-01-16 03:45:39', 'pawełprzybylska492732@example.org', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Paweł', 'pawełprzybylska492732', 'Przybylska', '428404920', '939');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2021-10-08 17:35:43', 'kamiljasiński701666@example.com', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Kamil', 'kamiljasiński701666', 'Jasiński', '452705418', '940');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2021-08-05 14:19:27', 'adaborkowska160197@example.net', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Ada', 'adaborkowska160197', 'Borkowska', '326204196', '941');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2021-06-07 09:45:35', 'cezarystępień798227@example.net', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Cezary', 'cezarystępień798227', 'Stępień', '867639280', '942');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2021-11-26 05:14:51', 'fabianwłodarczyk781054@example.com', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Fabian', 'fabianwłodarczyk781054', 'Włodarczyk', '853465930', '943');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2021-12-09 22:18:00', 'majagłowacki615683@example.net', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Maja', 'majagłowacki615683', 'Głowacki', '777418441', '944');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2022-02-20 02:17:49', 'nikolabrzeziński159600@example.com', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Nikola', 'nikolabrzeziński159600', 'Brzeziński', '640480577', '945');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2021-11-14 13:20:14', 'justynamazurek968184@example.com', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Justyna', 'justynamazurek968184', 'Mazurek', '408404394', '946');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2022-01-04 09:01:04', 'brunoszulc789246@example.com', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Bruno', 'brunoszulc789246', 'Szulc', '792665216', '947');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2021-10-05 06:59:46', 'józefkowalczyk900300@example.net', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Józef', 'józefkowalczyk900300', 'Kowalczyk', '317892275', '948');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2021-07-09 00:40:56', 'agnieszkakaźmierczak120002@example.com', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Agnieszka', 'agnieszkakaźmierczak120002', 'Kaźmierczak', '652201190', '949');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2021-05-29 07:42:38', 'aleksandersawicki496512@example.com', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Aleksander', 'aleksandersawicki496512', 'Sawicki', '786685310', '950');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2021-06-19 03:15:39', 'łukaszzalewski204825@example.net', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Łukasz', 'łukaszzalewski204825', 'Zalewski', '899448529', '951');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2021-05-28 00:17:30', 'sebastianchmielewski904064@example.net', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Sebastian', 'sebastianchmielewski904064', 'Chmielewski', '764073090', '952');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2022-03-28 22:12:52', 'soniawitkowski501836@example.net', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Sonia', 'soniawitkowski501836', 'Witkowski', '693551931', '953');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2021-12-12 23:10:20', 'sylwiazakrzewska796220@example.net', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Sylwia', 'sylwiazakrzewska796220', 'Zakrzewska', '871841008', '954');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2021-05-21 01:54:34', 'boryspietrzak699873@example.org', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Borys', 'boryspietrzak699873', 'Pietrzak', '942409967', '955');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2022-03-13 21:55:15', 'juliaduda617358@example.org', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Julia', 'juliaduda617358', 'Duda', '473101758', '956');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2021-07-01 20:14:11', 'boryssikora876521@example.org', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Borys', 'boryssikora876521', 'Sikora', '962180295', '957');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2022-02-19 00:24:57', 'dariawojciechowski140597@example.com', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Daria', 'dariawojciechowski140597', 'Wojciechowski', '425434725', '958');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2021-09-27 11:18:40', 'majapawłowski663933@example.org', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Maja', 'majapawłowski663933', 'Pawłowski', '303354318', '959');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2021-08-20 23:21:07', 'patryknowak23777@example.org', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Patryk', 'patryknowak23777', 'Nowak', '679630595', '960');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2022-04-16 16:36:22', 'tadeuszsokołowski808597@example.com', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Tadeusz', 'tadeuszsokołowski808597', 'Sokołowski', '904467286', '961');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2022-02-21 03:20:18', 'grzegorztomaszewska242513@example.org', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Grzegorz', 'grzegorztomaszewska242513', 'Tomaszewska', '477924343', '962');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2021-11-23 02:16:31', 'aleksanderbłaszczyk12728@example.com', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Aleksander', 'aleksanderbłaszczyk12728', 'Błaszczyk', '568188020', '963');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2022-03-11 22:32:38', 'jeremizając169385@example.com', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Jeremi', 'jeremizając169385', 'Zając', '604399620', '964');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2022-01-21 18:32:00', 'julitasikora180902@example.net', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Julita', 'julitasikora180902', 'Sikora', '733381417', '965');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2021-05-31 00:09:27', 'marcintomaszewska794248@example.org', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Marcin', 'marcintomaszewska794248', 'Tomaszewska', '686180937', '966');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2022-04-23 20:06:17', 'kingawalczak19353@example.com', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Kinga', 'kingawalczak19353', 'Walczak', '804237724', '967');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2022-02-19 14:56:27', 'juliuszkrawczyk475480@example.com', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Juliusz', 'juliuszkrawczyk475480', 'Krawczyk', '952313247', '968');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2021-08-16 11:46:08', 'makskubiak424757@example.org', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Maks', 'makskubiak424757', 'Kubiak', '235508559', '969');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2022-02-02 05:16:18', 'zofiamichalak385524@example.com', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Zofia', 'zofiamichalak385524', 'Michalak', '430803832', '970');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2021-10-24 01:40:42', 'korneliakwiatkowska101884@example.com', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Kornelia', 'korneliakwiatkowska101884', 'Kwiatkowska', '547217236', '971');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2021-08-30 03:45:42', 'damianzawadzki898498@example.net', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Damian', 'damianzawadzki898498', 'Zawadzki', '116733660', '972');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2021-10-19 06:39:42', 'agnieszkawieczorek732848@example.com', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Agnieszka', 'agnieszkawieczorek732848', 'Wieczorek', '611836844', '973');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2021-11-24 11:43:13', 'roksanakucharska109495@example.net', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Roksana', 'roksanakucharska109495', 'Kucharska', '856689744', '974');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2022-05-09 16:59:28', 'cyprianmalinowski238720@example.net', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Cyprian', 'cyprianmalinowski238720', 'Malinowski', '953204858', '975');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2022-02-08 09:36:57', 'dariabaranowski145051@example.com', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Daria', 'dariabaranowski145051', 'Baranowski', '153695875', '976');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2021-07-30 18:33:25', 'alicjawójcik895062@example.net', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Alicja', 'alicjawójcik895062', 'Wójcik', '416770238', '977');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2021-08-24 10:40:23', 'julianprzybylska128255@example.net', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Julian', 'julianprzybylska128255', 'Przybylska', '192378015', '978');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2021-08-15 01:20:35', 'joannamichalak475013@example.net', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Joanna', 'joannamichalak475013', 'Michalak', '781239553', '979');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2021-12-26 13:53:25', 'jagodaszczepański478273@example.com', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Jagoda', 'jagodaszczepański478273', 'Szczepański', '855473108', '980');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2021-08-16 19:23:19', 'maurycymichalski918110@example.net', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Maurycy', 'maurycymichalski918110', 'Michalski', '916803869', '981');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2021-12-23 21:32:01', 'lilianaszulc689433@example.org', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Liliana', 'lilianaszulc689433', 'Szulc', '407123475', '982');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2022-01-27 04:54:37', 'zofiawiśniewski939654@example.org', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Zofia', 'zofiawiśniewski939654', 'Wiśniewski', '610321056', '983');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2021-09-18 00:24:51', 'ignacykucharski138794@example.net', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Ignacy', 'ignacykucharski138794', 'Kucharski', '809676604', '984');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2021-06-18 21:46:51', 'dawidwłodarczyk587274@example.net', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Dawid', 'dawidwłodarczyk587274', 'Włodarczyk', '941074348', '985');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2021-10-06 23:27:47', 'milenamichalak83378@example.org', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Milena', 'milenamichalak83378', 'Michalak', '693583937', '986');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2021-07-16 01:37:40', 'leonardmaciejewski523358@example.com', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Leonard', 'leonardmaciejewski523358', 'Maciejewski', '725339324', '987');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2021-09-29 22:15:12', 'klaudiakaczmarek902068@example.org', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Klaudia', 'klaudiakaczmarek902068', 'Kaczmarek', '472024991', '988');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2021-05-26 04:12:51', 'ernestlaskowski728357@example.net', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Ernest', 'ernestlaskowski728357', 'Laskowski', '539918941', '989');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2021-09-14 13:06:32', 'aureliazalewski109694@example.org', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Aurelia', 'aureliazalewski109694', 'Zalewski', '855084899', '990');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2021-10-08 19:12:41', 'witoldchmielewski549204@example.com', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Witold', 'witoldchmielewski549204', 'Chmielewski', '200136742', '991');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2021-11-23 20:08:27', 'krystianandrzejewska701004@example.org', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Krystian', 'krystianandrzejewska701004', 'Andrzejewska', '802690238', '992');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2022-03-22 16:15:44', 'adamjankowska230760@example.com', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Adam', 'adamjankowska230760', 'Jankowska', '516030808', '993');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2021-07-27 18:26:36', 'kajatomaszewski898279@example.com', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Kaja', 'kajatomaszewski898279', 'Tomaszewski', '431094367', '994');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2021-07-03 08:39:41', 'jacektomaszewski771157@example.com', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Jacek', 'jacektomaszewski771157', 'Tomaszewski', '364139001', '995');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2022-01-05 18:03:40', 'błażejwasilewska462067@example.net', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Błażej', 'błażejwasilewska462067', 'Wasilewska', '805979335', '996');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2021-10-16 11:54:07', 'brunoadamska113608@example.com', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Bruno', 'brunoadamska113608', 'Adamska', '919479115', '997');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2022-04-04 13:44:37', 'marcelinawiśniewski848211@example.com', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Marcelina', 'marcelinawiśniewski848211', 'Wiśniewski', '248734272', '998');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2021-08-24 03:05:01', 'patrycjapiotrowska628889@example.org', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Patrycja', 'patrycjapiotrowska628889', 'Piotrowska', '961210576', '999');
INSERT INTO uzytkownicy (data_rejestracji, email, haslo, imie, nazwa_uzytkownika, nazwisko, telefon, adres_id) VALUES ('2022-04-07 21:14:02', 'kingazakrzewska432692@example.org', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Kinga', 'kingazakrzewska432692', 'Zakrzewska', '812367605', '1000');

INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('709.00', 'Procesory', 'mvm5a2e', 'Intel Core i5-11400F', 'Gniazdo procesora: Socket 1200, Taktowanie: 2.6 GHz , Liczba rdzeni: 6 rdzeni, Cache: 12 MB');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('889.00', 'Procesory', 'd7ltjnb', 'Intel Core i5-12400F', 'Gniazdo procesora: Socket 1700, Taktowanie: 2.5 GHz, Liczba rdzeni: 6 rdzeni, Cache: 18 MB');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('1160.00', 'Procesory', 'wgy0muo', 'AMD Ryzen 5 5600X', 'Gniazdo procesora: Socket AM4, Taktowanie: 3.7 GHz, Liczba rdzeni: 6 rdzeni, Cache: 35 MB');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('649.00', 'Procesory', 'qr0ll6m', 'Intel Core i5-10400F', 'Gniazdo procesora: Socket 1200, Taktowanie: 2.9 GHz, Liczba rdzeni: 6 rdzeni, Cache: 12 MB');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('379.00', 'Procesory', '2t0hi5g', 'Intel Core i3-10100F', 'Gniazdo procesora: Socket 1200, Taktowanie: 3.6 GHz, Liczba rdzeni: 4 rdzenie, Cache: 6 MB');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('1399.00', 'Procesory', 'pz1rfwr', 'AMD Ryzen 7 3800X', 'Gniazdo procesora: Socket AM4, Taktowanie: 3.9 GHz, Liczba rdzeni: 8 rdzeni, Cache: 36 MB');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('1449.00', 'Procesory', 'mm4z90x', 'Intel Core i5-12600K', 'Gniazdo procesora: Socket 1700, Taktowanie: 3.7 GHz, Liczba rdzeni: 10 rdzeni, Cache: 20 MB');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('1349.00', 'Procesory', 'ry9yhx6', 'Intel Core i5-12600KF', 'Gniazdo procesora: Socket 1700, Taktowanie: 3.7 GHz, Liczba rdzeni: 10 rdzeni, Cache: 20 MB');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('2099.00', 'Procesory', 'ensy73m', 'Intel Core i7-12700K', 'Gniazdo procesora: Socket 1700, Taktowanie: 3.6 GHz, Liczba rdzeni: 12 rdzeni, Cache: 25 MB');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('1999.00', 'Procesory', 'nlmas5g', 'Intel Core i7-12700KF', 'Gniazdo procesora: Socket 1700, Taktowanie: 3.6 GHz, Liczba rdzeni: 12 rdzeni, Cache: 25 MB');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('2499.00', 'Procesory', 'q8rh98e', 'AMD Ryzen 7 5800X3D', 'Gniazdo procesora: Socket AM4, Taktowanie: 3.4 GHz, Liczba rdzeni: 8 rdzeni, Cache: 96 MB');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('1099.00', 'Procesory', 'ffwm6yk', 'AMD Ryzen 5 5600G', 'Gniazdo procesora: Socket AM4, Taktowanie: 3.9 GHz , Liczba rdzeni: 6 rdzeni, Cache: 19 MB');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('1049.00', 'Procesory', '5btbgkl', 'AMD Ryzen 5 5600', 'Gniazdo procesora: Socket AM4, Taktowanie: 3.5 GHz, Liczba rdzeni: 6 rdzeni, Cache: 35 MB');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('549.00', 'Procesory', 'mi3i5f9', 'Intel Core i3-12100F', 'Gniazdo procesora: Socket 1700, Taktowanie: 3.3 GHz, Liczba rdzeni: 4 rdzenie, Cache: 12 MB');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('1699.00', 'Procesory', 'aryqfra', 'AMD Ryzen 7 5800X', 'Gniazdo procesora: Socket AM4, Taktowanie: 3.8 GHz, Liczba rdzeni: 8 rdzeni, Cache: 36 MB');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('3799.00', 'Procesory', '2qqi120', 'AMD Ryzen 9 5950X', 'Gniazdo procesora: Socket AM4, Taktowanie: 3.4 GHz, Liczba rdzeni: 16 rdzeni, Cache: 72 MB');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('2099.00', 'Procesory', 'h7madcs', 'AMD Ryzen 9 5900X', 'Gniazdo procesora: Socket AM4, Taktowanie: 3.7 GHz, Liczba rdzeni: 12 rdzeni, Cache: 70 MB');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('949.00', 'Procesory', 'j40lt6e', 'Intel Core i5-11400', 'Gniazdo procesora: Socket 1200, Taktowanie: 2.6 GHz , Liczba rdzeni: 6 rdzeni, Cache: 12 MB');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('3199.00', 'Procesory', 'yz9d2fe', 'Intel Core i9-12900K', 'Gniazdo procesora: Socket 1700, Taktowanie: 3.2 GHz, Liczba rdzeni: 16 rdzeni, Cache: 30 MB');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('1599.00', 'Procesory', 'y871hjd', 'AMD Ryzen 7 5700X', 'Gniazdo procesora: Socket AM4, Taktowanie: 3.4 GHz, Liczba rdzeni: 8 rdzeni, Cache: 36 MB');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('999.00', 'Procesory', 'uc3qtle', 'Intel Core i5-12400', 'Gniazdo procesora: Socket 1700, Taktowanie: 2.5 GHz, Liczba rdzeni: 6 rdzeni, Cache: 18 MB');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('809.00', 'Procesory', 'mqh1dq2', 'AMD Ryzen 5 5500', 'Gniazdo procesora: Socket AM4, Taktowanie: 3.6 GHz, Liczba rdzeni: 6 rdzeni, Cache: 19 MB');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('1059.00', 'Procesory', 'xzfvv7c', 'AMD Ryzen 5 3600 OEM + chlodzenie', 'Gniazdo procesora: Socket AM4, Taktowanie: 3.6 GHz, Liczba rdzeni: 6 rdzeni, Cache: 35 MB');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('389.00', 'Procesory', '2se9w6t', 'Intel Core i3-10105F', 'Gniazdo procesora: Socket 1200, Taktowanie: 3.7 GHz, Liczba rdzeni: 4 rdzenie, Cache: 6 MB');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('1099.00', 'Procesory', '9pk73py', 'Intel Core i5-11600KF', 'Gniazdo procesora: Socket 1200, Taktowanie: 3.9 GHz , Liczba rdzeni: 6 rdzeni, Cache: 12 MB');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('1249.00', 'Procesory', '2g6at0m', 'Intel Core i5-11600K', 'Gniazdo procesora: Socket 1200, Taktowanie: 3.9 GHz , Liczba rdzeni: 6 rdzeni, Cache: 12 MB');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('379.00', 'Procesory', 'j1nyyna', 'AMD Ryzen 3 1200AF OEM', 'Gniazdo procesora: Socket AM4, Taktowanie: 3.1 GHz, Liczba rdzeni: 4 rdzenie, Cache: 10 MB');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('1499.00', 'Procesory', 'h2fvnb4', 'AMD Ryzen 7 5700G', 'Gniazdo procesora: Socket AM4, Taktowanie: 3.8 GHz, Liczba rdzeni: 8 rdzeni, Cache: 20 MB');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('1299.00', 'Procesory', 'txr7qvn', 'Intel Core i7-10700F', 'Gniazdo procesora: Socket 1200, Taktowanie: 2.9 GHz, Liczba rdzeni: 8 rdzeni, Cache: 16 MB');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('1799.00', 'Procesory', 'a85lbc7', 'Intel Core i7-12700', 'Gniazdo procesora: Socket 1700, Taktowanie: 2.1 GHz, Liczba rdzeni: 12 rdzeni, Cache: 25 MB');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('589.00', 'Procesory', 'sjub7zr', 'Intel Core i3-10100', 'Gniazdo procesora: Socket 1200, Taktowanie: 3.6 GHz, Liczba rdzeni: 4 rdzenie, Cache: 6 MB');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('679.00', 'Procesory', '22k8rs2', 'AMD Ryzen 5 4500 OEM + Chlodzenie', 'Gniazdo procesora: Socket AM4, Taktowanie: 3.6 GHz, Liczba rdzeni: 6 rdzeni, Cache: 11 MB');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('799.00', 'Procesory', 'yfkoo5h', 'Intel Core i5-10400', 'Gniazdo procesora: Socket 1200, Taktowanie: 2.9 GHz, Liczba rdzeni: 6 rdzeni, Cache: 12 MB');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('1699.00', 'Procesory', 'toddn0i', 'Intel Core i7-12700F', 'Gniazdo procesora: Socket 1700, Taktowanie: 2.1 GHz, Liczba rdzeni: 12 rdzeni, Cache: 25 MB');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('1549.00', 'Procesory', '4snxldy', 'Intel Core i7-10700KF', 'Gniazdo procesora: Socket 1200, Taktowanie: 3.8 GHz, Liczba rdzeni: 8 rdzeni, Cache: 16 MB');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('699.00', 'Procesory', 'rutqlm3', 'Intel Core i3-12100', 'Gniazdo procesora: Socket 1700, Taktowanie: 3.3 GHz, Liczba rdzeni: 4 rdzenie, Cache: 12 MB');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('1229.00', 'Procesory', '6g09dwl', 'Intel Core i5-12600', 'Gniazdo procesora: Socket 1700, Taktowanie: 3.3 GHz, Liczba rdzeni: 6 rdzeni, Cache: 18 MB');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('1819.00', 'Procesory', '3u7xhz0', 'Intel Core i7-11700K', 'Gniazdo procesora: Socket 1200, Taktowanie: 3.6 GHz, Liczba rdzeni: 8 rdzeni, Cache: 16 MB');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('1749.00', 'Procesory', '6q9t1i8', 'Intel Core i7-11700KF', 'Gniazdo procesora: Socket 1200, Taktowanie: 3.6 GHz, Liczba rdzeni: 8 rdzeni, Cache: 16 MB');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('949.00', 'Procesory', 'j7kgoch', 'Intel Core i5-10600KF', 'Gniazdo procesora: Socket 1200, Taktowanie: 4.1 GHz, Liczba rdzeni: 6 rdzeni, Cache: 12 MB');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('1099.00', 'Procesory', 'u19csox', 'Intel Core i5-12500', 'Gniazdo procesora: Socket 1700, Taktowanie: 3.0 GHz, Liczba rdzeni: 6 rdzeni, Cache: 18 MB');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('579.00', 'Procesory', 'heekn8b', 'Intel Core i3-10105', 'Gniazdo procesora: Socket 1200, Taktowanie: 3.7 GHz, Liczba rdzeni: 4 rdzenie, Cache: 6 MB');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('499.00', 'Procesory', '8radozw', 'AMD Ryzen 3 4100 OEM + Chlodzenie', 'Gniazdo procesora: Socket AM4, Taktowanie: 3.8 GHz, Liczba rdzeni: 4 rdzenie, Cache: 6 MB');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('2999.00', 'Procesory', 'eu8vd5v', 'Intel Core i9-12900KF', 'Gniazdo procesora: Socket 1700, Taktowanie: 3.2 GHz, Liczba rdzeni: 16 rdzeni, Cache: 30 MB');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('369.00', 'Procesory', 'ky2zudh', 'AMD Ryzen 3 1200 OEM', 'Gniazdo procesora: Socket AM4, Taktowanie: 3.1 GHz, Liczba rdzeni: 4 rdzenie, Cache: 10 MB');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('1099.00', 'Procesory', '49uykmx', 'AMD Ryzen 5 3600 OEM', 'Gniazdo procesora: Socket AM4, Taktowanie: 3.6 GHz, Liczba rdzeni: 6 rdzeni, Cache: 35 MB');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('1699.00', 'Procesory', 'm5jml7l', 'Intel Core i7-11700', 'Gniazdo procesora: Socket 1200, Taktowanie: 2.5 GHz , Liczba rdzeni: 8 rdzeni, Cache: 16 MB');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('3999.00', 'Procesory', 'pkdanvq', 'Intel Core i9-12900KS', 'Gniazdo procesora: Socket 1700, Taktowanie: 3.4 GHz, Liczba rdzeni: 16 rdzeni, Cache: 30 MB');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('199.00', 'Procesory', 'farpub8', 'Intel Celeron G5905', 'Gniazdo procesora: Socket 1200, Taktowanie: 3.5 GHz, Liczba rdzeni: 2 rdzenie, Cache: 4 MB');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('1449.00', 'Procesory', 'pmv444d', 'Intel Core i7-10700', 'Gniazdo procesora: Socket 1200, Taktowanie: 2.9 GHz, Liczba rdzeni: 8 rdzeni, Cache: 16 MB');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('2399.00', 'Procesory', 'tppdm92', 'Intel Core i9-11900KF', 'Gniazdo procesora: Socket 1200, Taktowanie: 3.5 GHz , Liczba rdzeni: 8 rdzeni, Cache: 16 MB');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('2499.00', 'Procesory', '1yi28k5', 'Intel Core i9-11900K', 'Gniazdo procesora: Socket 1200, Taktowanie: 3.5 GHz , Liczba rdzeni: 8 rdzeni, Cache: 16 MB');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('299.00', 'Procesory', 'oyygs2y', 'Intel Pentium Gold G6400', 'Gniazdo procesora: Socket 1200, Taktowanie: 4.0 GHz, Liczba rdzeni: 2 rdzenie, Cache: 4 MB');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('1699.00', 'Procesory', '8dj1k17', 'Intel Core i7-11700F ', 'Gniazdo procesora: Socket 1200, Taktowanie: 2.5 GHz , Liczba rdzeni: 8 rdzeni, Cache: 16 MB');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('2149.00', 'Procesory', 'sytrch7', 'Intel Core i9-10900KF', 'Gniazdo procesora: Socket 1200, Taktowanie: 3.7 GHz, Liczba rdzeni: 10 rdzeni, Cache: 20 MB');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('2199.00', 'Procesory', '6y7axyp', 'Intel Core i9-10900K', 'Gniazdo procesora: Socket 1200, Taktowanie: 3.7 GHz, Liczba rdzeni: 10 rdzeni, Cache: 20 MB');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('1069.00', 'Procesory', 'mixw2db', 'Intel Core i5-11600', 'Gniazdo procesora: Socket 1200, Taktowanie: 2.8 GHz , Liczba rdzeni: 6 rdzeni, Cache: 12 MB');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('969.00', 'Procesory', 'x7wlcpv', 'Intel Core i5-10500', 'Gniazdo procesora: Socket 1200, Taktowanie: 3.1 GHz, Liczba rdzeni: 6 rdzeni, Cache: 12 MB');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('549.00', 'Procesory', 'lgnch6i', 'AMD Ryzen 3 4100', 'Gniazdo procesora: Socket AM4, Taktowanie: 3.8 GHz, Liczba rdzeni: 4 rdzenie, Cache: 6 MB');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('2299.00', 'Procesory', 'azk6c8t', 'Intel Core i9-11900F', 'Gniazdo procesora: Socket 1200, Taktowanie: 2.5 GHz , Liczba rdzeni: 8 rdzeni, Cache: 16 MB');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('2529.00', 'Procesory', 'a3g6ciu', 'AMD  Ryzen 9 3900X', 'Gniazdo procesora: Socket AM4, Taktowanie: 3.8 GHz, Liczba rdzeni: 12 rdzeni, Cache: 70 MB');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('799.00', 'Procesory', '6vdtx65', 'AMD Ryzen 5 4600G', 'Gniazdo procesora: Socket AM4, Taktowanie: 3.7 GHz, Liczba rdzeni: 6 rdzeni, Cache: 11 MB');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('329.00', 'Procesory', '38g03kt', 'Intel Pentium G6405', 'Gniazdo procesora: Socket 1200, Taktowanie: 4.1 GHz, Liczba rdzeni: 2 rdzenie, Cache: 4 MB');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('299.00', 'Procesory', 'rt9p3hm', 'Intel Celeron G6900', 'Gniazdo procesora: Socket 1700, Taktowanie: 3.4 GHz, Liczba rdzeni: 2 rdzenie, Cache: 4 MB');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('419.00', 'Procesory', 'tn2zfrx', 'Intel Pentium G7400', 'Gniazdo procesora: Socket 1700, Taktowanie: 3.7 GHz, Liczba rdzeni: 2 rdzenie, Cache: 6 MB');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('2799.00', 'Procesory', 'dpqahbp', 'Intel Core i9-12900', 'Gniazdo procesora: Socket 1700, Taktowanie: 2.4 GHz, Liczba rdzeni: 16 rdzeni, Cache: 30 MB');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('999.00', 'Procesory', 'ujsuaoi', 'Intel Core i5-11500', 'Gniazdo procesora: Socket 1200, Taktowanie: 2.7 GHz , Liczba rdzeni: 6 rdzeni, Cache: 12 MB');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('1999.00', 'Procesory', '2e6kx0s', 'Intel Core i9-10900F', 'Gniazdo procesora: Socket 1200, Taktowanie: 2.8 GHz, Liczba rdzeni: 10 rdzeni, Cache: 20 MB');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('3199.00', 'Procesory', 'jipkbhm', 'Intel Core i9-10900X', 'Gniazdo procesora: Socket 2066, Taktowanie: 3.7 GHz, Liczba rdzeni: 10 rdzeni, Cache: 19.25 MB');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('759.00', 'Procesory', 'im5sngy', 'AMD Ryzen 5 Pro 2400GE OEM', 'Gniazdo procesora: Socket AM4, Taktowanie: 3.2 GHz, Liczba rdzeni: 4 rdzenie, Cache: 6 MB');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('879.00', 'Procesory', 'rz0ujd8', 'AMD Ryzen 5 Pro 4650G OEM', 'Gniazdo procesora: Socket AM4, Taktowanie: 3.7 GHz, Liczba rdzeni: 6 rdzeni, Cache: 11 MB');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('2329.00', 'Procesory', 'jp534e2', 'Intel Core i9-11900', 'Gniazdo procesora: Socket 1200, Taktowanie: 2.5 GHz , Liczba rdzeni: 8 rdzeni, Cache: 16 MB');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('1099.00', 'Procesory', 'j6orre5', 'Intel Core i5-10600', 'Gniazdo procesora: Socket 1200, Taktowanie: 3.3 GHz, Liczba rdzeni: 6 rdzeni, Cache: 12 MB');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('1149.00', 'Procesory', 'ha1f4dm', 'Intel Core i5-10600K', 'Gniazdo procesora: Socket 1200, Taktowanie: 4.1 GHz, Liczba rdzeni: 6 rdzeni, Cache: 12 MB');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('1749.00', 'Procesory', '8ycwhtk', 'Intel Core i7-10700K', 'Gniazdo procesora: Socket 1200, Taktowanie: 3.8 GHz, Liczba rdzeni: 8 rdzeni, Cache: 16 MB');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('2099.00', 'Procesory', 'o6zn7v0', 'Intel Core i9-10900', 'Gniazdo procesora: Socket 1200, Taktowanie: 2.8 GHz, Liczba rdzeni: 10 rdzeni, Cache: 20 MB');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('699.00', 'Procesory', '4vridu0', 'AMD Ryzen 5 4500', 'Gniazdo procesora: Socket AM4, Taktowanie: 3.6 GHz, Liczba rdzeni: 6 rdzeni, Cache: 11 MB');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('2699.00', 'Procesory', 'qpa7c4k', 'Intel Core i9-12900F', 'Gniazdo procesora: Socket 1700, Taktowanie: 2.4 GHz, Liczba rdzeni: 16 rdzeni, Cache: 30 MB');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('499.00', 'Procesory', 'zjpq0um', 'Intel Pentium G6605', 'Gniazdo procesora: Socket 1200, Taktowanie: 4.3 GHz, Liczba rdzeni: 2 rdzenie, Cache: 4 MB');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('5499.00', 'Procesory', '13fwur5', 'AMD Threadripper PRO 3955WX', 'Gniazdo procesora: Socket sWRX8, Taktowanie: 3.9 GHz , Liczba rdzeni: 16 rdzeni, Cache: 72 MB');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('12699.00', 'Procesory', '0zevt5o', 'AMD Threadripper PRO 3975WX', 'Gniazdo procesora: Socket sWRX8, Taktowanie: 3.5 GHz , Liczba rdzeni: 32 rdzenie, Cache: 144 MB');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('28999.00', 'Procesory', 'pi8ztnq', 'AMD Threadripper PRO 3995WX', 'Gniazdo procesora: Socket sWRX8, Taktowanie: 2.7 GHz , Liczba rdzeni: 64 rdzenie, Cache: 288 MB');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('299.00', 'Procesory', 'ic1fz0y', 'Intel Celeron G5925', 'Gniazdo procesora: Socket 1200, Taktowanie: 3.6 GHz, Liczba rdzeni: 2 rdzenie, Cache: 4 MB');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('259.00', 'Procesory', 'wk87axc', 'Intel Celeron G5900', 'Gniazdo procesora: Socket 1200, Taktowanie: 3.4 GHz, Liczba rdzeni: 2 rdzenie, Cache: 2 MB');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('799.00', 'Procesory', '4mwscer', 'Intel Core i3-10300', 'Gniazdo procesora: Socket 1200, Taktowanie: 3.7 GHz, Liczba rdzeni: 4 rdzenie, Cache: 8 MB');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('849.00', 'Procesory', '17ls97j', 'Intel Core i3-10320', 'Gniazdo procesora: Socket 1200, Taktowanie: 3.8 GHz, Liczba rdzeni: 4 rdzenie, Cache: 8 MB');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('4299.00', 'Procesory', 'br1qh7s', 'Intel Core i9-10940X', 'Gniazdo procesora: Socket 2066, Taktowanie: 3.3 GHz, Liczba rdzeni: 14 rdzeni, Cache: 19.25 MB');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('18499.00', 'Procesory', 'zoq6sgn', 'AMD Ryzen Threadripper 3990X', 'Gniazdo procesora: Socket sTRX4, Taktowanie: 2.9 GHz, Liczba rdzeni: 64 rdzenie, Cache: 288 MB');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('3799.00', 'Procesory', 'ogyshmw', 'Intel Core i9-10920X', 'Gniazdo procesora: Socket 2066, Taktowanie: 3.5 GHz, Liczba rdzeni: 12 rdzeni, Cache: 19.25 MB');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('5399.00', 'Procesory', '6lhqi9s', 'Intel Core i9-10980XE', 'Gniazdo procesora: Socket 2066, Taktowanie: 3.0 GHz, Liczba rdzeni: 18 rdzeni, Cache: 24.75 MB');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('9899.00', 'Procesory', 'gpw1dpu', 'AMD Ryzen Threadripper 3970X', 'Gniazdo procesora: Socket sTRX4, Taktowanie: 3.7 GHz, Liczba rdzeni: 32 rdzenie, Cache: 144 MB');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('7699.00', 'Procesory', '3hp32ud', 'AMD Ryzen Threadripper 3960X', 'Gniazdo procesora: Socket sTRX4, Taktowanie: 3.8 GHz, Liczba rdzeni: 24 rdzenie, Cache: 140 MB');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('3599.00', 'Procesory', '8fxu9el', 'AMD Ryzen 9 3950X', 'Gniazdo procesora: Socket AM4, Taktowanie: 3.5 GHz, Liczba rdzeni: 16 rdzeni, Cache: 72 MB');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('9899.00', 'Procesory', 'zwa2uxf', 'AMD Ryzen Threadripper 3970X', 'Gniazdo procesora: Socket sTRX4, Taktowanie: 3.7 GHz, Liczba rdzeni: 32 rdzenie, Cache: 144 MB');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('7699.00', 'Procesory', 'fsa980t', 'AMD Ryzen Threadripper 3960X', 'Gniazdo procesora: Socket sTRX4, Taktowanie: 3.8 GHz, Liczba rdzeni: 24 rdzenie, Cache: 140 MB');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('3599.00', 'Procesory', '05eo13v', 'AMD Ryzen 9 3950X', 'Gniazdo procesora: Socket AM4, Taktowanie: 3.5 GHz, Liczba rdzeni: 16 rdzeni, Cache: 72 MB');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('9899.00', 'Procesory', '9jzq3s9', 'AMD Ryzen Threadripper 3970X', 'Gniazdo procesora: Socket sTRX4, Taktowanie: 3.7 GHz, Liczba rdzeni: 32 rdzenie, Cache: 144 MB');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('7699.00', 'Procesory', 'gu6k5hq', 'AMD Ryzen Threadripper 3960X', 'Gniazdo procesora: Socket sTRX4, Taktowanie: 3.8 GHz, Liczba rdzeni: 24 rdzenie, Cache: 140 MB');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('3599.00', 'Procesory', '4v0t2pw', 'AMD Ryzen 9 3950X', 'Gniazdo procesora: Socket AM4, Taktowanie: 3.5 GHz, Liczba rdzeni: 16 rdzeni, Cache: 72 MB');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('9899.00', 'Procesory', 'zp55uu8', 'AMD Ryzen Threadripper 3970X', 'Gniazdo procesora: Socket sTRX4, Taktowanie: 3.7 GHz, Liczba rdzeni: 32 rdzenie, Cache: 144 MB');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('7699.00', 'Procesory', 'ksghlz2', 'AMD Ryzen Threadripper 3960X', 'Gniazdo procesora: Socket sTRX4, Taktowanie: 3.8 GHz, Liczba rdzeni: 24 rdzenie, Cache: 140 MB');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('3599.00', 'Procesory', 'mkk3eg0', 'AMD Ryzen 9 3950X', 'Gniazdo procesora: Socket AM4, Taktowanie: 3.5 GHz, Liczba rdzeni: 16 rdzeni, Cache: 72 MB');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('9899.00', 'Procesory', '9eyc3cg', 'AMD Ryzen Threadripper 3970X', 'Gniazdo procesora: Socket sTRX4, Taktowanie: 3.7 GHz, Liczba rdzeni: 32 rdzenie, Cache: 144 MB');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('7699.00', 'Procesory', 'ie60n0j', 'AMD Ryzen Threadripper 3960X', 'Gniazdo procesora: Socket sTRX4, Taktowanie: 3.8 GHz, Liczba rdzeni: 24 rdzenie, Cache: 140 MB');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('3599.00', 'Procesory', '56wh9a7', 'AMD Ryzen 9 3950X', 'Gniazdo procesora: Socket AM4, Taktowanie: 3.5 GHz, Liczba rdzeni: 16 rdzeni, Cache: 72 MB');

INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('2099.00', 'Karty graficzne', 'ci2tj27', 'Karta graficzna GeForce GTX 1660 Ti', 'Pamiec: 6 GB, Rodzaj pamieci: GDDR6, Zlacza: HDMI - 1 szt., DisplayPort - 3 szt.');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('2899.00', 'Karty graficzne', '4i3neww', 'Karta graficzna GeForce RTX 3060', 'Pamiec: 12 GB, Rodzaj pamieci: GDDR6, Zlacza: HDMI 2.1 - 1 szt., DisplayPort 1.4a - 3 szt.');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('4699.00', 'Karty graficzne', 'b89iwh0', 'Karta graficzna GeForce RTX 3070', 'Pamiec: 8 GB, Rodzaj pamieci: GDDR6, Zlacza: HDMI - 2 szt., DisplayPort - 2 szt.');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('3099.00', 'Karty graficzne', 'ogz3l2r', 'Karta graficzna GeForce RTX 3060', 'Pamiec: 12 GB, Rodzaj pamieci: GDDR6, Zlacza: HDMI - 1 szt., DisplayPort - 3 szt.');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('5459.00', 'Karty graficzne', 'doh5sfx', 'Karta graficzna GeForce RTX 3080', 'Pamiec: 10 GB, Rodzaj pamieci: GDDR6X, Zlacza: HDMI - 2 szt., DisplayPort - 3 szt.');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('3099.00', 'Karty graficzne', 'n96cbcn', 'Karta graficzna GeForce RTX 3060', 'Pamiec: 12 GB, Rodzaj pamieci: GDDR6, Zlacza: HDMI - 2 szt., DisplayPort - 2 szt.');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('2399.00', 'Karty graficzne', '5bvrdgn', 'Karta graficzna GeForce RTX 2060', 'Pamiec: 6 GB, Rodzaj pamieci: GDDR6, Zlacza: HDMI - 1 szt., DisplayPort - 3 szt.');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('5799.00', 'Karty graficzne', 'gzn8byy', 'Karta graficzna GeForce RTX 3080', 'Pamiec: 12 GB, Rodzaj pamieci: GDDR6X, Zlacza: HDMI 2.1 - 1 szt., DisplayPort 1.4a - 3 szt.');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('2099.00', 'Karty graficzne', 'bc280o1', 'Karta graficzna GeForce RTX 3050', 'Pamiec: 8 GB, Rodzaj pamieci: GDDR6, Zlacza: HDMI 2.1 - 1 szt., DisplayPort 1.4a - 3 szt.');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('2799.00', 'Karty graficzne', '4utvq9y', 'Karta graficzna GeForce RTX 3060', 'Pamiec: 12 GB, Rodzaj pamieci: GDDR6, Zlacza: HDMI 2.1 - 1 szt., DisplayPort 1.4a - 3 szt.');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('3599.00', 'Karty graficzne', '0dfufwu', 'Karta graficzna GeForce RTX 3060 Ti', 'Pamiec: 8 GB, Rodzaj pamieci: GDDR6, Zlacza: HDMI - 1 szt., DisplayPort - 3 szt.');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('1999.00', 'Karty graficzne', 'fdlive7', 'Karta graficzna GeForce GTX 1660 Ti', 'Pamiec: 6 GB, Rodzaj pamieci: GDDR6, Zlacza: HDMI 2.0b - 2 szt., DVI-D - 1 szt., DisplayPort 1.4a - 1 szt.');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('1089.00', 'Karty graficzne', 'y47rr0l', 'Karta graficzna GeForce GTX 1050 Ti', 'Pamiec: 4 GB, Rodzaj pamieci: GDDR5, Zlacza: HDMI - 1 szt., DVI-D - 1 szt., DisplayPort - 1 szt.');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('6399.00', 'Karty graficzne', '7debyxa', 'Karta graficzna GeForce RTX 3080', 'Pamiec: 12 GB, Rodzaj pamieci: GDDR6X, Zlacza: HDMI 2.1 - 1 szt., DisplayPort 1.4a - 3 szt.');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('1699.00', 'Karty graficzne', 'qc7whyh', 'Karta graficzna GeForce GTX 1660 Ti', 'Pamiec: 6 GB, Rodzaj pamieci: GDDR6, Zlacza: HDMI 2.0b - 2 szt., DVI-D - 1 szt., DisplayPort 1.4a - 1 szt.');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('1299.00', 'Karty graficzne', 'whm7cd7', 'Karta graficzna RadeonT RX 6500 XT', 'Pamiec: 4 GB, Rodzaj pamieci: GDDR6, Zlacza: HDMI 2.1 - 1 szt., DisplayPort 1.4a - 1 szt.');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('7499.00', 'Karty graficzne', '9qzok4f', 'Karta graficzna GeForce RTX 3080 Ti', 'Pamiec: 12 GB, Rodzaj pamieci: GDDR6X, Zlacza: HDMI - 1 szt., DisplayPort - 3 szt.');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('3349.00', 'Karty graficzne', '2we00md', 'Karta graficzna GeForce RTX 3060 Ti', 'Pamiec: 8 GB, Rodzaj pamieci: GDDR6, Zlacza: HDMI - 2 szt., DisplayPort - 2 szt.');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('7799.00', 'Karty graficzne', '0atq9uy', 'Karta graficzna GeForce RTX 3080 Ti', 'Pamiec: 12 GB, Rodzaj pamieci: GDDR6X, Zlacza: HDMI - 1 szt., DisplayPort - 3 szt.');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('3599.00', 'Karty graficzne', 'bpvnpzb', 'Karta graficzna GeForce RTX 3060 Ti', 'Pamiec: 8 GB, Rodzaj pamieci: GDDR6, Zlacza: HDMI - 2 szt., DisplayPort - 2 szt.');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('3499.00', 'Karty graficzne', 'vtup6o8', 'Karta graficzna GeForce RTX 3060', 'Pamiec: 12 GB, Rodzaj pamieci: GDDR6, Zlacza: HDMI 2.1 - 1 szt., DisplayPort 1.4a - 3 szt.');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('2599.00', 'Karty graficzne', 'xpxn45z', 'Karta graficzna GeForce RTX 2060', 'Pamiec: 6 GB, Rodzaj pamieci: GDDR6, Zlacza: HDMI - 2 szt., DVI - 1 szt., DisplayPort - 1 szt.');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('1089.00', 'Karty graficzne', 'p2ximdx', 'Karta graficzna GeForce GTX 1050 Ti', 'Pamiec: 4 GB, Rodzaj pamieci: GDDR5, Zlacza: HDMI - 1 szt., DVI - 1 szt., DisplayPort - 1 szt.');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('1849.00', 'Karty graficzne', 'h4pdth7', 'Karta graficzna GeForce GTX 1660 SUPER', 'Pamiec: 6 GB, Rodzaj pamieci: GDDR6, Zlacza: HDMI - 1 szt., DVI - 1 szt., DisplayPort - 1 szt.');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('259.00', 'Karty graficzne', 'bdb6edf', 'Karta graficzna GeForce GT 710', 'Pamiec: 2 GB, Rodzaj pamieci: DDR3, Zlacza: HDMI - 1 szt., DVI - 1 szt., VGA');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('4449.00', 'Karty graficzne', 'cutd9fl', 'Karta graficzna GeForce RTX 3070', 'Pamiec: 8 GB, Rodzaj pamieci: GDDR6, Zlacza: HDMI - 1 szt., DisplayPort - 3 szt.');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('5599.00', 'Karty graficzne', 'v6dez0v', 'Karta graficzna GeForce RTX 3080', 'Pamiec: 10 GB, Rodzaj pamieci: GDDR6X, Zlacza: HDMI - 1 szt., DisplayPort - 3 szt.');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('2499.00', 'Karty graficzne', 'x9edvoo', 'Karta graficzna RadeonT RX 6600 XT', 'Pamiec: 8 GB, Rodzaj pamieci: GDDR6, Zlacza: HDMI - 1 szt., DisplayPort - 3 szt.');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('3949.00', 'Karty graficzne', '1ellgaw', 'Karta graficzna GeForce RTX 3070 Ti', 'Pamiec: 8 GB, Rodzaj pamieci: GDDR6X, Zlacza: HDMI - 1 szt., DisplayPort - 3 szt.');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('1899.00', 'Karty graficzne', 'lwsz2tm', 'Karta graficzna GeForce GTX 1660 SUPER', 'Pamiec: 6 GB, Rodzaj pamieci: GDDR6, Zlacza: HDMI - 1 szt., DVI - 1 szt., DisplayPort - 1 szt.');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('1259.00', 'Karty graficzne', 'hden9lv', 'Karta graficzna RadeonT RX 6500 XT', 'Pamiec: 4 GB, Rodzaj pamieci: GDDR6, Zlacza: HDMI 2.1 - 1 szt., DisplayPort 1.4a - 1 szt.');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('2799.00', 'Karty graficzne', '8m95iln', 'Karta graficzna GeForce RTX 2060', 'Pamiec: 6 GB, Rodzaj pamieci: GDDR6, Zlacza: HDMI 2.0b - 1 szt., DisplayPort 1.4 - 3 szt.');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('4499.00', 'Karty graficzne', 'f72ty1m', 'Karta graficzna GeForce RTX 3070 Ti', 'Pamiec: 8 GB, Rodzaj pamieci: GDDR6X, Zlacza: HDMI - 2 szt., DisplayPort - 3 szt.');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('1079.00', 'Karty graficzne', 'pi22eyj', 'Karta graficzna RadeonT RX 6500 XT', 'Pamiec: 4 GB, Rodzaj pamieci: GDDR6, Zlacza: HDMI 2.1 - 1 szt., DisplayPort 1.4 - 1 szt.');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('5199.00', 'Karty graficzne', 'jup8pip', 'Karta graficzna GeForce RTX 3080', 'Pamiec: 10 GB, Rodzaj pamieci: GDDR6X, Zlacza: HDMI - 1 szt., DisplayPort - 3 szt.');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('4899.00', 'Karty graficzne', '6azxd33', 'Karta graficzna GeForce RTX 3070 Ti', 'Pamiec: 8 GB, Rodzaj pamieci: GDDR6X, Zlacza: HDMI - 3 szt., DisplayPort - 3 szt.');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('419.00', 'Karty graficzne', '2mr9zig', 'Karta graficzna GeForce GT 730', 'Pamiec: 2 GB, Rodzaj pamieci: GDDR5, Zlacza: HDMI - 1 szt., DVI - 1 szt., VGA');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('439.00', 'Karty graficzne', '11fc4a2', 'Karta graficzna GeForce GT 730', 'Pamiec: 2 GB, Rodzaj pamieci: GDDR5, Zlacza: HDMI 1.4b - 4 szt.');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('2899.00', 'Karty graficzne', '5mw4wmx', 'Karta graficzna RadeonT RX 6600', 'Pamiec: 8 GB, Rodzaj pamieci: GDDR6, Zlacza: HDMI 2.1 - 1 szt., DisplayPort 1.4 - 3 szt.');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('569.00', 'Karty graficzne', '2t73c9j', 'Karta graficzna GeForce GT 1030', 'Pamiec: 2 GB, Rodzaj pamieci: GDDR5, Zlacza: HDMI - 1 szt., DVI - 1 szt.');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('1799.00', 'Karty graficzne', '6c7v8ty', 'Karta graficzna GeForce RTX 3050', 'Pamiec: 8 GB, Rodzaj pamieci: GDDR6, Zlacza: HDMI 2.1 - 1 szt., DisplayPort 1.4 - 3 szt.');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('1999.00', 'Karty graficzne', '6k3ppdt', 'Karta graficzna GeForce GTX 1660 SUPER', 'Pamiec: 6 GB, Rodzaj pamieci: GDDR6, Zlacza: HDMI 2.0b - 1 szt., DVI-D - 1 szt., DisplayPort 1.4 - 1 szt.');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('5399.00', 'Karty graficzne', '4j6wixa', 'Karta graficzna GeForce RTX 3080', 'Pamiec: 10 GB, Rodzaj pamieci: GDDR6X, Zlacza: HDMI 2.1 - 1 szt., DisplayPort 1.4a - 3 szt.');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('4299.00', 'Karty graficzne', 'xc5qqf0', 'Karta graficzna GeForce RTX 3070', 'Pamiec: 8 GB, Rodzaj pamieci: GDDR6, Zlacza: HDMI - 1 szt., DisplayPort - 3 szt.');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('3999.00', 'Karty graficzne', '4ufxk75', 'Karta graficzna GeForce RTX 3070 Ti', 'Pamiec: 8 GB, Rodzaj pamieci: GDDR6X, Zlacza: HDMI 2.1 - 1 szt., DisplayPort 1.4a - 3 szt.');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('3199.00', 'Karty graficzne', 'yjq6qd0', 'Karta graficzna RadeonT RX 6600', 'Pamiec: 8 GB, Rodzaj pamieci: GDDR6, Zlacza: HDMI 2.1 - 1 szt., DisplayPort 1.4 - 3 szt.');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('859.00', 'Karty graficzne', 'c4ngid8', 'Karta graficzna GeForce GTX 1050 Ti', 'Pamiec: 4 GB, Rodzaj pamieci: GDDR5, Zlacza: HDMI 2.0b - 1 szt., DVI-D - 1 szt., DisplayPort 1.4 - 1 szt.');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('649.00', 'Karty graficzne', 'jbg4kji', 'Karta graficzna GeForce GT 1030', 'Pamiec: 2 GB, Rodzaj pamieci: GDDR5, Zlacza: HDMI - 1 szt., DVI - 1 szt.');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('1249.00', 'Karty graficzne', '0cfroyc', 'Karta graficzna GeForce GTX 1050 Ti', 'Pamiec: 4 GB, Rodzaj pamieci: GDDR5, Zlacza: HDMI - 1 szt., DVI - 1 szt., DisplayPort - 1 szt.');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('4499.00', 'Karty graficzne', '1w2fgzf', 'Karta graficzna GeForce RTX 3070 Ti', 'Pamiec: 8 GB, Rodzaj pamieci: GDDR6X, Zlacza: HDMI 2.1 - 1 szt., DisplayPort 1.4a - 3 szt.');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('1299.00', 'Karty graficzne', 'ao23ubv', 'Karta graficzna RadeonT RX 6500 XT', 'Pamiec: 4 GB, Rodzaj pamieci: GDDR6, Zlacza: HDMI 2.1 - 1 szt., DisplayPort 1.4 - 1 szt.');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('3499.00', 'Karty graficzne', 'iqjhbbu', 'Karta graficzna RadeonT RX 6700 XT', 'Pamiec: 12 GB, Rodzaj pamieci: GDDR6, Zlacza: HDMI 2.1 - 1 szt., DisplayPort 1.4 - 3 szt.');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('10299.00', 'Karty graficzne', 't04axvy', 'Karta graficzna GeForce RTX 3090', 'Pamiec: 24 GB, Rodzaj pamieci: GDDR6X, Zlacza: HDMI - 1 szt., DisplayPort - 3 szt.');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('939.00', 'Karty graficzne', 'hlncp7m', 'Karta graficzna GeForce GTX 1050 Ti', 'Pamiec: 4 GB, Rodzaj pamieci: GDDR5, Zlacza: HDMI - 1 szt., DVI - 1 szt., DisplayPort - 1 szt.');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('1649.00', 'Karty graficzne', 'gvbco3i', 'Karta graficzna GeForce GTX 1650', 'Pamiec: 4 GB, Rodzaj pamieci: GDDR6, Zlacza: HDMI - 1 szt., DVI-D - 1 szt., DisplayPort - 1 szt.');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('9999.00', 'Karty graficzne', 'xob1ix2', 'Karta graficzna GeForce RTX 3090', 'Pamiec: 24 GB, Rodzaj pamieci: GDDR6X, Zlacza: HDMI - 2 szt., DisplayPort - 3 szt.');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('1799.00', 'Karty graficzne', 'v7jnwsg', 'Karta graficzna GeForce GTX 1660', 'Pamiec: 6 GB, Rodzaj pamieci: GDDR5, Zlacza: HDMI - 1 szt., DisplayPort - 3 szt.');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('5299.00', 'Karty graficzne', 'x9etdr3', 'Karta graficzna RadeonT RX 6800 XT', 'Pamiec: 16 GB, Rodzaj pamieci: GDDR6, Zlacza: HDMI 2.1 - 1 szt., DisplayPort 1.4 - 3 szt.');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('2099.00', 'Karty graficzne', 'cnzeeib', 'Karta graficzna GeForce RTX 3050', 'Pamiec: 8 GB, Rodzaj pamieci: GDDR6, Zlacza: HDMI 2.1 - 1 szt., DisplayPort 1.4a - 3 szt.');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('4299.00', 'Karty graficzne', '5hfwjl6', 'Karta graficzna GeForce RTX 3070', 'Pamiec: 8 GB, Rodzaj pamieci: GDDR6, Zlacza: HDMI 2.1 - 2 szt., DisplayPort 1.4a - 3 szt.');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('6899.00', 'Karty graficzne', 'u3jo98v', 'Karta graficzna GeForce RTX 3080', 'Pamiec: 10 GB, Rodzaj pamieci: GDDR6X, Zlacza: HDMI 2.1 - 1 szt., DisplayPort 1.4a - 3 szt.');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('6599.00', 'Karty graficzne', 'pez3oft', 'Karta graficzna GeForce RTX 3080 Ti', 'Pamiec: 12 GB, Rodzaj pamieci: GDDR6X, Zlacza: HDMI 2.1 - 1 szt., DisplayPort 1.4a - 3 szt.');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('4999.00', 'Karty graficzne', 'x7skkqu', 'Karta graficzna GeForce RTX 3070', 'Pamiec: 8 GB, Rodzaj pamieci: GDDR6, Zlacza: HDMI - 3 szt., DisplayPort - 3 szt.');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('3199.00', 'Karty graficzne', 'blvdoz2', 'Karta graficzna GeForce RTX 3060', 'Pamiec: 12 GB, Rodzaj pamieci: GDDR6, Zlacza: HDMI - 1 szt., DisplayPort - 3 szt.');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('2899.00', 'Karty graficzne', 'ye1mhlc', 'Karta graficzna GeForce RTX 3060', 'Pamiec: 12 GB, Rodzaj pamieci: GDDR6, Zlacza: HDMI - 1 szt., DisplayPort - 3 szt.');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('2099.00', 'Karty graficzne', 'f6ffuhx', 'Karta graficzna GeForce RTX 3050', 'Pamiec: 8 GB, Rodzaj pamieci: GDDR6, Zlacza: HDMI 2.1 - 1 szt., DisplayPort 1.4a - 3 szt.');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('6699.00', 'Karty graficzne', 'jam1dsg', 'Karta graficzna GeForce RTX 3080', 'Pamiec: 12 GB, Rodzaj pamieci: GDDR6X, Zlacza: HDMI 2.1 - 1 szt., DisplayPort 1.4a - 3 szt.');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('1649.00', 'Karty graficzne', 'kxm05lt', 'Karta graficzna GeForce GTX 1650', 'Pamiec: 4 GB, Rodzaj pamieci: GDDR5, Zlacza: HDMI - 1 szt., DVI-D - 1 szt., DisplayPort - 1 szt.');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('5999.00', 'Karty graficzne', 'qykth51', 'Karta graficzna Quadro RTX 4000', 'Pamiec: 8 GB, Rodzaj pamieci: GDDR6, Zlacza: DisplayPort - 3 szt., USB Typu-C');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('399.00', 'Karty graficzne', 'a0pg5rr', 'Karta graficzna GeForce GT 730', 'Pamiec: 2 GB, Rodzaj pamieci: DDR3, Zlacza: HDMI - 1 szt., DVI - 1 szt., VGA');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('499.00', 'Karty graficzne', 'bne1j83', 'Karta graficzna GeForce GT 1030', 'Pamiec: 2 GB, Rodzaj pamieci: GDDR5, Zlacza: HDMI - 1 szt., DVI - 1 szt.');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('899.00', 'Karty graficzne', 'kjnlgun', 'Karta graficzna RadeonT RX 6400', 'Pamiec: 4 GB, Rodzaj pamieci: GDDR6, Zlacza: HDMI 2.1 - 1 szt., DisplayPort 1.4 - 1 szt.');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('2499.00', 'Karty graficzne', 'qnnmatz', 'Karta graficzna RadeonT RX 6650 XT', 'Pamiec: 8 GB, Rodzaj pamieci: GDDR6, Zlacza: HDMI 2.1 - 1 szt., DisplayPort 1.4a - 3 szt.');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('4199.00', 'Karty graficzne', 'h5wmm7j', 'Karta graficzna GeForce RTX 3070 Ti', 'Pamiec: 8 GB, Rodzaj pamieci: GDDR6X, Zlacza: HDMI 2.1 - 1 szt., DisplayPort 1.4 - 3 szt.');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('1099.00', 'Karty graficzne', 'b7tjazj', 'Karta graficzna Quadro T400', 'Pamiec: 4 GB, Rodzaj pamieci: GDDR6, Zlacza: mini DisplayPort - 3 szt.');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('419.00', 'Karty graficzne', 'khjvn1f', 'Karta graficzna GeForce GT 730', 'Pamiec: 2 GB, Rodzaj pamieci: DDR3, Zlacza: HDMI - 1 szt., DVI-D - 1 szt., VGA');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('3889.00', 'Karty graficzne', 'o7iakmt', 'Karta graficzna RadeonT RX 6600 XT', 'Pamiec: 8 GB, Rodzaj pamieci: GDDR6, Zlacza: HDMI - 2 szt., DisplayPort - 2 szt.');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('1429.00', 'Karty graficzne', 'vb54835', 'Karta graficzna Quadro T600', 'Pamiec: 4 GB, Rodzaj pamieci: GDDR6, Zlacza: mini DisplayPort - 4 szt.');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('7899.00', 'Karty graficzne', 'ssn7atj', 'Karta graficzna Quadro A4000', 'Pamiec: 16 GB, Rodzaj pamieci: GDDR6, Zlacza: DisplayPort - 4 szt.');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('2169.00', 'Karty graficzne', 'n5bg5eg', 'Karta graficzna Quadro T1000', 'Pamiec: 4 GB, Rodzaj pamieci: GDDR6, Zlacza: mini DisplayPort - 4 szt.');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('3199.00', 'Karty graficzne', 'fe1w3t3', 'Karta graficzna GeForce RTX 3060', 'Pamiec: 12 GB, Rodzaj pamieci: GDDR6, Zlacza: HDMI - 2 szt., DisplayPort - 2 szt.');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('2999.00', 'Karty graficzne', '8olbtzq', 'Karta graficzna GeForce RTX 3060', 'Pamiec: 12 GB, Rodzaj pamieci: GDDR6, Zlacza: HDMI - 2 szt., DisplayPort - 2 szt.');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('679.00', 'Karty graficzne', '5ypd7o2', 'Karta graficzna GeForce GT 1030', 'Pamiec: 2 GB, Rodzaj pamieci: GDDR5, Zlacza: HDMI - 1 szt., DisplayPort - 1 szt.');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('529.00', 'Karty graficzne', 'z6ymh7b', 'Karta graficzna GeForce GT 1030', 'Pamiec: 2 GB, Rodzaj pamieci: DDR4, Zlacza: HDMI - 1 szt., DisplayPort - 1 szt.');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('539.00', 'Karty graficzne', 'cg5pimp', 'Karta graficzna GeForce GT 730', 'Pamiec: 4 GB, Rodzaj pamieci: DDR3, Zlacza: HDMI - 1 szt., DVI - 1 szt., VGA');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('499.00', 'Karty graficzne', '8dhfjcv', 'Karta graficzna GeForce GT 1030', 'Pamiec: 2 GB, Rodzaj pamieci: DDR4, Zlacza: HDMI - 1 szt., DVI - 1 szt.');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('799.00', 'Karty graficzne', 'db6r43t', 'Karta graficzna RadeonT Pro WX 2100', 'Pamiec: 2 GB, Rodzaj pamieci: GDDR5, Zlacza: DisplayPort - 1 szt., mini DisplayPort - 2 szt.');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('579.00', 'Karty graficzne', 'fwc91pp', 'Karta graficzna GeForce GT 1030', 'Pamiec: 2 GB, Rodzaj pamieci: GDDR5, Zlacza: HDMI - 1 szt., DVI - 1 szt.');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('1849.00', 'Karty graficzne', 'jcjuw25', 'Karta graficzna GeForce RTX 3050', 'Pamiec: 8 GB, Rodzaj pamieci: GDDR6, Zlacza: HDMI 2.1 - 1 szt., DisplayPort 1.4a - 3 szt.');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('6799.00', 'Karty graficzne', 'iqvlna7', 'Karta graficzna GeForce RTX 3080', 'Pamiec: 12 GB, Rodzaj pamieci: GDDR6X, Zlacza: HDMI 2.1 - 1 szt., DisplayPort 1.4a - 3 szt.');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('8999.00', 'Karty graficzne', 'vh8xmfw', 'Karta graficzna GeForce RTX 3080', 'Pamiec: 12 GB, Rodzaj pamieci: GDDR6X, Zlacza: HDMI 2.1 - 2 szt., DisplayPort 1.4a - 3 szt.');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('799.00', 'Karty graficzne', '446odr7', 'Karta graficzna Quadro T400', 'Pamiec: 2 GB, Rodzaj pamieci: GDDR6, Zlacza: mini DisplayPort - 3 szt.');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('5399.00', 'Karty graficzne', 't2rr80y', 'Karta graficzna GeForce RTX 3070', 'Pamiec: 8 GB, Rodzaj pamieci: GDDR6, Zlacza: HDMI - 2 szt., DisplayPort - 3 szt.');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('3899.00', 'Karty graficzne', 'b8uxk16', 'Karta graficzna RadeonT Pro W6600', 'Pamiec: 8 GB, Rodzaj pamieci: GDDR6, Zlacza: DisplayPort - 4 szt.');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('2699.00', 'Karty graficzne', 'vjfq3wu', 'Karta graficzna GeForce RTX 3060', 'Pamiec: 12 GB, Rodzaj pamieci: GDDR6, Zlacza: HDMI - 1 szt., DisplayPort - 3 szt.');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('3799.00', 'Karty graficzne', 'oflnj4p', 'Karta graficzna RadeonT RX 6750 XT', 'Pamiec: 12 GB, Rodzaj pamieci: GDDR6, Zlacza: HDMI 2.1 - 1 szt., DisplayPort 1.4a - 3 szt.');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('4199.00', 'Karty graficzne', 'ingsj9y', 'Karta graficzna GeForce RTX 3070 Ti', 'Pamiec: 8 GB, Rodzaj pamieci: GDDR6X, Zlacza: HDMI 2.1 - 1 szt., DisplayPort 1.4 - 3 szt.');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('1019.00', 'Karty graficzne', 'ye4pait', 'Karta graficzna RadeonT RX 6400', 'Pamiec: 4 GB, Rodzaj pamieci: GDDR6, Zlacza: HDMI 2.1 - 1 szt., DisplayPort 1.4 - 1 szt.');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('439.00', 'Karty graficzne', 'kmabo1i', 'Karta graficzna GeForce GT 730', 'Pamiec: 2 GB, Rodzaj pamieci: GDDR5, Zlacza: HDMI - 1 szt., DVI-I - 1 szt');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('429.00', 'Karty graficzne', 'u19l6lf', 'Karta graficzna GeForce GT 730', 'Pamiec: 2 GB, Rodzaj pamieci: DDR3, Zlacza: HDMI - 1 szt., DVI-D - 1 szt., VGA');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('6999.00', 'Karty graficzne', 'wgexgi3', 'Karta graficzna GeForce RTX 3080', 'Pamiec: 12 GB, Rodzaj pamieci: GDDR6X, Zlacza: HDMI 2.1 - 1 szt., DisplayPort 1.4a - 3 szt.');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('359.00', 'Karty graficzne', 'uoeb3g7', 'Karta graficzna GeForce GT 730', 'Pamiec: 2 GB, Rodzaj pamieci: DDR3, Zlacza: HDMI - 1 szt., DVI-D - 1 szt., VGA');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('11599.00', 'Karty graficzne', 'fla2nbe', 'Karta graficzna GeForce RTX 3090 Ti', 'Pamiec: 24 GB, Rodzaj pamieci: GDDR6X, Zlacza: HDMI 2.1 - 1 szt., DisplayPort 1.4a - 3 szt.');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('6999.00', 'Karty graficzne', '3ll6cgy', 'Karta graficzna GeForce RTX 3080', 'Pamiec: 12 GB, Rodzaj pamieci: GDDR6X, Zlacza: HDMI 2.1 - 2 szt., DisplayPort 1.4a - 3 szt.');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('2299.00', 'Karty graficzne', 'xhgnxtc', 'Karta graficzna RadeonT RX 6600', 'Pamiec: 8 GB, Rodzaj pamieci: GDDR6, Zlacza: HDMI 2.1 - 2 szt., DisplayPort 1.4 - 2 szt.');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('6899.00', 'Karty graficzne', '9z35a11', 'Karta graficzna GeForce RTX 3080', 'Pamiec: 10 GB, Rodzaj pamieci: GDDR6X, Zlacza: HDMI - 1 szt., DisplayPort - 3 szt.');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('8629.00', 'Karty graficzne', '96awtlo', 'Karta graficzna RadeonT RX 6900 XT', 'Pamiec: 16 GB, Rodzaj pamieci: GDDR6, Zlacza: HDMI - 1 szt., DisplayPort - 3 szt.');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('3099.00', 'Karty graficzne', 'o8uska4', 'Karta graficzna GeForce RTX 3060', 'Pamiec: 12 GB, Rodzaj pamieci: GDDR6, Zlacza: HDMI - 1 szt., DisplayPort - 3 szt.');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('4099.00', 'Karty graficzne', '633dbe7', 'Karta graficzna GeForce RTX 3060', 'Pamiec: 12 GB, Rodzaj pamieci: GDDR6, Zlacza: HDMI - 1 szt., DisplayPort - 3 szt.');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('1999.00', 'Karty graficzne', 'g9xex5g', 'Karta graficzna Quadro P1000', 'Pamiec: 4 GB, Rodzaj pamieci: GDDR5, Zlacza: mini DisplayPort - 4 szt.');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('4349.00', 'Karty graficzne', 'wh7nko5', 'Karta graficzna GeForce RTX 3070', 'Pamiec: 8 GB, Rodzaj pamieci: GDDR6, Zlacza: HDMI - 1 szt., DisplayPort - 3 szt.');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('13159.00', 'Karty graficzne', 'pkis6ji', 'Karta graficzna GeForce RTX 3090', 'Pamiec: 24 GB, Rodzaj pamieci: GDDR6X, Zlacza: HDMI - 1 szt., DisplayPort - 3 szt.');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('5059.00', 'Karty graficzne', 'jv6msid', 'Karta graficzna RadeonT Pro WX 8200', 'Pamiec: 8 GB, Rodzaj pamieci: HBM2, Zlacza: mini DisplayPort - 4 szt.');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('2699.00', 'Karty graficzne', '7a19w42', 'Karta graficzna GeForce RTX 2060', 'Pamiec: 6 GB, Rodzaj pamieci: GDDR6, Zlacza: HDMI - 2 szt., DVI - 1 szt., DisplayPort - 1 szt.');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('1129.00', 'Karty graficzne', '8nr7rh3', 'Karta graficzna RadeonT Pro WX 3200', 'Pamiec: 4 GB, Rodzaj pamieci: GDDR5, Zlacza: mini DisplayPort - 4 szt.');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('1899.00', 'Karty graficzne', '1xeav0p', 'Karta graficzna GeForce GTX 1660 Ti', 'Pamiec: 6 GB, Rodzaj pamieci: GDDR6, Zlacza: HDMI - 1 szt., DVI - 1 szt., DisplayPort - 1 szt.');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('3849.00', 'Karty graficzne', 'rtug5x7', 'Karta graficzna RadeonT RX 6750 XT', 'Pamiec: 12 GB, Rodzaj pamieci: GDDR6, Zlacza: HDMI 2.1 - 1 szt., DisplayPort 1.4a - 3 szt.');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('3749.00', 'Karty graficzne', 'm23ewdz', 'Karta graficzna RadeonT RX 6750 XT', 'Pamiec: 12 GB, Rodzaj pamieci: GDDR6, Zlacza: HDMI 2.1 - 1 szt., DisplayPort 1.4a - 3 szt.');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('2699.00', 'Karty graficzne', 'hfpxvds', 'Karta graficzna RadeonT RX 6650 XT', 'Pamiec: 8 GB, Rodzaj pamieci: GDDR6, Zlacza: HDMI 2.1 - 1 szt., DisplayPort 1.4a - 3 szt.');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('2499.00', 'Karty graficzne', '82wnbqt', 'Karta graficzna RadeonT RX 6650 XT', 'Pamiec: 8 GB, Rodzaj pamieci: GDDR6, Zlacza: HDMI 2.1 - 1 szt., DisplayPort 1.4a - 3 szt.');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('4099.00', 'Karty graficzne', '92m7ixp', 'Karta graficzna RadeonT RX 6750 XT', 'Pamiec: 12 GB, Rodzaj pamieci: GDDR6, Zlacza: HDMI 2.1 - 1 szt., DisplayPort 1.4a - 3 szt.');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('2699.00', 'Karty graficzne', 'rg22f5v', 'Karta graficzna RadeonT RX 6650 XT', 'Pamiec: 8 GB, Rodzaj pamieci: GDDR6, Zlacza: HDMI 2.1 - 1 szt., DisplayPort 1.4a - 3 szt.');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('8899.00', 'Karty graficzne', 'wz26dcs', 'Karta graficzna RadeonT RX 6950 XT', 'Pamiec: 16 GB, Rodzaj pamieci: GDDR6, Zlacza: HDMI 2.1 - 1 szt., DisplayPort 1.4a - 3 szt.');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('2719.00', 'Karty graficzne', 'rzma78u', 'Karta graficzna RadeonT RX 6650 XT', 'Pamiec: 8 GB, Rodzaj pamieci: GDDR6, Zlacza: HDMI 2.1 - 2 szt., DisplayPort 1.4a - 2 szt.');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('3759.00', 'Karty graficzne', '3943hnn', 'Karta graficzna RadeonT RX 6750 XT', 'Pamiec: 12 GB, Rodzaj pamieci: GDDR6, Zlacza: HDMI 2.1 - 2 szt., DisplayPort 1.4a - 2 szt.');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('3899.00', 'Karty graficzne', 'apinqk1', 'Karta graficzna RadeonT RX 6750 XT', 'Pamiec: 12 GB, Rodzaj pamieci: GDDR6, Zlacza: HDMI 2.1 - 2 szt., DisplayPort 1.4a - 2 szt.');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('8599.00', 'Karty graficzne', '0x7pi7l', 'Karta graficzna RadeonT RX 6950 XT', 'Pamiec: 16 GB, Rodzaj pamieci: GDDR6, Zlacza: HDMI 2.1 - 2 szt., DisplayPort 1.4a - 2 szt.');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('11999.00', 'Karty graficzne', 'b6s8naq', 'Karta graficzna GeForce RTX 3090 Ti', 'Pamiec: 24 GB, Rodzaj pamieci: GDDR6X, Zlacza: HDMI 2.1 - 1 szt., DisplayPort 1.4a - 3 szt.');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('5199.00', 'Karty graficzne', 'ba6m16y', 'Karta graficzna GeForce RTX 3080', 'Pamiec: 10 GB, Rodzaj pamieci: GDDR6X, Zlacza: HDMI 2.1 - 1 szt., DisplayPort 1.4a - 3 szt.');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('2839.00', 'Karty graficzne', 'h999rhv', 'Karta graficzna RadeonT RX 6650 XT', 'Pamiec: 8 GB, Rodzaj pamieci: GDDR6, Zlacza: HDMI 2.1 - 1 szt., DisplayPort 1.4a - 3 szt.');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('4149.00', 'Karty graficzne', 'jtrx33r', 'Karta graficzna RadeonT RX 6750 XT', 'Pamiec: 12 GB, Rodzaj pamieci: GDDR6, Zlacza: HDMI 2.1 - 1 szt., DisplayPort 1.4a - 3 szt.');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('4429.00', 'Karty graficzne', 'bqvxaj1', 'Karta graficzna RadeonT RX 6750 XT', 'Pamiec: 12 GB, Rodzaj pamieci: GDDR6, Zlacza: HDMI 2.1 - 1 szt., DisplayPort 1.4a - 3 szt.');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('999.00', 'Karty graficzne', 'dk64m89', 'Karta graficzna RadeonT RX 6400', 'Pamiec: 4 GB, Rodzaj pamieci: GDDR6, Zlacza: HDMI 2.1 - 1 szt., DisplayPort 1.4 - 1 szt.');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('10749.00', 'Karty graficzne', 'omb1ob3', 'Karta graficzna GeForce RTX 3090 Ti', 'Pamiec: 24 GB, Rodzaj pamieci: GDDR6X, Zlacza: HDMI 2.1 - 1 szt., DisplayPort 1.4a - 3 szt.');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('10999.00', 'Karty graficzne', 'z8q2zz2', 'Karta graficzna GeForce RTX 3090 Ti', 'Pamiec: 24 GB, Rodzaj pamieci: GDDR6X, Zlacza: HDMI 2.1 - 1 szt., DisplayPort 1.4a - 3 szt.');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('12199.00', 'Karty graficzne', 'lakuh90', 'Karta graficzna GeForce RTX 3090 Ti', 'Pamiec: 24 GB, Rodzaj pamieci: GDDR6X, Zlacza: HDMI 2.1 - 2 szt., DisplayPort 1.4a - 3 szt.');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('12399.00', 'Karty graficzne', 'ukyzw9e', 'Karta graficzna GeForce RTX 3090 Ti', 'Pamiec: 24 GB, Rodzaj pamieci: GDDR6X, Zlacza: HDMI 2.1 - 2 szt., DisplayPort 1.4a - 3 szt.');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('11399.00', 'Karty graficzne', 'xdefjx5', 'Karta graficzna GeForce RTX 3090 Ti', 'Pamiec: 24 GB, Rodzaj pamieci: GDDR6X, Zlacza: HDMI 2.1 - 1 szt., DisplayPort 1.4a - 3 szt.');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('4299.00', 'Karty graficzne', 'hq8o2zm', 'Karta graficzna Quadro RTX A2000', 'Pamiec: 12 GB, Rodzaj pamieci: GDDR6, Zlacza: mini DisplayPort - 4 szt.');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('7399.00', 'Karty graficzne', 'se7lt92', 'Karta graficzna GeForce RTX 3080', 'Pamiec: 12 GB, Rodzaj pamieci: GDDR6X, Zlacza: HDMI 2.1 - 2 szt., DisplayPort 1.4a - 3 szt.');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('7999.00', 'Karty graficzne', 'juje005', 'Karta graficzna GeForce RTX 3080', 'Pamiec: 12 GB, Rodzaj pamieci: GDDR6X, Zlacza: HDMI 2.1 - 1 szt., DisplayPort 1.4a - 3 szt.');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('7999.00', 'Karty graficzne', 'bma3dxb', 'Karta graficzna GeForce RTX 3080', 'Pamiec: 12 GB, Rodzaj pamieci: GDDR6X, Zlacza: HDMI 2.1 - 1 szt., DisplayPort 1.4a - 3 szt.');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('7999.00', 'Karty graficzne', '4mvpc7e', 'Karta graficzna GeForce RTX 3080', 'Pamiec: 12 GB, Rodzaj pamieci: GDDR6X, Zlacza: HDMI 2.1 - 1 szt., DisplayPort 1.4a - 3 szt.');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('5099.00', 'Karty graficzne', 'umgqiwb', 'Karta graficzna GeForce RTX 3080', 'Pamiec: 12 GB, Rodzaj pamieci: GDDR6X, Zlacza: HDMI 2.1 - 1 szt., DisplayPort 1.4a - 3 szt.');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('2049.00', 'Karty graficzne', 'f2oc0mo', 'Karta graficzna GeForce RTX 3050', 'Pamiec: 8 GB, Rodzaj pamieci: GDDR6, Zlacza: HDMI 2.1 - 1 szt., DisplayPort 1.4a - 3 szt.');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('1299.00', 'Karty graficzne', 's6akyaf', 'Karta graficzna RadeonT RX 6500 XT', 'Pamiec: 4 GB, Rodzaj pamieci: GDDR6, Zlacza: HDMI 2.1 - 1 szt., DisplayPort 1.4a - 1 szt.');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('11299.00', 'Karty graficzne', 'd7vyblz', 'Karta graficzna GeForce RTX 3090 Ti', 'Pamiec: 24 GB, Rodzaj pamieci: GDDR6X, Zlacza: HDMI 2.1 - 1 szt., DisplayPort 1.4a - 3 szt.');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('11499.00', 'Karty graficzne', '3k6rcwz', 'Karta graficzna GeForce RTX 3090 Ti', 'Pamiec: 24 GB, Rodzaj pamieci: GDDR6X, Zlacza: HDMI 2.1 - 1 szt., DisplayPort 1.4a - 3 szt.');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('3499.00', 'Karty graficzne', 'icx1m36', 'Karta graficzna Quadro RTX A2000', 'Pamiec: 6 GB, Rodzaj pamieci: GDDR6, Zlacza: mini DisplayPort - 4 szt.');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('8299.00', 'Karty graficzne', 'uv1elxk', 'Karta graficzna GeForce RTX 3080', 'Pamiec: 10 GB, Rodzaj pamieci: GDDR6X, Zlacza: HDMI 2.1 - 2 szt., DisplayPort 1.4a - 3 szt.');

INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('579.00', 'Plyty glówne', 'ptgbgzg', 'Gigabyte B660M DS3H DDR4', 'Obslugiwane procesory: Intel Core i9, Intel Core i7, Intel Core i5, Intel Core i3, Intel Celeron, Intel Pentium, Format: mATX, Gniazdo procesora: Socket 1700, Chipset: Intel B660');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('389.00', 'Plyty glówne', 'ebiztyx', 'Gigabyte B560M DS3H V2', 'Obslugiwane procesory: Intel Core i9, Intel Core i7, Intel Core i5, Intel Core i3, Intel Celeron, Intel Pentium, Format: mATX, Gniazdo procesora: Socket 1200, Chipset: Intel B560');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('1119.00', 'Plyty glówne', '1zffz62', 'Gigabyte Z690 GAMING X DDR4', 'Obslugiwane procesory: Intel Core i9, Intel Core i7, Intel Core i5, Intel Core i3, Intel Celeron, Intel Pentium, Format: ATX, Gniazdo procesora: Socket 1700, Chipset: Intel Z690');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('569.00', 'Plyty glówne', '4r7r2kh', 'Gigabyte B550 GAMING X V2 ', 'Obslugiwane procesory: AMD RyzenT, Format: ATX, Gniazdo procesora: Socket AM4, Chipset: AMD B550');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('1199.00', 'Plyty glówne', 'cyxyxet', 'MSI MPG Z590 GAMING PLUS', 'Obslugiwane procesory: Intel Core i9, Intel Core i7, Intel Core i5, Intel Core i3, Intel Celeron, Intel Pentium, Format: ATX, Gniazdo procesora: Socket 1200, Chipset: Intel Z590');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('279.00', 'Plyty glówne', 'opmq9rh', 'Gigabyte H410M H V3 ', 'Obslugiwane procesory: Intel Core i9, Intel Core i7, Intel Core i5, Intel Core i3, Intel Celeron, Intel Pentium, Format: mATX, Gniazdo procesora: Socket 1200, Chipset: Intel H510');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('799.00', 'Plyty glówne', 'cnl9rgx', 'Gigabyte B660 GAMING X DDR4', 'Obslugiwane procesory: Intel Core i9, Intel Core i7, Intel Core i5, Intel Core i3, Intel Celeron, Intel Pentium, Format: ATX, Gniazdo procesora: Socket 1700, Chipset: Intel B660');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('589.00', 'Plyty glówne', '8t3ilrw', 'MSI MAG Z490 TOMAHAWK', 'Obslugiwane procesory: Intel Core i9, Intel Core i7, Intel Core i5, Intel Core i3, Intel Celeron, Intel Pentium, Format: ATX, Gniazdo procesora: Socket 1200, Chipset: Intel Z490');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('429.00', 'Plyty glówne', 'cjtoo0c', 'MSI B450 TOMAHAWK MAX II', 'Obslugiwane procesory: AMD RyzenT, Format: ATX, Gniazdo procesora: Socket AM4, Chipset: AMD B450');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('719.00', 'Plyty glówne', 'nub7uel', 'Gigabyte Z590 GAMING X', 'Obslugiwane procesory: Intel Core i9, Intel Core i7, Intel Core i5, Intel Core i3, Intel Celeron, Intel Pentium, Format: ATX, Gniazdo procesora: Socket 1200, Chipset: Intel Z590');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('349.00', 'Plyty glówne', 'k4y2ou2', 'Gigabyte H510M H', 'Obslugiwane procesory: Intel Core i9, Intel Core i7, Intel Core i5, Intel Core i3, Intel Celeron, Intel Pentium, Format: mATX, Gniazdo procesora: Socket 1200, Chipset: Intel H510');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('1099.00', 'Plyty glówne', 'eutjetf', 'MSI PRO Z690-A DDR4', 'Obslugiwane procesory: Intel Core i9, Intel Core i7, Intel Core i5, Intel Core i3, Intel Celeron, Intel Pentium, Format: ATX, Gniazdo procesora: Socket 1700, Chipset: Intel Z690');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('429.00', 'Plyty glówne', 'e6plx7m', 'Gigabyte B450 AORUS PRO', 'Obslugiwane procesory: AMD RyzenT, Format: ATX, Gniazdo procesora: Socket AM4, Chipset: AMD B450');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('699.00', 'Plyty glówne', 'f3btrfy', 'Gigabyte B660 DS3H DDR4', 'Obslugiwane procesory: Intel Core i9, Intel Core i7, Intel Core i5, Intel Core i3, Intel Celeron, Intel Pentium, Format: ATX, Gniazdo procesora: Socket 1700, Chipset: Intel B660');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('779.00', 'Plyty glówne', '3kb8blw', 'ASUS TUF GAMING B550-PLUS', 'Obslugiwane procesory: AMD RyzenT, Format: ATX, Gniazdo procesora: Socket AM4, Chipset: AMD B550');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('699.00', 'Plyty glówne', '1dr7858', 'ASUS PRIME B660-PLUS DDR4', 'Obslugiwane procesory: Intel Core i9, Intel Core i7, Intel Core i5, Intel Core i3, Intel Celeron, Intel Pentium, Format: ATX, Gniazdo procesora: Socket 1700, Chipset: Intel B660');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('519.00', 'Plyty glówne', 'y0fkq7i', 'Gigabyte B560 HD3', 'Obslugiwane procesory: Intel Core i9, Intel Core i7, Intel Core i5, Intel Core i3, Intel Celeron, Intel Pentium, Format: ATX, Gniazdo procesora: Socket 1200, Chipset: Intel B560');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('489.00', 'Plyty glówne', 'zvu8h0f', 'MSI B560M-A PRO', 'Obslugiwane procesory: Intel Core i9, Intel Core i7, Intel Core i5, Intel Core i3, Intel Celeron, Intel Pentium, Format: mATX, Gniazdo procesora: Socket 1200, Chipset: Intel B560');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('579.00', 'Plyty glówne', 'awh8ocm', 'MSI MAG B560M BAZOOKA', 'Obslugiwane procesory: Intel Core i9, Intel Core i7, Intel Core i5, Intel Core i3, Intel Celeron, Intel Pentium, Format: mATX, Gniazdo procesora: Socket 1200, Chipset: Intel B560');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('1599.00', 'Plyty glówne', 'jsmchso', 'ASUS TUF GAMING Z690-PLUS DDR4', 'Obslugiwane procesory: Intel Core i9, Intel Core i7, Intel Core i5, Intel Core i3, Intel Celeron, Intel Pentium, Format: ATX, Gniazdo procesora: Socket 1700, Chipset: Intel Z690');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('619.00', 'Plyty glówne', '39pzcoq', 'ASUS PRIME B560-PLUS', 'Obslugiwane procesory: Intel Core i9, Intel Core i7, Intel Core i5, Intel Core i3, Intel Celeron, Intel Pentium, Format: ATX, Gniazdo procesora: Socket 1200, Chipset: Intel B560');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('959.00', 'Plyty glówne', '47jbiqd', 'ASUS PRIME Z590-P', 'Obslugiwane procesory: Intel Core i9, Intel Core i7, Intel Core i5, Intel Core i3, Intel Celeron, Intel Pentium, Format: ATX, Gniazdo procesora: Socket 1200, Chipset: Intel Z590');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('369.00', 'Plyty glówne', 'zqa5mrz', 'MSI B450M-A PRO MAX', 'Obslugiwane procesory: AMD RyzenT, Format: mATX, Gniazdo procesora: Socket AM4, Chipset: AMD B450');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('779.00', 'Plyty glówne', 'qj0s3vp', 'ASUS PRIME B660M-A DDR4', 'Obslugiwane procesory: Intel Core i9, Intel Core i7, Intel Core i5, Intel Core i3, Intel Celeron, Intel Pentium, Format: mATX, Gniazdo procesora: Socket 1700, Chipset: Intel B660');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('1559.00', 'Plyty glówne', 'q3iio47', 'MSI MAG Z690 TOMAHAWK WIFI DDR4', 'Obslugiwane procesory: Intel Core i9, Intel Core i7, Intel Core i5, Intel Core i3, Intel Celeron, Intel Pentium, Format: ATX, Gniazdo procesora: Socket 1700, Chipset: Intel Z690');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('639.00', 'Plyty glówne', 'xfhfuyg', 'Gigabyte B560M AORUS ELITE', 'Obslugiwane procesory: Intel Core i9, Intel Core i7, Intel Core i5, Intel Core i3, Intel Celeron, Intel Pentium, Format: mATX, Gniazdo procesora: Socket 1200, Chipset: Intel B560');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('1199.00', 'Plyty glówne', 'z96fviu', 'ASUS PRIME Z690-P DDR4', 'Obslugiwane procesory: Intel Core i9, Intel Core i7, Intel Core i5, Intel Core i3, Intel Celeron, Intel Pentium, Format: ATX, Gniazdo procesora: Socket 1700, Chipset: Intel Z690');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('699.00', 'Plyty glówne', 'cli5ayl', 'MSI PRO B660M-A DDR4', 'Obslugiwane procesory: Intel Core i9, Intel Core i7, Intel Core i5, Intel Core i3, Intel Celeron, Intel Pentium, Format: mATX, Gniazdo procesora: Socket 1700, Chipset: Intel B660');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('499.00', 'Plyty glówne', 'yphj4bm', 'Gigabyte H610M S2H DDR4', 'Obslugiwane procesory: Intel Core i9, Intel Core i7, Intel Core i5, Intel Core i3, Intel Celeron, Intel Pentium, Format: mATX, Gniazdo procesora: Socket 1700, Chipset: Intel H610');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('1149.00', 'Plyty glówne', 'db35wgb', 'Gigabyte Z690 UD DDR4', 'Obslugiwane procesory: Intel Core i9, Intel Core i7, Intel Core i5, Intel Core i3, Intel Celeron, Intel Pentium, Format: ATX, Gniazdo procesora: Socket 1700, Chipset: Intel Z690');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('849.00', 'Plyty glówne', 'k4y34s1', 'Gigabyte B550 AORUS PRO V2', 'Obslugiwane procesory: AMD RyzenT, Format: ATX, Gniazdo procesora: Socket AM4, Chipset: AMD B550');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('719.00', 'Plyty glówne', 'kdmgm5o', 'Gigabyte Z590 UD AC', 'Obslugiwane procesory: Intel Core i9, Intel Core i7, Intel Core i5, Intel Core i3, Intel Celeron, Intel Pentium, Format: ATX, Gniazdo procesora: Socket 1200, Chipset: Intel Z590');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('369.00', 'Plyty glówne', 'rannfv9', 'ASRock H510M-HVS', 'Obslugiwane procesory: Intel Core i9, Intel Core i7, Intel Core i5, Intel Core i3, Intel Celeron, Intel Pentium, Format: mATX, Gniazdo procesora: Socket 1200, Chipset: Intel H510');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('859.00', 'Plyty glówne', 'za61x5w', 'Gigabyte B550 AORUS ELITE AX V2', 'Obslugiwane procesory: AMD RyzenT, Format: ATX, Gniazdo procesora: Socket AM4, Chipset: AMD B550');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('649.00', 'Plyty glówne', '8dl9ct3', 'ASRock B660M Pro RS DDR4', 'Obslugiwane procesory: Intel Core i9, Intel Core i7, Intel Core i5, Intel Core i3, Intel Celeron, Intel Pentium, Format: mATX, Gniazdo procesora: Socket 1700, Chipset: Intel B660');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('689.00', 'Plyty glówne', 'stchfun', 'Gigabyte B660M DS3H AX DDR4', 'Obslugiwane procesory: Intel Core i9, Intel Core i7, Intel Core i5, Intel Core i3, Intel Celeron, Intel Pentium, Format: mATX, Gniazdo procesora: Socket 1700, Chipset: Intel B660');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('1689.00', 'Plyty glówne', 'l5dqg9w', 'ASUS TUF GAMING Z690-PLUS WIFI DDR4', 'Obslugiwane procesory: Intel Core i9, Intel Core i7, Intel Core i5, Intel Core i3, Intel Celeron, Intel Pentium, Format: ATX, Gniazdo procesora: Socket 1700, Chipset: Intel Z690');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('569.00', 'Plyty glówne', 'aorrucu', 'ASRock B460 Steel Legend', 'Obslugiwane procesory: Intel Core i9, Intel Core i7, Intel Core i5, Intel Core i3, Intel Celeron, Intel Pentium, Format: ATX, Gniazdo procesora: Socket 1200, Chipset: Intel B460');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('819.00', 'Plyty glówne', '34bfyen', 'MSI MAG B660M BAZOOKA DDR4', 'Obslugiwane procesory: Intel Core i9, Intel Core i7, Intel Core i5, Intel Core i3, Intel Celeron, Intel Pentium, Format: mATX, Gniazdo procesora: Socket 1700, Chipset: Intel B660');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('2419.00', 'Plyty glówne', 'abhjlv9', 'ASUS ROG STRIX Z690-F GAMING WIFI DDR5', 'Obslugiwane procesory: Intel Core i9, Intel Core i7, Intel Core i5, Intel Core i3, Intel Celeron, Intel Pentium, Format: ATX, Gniazdo procesora: Socket 1700, Chipset: Intel Z690');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('459.00', 'Plyty glówne', 'qlf0avn', 'MSI B450-A PRO MAX', 'Obslugiwane procesory: AMD RyzenT, Format: ATX, Gniazdo procesora: Socket AM4, Chipset: AMD B450');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('799.00', 'Plyty glówne', 'g3jq607', 'Gigabyte B660M GAMING X AX DDR4', 'Obslugiwane procesory: Intel Core i9, Intel Core i7, Intel Core i5, Intel Core i3, Intel Celeron, Intel Pentium, Format: mATX, Gniazdo procesora: Socket 1700, Chipset: Intel B660');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('499.00', 'Plyty glówne', 'y5qrqhz', 'Gigabyte B560M D3H', 'Obslugiwane procesory: Intel Core i9, Intel Core i7, Intel Core i5, Intel Core i3, Intel Celeron, Intel Pentium, Format: mATX, Gniazdo procesora: Socket 1200, Chipset: Intel B560');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('599.00', 'Plyty glówne', '1bbqqal', 'ASUS PRIME B560M-A', 'Obslugiwane procesory: Intel Core i9, Intel Core i7, Intel Core i5, Intel Core i3, Intel Celeron, Intel Pentium, Format: mATX, Gniazdo procesora: Socket 1200, Chipset: Intel B560');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('679.00', 'Plyty glówne', '36h6mxu', 'ASUS ROG STRIX B450-F GAMING II', 'Obslugiwane procesory: AMD RyzenT, Format: ATX, Gniazdo procesora: Socket AM4, Chipset: AMD B450');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('1299.00', 'Plyty glówne', 'dlsurgw', 'Gigabyte X570S AORUS ELITE AX', 'Obslugiwane procesory: AMD RyzenT, Format: ATX, Gniazdo procesora: Socket AM4, Chipset: AMD X570');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('549.00', 'Plyty glówne', 'a2z4fqm', 'Gigabyte B550M AORUS ELITE', 'Obslugiwane procesory: AMD RyzenT, Format: mATX, Gniazdo procesora: Socket AM4, Chipset: AMD B550');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('1039.00', 'Plyty glówne', 'h135oj1', 'ASUS TUF GAMING X570-PLUS', 'Obslugiwane procesory: AMD RyzenT, Format: ATX, Gniazdo procesora: Socket AM4, Chipset: AMD X570');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('619.00', 'Plyty glówne', 'jdsuucn', 'Gigabyte B660M GAMING DDR4', 'Obslugiwane procesory: Intel Core i9, Intel Core i7, Intel Core i5, Intel Core i3, Intel Celeron, Intel Pentium, Format: mATX, Gniazdo procesora: Socket 1700, Chipset: Intel B660');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('429.00', 'Plyty glówne', '7cuslmu', 'ASUS PRIME H510M-A', 'Obslugiwane procesory: Intel Core i9, Intel Core i7, Intel Core i5, Intel Core i3, Intel Celeron, Intel Pentium, Format: mATX, Gniazdo procesora: Socket 1200, Chipset: Intel H510');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('899.00', 'Plyty glówne', 's989bcz', 'MSI X570-A PRO', 'Obslugiwane procesory: AMD RyzenT, Format: ATX, Gniazdo procesora: Socket AM4, Chipset: AMD X570');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('289.00', 'Plyty glówne', 'kmxkt9v', 'ASRock H310CM-DVS', 'Obslugiwane procesory: Intel Core i7, Intel Core i5, Intel Core i3, Format: mATX, Gniazdo procesora: Socket 1151, Chipset: Intel H310');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('539.00', 'Plyty glówne', 'eoa9o45', 'Gigabyte B550 GAMING X', 'Obslugiwane procesory: AMD RyzenT, Format: ATX, Gniazdo procesora: Socket AM4, Chipset: AMD B550');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('719.00', 'Plyty glówne', 'i008djd', 'MSI B550-A PRO', 'Obslugiwane procesory: AMD RyzenT, Format: ATX, Gniazdo procesora: Socket AM4, Chipset: AMD B550');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('759.00', 'Plyty glówne', 'yel4e3z', 'Gigabyte B660 DS3H AX DDR4', 'Obslugiwane procesory: Intel Core i9, Intel Core i7, Intel Core i5, Intel Core i3, Intel Celeron, Intel Pentium, Format: ATX, Gniazdo procesora: Socket 1700, Chipset: Intel B660');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('2329.00', 'Plyty glówne', '356nha0', 'MSI MPG Z690 CARBON WIFI DDR5', 'Obslugiwane procesory: Intel Core i9, Intel Core i7, Intel Core i5, Intel Core i3, Intel Celeron, Intel Pentium, Format: ATX, Gniazdo procesora: Socket 1700, Chipset: Intel Z690');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('1079.00', 'Plyty glówne', '16jae23', 'MSI PRO Z690-A DDR5', 'Obslugiwane procesory: Intel Core i9, Intel Core i7, Intel Core i5, Intel Core i3, Intel Celeron, Intel Pentium, Format: ATX, Gniazdo procesora: Socket 1700, Chipset: Intel Z690');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('549.00', 'Plyty glówne', 'yut8szj', 'ASRock B560M Pro4', 'Obslugiwane procesory: Intel Core i9, Intel Core i7, Intel Core i5, Intel Core i3, Intel Celeron, Intel Pentium, Format: mATX, Gniazdo procesora: Socket 1200, Chipset: Intel B560');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('609.00', 'Plyty glówne', '99b83vw', 'ASRock B560 Pro4', 'Obslugiwane procesory: Intel Core i9, Intel Core i7, Intel Core i5, Intel Core i3, Intel Celeron, Intel Pentium, Format: ATX, Gniazdo procesora: Socket 1200, Chipset: Intel B560');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('1039.00', 'Plyty glówne', 'hmrpg7m', 'MSI MPG Z490 GAMING PLUS', 'Obslugiwane procesory: Intel Core i9, Intel Core i7, Intel Core i5, Intel Core i3, Intel Celeron, Intel Pentium, Format: ATX, Gniazdo procesora: Socket 1200, Chipset: Intel Z490');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('659.00', 'Plyty glówne', 'uevh36r', 'ASUS PRIME B660M-K DDR4', 'Obslugiwane procesory: Intel Core i9, Intel Core i7, Intel Core i5, Intel Core i3, Intel Celeron, Intel Pentium, Format: mATX, Gniazdo procesora: Socket 1700, Chipset: Intel B660');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('1059.00', 'Plyty glówne', 'ez70sla', 'MSI MAG B660 TOMAHAWK WIFI DDR4', 'Obslugiwane procesory: Intel Core i9, Intel Core i7, Intel Core i5, Intel Core i3, Intel Celeron, Intel Pentium, Format: ATX, Gniazdo procesora: Socket 1700, Chipset: Intel B660');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('1499.00', 'Plyty glówne', 'u26vcp5', 'Gigabyte X570S AORUS PRO AX', 'Obslugiwane procesory: AMD RyzenT, Format: ATX, Gniazdo procesora: Socket AM4, Chipset: AMD X570');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('639.00', 'Plyty glówne', '75pooms', 'ASRock B560M Steel Legend', 'Obslugiwane procesory: Intel Core i9, Intel Core i7, Intel Core i5, Intel Core i3, Intel Celeron, Intel Pentium, Format: mATX, Gniazdo procesora: Socket 1200, Chipset: Intel B560');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('459.00', 'Plyty glówne', 't3v86pd', 'ASUS PRIME B450-PLUS', 'Obslugiwane procesory: AMD RyzenT, Format: ATX, Gniazdo procesora: Socket AM4, Chipset: AMD B450');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('889.00', 'Plyty glówne', 'p911534', 'MSI PRO B660M-A WIFI DDR4', 'Obslugiwane procesory: Intel Core i9, Intel Core i7, Intel Core i5, Intel Core i3, Intel Celeron, Intel Pentium, Format: mATX, Gniazdo procesora: Socket 1700, Chipset: Intel B660');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('919.00', 'Plyty glówne', 'if8kkvx', 'MSI MAG B660M MORTAR WIFI DDR4', 'Obslugiwane procesory: Intel Core i9, Intel Core i7, Intel Core i5, Intel Core i3, Intel Celeron, Intel Pentium, Format: mATX, Gniazdo procesora: Socket 1700, Chipset: Intel B660');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('519.00', 'Plyty glówne', 'uv4drry', 'MSI B560M PRO-E', 'Obslugiwane procesory: Intel Core i9, Intel Core i7, Intel Core i5, Intel Core i3, Intel Celeron, Intel Pentium, Format: mATX, Gniazdo procesora: Socket 1200, Chipset: Intel B560');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('689.00', 'Plyty glówne', 'kf3ns9v', 'Gigabyte Z590 D', 'Obslugiwane procesory: Intel Core i9, Intel Core i7, Intel Core i5, Intel Core i3, Intel Celeron, Intel Pentium, Format: ATX, Gniazdo procesora: Socket 1200, Chipset: Intel Z590');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('599.00', 'Plyty glówne', '7lcx67e', 'Gigabyte B550M AORUS PRO-P', 'Obslugiwane procesory: AMD RyzenT, Format: mATX, Gniazdo procesora: Socket AM4, Chipset: AMD B550');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('959.00', 'Plyty glówne', '3f6hwax', 'ASUS ROG STRIX B550-F GAMING', 'Obslugiwane procesory: AMD RyzenT, Format: ATX, Gniazdo procesora: Socket AM4, Chipset: AMD B550');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('339.00', 'Plyty glówne', 'zsde169', 'Gigabyte H510M S2H V2', 'Obslugiwane procesory: Intel Core i9, Intel Core i7, Intel Core i5, Intel Core i3, Intel Celeron, Intel Pentium, Format: mATX, Gniazdo procesora: Socket 1200, Chipset: Intel H510');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('439.00', 'Plyty glówne', 'h24n9pf', 'ASRock H610M-HDV/M.2 DDR4', 'Obslugiwane procesory: Intel Core i9, Intel Core i7, Intel Core i5, Intel Core i3, Intel Celeron, Intel Pentium, Format: mATX, Gniazdo procesora: Socket 1700, Chipset: Intel H610');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('1659.00', 'Plyty glówne', '38mm4im', 'MSI MPG Z690 EDGE WIFI DDR4', 'Obslugiwane procesory: Intel Core i9, Intel Core i7, Intel Core i5, Intel Core i3, Intel Celeron, Intel Pentium, Format: ATX, Gniazdo procesora: Socket 1700, Chipset: Intel Z690');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('1999.00', 'Plyty glówne', '46xozt3', 'ASUS ROG STRIX Z690-A GAMING WIFI DDR4', 'Obslugiwane procesory: Intel Core i9, Intel Core i7, Intel Core i5, Intel Core i3, Intel Celeron, Intel Pentium, Format: ATX, Gniazdo procesora: Socket 1700, Chipset: Intel Z690');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('1399.00', 'Plyty glówne', 'p965rav', 'Gigabyte Z690 AORUS ELITE DDR4', 'Obslugiwane procesory: Intel Core i9, Intel Core i7, Intel Core i5, Intel Core i3, Intel Celeron, Intel Pentium, Format: ATX, Gniazdo procesora: Socket 1700, Chipset: Intel Z690');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('1949.00', 'Plyty glówne', 'xyj2dwz', 'Gigabyte X570S AORUS MASTER', 'Obslugiwane procesory: AMD RyzenT, Format: ATX, Gniazdo procesora: Socket AM4, Chipset: AMD X570');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('319.00', 'Plyty glówne', 'uij8q90', 'Gigabyte H410M S2H V3 ', 'Obslugiwane procesory: Intel Core i9, Intel Core i7, Intel Core i5, Intel Core i3, Intel Celeron, Intel Pentium, Format: mATX, Gniazdo procesora: Socket 1200, Chipset: Intel H510');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('459.00', 'Plyty glówne', 'it633l6', 'ASUS PRIME B560M-K', 'Obslugiwane procesory: Intel Core i9, Intel Core i7, Intel Core i5, Intel Core i3, Intel Celeron, Intel Pentium, Format: mATX, Gniazdo procesora: Socket 1200, Chipset: Intel B560');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('889.00', 'Plyty glówne', 'wq1blg2', 'ASUS TUF GAMING B560-PLUS WIFI', 'Obslugiwane procesory: Intel Core i9, Intel Core i7, Intel Core i5, Intel Core i3, Intel Celeron, Intel Pentium, Format: ATX, Gniazdo procesora: Socket 1200, Chipset: Intel B560');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('449.00', 'Plyty glówne', '38tqouf', 'MSI B550M-A PRO', 'Obslugiwane procesory: AMD RyzenT, Format: mATX, Gniazdo procesora: Socket AM4, Chipset: AMD B550');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('1049.00', 'Plyty glówne', 'idu1vwj', 'ASUS TUF GAMING Z590-PLUS ', 'Obslugiwane procesory: Intel Core i9, Intel Core i7, Intel Core i5, Intel Core i3, Intel Celeron, Intel Pentium, Format: ATX, Gniazdo procesora: Socket 1200, Chipset: Intel Z590');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('629.00', 'Plyty glówne', 'xoqiu3h', 'ASUS PRIME B550M-A', 'Obslugiwane procesory: AMD RyzenT, Format: mATX, Gniazdo procesora: Socket AM4, Chipset: AMD B550');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('1269.00', 'Plyty glówne', 'pabzzza', 'ASUS ROG STRIX B550-E GAMING', 'Obslugiwane procesory: AMD RyzenT, Format: ATX, Gniazdo procesora: Socket AM4, Chipset: AMD B550');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('919.00', 'Plyty glówne', 'it12q92', 'Gigabyte B660 GAMING X AX DDR4', 'Obslugiwane procesory: Intel Core i9, Intel Core i7, Intel Core i5, Intel Core i3, Intel Celeron, Intel Pentium, Format: ATX, Gniazdo procesora: Socket 1700, Chipset: Intel B660');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('1279.00', 'Plyty glówne', 'k1rbo50', 'MSI PRO Z690-A WIFI DDR5', 'Obslugiwane procesory: Intel Core i9, Intel Core i7, Intel Core i5, Intel Core i3, Intel Celeron, Intel Pentium, Format: ATX, Gniazdo procesora: Socket 1700, Chipset: Intel Z690');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('1219.00', 'Plyty glówne', 'plcgyw0', 'MSI MAG X570S TORPEDO MAX', 'Obslugiwane procesory: AMD RyzenT, Format: ATX, Gniazdo procesora: Socket AM4, Chipset: AMD X570');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('419.00', 'Plyty glówne', 'cj32ntn', 'Gigabyte B560M H', 'Obslugiwane procesory: Intel Core i9, Intel Core i7, Intel Core i5, Intel Core i3, Intel Celeron, Intel Pentium, Format: mATX, Gniazdo procesora: Socket 1200, Chipset: Intel B560');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('359.00', 'Plyty glówne', '8r2z5ea', 'ASUS PRIME H510M-K', 'Obslugiwane procesory: Intel Core i9, Intel Core i7, Intel Core i5, Intel Core i3, Intel Celeron, Intel Pentium, Format: mATX, Gniazdo procesora: Socket 1200, Chipset: Intel H510');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('1049.00', 'Plyty glówne', 't59exrm', 'MSI MAG B560 TOMAHAWK WIFI', 'Obslugiwane procesory: Intel Core i9, Intel Core i7, Intel Core i5, Intel Core i3, Intel Celeron, Intel Pentium, Format: ATX, Gniazdo procesora: Socket 1200, Chipset: Intel B560');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('349.00', 'Plyty glówne', 'x0hf9i0', 'ASUS PRIME B450M-A II', 'Obslugiwane procesory: AMD Athlon, AMD RyzenT, Format: mATX, Gniazdo procesora: Socket AM4, Chipset: AMD B450');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('629.00', 'Plyty glówne', 'z0sadbg', 'ASRock B550 Phantom Gaming 4/ac', 'Obslugiwane procesory: AMD RyzenT, Format: ATX, Gniazdo procesora: Socket AM4, Chipset: AMD B550');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('519.00', 'Plyty glówne', 'k8acpom', 'ASRock B550 Phantom Gaming 4', 'Obslugiwane procesory: AMD RyzenT, Format: ATX, Gniazdo procesora: Socket AM4, Chipset: AMD B550');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('369.00', 'Plyty glówne', 'izmuz07', 'ASUS PRIME H310M-K R2.0', 'Obslugiwane procesory: Intel Core i9, Intel Core i7, Intel Core i5, Intel Core i3, Intel Celeron, Intel Pentium, Format: mATX, Gniazdo procesora: Socket 1151, Chipset: Intel H310');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('1079.00', 'Plyty glówne', 'qdcbewo', 'ASUS TUF GAMING B550-PLUS WIFI II', 'Obslugiwane procesory: AMD RyzenT, Format: ATX, Gniazdo procesora: Socket AM4, Chipset: AMD B550');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('699.00', 'Plyty glówne', 'jvvpkni', 'MSI B560M PRO WIFI', 'Obslugiwane procesory: Intel Core i9, Intel Core i7, Intel Core i5, Intel Core i3, Intel Celeron, Intel Pentium, Format: mATX, Gniazdo procesora: Socket 1200, Chipset: Intel B560');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('1239.00', 'Plyty glówne', 'siz2d5j', 'ASRock Z690M-ITX/ax DDR4', 'Obslugiwane procesory: Intel Core i9, Intel Core i7, Intel Core i5, Intel Core i3, Intel Celeron, Intel Pentium, Format: mITX, Gniazdo procesora: Socket 1700, Chipset: Intel Z690');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('789.00', 'Plyty glówne', '79bic0p', 'Gigabyte Z690M DS3H DDR4', 'Obslugiwane procesory: Intel Core i9, Intel Core i7, Intel Core i5, Intel Core i3, Intel Celeron, Intel Pentium, Format: mATX, Gniazdo procesora: Socket 1700, Chipset: Intel Z690');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('1099.00', 'Plyty glówne', 'k6viidi', 'Gigabyte Z690 UD DDR5', 'Obslugiwane procesory: Intel Core i9, Intel Core i7, Intel Core i5, Intel Core i3, Intel Celeron, Intel Pentium, Format: ATX, Gniazdo procesora: Socket 1700, Chipset: Intel Z690');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('2019.00', 'Plyty glówne', '6q09o2a', 'ASUS ROG STRIX X570-E GAMING WIFI II', 'Obslugiwane procesory: AMD RyzenT, Format: ATX, Gniazdo procesora: Socket AM4, Chipset: AMD X570');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('659.00', 'Plyty glówne', 'mpxebe1', 'MSI B550M PRO-VDH', 'Obslugiwane procesory: AMD RyzenT, Format: mATX, Gniazdo procesora: Socket AM4, Chipset: AMD B550');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('689.00', 'Plyty glówne', 'qx3vfwt', 'MSI B560M PRO-VDH', 'Obslugiwane procesory: Intel Core i9, Intel Core i7, Intel Core i5, Intel Core i3, Intel Celeron, Intel Pentium, Format: mATX, Gniazdo procesora: Socket 1200, Chipset: Intel B560');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('1699.00', 'Plyty glówne', 'fa3cw09', 'Gigabyte Z590 AORUS ULTRA', 'Obslugiwane procesory: Intel Core i9, Intel Core i7, Intel Core i5, Intel Core i3, Intel Celeron, Intel Pentium, Format: ATX, Gniazdo procesora: Socket 1200, Chipset: Intel Z590');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('1949.00', 'Plyty glówne', '10hck0w', 'ASUS ROG STRIX Z590-E GAMING WIFI', 'Obslugiwane procesory: Intel Core i9, Intel Core i7, Intel Core i5, Intel Core i3, Intel Celeron, Intel Pentium, Format: ATX, Gniazdo procesora: Socket 1200, Chipset: Intel Z590');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('879.00', 'Plyty glówne', '3z4yciu', 'ASUS ROG STRIX B550-A GAMING', 'Obslugiwane procesory: AMD RyzenT, Format: ATX, Gniazdo procesora: Socket AM4, Chipset: AMD B550');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('479.00', 'Plyty glówne', 'soeb6y4', 'ASRock B550M Pro4', 'Obslugiwane procesory: AMD RyzenT, Format: uATX, Gniazdo procesora: Socket AM4, Chipset: AMD B550');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('1169.00', 'Plyty glówne', 'i4wdrz1', 'ASUS ROG STRIX B550-I GAMING', 'Obslugiwane procesory: AMD RyzenT, Format: mITX, Gniazdo procesora: Socket AM4, Chipset: AMD B550');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('1249.00', 'Plyty glówne', 'pg723bw', 'ASUS TUF GAMING X570-PLUS (Wi-Fi)', 'Obslugiwane procesory: AMD RyzenT, Format: ATX, Gniazdo procesora: Socket AM4, Chipset: AMD X570');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('389.00', 'Plyty glówne', 'pqc2fey', 'ASUS PRIME H310M-D R2.0', 'Obslugiwane procesory: Intel Core i7, Intel Core i5, Intel Core i3, Intel Celeron, Intel Pentium, Format: mATX, Gniazdo procesora: Socket 1151, Chipset: Intel H310');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('1049.00', 'Plyty glówne', '807cn9w', 'ASUS ROG STRIX B550-F GAMING WIFI II', 'Obslugiwane procesory: AMD RyzenT, Format: ATX, Gniazdo procesora: Socket AM4, Chipset: AMD B550');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('649.00', 'Plyty glówne', 'wya2kfs', 'ASRock H610M-ITX/ac DDR4', 'Obslugiwane procesory: Intel Core i9, Intel Core i7, Intel Core i5, Intel Core i3, Intel Celeron, Intel Pentium, Format: mITX, Gniazdo procesora: Socket 1700, Chipset: Intel H610');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('1079.00', 'Plyty glówne', 'gu93k7m', 'Gigabyte Z690 UD AX DDR5', 'Obslugiwane procesory: Intel Core i9, Intel Core i7, Intel Core i5, Intel Core i3, Intel Celeron, Intel Pentium, Format: ATX, Gniazdo procesora: Socket 1700, Chipset: Intel Z690');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('1259.00', 'Plyty glówne', 't88jh9d', 'Gigabyte Z690 GAMING X DDR5', 'Obslugiwane procesory: Intel Core i9, Intel Core i7, Intel Core i5, Intel Core i3, Intel Celeron, Intel Pentium, Format: ATX, Gniazdo procesora: Socket 1700, Chipset: Intel Z690');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('1369.00', 'Plyty glówne', '9bk1ufk', 'ASUS PRIME Z690-P WIFI DDR4', 'Obslugiwane procesory: Intel Core i9, Intel Core i7, Intel Core i5, Intel Core i3, Intel Celeron, Intel Pentium, Format: ATX, Gniazdo procesora: Socket 1700, Chipset: Intel Z690');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('409.00', 'Plyty glówne', '4zad1d4', 'ASRock B550M-HDV', 'Obslugiwane procesory: AMD RyzenT, Format: mATX, Gniazdo procesora: Socket AM4, Chipset: AMD B550');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('689.00', 'Plyty glówne', 'r60s7ei', 'ASUS PRIME B550-PLUS', 'Obslugiwane procesory: AMD RyzenT, Format: ATX, Gniazdo procesora: Socket AM4, Chipset: AMD B550');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('799.00', 'Plyty glówne', '6d96iln', 'ASRock X570 Phantom Gaming 4', 'Obslugiwane procesory: AMD RyzenT, Format: ATX, Gniazdo procesora: Socket AM4, Chipset: AMD X570');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('899.00', 'Plyty glówne', 'c03gatx', 'ASUS PRIME X570-P', 'Obslugiwane procesory: AMD RyzenT, Format: ATX, Gniazdo procesora: Socket AM4, Chipset: AMD X570');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('1479.00', 'Plyty glówne', 'wzbzahn', 'ASUS ROG STRIX X570-F GAMING', 'Obslugiwane procesory: AMD RyzenT, Format: ATX, Gniazdo procesora: Socket AM4, Chipset: AMD X570');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('519.00', 'Plyty glówne', '58zt3sb', 'ASRock B450 Steel Legend', 'Obslugiwane procesory: AMD RyzenT, Format: ATX, Gniazdo procesora: Socket AM4, Chipset: AMD B450');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('269.00', 'Plyty glówne', 'b82k45c', 'Gigabyte GA-A320M-H', 'Obslugiwane procesory: AMD RyzenT, Format: mATX, Gniazdo procesora: Socket AM4, Chipset: AMD A320');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('559.00', 'Plyty glówne', '9m6m482', 'ASRock B660M-HDV DDR4', 'Obslugiwane procesory: Intel Core i9, Intel Core i7, Intel Core i5, Intel Core i3, Intel Celeron, Intel Pentium, Format: mATX, Gniazdo procesora: Socket 1700, Chipset: Intel B660');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('1249.00', 'Plyty glówne', '1h8ztg5', 'ASUS ROG STRIX B660-A GAMING WIFI DDR4', 'Obslugiwane procesory: Intel Core i9, Intel Core i7, Intel Core i5, Intel Core i3, Intel Celeron, Intel Pentium, Format: ATX, Gniazdo procesora: Socket 1700, Chipset: Intel B660');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('1559.00', 'Plyty glówne', 'g93776a', 'MSI MAG Z690 TOMAHAWK WIFI DDR5', 'Obslugiwane procesory: Intel Core i9, Intel Core i7, Intel Core i5, Intel Core i3, Intel Celeron, Intel Pentium, Format: ATX, Gniazdo procesora: Socket 1700, Chipset: Intel Z690');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('1479.00', 'Plyty glówne', 'fjlp4lb', 'Gigabyte Z690 AORUS ELITE AX DDR5', 'Obslugiwane procesory: Intel Core i9, Intel Core i7, Intel Core i5, Intel Core i3, Intel Celeron, Intel Pentium, Format: ATX, Gniazdo procesora: Socket 1700, Chipset: Intel Z690');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('359.00', 'Plyty glówne', 'cb6gzuy', 'ASRock B450M Pro4 R2.0', 'Obslugiwane procesory: AMD RyzenT, Format: mATX, Gniazdo procesora: Socket AM4, Chipset: AMD B450');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('499.00', 'Plyty glówne', 'ngnhjve', 'MSI H510M-A PRO', 'Obslugiwane procesory: Intel Core i9, Intel Core i7, Intel Core i5, Intel Core i3, Intel Celeron, Intel Pentium, Format: mATX, Gniazdo procesora: Socket 1200, Chipset: Intel H510');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('1119.00', 'Plyty glówne', 'z24jmh5', 'Gigabyte Z590 VISION G', 'Obslugiwane procesory: Intel Core i9, Intel Core i7, Intel Core i5, Intel Core i3, Intel Celeron, Intel Pentium, Format: ATX, Gniazdo procesora: Socket 1200, Chipset: Intel Z590');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('1529.00', 'Plyty glówne', '09o79b3', 'ASUS ROG STRIX Z590-F GAMING WIFI', 'Obslugiwane procesory: Intel Core i9, Intel Core i7, Intel Core i5, Intel Core i3, Intel Celeron, Intel Pentium, Format: ATX, Gniazdo procesora: Socket 1200, Chipset: Intel Z590');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('1299.00', 'Plyty glówne', 'dt70v1x', 'ASUS TUF GAMING X570-PRO (WI-FI)', 'Obslugiwane procesory: AMD RyzenT, Format: ATX, Gniazdo procesora: Socket AM4, Chipset: AMD X570');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('889.00', 'Plyty glówne', 'gct4vg4', 'Gigabyte B550 AORUS PRO AC', 'Obslugiwane procesory: AMD RyzenT, Format: ATX, Gniazdo procesora: Socket AM4, Chipset: AMD B550');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('619.00', 'Plyty glówne', '2pywk7q', 'ASRock B550 Pro4', 'Obslugiwane procesory: AMD RyzenT, Format: ATX, Gniazdo procesora: Socket AM4, Chipset: AMD B550');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('399.00', 'Plyty glówne', 'rsgqegd', 'MSI B450M PRO-VDH MAX', 'Obslugiwane procesory: AMD RyzenT, Format: mATX, Gniazdo procesora: Socket AM4, Chipset: AMD B450');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('1429.00', 'Plyty glówne', 'cqj2s7j', 'ASUS PRIME X570-PRO', 'Obslugiwane procesory: AMD RyzenT, Format: ATX, Gniazdo procesora: Socket AM4, Chipset: AMD X570');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('1199.00', 'Plyty glówne', 'xqhy6rt', 'ASUS TUF GAMING H670-PRO WIFI DDR4', 'Obslugiwane procesory: Intel Core i9, Intel Core i7, Intel Core i5, Intel Core i3, Intel Celeron, Intel Pentium, Format: ATX, Gniazdo procesora: Socket 1700, Chipset: Intel H670');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('869.00', 'Plyty glówne', 'zkp2abh', 'ASUS PRIME B660M-A WIFI DDR4', 'Obslugiwane procesory: Intel Core i9, Intel Core i7, Intel Core i5, Intel Core i3, Intel Celeron, Intel Pentium, Format: mATX, Gniazdo procesora: Socket 1700, Chipset: Intel B660');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('1019.00', 'Plyty glówne', 'szjyfmw', 'ASUS ROG STRIX B660-I GAMING WIFI DDR5', 'Obslugiwane procesory: Intel Core i9, Intel Core i7, Intel Core i5, Intel Core i3, Intel Celeron, Intel Pentium, Format: mITX, Gniazdo procesora: Socket 1700, Chipset: Intel B660');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('899.00', 'Plyty glówne', 'b1trtue', 'ASUS TUF GAMING B660M-PLUS WIFI DDR4', 'Obslugiwane procesory: Intel Core i9, Intel Core i7, Intel Core i5, Intel Core i3, Intel Celeron, Intel Pentium, Format: mATX, Gniazdo procesora: Socket 1700, Chipset: Intel B660');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('1519.00', 'Plyty glówne', 'vjcckte', 'MSI MAG Z690 TORPEDO DDR5', 'Obslugiwane procesory: Intel Core i9, Intel Core i7, Intel Core i5, Intel Core i3, Intel Celeron, Intel Pentium, Format: ATX, Gniazdo procesora: Socket 1700, Chipset: Intel Z690');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('2739.00', 'Plyty glówne', '0r9op83', 'ASUS ProArt Z690-CREATOR WIFI DDR5', 'Obslugiwane procesory: Intel Core i9, Intel Core i7, Intel Core i5, Intel Core i3, Intel Celeron, Intel Pentium, Format: ATX, Gniazdo procesora: Socket 1700, Chipset: Intel Z690');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('2519.00', 'Plyty glówne', 'h2zde6t', 'Gigabyte Z690 AORUS MASTER DDR5', 'Obslugiwane procesory: Intel Core i9, Intel Core i7, Intel Core i5, Intel Core i3, Intel Celeron, Intel Pentium, Format: E-ATX, Gniazdo procesora: Socket 1700, Chipset: Intel Z690');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('1459.00', 'Plyty glówne', '10dnuxw', 'MSI MAG X570S TOMAHAWK MAX WIFI', 'Obslugiwane procesory: AMD RyzenT, Format: ATX, Gniazdo procesora: Socket AM4, Chipset: AMD X570');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('829.00', 'Plyty glówne', 'zxhl7od', 'ASUS TUF GAMING B550M-E WIFI', 'Obslugiwane procesory: AMD RyzenT, Format: mATX, Gniazdo procesora: Socket AM4, Chipset: AMD B550');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('759.00', 'Plyty glówne', 'amz1sdt', 'MSI MAG B560M MORTAR', 'Obslugiwane procesory: Intel Core i9, Intel Core i7, Intel Core i5, Intel Core i3, Intel Celeron, Intel Pentium, Format: mATX, Gniazdo procesora: Socket 1200, Chipset: Intel B560');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('1379.00', 'Plyty glówne', 'ilj1o44', 'Gigabyte Z590I AORUS ULTRA', 'Obslugiwane procesory: Intel Core i9, Intel Core i7, Intel Core i5, Intel Core i3, Intel Celeron, Intel Pentium, Format: mITX, Gniazdo procesora: Socket 1200, Chipset: Intel Z590');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('1329.00', 'Plyty glówne', '04npyu5', 'Gigabyte Z590 AORUS ELITE AX', 'Obslugiwane procesory: Intel Core i9, Intel Core i7, Intel Core i5, Intel Core i3, Intel Celeron, Intel Pentium, Format: ATX, Gniazdo procesora: Socket 1200, Chipset: Intel Z590');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('299.00', 'Plyty glówne', 'j0zz6sk', 'ASRock A520M-HVS', 'Obslugiwane procesory: AMD RyzenT, Format: mATX, Gniazdo procesora: Socket AM4, Chipset: AMD A520');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('2439.00', 'Plyty glówne', '42dssyh', 'ASUS ROG Crosshair VIII Dark Hero', 'Obslugiwane procesory: AMD RyzenT, Format: ATX, Gniazdo procesora: Socket AM4, Chipset: AMD X570');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('469.00', 'Plyty glówne', 'oamv3as', 'Gigabyte B550M DS3H', 'Obslugiwane procesory: AMD RyzenT, Format: mATX, Gniazdo procesora: Socket AM4, Chipset: AMD B550');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('249.00', 'Plyty glówne', 'y4wf431', 'ASRock A320M-DVS R4.0', 'Obslugiwane procesory: AMD RyzenT, Format: mATX, Gniazdo procesora: Socket AM4, Chipset: AMD A320');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('969.00', 'Plyty glówne', '546h4j1', 'MSI Z490-A PRO', 'Obslugiwane procesory: Intel Core i9, Intel Core i7, Intel Core i5, Intel Core i3, Intel Celeron, Intel Pentium, Format: ATX, Gniazdo procesora: Socket 1200, Chipset: Intel Z490');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('329.00', 'Plyty glówne', 'nabwvio', 'Gigabyte B450M DS3H', 'Obslugiwane procesory: AMD RyzenT, Format: mATX, Gniazdo procesora: Socket AM4, Chipset: AMD B450');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('299.00', 'Plyty glówne', 'tgi7fvu', 'ASRock H310CM-HDV/M.2', 'Obslugiwane procesory: Intel Core i9, Intel Core i7, Intel Core i5, Intel Core i3, Intel Celeron, Intel Pentium, Format: mATX, Gniazdo procesora: Socket 1151, Chipset: Intel H310');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('899.00', 'Plyty glówne', '4a57ulv', 'ASUS PRIME H670-PLUS DDR4', 'Obslugiwane procesory: Intel Core i9, Intel Core i7, Intel Core i5, Intel Core i3, Intel Celeron, Intel Pentium, Format: ATX, Gniazdo procesora: Socket 1700, Chipset: Intel H670');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('919.00', 'Plyty glówne', 'fcuczu0', 'ASUS TUF GAMING B660M-PLUS DDR4', 'Obslugiwane procesory: Intel Core i9, Intel Core i7, Intel Core i5, Intel Core i3, Intel Celeron, Intel Pentium, Format: mATX, Gniazdo procesora: Socket 1700, Chipset: Intel B660');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('989.00', 'Plyty glówne', '9hkyoqb', 'ASRock Z690 Phantom Gaming 4 DDR4', 'Obslugiwane procesory: Intel Core i9, Intel Core i7, Intel Core i5, Intel Core i3, Intel Celeron, Intel Pentium, Format: ATX, Gniazdo procesora: Socket 1700, Chipset: Intel Z690');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('1379.00', 'Plyty glówne', 'al9h2ee', 'ASRock Z690 Steel Legend DDR4', 'Obslugiwane procesory: Intel Core i9, Intel Core i7, Intel Core i5, Intel Core i3, Intel Celeron, Intel Pentium, Format: ATX, Gniazdo procesora: Socket 1700, Chipset: Intel Z690');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('1379.00', 'Plyty glówne', 'xniygfa', 'Gigabyte Z690 AERO G DDR5', 'Obslugiwane procesory: Intel Core i9, Intel Core i7, Intel Core i5, Intel Core i3, Intel Celeron, Intel Pentium, Format: ATX, Gniazdo procesora: Socket 1700, Chipset: Intel Z690');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('1319.00', 'Plyty glówne', '3blj8fh', 'Gigabyte Z690M A ELITE AX DDR4', 'Obslugiwane procesory: Intel Core i9, Intel Core i7, Intel Core i5, Intel Core i3, Intel Celeron, Intel Pentium, Format: mATX, Gniazdo procesora: Socket 1700, Chipset: Intel Z690');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('2949.00', 'Plyty glówne', '8qu6yov', 'MSI MEG Z690 UNIFY DDR5', 'Obslugiwane procesory: Intel Core i9, Intel Core i7, Intel Core i5, Intel Core i3, Intel Celeron, Intel Pentium, Format: ATX, Gniazdo procesora: Socket 1700, Chipset: Intel Z690');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('2249.00', 'Plyty glówne', '08h1ft4', 'MSI MPG Z690 FORCE WIFI DDR5', 'Obslugiwane procesory: Intel Core i9, Intel Core i7, Intel Core i5, Intel Core i3, Intel Celeron, Intel Pentium, Format: ATX, Gniazdo procesora: Socket 1700, Chipset: Intel Z690');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('6149.00', 'Plyty glówne', 'z6z3hqr', 'ASUS ROG MAXIMUS Z690 EXTREME DDR5', 'Obslugiwane procesory: Intel Core i9, Intel Core i7, Intel Core i5, Intel Core i3, Intel Celeron, Intel Pentium, Format: E-ATX, Gniazdo procesora: Socket 1700, Chipset: Intel Z690');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('2439.00', 'Plyty glówne', 'ylnso0f', 'ASUS ROG STRIX Z690-I GAMING WIFI DDR5', 'Obslugiwane procesory: Intel Core i9, Intel Core i7, Intel Core i5, Intel Core i3, Intel Celeron, Intel Pentium, Format: mITX, Gniazdo procesora: Socket 1700, Chipset: Intel Z690');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('1469.00', 'Plyty glówne', 'f0prk4c', 'ASUS TUF GAMING X570-PRO WIFI II', 'Obslugiwane procesory: AMD RyzenT, Format: ATX, Gniazdo procesora: Socket AM4, Chipset: AMD X570');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('1579.00', 'Plyty glówne', '6nlc1ty', 'MSI MPG X570S EDGE MAX WIFI', 'Obslugiwane procesory: AMD RyzenT, Format: ATX, Gniazdo procesora: Socket AM4, Chipset: AMD X570');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('2369.00', 'Plyty glówne', 'pa8bwgd', 'ASUS ROG STRIX X299-E GAMING II', 'Obslugiwane procesory: Intel Core i9 X-series, Intel Core i7 X-series, Intel Core i5 X-series, Format: ATX, Gniazdo procesora: Socket 2066, Chipset: Intel X299');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('509.00', 'Plyty glówne', 'gwq1z1i', 'ASUS PRIME H510M-D', 'Obslugiwane procesory: Intel Core i9, Intel Core i7, Intel Core i5, Intel Core i3, Intel Celeron, Intel Pentium, Format: mATX, Gniazdo procesora: Socket 1200, Chipset: Intel H510');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('559.00', 'Plyty glówne', 'ehnkop4', 'ASUS PRIME H510M-A WIFI', 'Obslugiwane procesory: Intel Core i9, Intel Core i7, Intel Core i5, Intel Core i3, Intel Celeron, Intel Pentium, Format: mATX, Gniazdo procesora: Socket 1200, Chipset: Intel H510');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('1029.00', 'Plyty glówne', '93j5z14', 'ASUS ROG STRIX B560-A GAMING WIFI', 'Obslugiwane procesory: Intel Core i9, Intel Core i7, Intel Core i5, Intel Core i3, Intel Celeron, Intel Pentium, Format: ATX, Gniazdo procesora: Socket 1200, Chipset: Intel B560');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('429.00', 'Plyty glówne', 'rn1r74i', 'ASUS  PRIME H510M-E', 'Obslugiwane procesory: Intel Core i9, Intel Core i7, Intel Core i5, Intel Core i3, Intel Celeron, Intel Pentium, Format: mATX, Gniazdo procesora: Socket 1200, Chipset: Intel H510');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('309.00', 'Plyty glówne', 'lqr23c0', 'Gigabyte A520M H', 'Obslugiwane procesory: AMD RyzenT, Format: mATX, Gniazdo procesora: Socket AM4, Chipset: AMD A520');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('719.00', 'Plyty glówne', 'n92vd41', 'Gigabyte Z590M', 'Obslugiwane procesory: Intel Core i9, Intel Core i7, Intel Core i5, Intel Core i3, Intel Celeron, Intel Pentium, Format: mATX, Gniazdo procesora: Socket 1200, Chipset: Intel Z590');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('499.00', 'Plyty glówne', 'g93ld6r', 'ASUS TUF GAMING B450M-PRO II', 'Obslugiwane procesory: AMD RyzenT, Format: mATX, Gniazdo procesora: Socket AM4, Chipset: AMD B450');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('1569.00', 'Plyty glówne', 'iyg8pjy', 'ASUS ROG STRIX X570-I GAMING', 'Obslugiwane procesory: AMD RyzenT, Format: mITX, Gniazdo procesora: Socket AM4, Chipset: AMD X570');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('329.00', 'Plyty glówne', 'i1j3704', 'ASRock B450M-HDV R4.0', 'Obslugiwane procesory: AMD RyzenT, Format: mATX, Gniazdo procesora: Socket AM4, Chipset: AMD B450');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('1889.00', 'Plyty glówne', '16twn4v', 'ASUS PRIME X299-A II', 'Obslugiwane procesory: Intel Core i9 X-series, Intel Core i7 X-series, Intel Core i5 X-series, Format: ATX, Gniazdo procesora: Socket 2066, Chipset: Intel X299');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('499.00', 'Plyty glówne', '5siw7dk', 'ASUS TUF B450M-PRO GAMING', 'Obslugiwane procesory: AMD RyzenT, Format: mATX, Gniazdo procesora: Socket AM4, Chipset: AMD B450');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('1599.00', 'Plyty glówne', 'p8f492c', 'MSI MEG B550 UNIFY', 'Obslugiwane procesory: AMD RyzenT, Format: ATX, Gniazdo procesora: Socket AM4, Chipset: AMD B550');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('399.00', 'Plyty glówne', '2k5m3lf', 'ASRock H610M-HDV DDR4', 'Obslugiwane procesory: Intel Core i9, Intel Core i7, Intel Core i5, Intel Core i3, Intel Celeron, Intel Pentium, Format: mATX, Gniazdo procesora: Socket 1700, Chipset: Intel H610');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('869.00', 'Plyty glówne', 'ir4g58q', 'ASUS TUF GAMING B660M-E DDR4', 'Obslugiwane procesory: Intel Core i9, Intel Core i7, Intel Core i5, Intel Core i3, Intel Celeron, Intel Pentium, Format: mATX, Gniazdo procesora: Socket 1700, Chipset: Intel B660');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('1019.00', 'Plyty glówne', 'ciy1b6n', 'ASUS TUF GAMING B660-PLUS WIFI DDR4', 'Obslugiwane procesory: Intel Core i9, Intel Core i7, Intel Core i5, Intel Core i3, Intel Celeron, Intel Pentium, Format: ATX, Gniazdo procesora: Socket 1700, Chipset: Intel B660');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('1149.00', 'Plyty glówne', 'g8ksgn3', 'ASUS ROG STRIX B660-G GAMING WIFI DDR5', 'Obslugiwane procesory: Intel Core i9, Intel Core i7, Intel Core i5, Intel Core i3, Intel Celeron, Intel Pentium, Format: mATX, Gniazdo procesora: Socket 1700, Chipset: Intel B660');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('509.00', 'Plyty glówne', '3d08i10', 'ASUS PRIME H610M-D DDR4', 'Obslugiwane procesory: Intel Core i9, Intel Core i7, Intel Core i5, Intel Core i3, Intel Celeron, Intel Pentium, Format: mATX, Gniazdo procesora: Socket 1700, Chipset: Intel H610');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('579.00', 'Plyty glówne', 'vzjusqw', 'ASUS PRIME H610M-A DDR4', 'Obslugiwane procesory: Intel Core i9, Intel Core i7, Intel Core i5, Intel Core i3, Intel Celeron, Intel Pentium, Format: mATX, Gniazdo procesora: Socket 1700, Chipset: Intel H610');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('559.00', 'Plyty glówne', 'appcf5n', 'ASUS PRIME H610M-E DDR4', 'Obslugiwane procesory: Intel Core i9, Intel Core i7, Intel Core i5, Intel Core i3, Intel Celeron, Intel Pentium, Format: mATX, Gniazdo procesora: Socket 1700, Chipset: Intel H610');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('3849.00', 'Plyty glówne', 'zrc77zv', 'ASUS WS C422 SAGE/10G', 'Obslugiwane procesory: Intel Xeon W, Format: CEB, Gniazdo procesora: Socket 2066, Chipset: Intel C422');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('589.00', 'Plyty glówne', 'nt4w8mp', 'MSI PRO B660M-E DDR4', 'Obslugiwane procesory: Intel Core i9, Intel Core i7, Intel Core i5, Intel Core i3, Intel Celeron, Intel Pentium, Format: mATX, Gniazdo procesora: Socket 1700, Chipset: Intel B660');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('899.00', 'Plyty glówne', 'o5jvgqr', 'MSI MAG B660M MORTAR DDR4', 'Obslugiwane procesory: Intel Core i9, Intel Core i7, Intel Core i5, Intel Core i3, Intel Celeron, Intel Pentium, Format: mATX, Gniazdo procesora: Socket 1700, Chipset: Intel B660');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('769.00', 'Plyty glówne', 'tpfto2f', 'Gigabyte B660M GAMING X DDR4', 'Obslugiwane procesory: Intel Core i9, Intel Core i7, Intel Core i5, Intel Core i3, Intel Celeron, Intel Pentium, Format: mATX, Gniazdo procesora: Socket 1700, Chipset: Intel B660');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('1259.00', 'Plyty glówne', 's6qatpd', 'Gigabyte B660 AORUS MASTER DDR4', 'Obslugiwane procesory: Intel Core i9, Intel Core i7, Intel Core i5, Intel Core i3, Intel Celeron, Intel Pentium, Format: ATX, Gniazdo procesora: Socket 1700, Chipset: Intel B660');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('1129.00', 'Plyty glówne', 'w7blboh', 'ASRock Z690 PG Riptide DDR4', 'Obslugiwane procesory: Intel Core i9, Intel Core i7, Intel Core i5, Intel Core i3, Intel Celeron, Intel Pentium, Format: ATX, Gniazdo procesora: Socket 1700, Chipset: Intel Z690');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('1429.00', 'Plyty glówne', 'fp9uegw', 'ASRock Z690 Extreme DDR4', 'Obslugiwane procesory: Intel Core i9, Intel Core i7, Intel Core i5, Intel Core i3, Intel Celeron, Intel Pentium, Format: ATX, Gniazdo procesora: Socket 1700, Chipset: Intel Z690');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('1839.00', 'Plyty glówne', 'ugq0n6f', 'ASRock Z690 Phantom Gaming-ITX/TB4 DDR5', 'Obslugiwane procesory: Intel Core i9, Intel Core i7, Intel Core i5, Intel Core i3, Intel Celeron, Intel Pentium, Format: mITX, Gniazdo procesora: Socket 1700, Chipset: Intel Z690');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('3559.00', 'Plyty glówne', 'b8nr8p5', 'MSI MEG Z690 ACE DDR5', 'Obslugiwane procesory: Intel Core i9, Intel Core i7, Intel Core i5, Intel Core i3, Intel Celeron, Intel Pentium, Format: E-ATX, Gniazdo procesora: Socket 1700, Chipset: Intel Z690');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('1699.00', 'Plyty glówne', 'xnvo8l2', 'Gigabyte Z690 AORUS PRO DDR5', 'Obslugiwane procesory: Intel Core i9, Intel Core i7, Intel Core i5, Intel Core i3, Intel Celeron, Intel Pentium, Format: ATX, Gniazdo procesora: Socket 1700, Chipset: Intel Z690');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('4049.00', 'Plyty glówne', '8hkecjn', 'ASUS ROG MAXIMUS Z690 FORMULA DDR5', 'Obslugiwane procesory: Intel Core i9, Intel Core i7, Intel Core i5, Intel Core i3, Intel Celeron, Intel Pentium, Format: ATX, Gniazdo procesora: Socket 1700, Chipset: Intel Z690');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('3379.00', 'Plyty glówne', '0g9kvt8', 'ASUS ROG MAXIMUS Z690 HERO DDR5', 'Obslugiwane procesory: Intel Core i9, Intel Core i7, Intel Core i5, Intel Core i3, Intel Celeron, Intel Pentium, Format: ATX, Gniazdo procesora: Socket 1700, Chipset: Intel Z690');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('1579.00', 'Plyty glówne', 'z0bft8u', 'ASUS PRIME Z690-A DDR5', 'Obslugiwane procesory: Intel Core i9, Intel Core i7, Intel Core i5, Intel Core i3, Intel Celeron, Intel Pentium, Format: ATX, Gniazdo procesora: Socket 1700, Chipset: Intel Z690');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('1549.00', 'Plyty glówne', '0x5e9ms', 'ASUS PRIME Z690-P WIFI DDR5', 'Obslugiwane procesory: Intel Core i9, Intel Core i7, Intel Core i5, Intel Core i3, Intel Celeron, Intel Pentium, Format: ATX, Gniazdo procesora: Socket 1700, Chipset: Intel Z690');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('1299.00', 'Plyty glówne', 'bngg55x', 'ASUS PRIME Z690-P DDR5', 'Obslugiwane procesory: Intel Core i9, Intel Core i7, Intel Core i5, Intel Core i3, Intel Celeron, Intel Pentium, Format: ATX, Gniazdo procesora: Socket 1700, Chipset: Intel Z690');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('2199.00', 'Plyty glówne', '9g5lw2b', 'ASUS ProArt X570-CREATOR WIFI', 'Obslugiwane procesory: AMD RyzenT, Format: ATX, Gniazdo procesora: Socket AM4, Chipset: AMD X570');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('389.00', 'Plyty glówne', '1ohm689', 'Gigabyte H510M S2H', 'Obslugiwane procesory: Intel Core i9, Intel Core i7, Intel Core i5, Intel Core i3, Intel Celeron, Intel Pentium, Format: mATX, Gniazdo procesora: Socket 1200, Chipset: Intel H510');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('429.00', 'Plyty glówne', 'ouiooh9', 'MSI H510M PRO', 'Obslugiwane procesory: Intel Core i9, Intel Core i7, Intel Core i5, Intel Core i3, Intel Celeron, Intel Pentium, Format: mATX, Gniazdo procesora: Socket 1200, Chipset: Intel H510');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('999.00', 'Plyty glówne', 'uqad769', 'ASUS ROG STRIX B560-G GAMING WIFI', 'Obslugiwane procesory: Intel Core i9, Intel Core i7, Intel Core i5, Intel Core i3, Intel Celeron, Intel Pentium, Format: mATX, Gniazdo procesora: Socket 1200, Chipset: Intel B560');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('1039.00', 'Plyty glówne', '43e1zk1', 'ASUS ROG STRIX B560-F GAMING WIFI', 'Obslugiwane procesory: Intel Core i9, Intel Core i7, Intel Core i5, Intel Core i3, Intel Celeron, Intel Pentium, Format: ATX, Gniazdo procesora: Socket 1200, Chipset: Intel B560');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('1099.00', 'Plyty glówne', '3g57ftj', 'MSI MAG Z590 TORPEDO', 'Obslugiwane procesory: Intel Core i9, Intel Core i7, Intel Core i5, Intel Core i3, Intel Celeron, Intel Pentium, Format: ATX, Gniazdo procesora: Socket 1200, Chipset: Intel Z590');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('1349.00', 'Plyty glówne', 'jw3dptw', 'MSI MAG Z590 TOMAHAWK WIFI', 'Obslugiwane procesory: Intel Core i9, Intel Core i7, Intel Core i5, Intel Core i3, Intel Celeron, Intel Pentium, Format: ATX, Gniazdo procesora: Socket 1200, Chipset: Intel Z590');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('1899.00', 'Plyty glówne', '483qwyo', 'MSI MEG Z590 UNIFY', 'Obslugiwane procesory: Intel Core i9, Intel Core i7, Intel Core i5, Intel Core i3, Intel Celeron, Intel Pentium, Format: ATX, Gniazdo procesora: Socket 1200, Chipset: Intel Z590');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('549.00', 'Plyty glówne', '14h17d7', 'MSI B550M PRO', 'Obslugiwane procesory: AMD RyzenT, Format: mATX, Gniazdo procesora: Socket AM4, Chipset: AMD B550');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('489.00', 'Plyty glówne', 'vcvfxhw', 'ASRock B560M-HDV', 'Obslugiwane procesory: Intel Core i9, Intel Core i7, Intel Core i5, Intel Core i3, Intel Celeron, Intel Pentium, Format: mATX, Gniazdo procesora: Socket 1200, Chipset: Intel B560');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('729.00', 'Plyty glówne', 'noriyzl', 'ASRock B560 Steel Legend', 'Obslugiwane procesory: Intel Core i9, Intel Core i7, Intel Core i5, Intel Core i3, Intel Celeron, Intel Pentium, Format: ATX, Gniazdo procesora: Socket 1200, Chipset: Intel B560');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('769.00', 'Plyty glówne', '4iarlla', 'ASRock Z590 Phantom Gaming 4', 'Obslugiwane procesory: Intel Core i9, Intel Core i7, Intel Core i5, Intel Core i3, Intel Celeron, Intel Pentium, Format: ATX, Gniazdo procesora: Socket 1200, Chipset: Intel Z590');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('1139.00', 'Plyty glówne', '6mjcvmc', 'ASRock Z590 Extreme', 'Obslugiwane procesory: Intel Core i9, Intel Core i7, Intel Core i5, Intel Core i3, Intel Celeron, Intel Pentium, Format: ATX, Gniazdo procesora: Socket 1200, Chipset: Intel Z590');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('2079.00', 'Plyty glówne', 'nwgjpmx', 'ASRock Z590 Taichi', 'Obslugiwane procesory: Intel Core i9, Intel Core i7, Intel Core i5, Intel Core i3, Intel Celeron, Intel Pentium, Format: ATX, Gniazdo procesora: Socket 1200, Chipset: Intel Z590');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('1549.00', 'Plyty glówne', 'ug82map', 'Gigabyte Z590I VISION D', 'Obslugiwane procesory: Intel Core i9, Intel Core i7, Intel Core i5, Intel Core i3, Intel Celeron, Intel Pentium, Format: mITX, Gniazdo procesora: Socket 1200, Chipset: Intel Z590');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('1659.00', 'Plyty glówne', 'ski90c8', 'Gigabyte Z590 VISION D', 'Obslugiwane procesory: Intel Core i9, Intel Core i7, Intel Core i5, Intel Core i3, Intel Celeron, Intel Pentium, Format: ATX, Gniazdo procesora: Socket 1200, Chipset: Intel Z590');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('1619.00', 'Plyty glówne', 'vhiu271', 'ASRock B550 Taichi Razer Edition', 'Obslugiwane procesory: AMD RyzenT, Format: ATX, Gniazdo procesora: Socket AM4, Chipset: AMD B550');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('299.00', 'Plyty glówne', '1lcb5ua', 'Gigabyte A520M S2H', 'Obslugiwane procesory: AMD RyzenT, Format: mATX, Gniazdo procesora: Socket AM4, Chipset: AMD A520');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('389.00', 'Plyty glówne', '2k9imxj', 'Gigabyte B550M S2H', 'Obslugiwane procesory: AMD RyzenT, Format: mATX, Gniazdo procesora: Socket AM4, Chipset: AMD B550');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('499.00', 'Plyty glówne', 'bcz0lum', 'MSI MAG A520M VECTOR WIFI', 'Obslugiwane procesory: AMD RyzenT, Format: mATX, Gniazdo procesora: Socket AM4, Chipset: AMD A520');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('379.00', 'Plyty glówne', 'bbewje3', 'MSI A520M-A PRO', 'Obslugiwane procesory: AMD RyzenT, Format: mATX, Gniazdo procesora: Socket AM4, Chipset: AMD A520');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('869.00', 'Plyty glówne', 'p8yxq84', 'ASRock B550 Steel Legend', 'Obslugiwane procesory: AMD RyzenT, Format: ATX, Gniazdo procesora: Socket AM4, Chipset: AMD B550');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('559.00', 'Plyty glówne', '56zrqp1', 'ASUS PRIME B550M-K', 'Obslugiwane procesory: AMD RyzenT, Format: mATX, Gniazdo procesora: Socket AM4, Chipset: AMD B550');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('799.00', 'Plyty glówne', '0j1wpyt', 'ASUS PRIME B550M-A (WI-FI)', 'Obslugiwane procesory: AMD RyzenT, Format: mATX, Gniazdo procesora: Socket AM4, Chipset: AMD B550');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('799.00', 'Plyty glówne', 'esvqlnz', 'ASUS TUF GAMING B550M-PLUS', 'Obslugiwane procesory: AMD RyzenT, Format: mATX, Gniazdo procesora: Socket AM4, Chipset: AMD B550');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('999.00', 'Plyty glówne', 'j9puphl', 'ASUS TUF GAMING B550M-PLUS (WI-FI)', 'Obslugiwane procesory: AMD RyzenT, Format: mATX, Gniazdo procesora: Socket AM4, Chipset: AMD B550');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('409.00', 'Plyty glówne', 'nku71qh', 'ASUS PRIME H410M-A', 'Obslugiwane procesory: Intel Core i9, Intel Core i7, Intel Core i5, Intel Core i3, Intel Celeron, Intel Pentium, Format: mATX, Gniazdo procesora: Socket 1200, Chipset: Intel H410');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('329.00', 'Plyty glówne', 'har5evb', 'Gigabyte B450M S2H', 'Obslugiwane procesory: AMD RyzenT, Format: mATX, Gniazdo procesora: Socket AM4, Chipset: AMD B450');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('1619.00', 'Plyty glówne', '3na5qil', 'ASRock X570 Taichi', 'Obslugiwane procesory: AMD RyzenT, Format: ATX, Gniazdo procesora: Socket AM4, Chipset: AMD X570');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('4059.00', 'Plyty glówne', 'ochetdu', 'Gigabyte X570 AORUS XTREME', 'Obslugiwane procesory: AMD RyzenT, Format: ATX, Gniazdo procesora: Socket AM4, Chipset: AMD X570');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('319.00', 'Plyty glówne', '7k7aiow', 'ASUS PRIME H310M-R R2.0 ', 'Obslugiwane procesory: Intel Core i7, Intel Core i5, Intel Core i3, Intel Celeron, Intel Pentium, Format: mATX, Gniazdo procesora: Socket 1151, Chipset: Intel H310');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('409.00', 'Plyty glówne', '9f1zhm8', 'Gigabyte B450 Gaming X', 'Obslugiwane procesory: AMD RyzenT, Format: ATX, Gniazdo procesora: Socket AM4, Chipset: AMD B450');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('369.00', 'Plyty glówne', 'sdvh2xr', 'ASUS PRIME H310M-E R2.0', 'Obslugiwane procesory: Intel Core i7, Intel Core i5, Intel Core i3, Format: mATX, Gniazdo procesora: Socket 1151, Chipset: Intel H310');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('279.00', 'Plyty glówne', 'vp190a9', 'ASUS PRIME A320M-A', 'Obslugiwane procesory: AMD RyzenT, Format: mATX, Gniazdo procesora: Socket AM4, Chipset: AMD A320');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('459.00', 'Plyty glówne', 'hn2gmwk', 'Gigabyte B450 AORUS M', 'Obslugiwane procesory: AMD RyzenT, Format: mATX, Gniazdo procesora: Socket AM4, Chipset: AMD B450');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('489.00', 'Plyty glówne', '1u57hp4', 'ASRock Fatal1ty B450 Gaming K4', 'Obslugiwane procesory: AMD RyzenT, Format: ATX, Gniazdo procesora: Socket AM4, Chipset: AMD B450');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('419.00', 'Plyty glówne', 'hkfi7n7', 'ASRock B560M-HDV R2.0', 'Obslugiwane procesory: Intel Core i9, Intel Core i7, Intel Core i5, Intel Core i3, Intel Celeron, Intel Pentium, Format: mATX, Gniazdo procesora: Socket 1200, Chipset: Intel B560');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('389.00', 'Plyty glówne', '0v82qdl', 'ASRock H470M-HDV/M.2', 'Obslugiwane procesory: Intel Core i9, Intel Core i7, Intel Core i5, Intel Core i3, Intel Celeron, Intel Pentium, Format: mATX, Gniazdo procesora: Socket 1200, Chipset: Intel H470');

INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('283.90', 'Dyski', 'kbk9xh6', 'Samsung 500GB M.2 PCIe NVMe 980', 'Pojemnosc: 500 GB, Interfejs: M.2 PCIe NVMe 3.0 x4, Predkosc odczytu: 3100 MB/s, Predkosc zapisu: 2600 MB/s');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('269.00', 'Dyski', 'zskf9t5', 'Crucial 500GB 2,5 SATA SSD MX500', 'Pojemnosc: 500 GB, Interfejs: 2,5 SATA, Predkosc odczytu: 560 MB/s, Predkosc zapisu: 510 MB/s');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('519.00', 'Dyski', 'dz0zbcb', 'Samsung 1TB M.2 PCIe NVMe 980', 'Pojemnosc: 1000 GB, Interfejs: M.2 PCIe NVMe 3.0 x4, Predkosc odczytu: 3500 MB/s, Predkosc zapisu: 3000 MB/s');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('419.00', 'Dyski', '7cqgulv', 'WD 1TB M.2 PCIe NVMe Blue SN570', 'Pojemnosc: 1000 GB, Interfejs: M.2 PCIe NVMe 3.0 x4, Predkosc odczytu: 3500 MB/s, Predkosc zapisu: 3000 MB/s');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('219.00', 'Dyski', '7zqwrho', 'GOODRAM 512GB 2,5 SATA SSD CX400', 'Pojemnosc: 512 GB, Interfejs: 2,5 SATA, Predkosc odczytu: 550 MB/s, Predkosc zapisu: 500 MB/s');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('134.99', 'Dyski', 'ks6oym1', 'GOODRAM 256GB 2,5 SATA SSD CX400', 'Pojemnosc: 256 GB, Interfejs: 2,5 SATA, Predkosc odczytu: 550 MB/s, Predkosc zapisu: 480 MB/s');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('429.00', 'Dyski', '9684mpq', 'Crucial 1TB 2,5 SATA SSD MX500', 'Pojemnosc: 1000 GB, Interfejs: 2,5 SATA, Predkosc odczytu: 560 MB/s, Predkosc zapisu: 510 MB/s');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('469.00', 'Dyski', 'zjkz1tn', 'WD 1TB M.2 PCIe Gen4 NVMe Black SN750 SE', 'Pojemnosc: 1000 GB, Interfejs: M.2 PCIe NVMe 4.0 x4, Predkosc odczytu: 3600 MB/s, Predkosc zapisu: 2830 MB/s');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('319.00', 'Dyski', '053c7j3', 'Samsung 500GB 2,5 SATA SSD 870 EVO', 'Pojemnosc: 500 GB, Interfejs: 2,5 SATA, Predkosc odczytu: 560 MB/s, Predkosc zapisu: 530 MB/s');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('259.00', 'Dyski', '45sqmp3', 'Seagate BARRACUDA 2TB 7200obr. 256MB ', 'Pojemnosc: 2000 GB, Interfejs: SATA III, Format: 3.5, Predkosc obr.: 7200 obr./min');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('589.00', 'Dyski', 'gelnzk9', 'Samsung 1TB M.2 PCIe NVMe 970 EVO Plus', 'Pojemnosc: 1000 GB, Interfejs: M.2 PCIe NVMe 3.0 x4, Predkosc odczytu: 3500 MB/s, Predkosc zapisu: 3300 MB/s');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('129.90', 'Dyski', 'htmh6eh', 'ADATA 256GB 2,5 SATA SSD Ultimate SU650', 'Pojemnosc: 256 GB, Interfejs: 2,5 SATA, Predkosc odczytu: 520 MB/s, Predkosc zapisu: 450 MB/s');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('199.00', 'Dyski', 'pf82ybl', 'Crucial 250GB 2,5 SATA SSD MX500', 'Pojemnosc: 250 GB, Interfejs: 2,5 SATA, Predkosc odczytu: 560 MB/s, Predkosc zapisu: 510 MB/s');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('206.00', 'Dyski', 'ycl3c9f', 'KIOXIA 480GB 2,5 SATA SSD EXCERIA', 'Pojemnosc: 480 GB, Interfejs: 2,5 SATA, Predkosc odczytu: 555 MB/s, Predkosc zapisu: 540 MB/s');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('799.00', 'Dyski', 'bona0ys', 'Samsung 1TB M.2 PCIe Gen4 NVMe 980 PRO', 'Pojemnosc: 1000 GB, Interfejs: M.2 PCIe NVMe 4.0 x4, Predkosc odczytu: 7000 MB/s, Predkosc zapisu: 5000 MB/s');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('519.00', 'Dyski', 'f0laip2', 'Samsung 1TB 2,5 SATA SSD 870 EVO', 'Pojemnosc: 1000 GB, Interfejs: 2,5 SATA, Predkosc odczytu: 560 MB/s, Predkosc zapisu: 530 MB/s');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('349.00', 'Dyski', 'lp5afun', 'Samsung 500GB M.2 PCIe NVMe 970 EVO Plus', 'Pojemnosc: 500 GB, Interfejs: M.2 PCIe NVMe 3.0 x4, Predkosc odczytu: 3500 MB/s, Predkosc zapisu: 3200 MB/s');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('209.00', 'Dyski', 'zvzxoqs', 'Seagate Expansion Portable 1TB USB 3.2 Gen. 1 Czarny', 'Pojemnosc: 1000 GB, Interfejs: USB 3.2 Gen. 1, Format: 2.5, Kolor: Czarny');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('89.00', 'Dyski', 'b0uxm3g', 'GOODRAM 128GB 2,5 SATA SSD CX400', 'Pojemnosc: 128 GB, Interfejs: 2,5 SATA, Predkosc odczytu: 550 MB/s, Predkosc zapisu: 460 MB/s');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('649.00', 'Dyski', 'e0h6pzk', 'Crucial 1TB M.2 PCIe Gen4 NVMe P5 Plus', 'Pojemnosc: 1000 GB, Interfejs: M.2 PCIe NVMe 4.0 x4, Predkosc odczytu: 6600 MB/s, Predkosc zapisu: 5000 MB/s');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('229.00', 'Dyski', 'fv2pvun', 'Kingston 500GB M.2 PCIe NVMe NV1', 'Pojemnosc: 500 GB, Interfejs: M.2 PCIe NVMe 3.0 x4, Predkosc odczytu: 2100 MB/s, Predkosc zapisu: 1700 MB/s');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('429.00', 'Dyski', 'wr28o3m', 'Samsung 1TB 2,5 SATA SSD 870 QVO', 'Pojemnosc: 1000 GB, Interfejs: 2,5 SATA, Predkosc odczytu: 560 MB/s, Predkosc zapisu: 530 MB/s');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('259.00', 'Dyski', '3ymvi0d', 'PNY 500GB M.2 PCIe NVMe XLR8 CM3031', 'Pojemnosc: 500 GB, Interfejs: M.2 PCIe NVMe 3.0 x4, Predkosc odczytu: 3500 MB/s, Predkosc zapisu: 2000 MB/s');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('279.00', 'Dyski', '02n7wvg', 'Seagate Expansion Portable 2TB USB 3.2 Gen. 1 Czarny', 'Pojemnosc: 2000 GB, Interfejs: USB 3.2 Gen. 1, Format: 2.5, Kolor: Czarny');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('139.90', 'Dyski', 'qxfz5ct', 'Kingston 240GB 2,5 SATA SSD A400 ', 'Pojemnosc: 240 GB, Interfejs: 2,5 SATA, Predkosc odczytu: 500 MB/s, Predkosc zapisu: 350 MB/s');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('169.00', 'Dyski', 'a8i37fo', 'Toshiba P300 1TB 7200obr. 64MB OEM', 'Pojemnosc: 1000 GB, Interfejs: SATA III, Format: 3.5, Predkosc obr.: 7200 obr./min');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('269.00', 'Dyski', 's4z8a4m', 'Toshiba Canvio Basics 2TB USB 3.2 Gen. 1 Czarny', 'Pojemnosc: 2000 GB, Interfejs: USB 3.2 Gen. 1, Format: 2.5, Kolor: Czarny');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('429.00', 'Dyski', 'k5khzhf', 'Kingston 1TB M.2 PCIe NVMe NV1', 'Pojemnosc: 1000 GB, Interfejs: M.2 PCIe NVMe 3.0 x4, Predkosc odczytu: 2100 MB/s, Predkosc zapisu: 1700 MB/s');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('225.00', 'Dyski', '5nt99gg', 'ADATA 512GB 2,5 SATA SSD Ultimate SU650', 'Pojemnosc: 512 GB, Interfejs: 2,5 SATA, Predkosc odczytu: 520 MB/s, Predkosc zapisu: 450 MB/s');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('569.00', 'Dyski', '4wht132', 'Samsung Portable SSD T7 1TB USB 3.2 Gen. 2 Szary', 'Pojemnosc: 1000 GB, Interfejs: USB 3.2 Gen. 2, Predkosc odczytu: 1050 MB/s, Predkosc zapisu: 1000 MB/s');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('153.00', 'Dyski', '1e3l5yr', 'Crucial 240GB 2,5 SATA SSD BX500 ', 'Pojemnosc: 240 GB, Interfejs: 2,5 SATA, Predkosc odczytu: 540 MB/s, Predkosc zapisu: 500 MB/s');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('129.90', 'Dyski', '8x9w34f', 'PNY 240GB 2,5 SATA SSD CS900', 'Pojemnosc: 240 GB, Interfejs: 2,5 SATA, Predkosc odczytu: 535 MB/s, Predkosc zapisu: 500 MB/s');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('239.00', 'Dyski', '36re5ng', 'Silicon Power 512GB 2,5 SATA SSD A55 ', 'Pojemnosc: 512 GB, Interfejs: 2,5 SATA, Predkosc odczytu: 560 MB/s, Predkosc zapisu: 530 MB/s');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('195.00', 'Dyski', 'uz489iy', 'Toshiba Canvio Basics 1TB USB 3.2 Gen. 1 Czarny', 'Pojemnosc: 1000 GB, Interfejs: USB 3.2 Gen. 1, Format: 2.5, Kolor: Czarny');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('259.00', 'Dyski', 'hrojauu', 'WD 500GB M.2 PCIe NVMe Blue SN570', 'Pojemnosc: 500 GB, Interfejs: M.2 PCIe NVMe 3.0 x4, Predkosc odczytu: 3500 MB/s, Predkosc zapisu: 2300 MB/s');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('309.00', 'Dyski', '1r66sy7', 'Gigabyte 512GB M.2 PCIe NVMe M30', 'Pojemnosc: 512 GB, Interfejs: M.2 PCIe NVMe 3.0 x4, Predkosc odczytu: 3500 MB/s, Predkosc zapisu: 2600 MB/s');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('519.00', 'Dyski', 'zumgmab', 'PNY 1TB M.2 PCIe NVMe XLR8 CS3030 ', 'Pojemnosc: 1000 GB, Interfejs: M.2 PCIe NVMe 3.0 x4, Predkosc odczytu: 3500 MB/s, Predkosc zapisu: 3000 MB/s');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('339.00', 'Dyski', '21o6ovg', 'Samsung Portable SSD T7 500GB USB 3.2 Gen. 2 Szary', 'Pojemnosc: 500 GB, Interfejs: USB 3.2 Gen. 2, Predkosc odczytu: 1050 MB/s, Predkosc zapisu: 1000 MB/s');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('299.00', 'Dyski', 'p9n6q31', 'WD Elements Portable 2TB USB 3.2 Gen. 1 Czarny', 'Pojemnosc: 2000 GB, Interfejs: USB 3.2 Gen. 1, Format: 2.5, Kolor: Czarny');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('509.00', 'Dyski', 'gum2jvb', 'Seagate Expansion Portable 5TB USB 3.2 Gen. 1 Czarny', 'Pojemnosc: 5000 GB, Interfejs: USB 3.2 Gen. 1, Format: 2.5, Kolor: Czarny');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('86.90', 'Dyski', 'nvjmzj5', 'Patriot 128GB 2,5 SATA SSD P210', 'Pojemnosc: 128 GB, Interfejs: 2,5 SATA, Predkosc odczytu: 450 MB/s, Predkosc zapisu: 430 MB/s');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('215.00', 'Dyski', 'er2wixq', 'WD Elements Portable 1TB USB 3.2 Gen. 1 Czarny', 'Pojemnosc: 1000 GB, Interfejs: USB 3.2 Gen. 1, Format: 2.5, Kolor: Czarny');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('279.00', 'Dyski', '20ov0ol', 'ADATA 512GB 2,5 SATA SSD Ultimate SU800', 'Pojemnosc: 512 GB, Interfejs: 2,5 SATA, Predkosc odczytu: 560 MB/s, Predkosc zapisu: 520 MB/s');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('469.00', 'Dyski', 'ts0c6ft', 'LaCie Mobile Drive 2TB USB 3.2 Gen. 1 Srebrny', 'Pojemnosc: 2000 GB, Interfejs: USB 3.2 Gen. 1, Format: 2.5, Kolor: Srebrny');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('229.00', 'Dyski', 'a0pdo0n', 'Crucial 480GB 2,5 SATA SSD BX500 ', 'Pojemnosc: 480 GB, Interfejs: 2,5 SATA, Predkosc odczytu: 540 MB/s, Predkosc zapisu: 500 MB/s');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('519.00', 'Dyski', 'eftzllk', 'Samsung 500GB M.2 PCIe Gen4 NVMe 980 PRO', 'Pojemnosc: 500 GB, Interfejs: M.2 PCIe NVMe 4.0 x4, Predkosc odczytu: 6900 MB/s, Predkosc zapisu: 5000 MB/s');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('279.00', 'Dyski', 'qwjhfko', 'GOODRAM HL100 512GB USB 3.2 Gen. 2 Szary', 'Pojemnosc: 512 GB, Interfejs: USB 3.2 Gen. 2, Predkosc odczytu: 450 MB/s, Predkosc zapisu: 420 MB/s');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('165.00', 'Dyski', 'u9fjh14', 'GOODRAM HL100 256GB USB 3.2 Gen. 2 Szary', 'Pojemnosc: 256 GB, Interfejs: USB 3.2 Gen. 2, Predkosc odczytu: 450 MB/s, Predkosc zapisu: 420 MB/s');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('83.00', 'Dyski', 'djj5dke', 'GOODRAM 120GB 2,5 SATA SSD CL100 gen.3', 'Pojemnosc: 120 GB, Interfejs: 2,5 SATA, Predkosc odczytu: 500 MB/s, Predkosc zapisu: 360 MB/s');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('1149.00', 'Dyski', 'rms4xcx', 'Samsung 2TB M.2 PCIe NVMe 970 EVO Plus', 'Pojemnosc: 2000 GB, Interfejs: M.2 PCIe NVMe 3.0 x4, Predkosc odczytu: 3500 MB/s, Predkosc zapisu: 3300 MB/s');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('219.00', 'Dyski', '557xcac', 'Patriot 512GB 2,5 SATA SSD P210', 'Pojemnosc: 512 GB, Interfejs: 2,5 SATA, Predkosc odczytu: 520 MB/s, Predkosc zapisu: 430 MB/s');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('569.00', 'Dyski', '71516ep', 'Samsung Portable SSD T7 1TB USB 3.2 Gen. 2 Niebieski', 'Pojemnosc: 1000 GB, Interfejs: USB 3.2 Gen. 2, Predkosc odczytu: 1050 MB/s, Predkosc zapisu: 1000 MB/s');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('129.00', 'Dyski', 'bk4hjua', 'GOODRAM 240GB 2,5 SATA SSD CL100 gen.3', 'Pojemnosc: 240 GB, Interfejs: 2,5 SATA, Predkosc odczytu: 520 MB/s, Predkosc zapisu: 400 MB/s');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('509.00', 'Dyski', '6j5hag9', 'Seagate IRONWOLF CMR 4TB 5900obr. 64MB ', 'Pojemnosc: 4000 GB, Interfejs: SATA III, Format: 3.5, Predkosc obr.: 5900 obr./min');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('289.00', 'Dyski', 'j1ori21', 'KIOXIA 500GB M.2 PCIe NVMe EXCERIA PLUS G2', 'Pojemnosc: 500 GB, Interfejs: M.2 PCIe NVMe 3.0 x4, Predkosc odczytu: 3400 MB/s, Predkosc zapisu: 3200 MB/s');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('209.00', 'Dyski', 'diwez1h', 'Patriot 480GB 2,5 SATA SSD BURST ELITE', 'Pojemnosc: 480 GB, Interfejs: 2,5 SATA, Predkosc odczytu: 450 MB/s, Predkosc zapisu: 320 MB/s');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('384.00', 'Dyski', 'tpeigyq', 'Crucial 500GB M.2 PCIe Gen4 NVMe P5 Plus', 'Pojemnosc: 500 GB, Interfejs: M.2 PCIe NVMe 4.0 x4, Predkosc odczytu: 6600 MB/s, Predkosc zapisu: 4000 MB/s');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('429.00', 'Dyski', 'czwnsw9', 'Samsung Portable SSD T7 Touch 500GB USB 3.2 Gen. 2 Czarny', 'Pojemnosc: 500 GB, Interfejs: USB 3.2 Gen. 2, Predkosc odczytu: 1050 MB/s, Predkosc zapisu: 1000 MB/s');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('244.00', 'Dyski', 'vcqb5dw', 'KIOXIA 500GB M.2 PCIe NVMe EXCERIA', 'Pojemnosc: 500 GB, Interfejs: M.2 PCIe NVMe 3.0 x4, Predkosc odczytu: 1700 MB/s, Predkosc zapisu: 1600 MB/s');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('649.00', 'Dyski', '0qixny8', 'SanDisk Extreme Portable SSD 1TB USB 3.2 Gen.2 Granatowy', 'Pojemnosc: 1000 GB, Interfejs: USB 3.2 Gen. 2, Predkosc odczytu: 1050 MB/s, Predkosc zapisu: 1000 MB/s');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('154.00', 'Dyski', 'bhdu43m', 'KIOXIA 240GB 2,5 SATA SSD EXCERIA', 'Pojemnosc: 240 GB, Interfejs: 2,5 SATA, Predkosc odczytu: 555 MB/s, Predkosc zapisu: 540 MB/s');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('239.00', 'Dyski', '4105rsh', 'GOODRAM 512GB M.2 PCIe NVMe PX500', 'Pojemnosc: 512 GB, Interfejs: M.2 PCIe NVMe 3.0 x4, Predkosc odczytu: 2000 MB/s, Predkosc zapisu: 1600 MB/s');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('839.00', 'Dyski', 'b2eze2s', 'Samsung 2TB 2,5 SATA SSD 870 QVO', 'Pojemnosc: 2000 GB, Interfejs: 2,5 SATA, Predkosc odczytu: 560 MB/s, Predkosc zapisu: 530 MB/s');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('399.00', 'Dyski', 'ggc6wvt', 'SanDisk Extreme Portable SSD 500GB USB 3.2 Gen.2 Granatowy', 'Pojemnosc: 500 GB, Interfejs: USB 3.2 Gen. 2, Predkosc odczytu: 1050 MB/s, Predkosc zapisu: 1000 MB/s');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('87.00', 'Dyski', '07u4asa', 'PNY 120GB 2,5 SATA SSD CS900', 'Pojemnosc: 120 GB, Interfejs: 2,5 SATA, Predkosc odczytu: 515 MB/s, Predkosc zapisu: 490 MB/s');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('259.00', 'Dyski', 'rs4y4w2', 'MSI 500GB M.2 PCIe NVMe Spatium M390', 'Pojemnosc: 500 GB, Interfejs: M.2 PCIe NVMe 3.0 x4, Predkosc odczytu: 3300 MB/s, Predkosc zapisu: 2300 MB/s');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('529.00', 'Dyski', 'lqhmvo9', 'ADATA 1TB M.2 PCIe NVMe XPG SX8200 Pro (2021)', 'Pojemnosc: 1000 GB, Interfejs: M.2 PCIe NVMe 3.0 x4, Predkosc odczytu: 3500 MB/s, Predkosc zapisu: 3000 MB/s');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('129.00', 'Dyski', 'ye8i7p6', 'Patriot 240GB 2,5 SATA SSD BURST ELITE', 'Pojemnosc: 240 GB, Interfejs: 2,5 SATA, Predkosc odczytu: 450 MB/s, Predkosc zapisu: 320 MB/s');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('399.00', 'Dyski', 'bazgh45', 'Patriot 1TB 2,5 SATA SSD P210', 'Pojemnosc: 1000 GB, Interfejs: 2,5 SATA, Predkosc odczytu: 520 MB/s, Predkosc zapisu: 430 MB/s');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('259.00', 'Dyski', '5obr0gt', 'Samsung 250GB 2,5 SATA SSD 870 EVO', 'Pojemnosc: 250 GB, Interfejs: 2,5 SATA, Predkosc odczytu: 560 MB/s, Predkosc zapisu: 530 MB/s');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('499.00', 'Dyski', 'ikbkf15', 'GOODRAM HL100 1TB USB 3.2 Gen. 2 Szary', 'Pojemnosc: 1000 GB, Interfejs: USB 3.2 Gen. 2, Predkosc odczytu: 450 MB/s, Predkosc zapisu: 420 MB/s');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('239.00', 'Dyski', 'z6sbgul', 'Kingston 480GB 2,5 SATA SSD A400 ', 'Pojemnosc: 480 GB, Interfejs: 2,5 SATA, Predkosc odczytu: 500 MB/s, Predkosc zapisu: 450 MB/s');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('699.00', 'Dyski', '3wuddfq', 'ADATA 1TB M.2 PCIe Gen4 NVMe GAMMIX S70 Blade', 'Pojemnosc: 1000 GB, Interfejs: M.2 PCIe NVMe 4.0 x4, Predkosc odczytu: 7400 MB/s, Predkosc zapisu: 5500 MB/s');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('139.90', 'Dyski', 'serw48r', 'Patriot 256GB 2,5 SATA SSD P210', 'Pojemnosc: 256 GB, Interfejs: 2,5 SATA, Predkosc odczytu: 500 MB/s, Predkosc zapisu: 400 MB/s');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('149.00', 'Dyski', 'bf6vipp', 'Lexar 256GB M.2 PCIe NVMe NM620', 'Pojemnosc: 256 GB, Interfejs: M.2 PCIe NVMe 3.0 x4, Predkosc odczytu: 3000 MB/s, Predkosc zapisu: 1300 MB/s');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('569.00', 'Dyski', '4782yam', 'Samsung Portable SSD T7 1TB USB 3.2 Gen. 2 Czerwony', 'Pojemnosc: 1000 GB, Interfejs: USB 3.2 Gen. 2, Predkosc odczytu: 1050 MB/s, Predkosc zapisu: 1000 MB/s');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('425.00', 'Dyski', 'fgfbitb', 'Toshiba Canvio Basics 4TB USB 3.2 Gen. 1 Czarny', 'Pojemnosc: 4000 GB, Interfejs: USB 3.2 Gen. 1, Format: 2.5, Kolor: Czarny');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('205.00', 'Dyski', '2qo7ac1', 'WD BLUE 1TB 7200obr. 64MB CMR', 'Pojemnosc: 1000 GB, Interfejs: SATA III, Format: 3.5, Predkosc obr.: 7200 obr./min');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('149.00', 'Dyski', 'gtym4nx', 'GOODRAM 256GB M.2 PCIe NVMe PX500', 'Pojemnosc: 256 GB, Interfejs: M.2 PCIe NVMe 3.0 x4, Predkosc odczytu: 1850 MB/s, Predkosc zapisu: 950 MB/s');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('219.00', 'Dyski', 'zxp9f69', 'PNY Elite Portable SSD 480GB USB 3.2 Gen. 1 Czarny', 'Pojemnosc: 480 GB, Interfejs: USB 3.2 Gen. 1, Predkosc odczytu: 430 MB/s, Predkosc zapisu: 400 MB/s');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('399.99', 'Dyski', '1xmofen', 'GOODRAM 1TB 2,5 SATA SSD CX400', 'Pojemnosc: 1024 GB, Interfejs: 2,5 SATA, Predkosc odczytu: 550 MB/s, Predkosc zapisu: 500 MB/s');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('179.00', 'Dyski', '8muunpj', 'GOODRAM 256GB M.2 PCIe NVMe IRDM', 'Pojemnosc: 256 GB, Interfejs: M.2 PCIe NVMe 3.0 x4, Predkosc odczytu: 3000 MB/s, Predkosc zapisu: 1000 MB/s');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('279.00', 'Dyski', 'zqzhmyx', 'Samsung 250GB M.2 PCIe NVMe 970 EVO Plus', 'Pojemnosc: 250 GB, Interfejs: M.2 PCIe NVMe 3.0 x4, Predkosc odczytu: 3500 MB/s, Predkosc zapisu: 2300 MB/s');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('225.00', 'Dyski', 'nio6wyp', 'Seagate BARRACUDA 1TB 5400obr. 128MB ', 'Pojemnosc: 1000 GB, Interfejs: SATA III, Format: 2.5, Predkosc obr.: 5400 obr./min');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('209.00', 'Dyski', 'szdcxdb', 'Seagate BARRACUDA 1TB 7200obr. 64MB ', 'Pojemnosc: 1000 GB, Interfejs: SATA III, Format: 3.5, Predkosc obr.: 7200 obr./min');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('499.00', 'Dyski', '4cr69ni', 'Patriot 1TB M.2 PCIe NVMe Viper VPN110', 'Pojemnosc: 1000 GB, Interfejs: M.2 PCIe NVMe 3.0 x4, Predkosc odczytu: 3300 MB/s, Predkosc zapisu: 3000 MB/s');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('435.00', 'Dyski', 'gd2p8na', 'Seagate Expansion Portable 4TB USB 3.2 Gen. 1 Czarny', 'Pojemnosc: 4000 GB, Interfejs: USB 3.2 Gen. 1, Format: 2.5, Kolor: Czarny');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('229.00', 'Dyski', 'gz13hkn', 'PNY 480GB 2,5 SATA SSD CS900', 'Pojemnosc: 480 GB, Interfejs: 2,5 SATA, Predkosc odczytu: 550 MB/s, Predkosc zapisu: 500 MB/s');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('479.00', 'Dyski', 'o8tsq8o', 'MSI 1TB M.2 PCIe NVMe Spatium M390', 'Pojemnosc: 1000 GB, Interfejs: M.2 PCIe NVMe 3.0 x4, Predkosc odczytu: 3300 MB/s, Predkosc zapisu: 3000 MB/s');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('789.00', 'Dyski', 'xrr1mi6', 'Seagate IRONWOLF CMR 6TB 5400obr. 256MB', 'Pojemnosc: 6000 GB, Interfejs: SATA III, Format: 3.5, Predkosc obr.: 5400 obr./min');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('169.00', 'Dyski', 'ohmolpg', 'PNY Elite Portable SSD 240GB USB 3.2 Gen. 1 Czarny', 'Pojemnosc: 240 GB, Interfejs: USB 3.2 Gen. 1, Predkosc odczytu: 430 MB/s, Predkosc zapisu: 400 MB/s');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('1099.00', 'Dyski', 'fxpzkpm', 'Samsung Portable SSD T7 2TB USB 3.2 Gen. 2 Szary', 'Pojemnosc: 2000 GB, Interfejs: USB 3.2 Gen. 2, Predkosc odczytu: 1050 MB/s, Predkosc zapisu: 1000 MB/s');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('369.00', 'Dyski', '0mkq3xp', 'Samsung Portable SSD T7 500GB USB 3.2 Gen. 2 Niebieski', 'Pojemnosc: 500 GB, Interfejs: USB 3.2 Gen. 2, Predkosc odczytu: 1050 MB/s, Predkosc zapisu: 1000 MB/s');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('299.00', 'Dyski', 'e9msp4t', 'ADATA 512GB M.2 PCIe NVMe XPG SX8200 Pro (2021)', 'Pojemnosc: 512 GB, Interfejs: M.2 PCIe NVMe 3.0 x4, Predkosc odczytu: 3500 MB/s, Predkosc zapisu: 2300 MB/s');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('359.00', 'Dyski', 'wjzvfe3', 'Toshiba P300 3TB 7200obr. 64MB OEM', 'Pojemnosc: 3000 GB, Interfejs: SATA III, Format: 3.5, Predkosc obr.: 7200 obr./min');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('1659.00', 'Dyski', 'soo66gj', 'Samsung 4TB 2,5 SATA SSD 870 QVO', 'Pojemnosc: 4000 GB, Interfejs: 2,5 SATA, Predkosc odczytu: 560 MB/s, Predkosc zapisu: 530 MB/s');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('969.00', 'Dyski', 'kd4fscx', 'Samsung 1TB M.2 PCIe Gen4 NVMe 980 PRO Heatsink', 'Pojemnosc: 1000 GB, Interfejs: M.2 PCIe NVMe 4.0 x4, Predkosc odczytu: 7000 MB/s, Predkosc zapisu: 5000 MB/s');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('525.00', 'Dyski', 'ehjtuqj', 'WD RED 4TB 5400obr. 256MB DM-SMR', 'Pojemnosc: 4000 GB, Interfejs: SATA III, Format: 3.5, Predkosc obr.: 5400 obr./min');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('299.00', 'Dyski', 'i066wws', 'WD 500GB 2,5 SATA SSD Blue', 'Pojemnosc: 500 GB, Interfejs: 2,5 SATA, Predkosc odczytu: 560 MB/s, Predkosc zapisu: 530 MB/s');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('189.00', 'Dyski', 'nzdfkur', 'ADATA 256GB 2,5 SATA SSD Ultimate SU800', 'Pojemnosc: 256 GB, Interfejs: 2,5 SATA, Predkosc odczytu: 560 MB/s, Predkosc zapisu: 520 MB/s');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('269.00', 'Dyski', '86u8qf5', 'ADATA SD600Q 480GB USB 3.2 Gen. 1 Czarny', 'Pojemnosc: 480 GB, Interfejs: USB 3.2 Gen. 1, Predkosc odczytu: 440 MB/s, Predkosc zapisu: 430 MB/s');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('449.00', 'Dyski', '6tm817r', 'Seagate BARRACUDA 4TB 5400obr. 256MB ', 'Pojemnosc: 4000 GB, Interfejs: SATA III, Format: 3.5, Predkosc obr.: 5400 obr./min');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('459.00', 'Dyski', 'bpcuxsj', 'WD Elements Portable 4TB USB 3.2 Gen. 1 Czarny', 'Pojemnosc: 4000 GB, Interfejs: USB 3.2 Gen. 1, Format: 2.5, Kolor: Czarny');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('2609.00', 'Dyski', 'ps0ju17', 'Synology DS220+ 8TB (2xHDD, 2x2-2.9GHz, 2GB, 2xUSB, 2xLAN)', 'Rodzaj: Z dolaczonym dyskiem, Pojemnosc: 8 TB, Kieszenie: 2,5/3,5 - 2 szt., System plików: EXT4, Btrfs');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('154.00', 'Dyski', 'n10hsfh', 'Patriot 256GB M.2 PCIe NVMe P300', 'Pojemnosc: 256 GB, Interfejs: M.2 PCIe NVMe 3.0 x4, Predkosc odczytu: 1700 MB/s, Predkosc zapisu: 1100 MB/s');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('499.00', 'Dyski', 'mywdkpn', 'PNY Elite Portable SSD 960GB USB 3.2 Gen. 1 Czarny', 'Pojemnosc: 960 GB, Interfejs: USB 3.2 Gen. 1, Predkosc odczytu: 420 MB/s, Predkosc zapisu: 420 MB/s');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('539.00', 'Dyski', 'qs961bl', 'WD Elements Portable 5TB USB 3.2 Gen. 1 Czarny', 'Pojemnosc: 5000 GB, Interfejs: USB 3.2 Gen. 1, Format: 2.5, Kolor: Czarny');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('299.00', 'Dyski', 'kbuwbis', 'WD 500GB M.2 SATA SSD Blue', 'Pojemnosc: 500 GB, Interfejs: M.2 SATA, Predkosc odczytu: 560 MB/s, Predkosc zapisu: 530 MB/s');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('129.00', 'Dyski', 'mvy7p9r', 'Lexar 240GB 2,5 SATA SSD NQ100', 'Pojemnosc: 240 GB, Interfejs: 2,5 SATA, Predkosc odczytu: 550 MB/s, Predkosc zapisu: 445 MB/s');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('559.00', 'Dyski', '4nzh1kz', 'Kingston 1TB M.2 PCIe NVMe KC2500', 'Pojemnosc: 1000 GB, Interfejs: M.2 PCIe NVMe 3.0 x4, Predkosc odczytu: 3500 MB/s, Predkosc zapisu: 2900 MB/s');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('549.00', 'Dyski', '1qrmd60', 'WD My Passport 5TB USB 3.2 Gen. 1 Czarny', 'Pojemnosc: 5000 GB, Interfejs: USB 3.2 Gen. 1, Format: 2.5, Kolor: Czarny');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('134.00', 'Dyski', '0an4yud', 'ADATA 128GB M.2 PCIe NVMe XPG SX6000 Lite', 'Pojemnosc: 128 GB, Interfejs: M.2 PCIe NVMe 3.0 x4, Predkosc odczytu: 1800 MB/s, Predkosc zapisu: 600 MB/s');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('1749.00', 'Dyski', 'zpvq8ya', 'Samsung 2TB M.2 PCIe Gen4 NVMe 980 PRO', 'Pojemnosc: 2000 GB, Interfejs: M.2 PCIe NVMe 4.0 x4, Predkosc odczytu: 7000 MB/s, Predkosc zapisu: 5100 MB/s');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('209.90', 'Dyski', 'd8g6q7w', 'GOODRAM 480GB 2,5 SATA SSD CL100 gen.3', 'Pojemnosc: 480 GB, Interfejs: 2,5 SATA, Predkosc odczytu: 540 MB/s, Predkosc zapisu: 460 MB/s');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('469.00', 'Dyski', 'fjxa2wt', 'Patriot 1TB M.2 PCIe NVMe P300', 'Pojemnosc: 1000 GB, Interfejs: M.2 PCIe NVMe 3.0 x4, Predkosc odczytu: 2100 MB/s, Predkosc zapisu: 1650 MB/s');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('329.00', 'Dyski', 'ucj9mtm', 'Silicon Power Armor A60 2TB USB 3.2 Gen. 1 Czarno-Zielony', 'Pojemnosc: 2000 GB, Interfejs: USB 3.2 Gen. 1, Format: 2.5, Kolor: Czarno-Zielony');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('459.00', 'Dyski', 'ukd1noe', 'Lexar 1TB M.2 PCIe NVMe NM620', 'Pojemnosc: 1000 GB, Interfejs: M.2 PCIe NVMe 3.0 x4, Predkosc odczytu: 3300 MB/s, Predkosc zapisu: 3000 MB/s');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('739.00', 'Dyski', '8e13vyw', 'WD RED PRO 4TB 7200obr. 256MB CMR', 'Pojemnosc: 4000 GB, Interfejs: SATA III, Format: 3.5, Predkosc obr.: 7200 obr./min');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('359.00', 'Dyski', 'slrw0m4', 'WD 500GB 2,5 SATA SSD Red SA500', 'Pojemnosc: 500 GB, Interfejs: 2,5 SATA, Predkosc odczytu: 560 MB/s, Predkosc zapisu: 530 MB/s');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('339.00', 'Dyski', '2z388te', 'Samsung 500GB M.2 SATA SSD 860 EVO', 'Pojemnosc: 500 GB, Interfejs: M.2 SATA, Predkosc odczytu: 550 MB/s, Predkosc zapisu: 520 MB/s');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('449.00', 'Dyski', 'mlsvfxt', 'Plextor 1TB 2,5 SATA SSD M8VC Plus', 'Pojemnosc: 1000 GB, Interfejs: 2,5 SATA, Predkosc odczytu: 560 MB/s, Predkosc zapisu: 520 MB/s');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('1899.00', 'Dyski', 'xcecssi', 'WD 2TB M.2 PCIe Gen4 NVMe Black SN850 Heatsink', 'Pojemnosc: 2000 GB, Interfejs: M.2 PCIe NVMe 4.0 x4, Predkosc odczytu: 7000 MB/s, Predkosc zapisu: 5100 MB/s');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('295.00', 'Dyski', 'f8hf88c', 'Toshiba Canvio Advance 2TB USB 3.2 Gen. 1 Czarny', 'Pojemnosc: 2000 GB, Interfejs: USB 3.2 Gen. 1, Format: 2.5, Kolor: Czarny');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('809.00', 'Dyski', '23lngs3', 'Kingston 2TB M.2 PCIe NVMe NV1', 'Pojemnosc: 2000 GB, Interfejs: M.2 PCIe NVMe 3.0 x4, Predkosc odczytu: 2100 MB/s, Predkosc zapisu: 1700 MB/s');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('219.00', 'Dyski', 'vk3q50v', 'Kingston 256GB mSATA SSD KC600', 'Pojemnosc: 256 GB, Interfejs: mSATA, Predkosc odczytu: 550 MB/s, Predkosc zapisu: 500 MB/s');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('414.00', 'Dyski', '4ihqbd6', 'Crucial 1TB 2,5 SATA SSD BX500', 'Pojemnosc: 1000 GB, Interfejs: 2,5 SATA, Predkosc odczytu: 540 MB/s, Predkosc zapisu: 500 MB/s');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('839.00', 'Dyski', 'imur4vw', 'Crucial 2TB 2,5 SATA SSD MX500', 'Pojemnosc: 2000 GB, Interfejs: 2,5 SATA, Predkosc odczytu: 560 MB/s, Predkosc zapisu: 510 MB/s');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('305.00', 'Dyski', '3u3awcu', 'Seagate SKYHAWK 2TB 5400obr. 256MB ', 'Pojemnosc: 2000 GB, Interfejs: SATA III, Format: 3.5, Predkosc obr.: 5400 obr./min');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('249.00', 'Dyski', 'sgh9f1c', 'Samsung 250GB M.2 PCIe NVMe 980', 'Pojemnosc: 250 GB, Interfejs: M.2 PCIe NVMe 3.0 x4, Predkosc odczytu: 2900 MB/s, Predkosc zapisu: 1300 MB/s');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('219.90', 'Dyski', '2mwxsxm', 'Samsung 250GB M.2 SATA SSD 860 EVO', 'Pojemnosc: 250 GB, Interfejs: M.2 SATA, Predkosc odczytu: 550 MB/s, Predkosc zapisu: 520 MB/s');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('369.00', 'Dyski', 'yay74ht', 'Seagate BARRACUDA 2TB 5400obr. 128MB ', 'Pojemnosc: 2000 GB, Interfejs: SATA III, Format: 2.5, Predkosc obr.: 5400 obr./min');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('899.00', 'Dyski', 'q27m7g3', 'Patriot 2TB M.2 PCIe NVMe Viper VPN110', 'Pojemnosc: 2000 GB, Interfejs: M.2 PCIe NVMe 3.0 x4, Predkosc odczytu: 3300 MB/s, Predkosc zapisu: 3000 MB/s');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('379.00', 'Dyski', 'zaqi8ak', 'Kingston 512GB mSATA SSD KC600', 'Pojemnosc: 512 GB, Interfejs: mSATA, Predkosc odczytu: 550 MB/s, Predkosc zapisu: 520 MB/s');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('759.00', 'Dyski', 'c0r6m3q', 'WD 1TB M.2 PCIe Gen4 NVMe Black SN850', 'Pojemnosc: 1000 GB, Interfejs: M.2 PCIe NVMe 4.0 x4, Predkosc odczytu: 7000 MB/s, Predkosc zapisu: 5300 MB/s');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('219.00', 'Dyski', 'a85l9ke', 'Lexar 512GB 2,5 SATA SSD NS100', 'Pojemnosc: 512 GB, Interfejs: 2,5 SATA, Predkosc odczytu: 550 MB/s');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('309.00', 'Dyski', 'udd35bc', 'ADATA 512GB M.2 PCIe NVMe XPG SPECTRIX S40G RGB ', 'Pojemnosc: 512 GB, Interfejs: M.2 PCIe NVMe 3.0 x4, Predkosc odczytu: 3500 MB/s, Predkosc zapisu: 1900 MB/s');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('385.00', 'Dyski', 'olviujb', 'GOODRAM HX100 512GB USB 3.2 Gen. 2 Czarny', 'Pojemnosc: 512 GB, Interfejs: USB 3.2 Gen. 2, Predkosc odczytu: 950 MB/s, Predkosc zapisu: 900 MB/s');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('89.00', 'Dyski', 'lgouwbv', 'Lexar 128GB 2,5 SATA SSD NS100', 'Pojemnosc: 128 GB, Interfejs: 2,5 SATA, Predkosc odczytu: 520 MB/s');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('389.00', 'Dyski', 'agaqodp', 'GOODRAM 960GB 2,5 SATA SSD CL100 gen.3', 'Pojemnosc: 960 GB, Interfejs: 2,5 SATA, Predkosc odczytu: 540 MB/s, Predkosc zapisu: 460 MB/s');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('335.00', 'Dyski', '5bb97yf', 'GOODRAM 512GB 2,5 SATA SSD IRDM PRO GEN. 2', 'Pojemnosc: 512 GB, Interfejs: 2,5 SATA, Predkosc odczytu: 555 MB/s, Predkosc zapisu: 530 MB/s');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('1165.00', 'Dyski', '7mpd0iy', 'Seagate IRONWOLF CMR 8TB 7200obr. 256MB ', 'Pojemnosc: 8000 GB, Interfejs: SATA III, Format: 3.5, Predkosc obr.: 7200 obr./min');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('399.00', 'Dyski', 'x6x3toy', 'PNY 960GB 2,5 SATA SSD CS900', 'Pojemnosc: 960 GB, Interfejs: 2,5 SATA, Predkosc odczytu: 535 MB/s, Predkosc zapisu: 515 MB/s');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('95.00', 'Dyski', '2p1list', 'Gigabyte 120GB 2,5 SATA SSD', 'Pojemnosc: 120 GB, Interfejs: 2,5 SATA, Predkosc odczytu: 500 MB/s, Predkosc zapisu: 380 MB/s');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('139.90', 'Dyski', '7cmq8wt', 'Silicon Power 256GB 2,5 SATA SSD A55', 'Pojemnosc: 256 GB, Interfejs: 2,5 SATA, Predkosc odczytu: 550 MB/s, Predkosc zapisu: 450 MB/s');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('459.00', 'Dyski', 'jujxu7p', 'PNY 1TB M.2 PCIe NVMe XLR8 CM3031', 'Pojemnosc: 1000 GB, Interfejs: M.2 PCIe NVMe 3.0 x4, Predkosc odczytu: 3500 MB/s, Predkosc zapisu: 3000 MB/s');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('104.90', 'Dyski', '49rx48m', 'Patriot 128GB M.2 PCIe NVMe P300', 'Pojemnosc: 128 GB, Interfejs: M.2 PCIe NVMe 3.0 x4, Predkosc odczytu: 1600 MB/s, Predkosc zapisu: 600 MB/s');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('379.00', 'Dyski', 'lmy6y2c', 'Samsung Portable SSD T7 500GB USB 3.2 Gen. 2 Czerwony', 'Pojemnosc: 500 GB, Interfejs: USB 3.2 Gen. 2, Predkosc odczytu: 1050 MB/s, Predkosc zapisu: 1000 MB/s');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('269.00', 'Dyski', 'wlxxgv0', 'Crucial 500GB M.2 PCIe NVMe P2', 'Pojemnosc: 500 GB, Interfejs: M.2 PCIe NVMe 3.0 x4, Predkosc odczytu: 2300 MB/s, Predkosc zapisu: 940 MB/s');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('749.00', 'Dyski', 'jdwbven', 'Crucial 2TB 2,5 SATA SSD BX500', 'Pojemnosc: 2000 GB, Interfejs: 2,5 SATA, Predkosc odczytu: 540 MB/s, Predkosc zapisu: 500 MB/s');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('159.00', 'Dyski', 'loe9si8', 'ADATA 256GB 2,5 SATA SSD Ultimate SU750', 'Pojemnosc: 256 GB, Interfejs: 2,5 SATA, Predkosc odczytu: 550 MB/s, Predkosc zapisu: 520 MB/s');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('489.00', 'Dyski', 'qixpugv', 'WD 1TB M.2 SATA SSD Blue', 'Pojemnosc: 1000 GB, Interfejs: M.2 SATA, Predkosc odczytu: 560 MB/s, Predkosc zapisu: 530 MB/s');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('249.00', 'Dyski', 'zxvj6rx', 'GOODRAM HX100 256GB USB 3.2 Gen. 2 Czarny', 'Pojemnosc: 256 GB, Interfejs: USB 3.2 Gen. 2, Predkosc odczytu: 950 MB/s, Predkosc zapisu: 900 MB/s');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('1159.00', 'Dyski', 'jvaokqt', 'Samsung 2TB 2,5 SATA SSD 870 EVO', 'Pojemnosc: 2000 GB, Interfejs: 2,5 SATA, Predkosc odczytu: 560 MB/s, Predkosc zapisu: 530 MB/s');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('1099.00', 'Dyski', '65vh400', 'Samsung Portable SSD T7 2TB USB 3.2 Gen. 2 Niebieski', 'Pojemnosc: 2000 GB, Interfejs: USB 3.2 Gen. 2, Predkosc odczytu: 1050 MB/s, Predkosc zapisu: 1000 MB/s');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('279.00', 'Dyski', '9t7gsef', 'Gigabyte 512GB M.2 PCIe NVMe', 'Pojemnosc: 512 GB, Interfejs: M.2 PCIe NVMe 3.0 x4, Predkosc odczytu: 1700 MB/s, Predkosc zapisu: 1550 MB/s');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('1399.00', 'Dyski', 'c0ivonu', 'ADATA 2TB M.2 PCIe Gen4 NVMe GAMMIX S70 Blade', 'Pojemnosc: 2000 GB, Interfejs: M.2 PCIe NVMe 4.0 x4, Predkosc odczytu: 7400 MB/s, Predkosc zapisu: 6800 MB/s');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('169.00', 'Dyski', 'pb31x1b', 'Kingston 240GB M.2 SATA SSD A400 ', 'Pojemnosc: 240 GB, Interfejs: M.2 SATA, Predkosc odczytu: 500 MB/s, Predkosc zapisu: 350 MB/s');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('929.00', 'Dyski', '3euh3ov', 'Seagate 1TB M.2 PCIe Gen4 NVMe FireCuda 530 Heatsink', 'Pojemnosc: 1000 GB, Interfejs: M.2 PCIe NVMe 4.0 x4, Predkosc odczytu: 7300 MB/s, Predkosc zapisu: 6000 MB/s');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('489.00', 'Dyski', 'obh1hv2', 'WD BLUE 4TB 5400obr. 256MB DM-SMR', 'Pojemnosc: 4000 GB, Interfejs: SATA III, Format: 3.5, Predkosc obr.: 5400 obr./min');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('459.00', 'Dyski', 'eycnmsg', 'WD 500GB M.2 PCIe Gen4 NVMe Black SN850', 'Pojemnosc: 500 GB, Interfejs: M.2 PCIe NVMe 4.0 x4, Predkosc odczytu: 7000 MB/s, Rodzaj kosci pamieci: TLC');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('1079.00', 'Dyski', 'w337c0p', 'Samsung Portable SSD T7 2TB USB 3.2 Gen. 2 Czerwony', 'Pojemnosc: 2000 GB, Interfejs: USB 3.2 Gen. 2, Predkosc odczytu: 1050 MB/s, Predkosc zapisu: 1000 MB/s');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('549.00', 'Dyski', '34rgi9g', 'WD 1TB 2,5 SATA SSD Blue', 'Pojemnosc: 1000 GB, Interfejs: 2,5 SATA, Predkosc odczytu: 560 MB/s, Predkosc zapisu: 530 MB/s');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('224.00', 'Dyski', 'pm0z1uy', 'WD 250GB 2,5 SATA SSD Blue', 'Pojemnosc: 250 GB, Interfejs: 2,5 SATA, Predkosc odczytu: 550 MB/s, Predkosc zapisu: 525 MB/s');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('309.00', 'Dyski', '9a6g23l', 'Seagate SKYHAWK CMR 2TB 5900obr. 64MB ', 'Pojemnosc: 2000 GB, Interfejs: SATA III, Format: 3.5, Predkosc odczytu: 180 MB/s');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('299.00', 'Dyski', 'nznki5g', 'GOODRAM 512GB M.2 PCIe NVMe IRDM', 'Pojemnosc: 512 GB, Interfejs: M.2 PCIe NVMe 3.0 x4, Predkosc odczytu: 3200 MB/s, Predkosc zapisu: 2000 MB/s');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('439.00', 'Dyski', 'l2k1ogv', 'Crucial 1TB M.2 PCIe NVMe P2', 'Pojemnosc: 1000 GB, Interfejs: M.2 PCIe NVMe 3.0 x4, Predkosc odczytu: 2400 MB/s, Predkosc zapisu: 1800 MB/s');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('629.00', 'Dyski', 'i1u0xvy', 'WD 1TB 2,5 SATA SSD Red SA500', 'Pojemnosc: 1000 GB, Interfejs: 2,5 SATA, Predkosc odczytu: 560 MB/s, Predkosc zapisu: 530 MB/s');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('279.00', 'Dyski', 'ldxv8sx', 'WD 250GB M.2 PCIe NVMe Black SN750', 'Pojemnosc: 250 GB, Interfejs: M.2 PCIe NVMe 3.0 x4, Predkosc odczytu: 3100 MB/s, Predkosc zapisu: 1600 MB/s');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('155.00', 'Dyski', '28zkgdp', 'Gigabyte 256GB 2,5 SATA SSD ', 'Pojemnosc: 256 GB, Interfejs: 2,5 SATA, Predkosc odczytu: 520 MB/s, Predkosc zapisu: 500 MB/s');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('479.00', 'Dyski', 'de6ad0d', 'Seagate SKYHAWK CMR 4TB 5900obr. 64MB ', 'Pojemnosc: 4000 GB, Interfejs: SATA III, Format: 3.5, Predkosc odczytu: 190 MB/s');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('1899.00', 'Dyski', 'vy0lnd1', 'Samsung 2TB M.2 PCIe Gen4 NVMe 980 PRO Heatsink', 'Pojemnosc: 2000 GB, Interfejs: M.2 PCIe NVMe 4.0 x4, Predkosc odczytu: 7000 MB/s, Predkosc zapisu: 5100 MB/s');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('679.00', 'Dyski', 'kkhehwb', 'Patriot 1TB M.2 PCIe Gen4 NVMe Viper VP4300', 'Pojemnosc: 1000 GB, Interfejs: M.2 PCIe NVMe 4.0 x4, Predkosc odczytu: 7400 MB/s, Predkosc zapisu: 5500 MB/s');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('899.00', 'Dyski', 'wzzkmst', 'WD 1TB M.2 PCIe Gen4 NVMe Black SN850 Heatsink', 'Pojemnosc: 1000 GB, Interfejs: M.2 PCIe NVMe 4.0 x4, Predkosc odczytu: 7000 MB/s, Predkosc zapisu: 5300 MB/s');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('429.00', 'Dyski', '4vpicfe', 'Samsung Portable SSD T7 Touch 500GB USB 3.2 Gen. 2 Srebrny', 'Pojemnosc: 500 GB, Interfejs: USB 3.2 Gen. 2, Predkosc odczytu: 1050 MB/s, Predkosc zapisu: 1000 MB/s');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('269.00', 'Dyski', 'wy9uvv1', 'ADATA 512GB 2,5 SATA SSD Ultimate SU750', 'Pojemnosc: 512 GB, Interfejs: 2,5 SATA, Predkosc odczytu: 550 MB/s, Predkosc zapisu: 520 MB/s');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('319.00', 'Dyski', 'oyjup8r', 'ADATA 512GB M.2 PCIe NVMe XPG GAMMIX S11 Pro ', 'Pojemnosc: 512 GB, Interfejs: M.2 PCIe NVMe 3.0 x4, Predkosc odczytu: 3350 MB/s, Predkosc zapisu: 2350 MB/s');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('539.00', 'Dyski', 'wrg0rnr', 'ADATA 1TB M.2 PCIe NVMe XPG GAMMIX S11 Pro ', 'Pojemnosc: 1000 GB, Interfejs: M.2 PCIe NVMe 3.0 x4, Predkosc odczytu: 3350 MB/s, Predkosc zapisu: 2800 MB/s');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('139.00', 'Dyski', 'og11rt2', 'Silicon Power 256GB M.2 SATA SSD A55', 'Pojemnosc: 256 GB, Interfejs: M.2 SATA, Predkosc odczytu: 550 MB/s, Predkosc zapisu: 450 MB/s');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('229.00', 'Dyski', 'dudl8vx', 'GOODRAM 240GB 2,5 SATA SSD IRDM GEN. 2', 'Pojemnosc: 240 GB, Interfejs: 2,5 SATA, Predkosc odczytu: 540 MB/s, Predkosc zapisu: 520 MB/s');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('149.00', 'Dyski', 'wjtwbki', 'Patriot 240GB 2,5 SATA SSD BURST', 'Pojemnosc: 240 GB, Interfejs: 2,5 SATA, Predkosc odczytu: 555 MB/s, Predkosc zapisu: 500 MB/s');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('789.00', 'Dyski', 'bp18ubh', 'Kingston 1TB M.2 PCIe Gen4 NVMe KC3000', 'Pojemnosc: 1024 GB, Interfejs: M.2 PCIe NVMe 4.0 x4, Predkosc odczytu: 7000 MB/s, Predkosc zapisu: 6000 MB/s');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('2399.00', 'Dyski', 'diiv3xh', 'SanDisk Extreme Portable SSD 4TB USB 3.2 Gen.2 Granatowy', 'Pojemnosc: 4000 GB, Interfejs: USB 3.2 Gen. 2, Predkosc odczytu: 1050 MB/s, Predkosc zapisu: 1000 MB/s');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('469.00', 'Dyski', 'sh5db0l', 'Kingston XS2000 500GB USB 3.2 Gen 2x2 Srebrny', 'Pojemnosc: 500 GB, Interfejs: USB 3.2 Gen. 2 x 2, Predkosc odczytu: 2000 MB/s, Predkosc zapisu: 2000 MB/s');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('579.00', 'Dyski', 'dgisl4a', 'ADATA 1TB M.2 PCIe Gen4 NVMe GAMMIX S50 Lite', 'Pojemnosc: 1000 GB, Interfejs: M.2 PCIe NVMe 4.0 x4, Predkosc odczytu: 3900 MB/s, Predkosc zapisu: 3200 MB/s');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('159.00', 'Dyski', 'ixmpcim', 'ADATA 256GB M.2 PCIe NVMe XPG SX6000 Pro', 'Pojemnosc: 256 GB, Interfejs: M.2 PCIe NVMe 3.0 x4, Predkosc odczytu: 2100 MB/s, Predkosc zapisu: 1200 MB/s');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('255.00', 'Dyski', '1a47rt0', 'WD BLUE 1TB 5400obr. 128MB OEM DM-SMR', 'Pojemnosc: 1000 GB, Interfejs: SATA III, Format: 2.5, Predkosc obr.: 5400 obr./min');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('409.00', 'Dyski', 'l51f9qd', 'Seagate IRONWOLF CMR 2TB 5900obr. 64MB ', 'Pojemnosc: 2000 GB, Interfejs: SATA III, Format: 3.5, Predkosc obr.: 5900 obr./min');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('379.00', 'Dyski', 'bzs0l78', 'ADATA 512GB M.2 PCIe Gen4 NVMe LEGEND 840', 'Pojemnosc: 512 GB, Interfejs: M.2 PCIe NVMe 4.0 x4, Predkosc odczytu: 5000 MB/s, Predkosc zapisu: 4500 MB/s');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('539.00', 'Dyski', 'jroihg6', 'ADATA 1TB M.2 PCIe NVMe LEGEND 750', 'Pojemnosc: 1000 GB, Interfejs: M.2 PCIe NVMe 3.0 x4, Predkosc odczytu: 3500 MB/s, Predkosc zapisu: 3000 MB/s');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('1599.00', 'Dyski', 'v7fzo53', 'Kingston 2TB M.2 PCIe Gen4 NVMe KC3000', 'Pojemnosc: 2048 GB, Interfejs: M.2 PCIe NVMe 4.0 x4, Predkosc odczytu: 7000 MB/s, Predkosc zapisu: 7000 MB/s');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('289.00', 'Dyski', 'hagtpl3', 'Crucial X6 500GB USB 3.2 Gen. 2 Czarny', 'Pojemnosc: 500 GB, Interfejs: USB 3.2 Gen. 2, Predkosc odczytu: 540 MB/s');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('289.00', 'Dyski', 'lsnnn7h', 'Lexar 512GB M.2 PCIe NVMe NM620', 'Pojemnosc: 512 GB, Interfejs: M.2 PCIe NVMe 3.0 x4, Predkosc odczytu: 3300 MB/s, Predkosc zapisu: 2400 MB/s');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('1399.00', 'Dyski', '84p2lpq', 'SanDisk Extreme Portable SSD 2TB USB 3.2 Gen.2 Granatowy', 'Pojemnosc: 2000 GB, Interfejs: USB 3.2 Gen. 2, Predkosc odczytu: 1050 MB/s, Predkosc zapisu: 1000 MB/s');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('249.00', 'Dyski', 'soxjnez', 'WD My Passport 1TB USB 3.2 Gen. 1 Czarny ', 'Pojemnosc: 1000 GB, Interfejs: USB 3.2 Gen. 1, Format: 2.5, Kolor: Czarny');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('709.00', 'Dyski', '9upuvl4', 'Seagate IRONWOLF PRO CMR 4TB 7200obr. 256MB', 'Pojemnosc: 4000 GB, Interfejs: SATA III, Format: 3.5, Predkosc obr.: 7200 obr./min');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('539.00', 'Dyski', 'ymq7ue9', 'Gigabyte 1TB M.2 PCIe NVMe', 'Pojemnosc: 1000 GB, Interfejs: M.2 PCIe NVMe 3.0 x4, Predkosc odczytu: 2500 MB/s, Predkosc zapisu: 2100 MB/s');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('139.00', 'Dyski', '0b65kyy', 'ADATA 240GB 2,5 SATA SSD Ultimate SU630', 'Pojemnosc: 240 GB, Interfejs: 2,5 SATA, Predkosc odczytu: 520 MB/s, Predkosc zapisu: 450 MB/s');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('99.00', 'Dyski', 'cz8cply', 'Silicon Power 128GB M.2 SATA SSD A55', 'Pojemnosc: 128 GB, Interfejs: M.2 SATA, Predkosc odczytu: 550 MB/s, Predkosc zapisu: 450 MB/s');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('189.00', 'Dyski', 'vsjchdm', 'WD 240GB M.2 SATA SSD Green', 'Pojemnosc: 240 GB, Interfejs: M.2 SATA, Predkosc odczytu: 545 MB/s, Predkosc zapisu: 465 MB/s');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('1249.00', 'Dyski', '8832uni', 'Kingston XS2000 2TB USB 3.2 Gen 2x2 Srebrny', 'Pojemnosc: 2000 GB, Interfejs: USB 3.2 Gen. 2 x 2, Predkosc odczytu: 2000 MB/s, Predkosc zapisu: 2000 MB/s');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('369.00', 'Dyski', 'r062kst', 'Transcend Storejet 25M3 2TB USB 3.2 Gen. 1 Szary', 'Pojemnosc: 2000 GB, Interfejs: USB 3.2 Gen. 1, Format: 2.5, Kolor: Szary');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('279.00', 'Dyski', 'm3pdpa7', 'Seagate BARRACUDA 1TB 7200obr. 128MB ', 'Pojemnosc: 1000 GB, Interfejs: SATA III, Format: 2.5, Predkosc obr.: 7200 obr./min');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('1029.00', 'Dyski', '6rsgaed', 'SanDisk Extreme PRO Portable SSD V2 1TB USB 3.2 Gen 2x2 ', 'Pojemnosc: 1000 GB, Interfejs: USB 3.2 Gen. 2 x 2, Predkosc odczytu: 2000 MB/s, Predkosc zapisu: 2000 MB/s');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('323.00', 'Dyski', '4h4nbvb', 'Seagate One Touch Portable 2TB USB 3.2 Gen. 1 Rózowy', 'Pojemnosc: 2000 GB, Interfejs: USB 3.2 Gen. 1, Format: 2.5, Kolor: Rózowy');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('369.00', 'Dyski', 'ecczlpu', 'WD My Passport 2TB USB 3.2 Gen. 1 Czerwony', 'Pojemnosc: 2000 GB, Interfejs: USB 3.2 Gen. 1, Format: 2.5, Kolor: Czerwony');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('159.00', 'Dyski', '1clf3fi', 'Silicon Power 256GB M.2 PCIe NVMe A60', 'Pojemnosc: 256 GB, Interfejs: M.2 PCIe NVMe 3.0 x4, Predkosc odczytu: 2200 MB/s, Predkosc zapisu: 1600 MB/s');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('249.00', 'Dyski', '1503cqb', 'ADATA 512GB M.2 PCIe NVMe XPG SX6000 Pro', 'Pojemnosc: 512 GB, Interfejs: M.2 PCIe NVMe 3.0 x4, Predkosc odczytu: 2100 MB/s, Predkosc zapisu: 1400 MB/s');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('569.00', 'Dyski', 'pkvuify', 'Samsung 1TB M.2 SATA SSD 860 EVO', 'Pojemnosc: 1000 GB, Interfejs: M.2 SATA, Predkosc odczytu: 550 MB/s, Predkosc zapisu: 520 MB/s');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('225.00', 'Dyski', '3bnj7ri', 'Seagate SKYHAWK CMR 1TB 5900obr. 64MB ', 'Pojemnosc: 1000 GB, Interfejs: SATA III, Format: 3.5, Predkosc obr.: 5900 obr./min');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('849.00', 'Dyski', 'zmnevlf', 'WD RED 6TB 5400obr. 256MB DM-SMR', 'Pojemnosc: 6000 GB, Interfejs: SATA III, Format: 3.5, Predkosc obr.: 5400 obr./min');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('539.00', 'Dyski', 'pgbh05c', 'WD Elements Desktop 4TB USB 3.2 Gen. 1 Czarny', 'Pojemnosc: 4000 GB, Interfejs: USB 3.2 Gen. 1, Format: 3.5, Kolor: Czarny');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('339.00', 'Dyski', 'n5v9eaz', 'WD PURPLE 2TB 5400obr. 256MB ', 'Pojemnosc: 2000 GB, Interfejs: SATA III, Format: 3.5, Predkosc obr.: 5400 obr./min');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('1759.00', 'Dyski', '3recj78', 'Seagate 2TB M.2 PCIe Gen4 NVMe FireCuda 530 Heatsink', 'Pojemnosc: 2000 GB, Interfejs: M.2 PCIe NVMe 4.0 x4, Predkosc odczytu: 7300 MB/s, Predkosc zapisu: 6900 MB/s');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('1599.00', 'Dyski', 'b866xaa', 'Synology DS220+ (2xHDD, 2x2-2.9GHz, 2GB, 2xUSB, 2xLAN)', 'Rodzaj: Bez dolaczonego dysku, Pojemnosc: 0 TB, Kieszenie: 2,5/3,5 - 2 szt., System plików: EXT4, Btrfs');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('219.00', 'Dyski', 'rvxrf7a', 'Kingston 256GB 2,5 SATA SSD KC600', 'Pojemnosc: 256 GB, Interfejs: 2,5 SATA, Predkosc odczytu: 550 MB/s, Predkosc zapisu: 500 MB/s');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('124.00', 'Dyski', 'dtmilvp', 'Gigabyte 128GB M.2 PCIe NVMe', 'Pojemnosc: 128 GB, Interfejs: M.2 PCIe NVMe 3.0 x4, Predkosc odczytu: 1550 MB/s, Predkosc zapisu: 550 MB/s');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('259.00', 'Dyski', 'g3l2rt8', 'ADATA 480GB M.2 SATA SSD Ultimate SU650', 'Pojemnosc: 480 GB, Interfejs: M.2 SATA, Predkosc odczytu: 550 MB/s, Predkosc zapisu: 510 MB/s');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('299.00', 'Dyski', '5icloho', 'Silicon Power 512GB M.2 PCIe NVMe A80', 'Pojemnosc: 512 GB, Interfejs: M.2 PCIe NVMe 3.0 x4, Predkosc odczytu: 3400 MB/s, Predkosc zapisu: 3000 MB/s');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('229.00', 'Dyski', 'jfll5b6', 'Silicon Power 256GB M.2 PCIe NVMe A80', 'Pojemnosc: 256 GB, Interfejs: M.2 PCIe NVMe 3.0 x4, Predkosc odczytu: 3400 MB/s, Predkosc zapisu: 3000 MB/s');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('1149.00', 'Dyski', 'j8q0dzy', 'Patriot 2TB M.2 PCIe NVMe VPN100', 'Pojemnosc: 2000 GB, Interfejs: M.2 PCIe NVMe 3.0 x4, Predkosc odczytu: 3400 MB/s, Predkosc zapisu: 3200 MB/s');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('205.00', 'Dyski', '8349ks5', 'ADATA HV620S 1TB USB 3.2 Gen. 1 Czarny', 'Pojemnosc: 1000 GB, Interfejs: USB 3.2 Gen. 1, Format: 2.5, Kolor: Czarny');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('449.00', 'Dyski', 'eudgrdw', 'WD PURPLE 3TB 5400obr. 64MB CMR', 'Pojemnosc: 3000 GB, Interfejs: SATA III, Format: 3.5, Predkosc obr.: 5400 obr./min');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('519.00', 'Dyski', 'mvg1zv5', 'GOODRAM HX100 1TB USB 3.2 Gen. 2 Czarny', 'Pojemnosc: 1000 GB, Interfejs: USB 3.2 Gen. 2, Predkosc odczytu: 950 MB/s, Predkosc zapisu: 900 MB/s');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('759.00', 'Dyski', 'oa7rut8', 'Seagate Expansion Desktop 8TB USB 3.2 Gen. 1 Czarny', 'Pojemnosc: 8000 GB, Interfejs: USB 3.2 Gen. 1, Format: 3.5, Kolor: Czarny');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('599.00', 'Dyski', '653n5i7', 'Seagate Expansion Desktop 6TB USB 3.2 Gen. 1 Czarny', 'Pojemnosc: 6000 GB, Interfejs: USB 3.2 Gen. 1, Format: 3.5, Kolor: Czarny');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('459.00', 'Dyski', 'qimeyte', 'Seagate Expansion Desktop 4TB USB 3.2 Gen. 1 Czarny', 'Pojemnosc: 4000 GB, Interfejs: USB 3.2 Gen. 1, Format: 3.5, Kolor: Czarny');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('425.00', 'Dyski', 'uifm9i7', 'WD RED PLUS 2TB 5400obr. 128MB CMR', 'Pojemnosc: 2000 GB, Interfejs: SATA III, Format: 3.5, Predkosc obr.: 5400 obr./min');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('569.00', 'Dyski', 'mjiod5t', 'Crucial X6 1TB USB 3.2 Gen. 2 Czarny ', 'Pojemnosc: 1000 GB, Interfejs: USB 3.2 Gen. 2, Predkosc odczytu: 540 MB/s');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('579.00', 'Dyski', '27r107j', 'GOODRAM 1TB M.2 PCIe NVMe IRDM', 'Pojemnosc: 1024 GB, Interfejs: M.2 PCIe NVMe 3.0 x4, Predkosc odczytu: 3200 MB/s, Predkosc zapisu: 3000 MB/s');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('449.00', 'Dyski', 'zl3x5z6', 'GOODRAM 1TB M.2 PCIe NVMe PX500', 'Pojemnosc: 1024 GB, Interfejs: M.2 PCIe NVMe 3.0 x4, Predkosc odczytu: 2050 MB/s, Predkosc zapisu: 1650 MB/s');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('579.00', 'Dyski', 'n4wabz4', 'GOODRAM 1TB 2,5 SATA SSD IRDM PRO GEN. 2', 'Pojemnosc: 1024 GB, Interfejs: 2,5 SATA, Predkosc odczytu: 555 MB/s, Predkosc zapisu: 535 MB/s');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('409.00', 'Dyski', '32evlbs', 'WD RED 2TB 5400obr. 256MB DM-SMR', 'Pojemnosc: 2000 GB, Interfejs: SATA III, Format: 3.5, Predkosc obr.: 5400 obr./min');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('359.00', 'Dyski', 'ut01ony', 'WD My Passport 2TB USB 3.2 Gen. 1 Czarny', 'Pojemnosc: 2000 GB, Interfejs: USB 3.2 Gen. 1, Format: 2.5, Kolor: Czarny');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('439.00', 'Dyski', 'l6nzx66', 'Gigabyte 500GB M.2 PCIe Gen4 NVMe AORUS', 'Pojemnosc: 500 GB, Interfejs: M.2 PCIe NVMe 4.0 x4, Predkosc odczytu: 5000 MB/s, Predkosc zapisu: 2500 MB/s');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('189.00', 'Dyski', '7nzdsa0', 'ADATA SD600Q 240GB USB 3.2 Gen. 1 Czarny', 'Pojemnosc: 240 GB, Interfejs: USB 3.2 Gen. 1, Predkosc odczytu: 440 MB/s, Predkosc zapisu: 430 MB/s');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('99.00', 'Dyski', 'qwnbfz0', 'Kingston 120GB M.2 SATA SSD A400', 'Pojemnosc: 120 GB, Interfejs: M.2 SATA, Predkosc odczytu: 500 MB/s, Predkosc zapisu: 320 MB/s');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('339.00', 'Dyski', 'fnex51e', 'ADATA HD710 PRO 2TB USB 3.2 Gen. 1 Czarny', 'Pojemnosc: 2000 GB, Interfejs: USB 3.2 Gen. 1, Format: 2.5, Kolor: Czarny');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('1259.00', 'Dyski', '237qmgb', 'WD GOLD 8TB 7200obr. 256MB ', 'Pojemnosc: 8000 GB, Interfejs: SATA III, Format: 3.5, Predkosc obr.: 7200 obr./min');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('255.00', 'Dyski', '9ilo496', 'WD PURPLE 1TB 5400obr. 64MB CMR ', 'Pojemnosc: 1000 GB, Interfejs: SATA III, Format: 3.5, Predkosc obr.: 5400 obr./min');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('269.00', 'Dyski', 'nos3ate', 'Seagate IRONWOLF CMR 1TB 5900obr. 64MB ', 'Pojemnosc: 1000 GB, Interfejs: SATA III, Format: 3.5, Predkosc obr.: 5900 obr./min');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('559.00', 'Dyski', '8wziyzg', 'ADATA 1TB 2,5 SATA SSD Ultimate SU800', 'Pojemnosc: 1000 GB, Interfejs: 2,5 SATA, Predkosc odczytu: 560 MB/s, Predkosc zapisu: 520 MB/s');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('279.00', 'Dyski', 'sjb3f1e', 'WD 250GB M.2 PCIe Gen4 NVMe Black SN770', 'Pojemnosc: 250 GB, Interfejs: M.2 PCIe NVMe 4.0 x4, Predkosc odczytu: 4000 MB/s, Predkosc zapisu: 2000 MB/s');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('649.00', 'Dyski', 'u4xg48r', 'Seagate One Touch HUB 6TB USB 3.2 Gen.1 Czarno-Srebrny', 'Pojemnosc: 6000 GB, Interfejs: USB 3.2 Gen. 1, Format: 3.5, Kolor: Czarno-Srebrny');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('399.00', 'Dyski', 'ncxm2d2', 'ADATA 512GB M.2 PCIe Gen4 NVMe GAMMIX S70 Blade', 'Pojemnosc: 512 GB, Interfejs: M.2 PCIe NVMe 4.0 x4, Predkosc odczytu: 7400 MB/s, Predkosc zapisu: 2600 MB/s');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('103.00', 'Dyski', '9w65g04', 'Transcend 120GB M.2 SATA 2242 SSD 420S', 'Pojemnosc: 120 GB, Interfejs: M.2 SATA, Predkosc odczytu: 500 MB/s, Predkosc zapisu: 350 MB/s');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('1489.00', 'Dyski', 'gghyr6q', 'Crucial 2TB M.2 PCIe Gen4 NVMe P5 Plus', 'Pojemnosc: 2000 GB, Interfejs: M.2 PCIe NVMe 4.0 x4, Predkosc odczytu: 6600 MB/s, Predkosc zapisu: 5000 MB/s');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('229.00', 'Dyski', '0jvyh13', 'Silicon Power Armor A60 1TB USB 3.2 Gen. 1 Czarny', 'Pojemnosc: 1000 GB, Interfejs: USB 3.2 Gen. 1, Format: 2.5, Kolor: Czarny');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('1345.00', 'Dyski', 'u5vgvwu', 'Patriot 2TB M.2 PCIe Gen4 NVMe Viper VP4300', 'Pojemnosc: 2000 GB, Interfejs: M.2 PCIe NVMe 4.0 x4, Predkosc odczytu: 7400 MB/s, Predkosc zapisu: 6800 MB/s');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('429.00', 'Dyski', 'tc77wot', 'Toshiba Canvio Advance 4TB USB 3.2 Gen. 1 Bialy', 'Pojemnosc: 4000 GB, Interfejs: USB 3.2 Gen. 1, Format: 2.5, Kolor: Bialy');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('212.00', 'Dyski', 'wf991lo', 'Toshiba Canvio Advance 1TB USB 3.2 Gen. 1 Czarny', 'Pojemnosc: 1000 GB, Interfejs: USB 3.2 Gen. 1, Format: 2.5, Kolor: Czarny');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('1429.00', 'Dyski', 'xpsmcbn', 'Synology DS220j 2TB (2xHDD,4x1.4GHz,512MB,2xUSB,1xLAN)', 'Rodzaj: Z dolaczonym dyskiem, Pojemnosc: 2 TB, Kieszenie: 2,5/3,5 - 2 szt., System plików: EXT4');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('2409.00', 'Dyski', '3bxum0n', 'Synology DS220+ 4TB (2xHDD, 2x2-2.9GHz, 2GB, 2xUSB, 2xLAN)', 'Rodzaj: Z dolaczonym dyskiem, Pojemnosc: 4 TB, Kieszenie: 2,5/3,5 - 2 szt., System plików: EXT4, Btrfs');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('549.00', 'Dyski', '2jxunjw', 'Seagate One Touch Portable 5TB USB 3.2 Gen. 1 Czarny', 'Pojemnosc: 5000 GB, Interfejs: USB 3.2 Gen. 1, Format: 2.5, Kolor: Czarny');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('229.00', 'Dyski', 'ek25r7n', 'ADATA 256GB M.2 PCIe NVMe XPG SX8200 Pro (2021)', 'Pojemnosc: 256 GB, Interfejs: M.2 PCIe NVMe 3.0 x4, Predkosc odczytu: 3500 MB/s, Predkosc zapisu: 1200 MB/s');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('469.00', 'Dyski', 'dwzqpo8', 'Kingston 960GB 2,5 SATA SSD A400 ', 'Pojemnosc: 960 GB, Interfejs: 2,5 SATA, Predkosc odczytu: 500 MB/s, Predkosc zapisu: 450 MB/s');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('419.00', 'Dyski', 'od5tvg2', 'Silicon Power 1TB 2,5 SATA SSD A55', 'Pojemnosc: 1000 GB, Interfejs: 2,5 SATA, Predkosc odczytu: 560 MB/s, Predkosc zapisu: 530 MB/s');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('619.00', 'Dyski', 'aimkpf5', 'Samsung 512GB M.2 PCIe NVMe 970 PRO', 'Pojemnosc: 512 GB, Interfejs: M.2 PCIe NVMe 3.0 x4, Predkosc odczytu: 3500 MB/s, Predkosc zapisu: 2300 MB/s');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('99.00', 'Dyski', '7lnnb2s', 'ADATA 120GB 2,5 SATA SSD Ultimate SU650', 'Pojemnosc: 120 GB, Interfejs: 2,5 SATA, Predkosc odczytu: 520 MB/s, Predkosc zapisu: 320 MB/s');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('169.00', 'Dyski', 'f1rvfay', 'WD 240GB 2,5 SATA SSD Green', 'Pojemnosc: 240 GB, Interfejs: 2,5 SATA, Predkosc odczytu: 545 MB/s, Rodzaj kosci pamieci: TLC');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('119.00', 'Dyski', 'o9d7uqm', 'Kingston 120GB 2,5 SATA SSD A400', 'Pojemnosc: 120 GB, Interfejs: 2,5 SATA, Predkosc odczytu: 500 MB/s, Predkosc zapisu: 320 MB/s');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('369.00', 'Dyski', 'g3b2d6d', 'Transcend StoreJet 25 H3P 2TB USB 3.2 Gen. 1 Fioletowy', 'Pojemnosc: 2000 GB, Interfejs: USB 3.2 Gen. 1, Format: 2.5, Kolor: Czarno-Fioletowy');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('559.00', 'Dyski', 'bpuc1sh', 'WD PURPLE 4TB 5400obr. 256MB', 'Pojemnosc: 4000 GB, Interfejs: SATA III, Format: 3.5, Predkosc obr.: 5400 obr./min');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('294.00', 'Dyski', 'llcowoj', 'Transcend 480GB M.2 SATA 2242 SSD MTS 420S', 'Pojemnosc: 480 GB, Interfejs: M.2 SATA, Predkosc odczytu: 530 MB/s, Predkosc zapisu: 480 MB/s');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('219.00', 'Dyski', 'mm9qfcv', 'WD 250GB M.2 PCIe NVMe Blue SN570', 'Pojemnosc: 250 GB, Interfejs: M.2 PCIe NVMe 3.0 x4, Predkosc odczytu: 3300 MB/s, Predkosc zapisu: 1200 MB/s');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('359.00', 'Dyski', 'kin5zrz', 'ADATA 512GB M.2 PCIe Gen4 NVMe GAMMIX S50 Lite', 'Pojemnosc: 512 GB, Interfejs: M.2 PCIe NVMe 4.0 x4, Predkosc odczytu: 3900 MB/s, Predkosc zapisu: 3200 MB/s');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('959.00', 'Dyski', 'smw97pd', 'Seagate Expansion Desktop 10TB USB 3.2 Gen. 1 Czarny', 'Pojemnosc: 10000 GB, Interfejs: USB 3.2 Gen. 1, Format: 3.5, Kolor: Czarny');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('1759.00', 'Dyski', 'l8torrd', 'QNAP TS-230 8TB (2xHDD, 4x1.4GHz, 2GB, 3xUSB, 1xLAN)', 'Rodzaj: Z dolaczonym dyskiem, Pojemnosc: 8 TB, Kieszenie: 2,5/3,5 - 2 szt., System plików: EXT4');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('799.00', 'Dyski', 'wbr9bd5', 'Gigabyte 1TB M.2 PCIe Gen4 NVMe AORUS 7000s', 'Pojemnosc: 1000 GB, Interfejs: M.2 PCIe NVMe 4.0 x4, Predkosc odczytu: 7000 MB/s, Predkosc zapisu: 5500 MB/s');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('1909.00', 'Dyski', 'qcl84r1', 'Synology DS220j 8TB (2xHDD,4x1.4GHz,512MB,2xUSB,1xLAN)', 'Rodzaj: Z dolaczonym dyskiem, Pojemnosc: 8 TB, Kieszenie: 2,5/3,5 - 2 szt., System plików: EXT4');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('323.00', 'Dyski', 'hhhbbs3', 'Seagate One Touch Portable 2TB USB 3.2 Gen. 1 Czarny', 'Pojemnosc: 2000 GB, Interfejs: USB 3.2 Gen. 1, Format: 2.5, Kolor: Czarny');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('139.00', 'Dyski', '9qq10ga', 'Lexar 256GB 2,5 SATA SSD NS100', 'Pojemnosc: 256 GB, Interfejs: 2,5 SATA, Predkosc odczytu: 520 MB/s');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('1599.00', 'Dyski', 'ppcxusy', 'LaCie D2 Professional 10TB USB 3.2 Gen. 2 Czarny', 'Pojemnosc: 10000 GB, Interfejs: USB 3.2 Gen. 2, Format: 3.5, Kolor: Czarny');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('549.00', 'Dyski', 'h66yo5b', 'WD My Passport 4TB USB 3.2 Gen. 1 Czerwony', 'Pojemnosc: 4000 GB, Interfejs: USB 3.2 Gen. 1, Format: 2.5, Kolor: Czerwony');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('769.00', 'Dyski', 'kkac9me', 'Seagate SKYHAWK CMR 6TB 5900obr. 256MB', 'Pojemnosc: 6000 GB, Interfejs: SATA III, Format: 3.5, Predkosc obr.: 5900 obr./min');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('249.00', 'Dyski', '1lmq9lx', 'Silicon Power 512GB M.2 PCIe NVMe A60', 'Pojemnosc: 512 GB, Interfejs: M.2 PCIe NVMe 3.0 x4, Predkosc odczytu: 2200 MB/s, Predkosc zapisu: 1600 MB/s');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('159.00', 'Dyski', 'ubib74b', 'ADATA 240GB M.2 SATA SSD Ultimate SU650', 'Pojemnosc: 240 GB, Interfejs: M.2 SATA, Predkosc odczytu: 550 MB/s, Predkosc zapisu: 500 MB/s');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('249.00', 'Dyski', 'xjji0c0', 'Gigabyte 480GB 2,5 SATA SSD', 'Pojemnosc: 480 GB, Interfejs: 2,5 SATA, Predkosc odczytu: 550 MB/s, Predkosc zapisu: 480 MB/s');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('179.00', 'Dyski', 'llmwx1y', 'ADATA 256GB M.2 PCIe NVMe XPG GAMMIX S5 ', 'Pojemnosc: 256 GB, Interfejs: M.2 PCIe NVMe 3.0 x4, Predkosc odczytu: 2100 MB/s, Predkosc zapisu: 1200 MB/s');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('94.00', 'Dyski', 'gqxb47z', 'Apacer 128GB 2,5 SATA SSD AS350 Panther', 'Pojemnosc: 128 GB, Interfejs: 2,5 SATA, Predkosc odczytu: 560 MB/s, Predkosc zapisu: 540 MB/s');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('1399.00', 'Dyski', 'dzhwhaw', 'WD RED PRO 8TB 7200obr. 256MB CMR', 'Pojemnosc: 8000 GB, Interfejs: SATA III, Format: 3.5, Predkosc obr.: 7200 obr./min');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('254.00', 'Dyski', '5xwraaw', 'Silicon Power 512GB M.2 SATA SSD A55', 'Pojemnosc: 512 GB, Interfejs: M.2 SATA, Predkosc odczytu: 560 MB/s, Predkosc zapisu: 530 MB/s');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('1169.00', 'Dyski', 'a150jeo', 'WD RED PRO 6TB 7200obr. 256MB CMR', 'Pojemnosc: 6000 GB, Interfejs: SATA III, Format: 3.5, Predkosc obr.: 7200 obr./min');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('499.00', 'Dyski', '0a5ku9o', 'WD RED PRO 2TB 7200obr. 64MB CMR', 'Pojemnosc: 2000 GB, Interfejs: SATA III, Format: 3.5, Predkosc obr.: 7200 obr./min');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('227.00', 'Dyski', 'vvac8mt', 'ADATA HD650 1TB USB 3.2 Gen. 1 Czarno-Srebrny', 'Pojemnosc: 1000 GB, Interfejs: USB 3.2 Gen. 1, Format: 2.5, Kolor: Czarno-Srebrny');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('859.00', 'Dyski', 'ucw2cnr', 'Seagate One Touch HUB 8TB USB 3.2 Gen.1 Czarno-Srebrny', 'Pojemnosc: 8000 GB, Interfejs: USB 3.2 Gen. 1, Format: 3.5, Kolor: Czarno-Srebrny');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('755.00', 'Dyski', 'y1fx1cf', 'Corsair 1TB M.2 PCIe Gen4 NVMe Force MP600', 'Pojemnosc: 1000 GB, Interfejs: M.2 PCIe NVMe 4.0 x4, Predkosc odczytu: 4950 MB/s, Predkosc zapisu: 4250 MB/s');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('319.00', 'Dyski', 'z3bu3ke', 'Patriot 512GB M.2 PCIe NVMe Viper VPN110', 'Pojemnosc: 512 GB, Interfejs: M.2 PCIe NVMe 3.0 x4, Predkosc odczytu: 3100 MB/s, Predkosc zapisu: 2300 MB/s');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('479.00', 'Dyski', 'znlxbii', 'Kingston 512GB M.2 PCIe Gen4 NVMe KC3000', 'Pojemnosc: 512 GB, Interfejs: M.2 PCIe NVMe 4.0 x4, Predkosc odczytu: 7000 MB/s, Predkosc zapisu: 3900 MB/s');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('869.00', 'Dyski', 'bvodydq', 'Seagate 1TB M.2 PCIe Gen4 NVMe FireCuda 530', 'Pojemnosc: 1000 GB, Interfejs: M.2 PCIe NVMe 4.0 x4, Predkosc odczytu: 7300 MB/s, Predkosc zapisu: 6000 MB/s');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('1549.00', 'Dyski', 'yhhh27l', 'MSI 2TB M.2 PCIe Gen4 NVMe Spatium M480', 'Pojemnosc: 2000 GB, Interfejs: M.2 PCIe NVMe 4.0 x4, Predkosc odczytu: 7000 MB/s, Predkosc zapisu: 6850 MB/s');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('295.00', 'Dyski', 'jyx57i7', 'Toshiba Canvio Advance 2TB USB 3.2 Gen. 1 Bialy', 'Pojemnosc: 2000 GB, Interfejs: USB 3.2 Gen. 1, Format: 2.5, Kolor: Bialy');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('2279.00', 'Dyski', '30sebp6', 'Samsung 4TB 2,5 SATA SSD 870 EVO', 'Pojemnosc: 4000 GB, Interfejs: 2,5 SATA, Predkosc odczytu: 560 MB/s, Predkosc zapisu: 530 MB/s');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('1499.00', 'Dyski', 'zleaejw', 'WD 2TB M.2 PCIe Gen4 NVMe Black SN850', 'Pojemnosc: 2000 GB, Interfejs: M.2 PCIe NVMe 4.0 x4, Predkosc odczytu: 7000 MB/s, Predkosc zapisu: 5300 MB/s');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('549.00', 'Dyski', 'e1tc0ya', 'Seagate One Touch Portable 5TB USB 3.2 Gen. 1 Srebrny', 'Pojemnosc: 5000 GB, Interfejs: USB 3.2 Gen. 1, Format: 2.5, Kolor: Srebrny');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('2999.00', 'Dyski', 'u5mbn4p', 'Samsung 8TB 2,5 SATA SSD 870 QVO', 'Pojemnosc: 8000 GB, Interfejs: 2,5 SATA, Predkosc odczytu: 560 MB/s, Predkosc zapisu: 530 MB/s');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('1329.00', 'Dyski', 'yx3f0mj', 'Seagate IRONWOLF PRO CMR 8TB 7200obr. 256MB', 'Pojemnosc: 8000 GB, Interfejs: SATA III, Format: 3.5, Predkosc obr.: 7200 obr./min');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('1429.00', 'Dyski', 'w69wxv9', 'Samsung Portable SSD T7 Touch 2TB USB 3.2 Gen. 2 Czarny', 'Pojemnosc: 2000 GB, Interfejs: USB 3.2 Gen. 2, Predkosc odczytu: 1050 MB/s, Predkosc zapisu: 1000 MB/s');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('1429.00', 'Dyski', '7chwxye', 'Samsung Portable SSD T7 Touch 2TB USB 3.2 Gen. 2 Srebrny', 'Pojemnosc: 2000 GB, Interfejs: USB 3.2 Gen. 2, Predkosc odczytu: 1050 MB/s, Predkosc zapisu: 1000 MB/s');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('779.00', 'Dyski', '8d28u6i', 'Samsung Portable SSD T7 Touch 1TB USB 3.2 Gen. 2 Czarny', 'Pojemnosc: 1000 GB, Interfejs: USB 3.2 Gen. 2, Predkosc odczytu: 1050 MB/s, Predkosc zapisu: 1000 MB/s');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('549.00', 'Dyski', 'efdxwpb', 'WD My Passport 4TB USB 3.2 Gen. 1 Czarny', 'Pojemnosc: 4000 GB, Interfejs: USB 3.2 Gen. 1, Format: 2.5, Kolor: Czarny');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('699.00', 'Dyski', 'yl5f7ns', 'Kingston 1TB 2,5 SATA SSD KC600', 'Pojemnosc: 1000 GB, Interfejs: 2,5 SATA, Predkosc odczytu: 550 MB/s, Predkosc zapisu: 520 MB/s');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('1199.00', 'Dyski', '5vpldby', 'ADATA 2TB M.2 PCIe NVMe XPG SX8200 Pro (2021)', 'Pojemnosc: 2000 GB, Interfejs: M.2 PCIe NVMe 3.0 x4, Predkosc odczytu: 3500 MB/s, Predkosc zapisu: 3000 MB/s');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('219.00', 'Dyski', '2fp1ek1', 'ADATA 256GB M.2 PCIe NVMe  XPG SPECTRIX S40G RGB', 'Pojemnosc: 256 GB, Interfejs: M.2 PCIe NVMe 3.0 x4, Predkosc odczytu: 3500 MB/s, Predkosc zapisu: 1200 MB/s');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('218.00', 'Dyski', 'tbhpqbr', 'ADATA 480GB 2,5 SATA SSD Ultimate SU630 ', 'Pojemnosc: 480 GB, Interfejs: 2,5 SATA, Predkosc odczytu: 520 MB/s, Predkosc zapisu: 450 MB/s');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('209.90', 'Dyski', '159bf8i', 'ADATA 256GB M.2 PCIe NVMe XPG GAMMIX S11 Pro', 'Pojemnosc: 256 GB, Interfejs: M.2 PCIe NVMe 3.0 x4, Predkosc odczytu: 3350 MB/s, Predkosc zapisu: 1150 MB/s');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('259.00', 'Dyski', '2mr1lvc', 'ADATA 512GB M.2 PCIe NVMe XPG SX6000 Lite ', 'Pojemnosc: 512 GB, Interfejs: M.2 PCIe NVMe 3.0 x4, Predkosc odczytu: 1800 MB/s, Predkosc zapisu: 1200 MB/s');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('95.00', 'Dyski', 'slwq4tn', 'Silicon Power 128GB 2,5 SATA SSD A55', 'Pojemnosc: 128 GB, Interfejs: 2,5 SATA, Predkosc odczytu: 550 MB/s, Predkosc zapisu: 420 MB/s');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('219.00', 'Dyski', 'ay8rfke', 'ADATA HV300 1TB USB 3.2 Gen. 1 Czarny', 'Pojemnosc: 1000 GB, Interfejs: USB 3.2 Gen. 1, Format: 2.5, Kolor: Czarny');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('519.00', 'Dyski', 'kwzqmbe', 'ADATA HD710 PRO 4TB USB 3.2 Gen. 1 Czarny', 'Pojemnosc: 4000 GB, Interfejs: USB 3.2 Gen. 1, Format: 2.5, Kolor: Czarny');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('244.00', 'Dyski', '1rj9epa', 'WD 250GB M.2 SATA SSD Blue', 'Pojemnosc: 250 GB, Interfejs: M.2 SATA, Predkosc odczytu: 550 MB/s, Predkosc zapisu: 525 MB/s');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('1079.00', 'Dyski', '3804yxb', 'WD GOLD 6TB 7200obr. 256MB ', 'Pojemnosc: 6000 GB, Interfejs: SATA III, Format: 3.5, Predkosc obr.: 7200 obr./min');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('849.00', 'Dyski', 'zv0xrdz', 'WD GOLD 4TB 7200obr. 256MB ', 'Pojemnosc: 4000 GB, Interfejs: SATA III, Format: 3.5, Predkosc obr.: 7200 obr./min');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('89.00', 'Dyski', 'gauaweq', 'Silicon Power 120GB 2,5 SATA SSD S55', 'Pojemnosc: 120 GB, Interfejs: 2,5 SATA, Predkosc odczytu: 550 MB/s, Predkosc zapisu: 450 MB/s');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('209.00', 'Dyski', 'z2k9u92', 'WD BLUE 1TB 5400obr. 64MB CMR', 'Pojemnosc: 1000 GB, Interfejs: SATA III, Format: 3.5, Predkosc obr.: 5400 obr./min');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('399.00', 'Dyski', '5mrzenh', 'WD BLACK 1TB 7200obr. 64MB CMR', 'Pojemnosc: 1000 GB, Interfejs: SATA III, Format: 3.5, Predkosc obr.: 7200 obr./min');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('549.00', 'Dyski', '19xqxcv', 'SanDisk Portable SSD 1TB USB 3.2 Gen.2 Granatowy', 'Pojemnosc: 1000 GB, Interfejs: USB 3.2 Gen. 2, Predkosc odczytu: 520 MB/s');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('389.00', 'Dyski', 'b1468pu', 'WD 500GB M.2 PCIe Gen4 NVMe Black SN770', 'Pojemnosc: 500 GB, Interfejs: M.2 PCIe NVMe 4.0 x4, Predkosc odczytu: 5000 MB/s, Predkosc zapisu: 4000 MB/s');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('3469.00', 'Dyski', 'qz9rltd', 'Seagate IRONWOLF PRO CMR 20TB 256MB 7200obr. ', 'Pojemnosc: 20000 GB, Interfejs: SATA III, Format: 3.5, Predkosc obr.: 7200 obr./min');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('239.00', 'Dyski', 'fy6ezk6', 'Silicon Power Armor A66 1TB USB 3.2 Gen. 1 Czarno-Zólty', 'Pojemnosc: 1000 GB, Interfejs: USB 3.2 Gen. 1, Format: 2.5, Kolor: Czarno-Zólty');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('239.00', 'Dyski', 'jr8m1rp', 'Silicon Power Armor A66 1TB USB 3.2 Gen. 1 Czarno-Niebieski', 'Pojemnosc: 1000 GB, Interfejs: USB 3.2 Gen. 1, Format: 2.5, Kolor: Czarno-Niebieski');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('1119.00', 'Dyski', 'c7u0b6y', 'Seagate Expansion Desktop 12TB USB 3.2 Gen. 1 Czarny', 'Pojemnosc: 12000 GB, Interfejs: USB 3.2 Gen. 1, Format: 3.5, Kolor: Czarny');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('1199.00', 'Dyski', 'brdwsgn', 'WD PURPLE PRO 8TB 7200obr. 256MB', 'Pojemnosc: 8000 GB, Interfejs: SATA III, Format: 3.5, Predkosc obr.: 7200 obr./min');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('1559.00', 'Dyski', 'xth34eu', 'QNAP TS-230 4TB (2xHDD, 4x1.4GHz, 2GB, 3xUSB, 1xLAN)', 'Rodzaj: Z dolaczonym dyskiem, Pojemnosc: 4 TB, Kieszenie: 2,5/3,5 - 2 szt., System plików: EXT4');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('539.00', 'Dyski', 'k3l8313', 'Corsair 1TB M.2 PCIe Gen4 NVMe MP600 Core', 'Pojemnosc: 1000 GB, Interfejs: M.2 PCIe NVMe 4.0 x4, Predkosc odczytu: 4700 MB/s, Predkosc zapisu: 1950 MB/s');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('429.00', 'Dyski', 'j6sg8eo', 'Toshiba Canvio Advance 4TB USB 3.2 Gen. 1 Czerwony', 'Pojemnosc: 4000 GB, Interfejs: USB 3.2 Gen. 1, Format: 2.5, Kolor: Czerwony');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('289.00', 'Dyski', '3nskyoe', 'Toshiba Canvio Advance 2TB USB 3.2 Gen. 1 Czerwony', 'Pojemnosc: 2000 GB, Interfejs: USB 3.2 Gen. 1, Format: 2.5, Kolor: Czerwony');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('212.00', 'Dyski', 'g2rgdrv', 'Toshiba Canvio Advance 1TB USB 3.2 Gen. 1 Czerwony', 'Pojemnosc: 1000 GB, Interfejs: USB 3.2 Gen. 1, Format: 2.5, Kolor: Czerwony');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('1699.00', 'Dyski', '81u8n53', 'SanDisk Extreme PRO Portable SSD V2 2TB USB 3.2 Gen 2x2 ', 'Pojemnosc: 2000 GB, Interfejs: USB 3.2 Gen. 2 x 2, Predkosc odczytu: 2000 MB/s, Predkosc zapisu: 2000 MB/s');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('1709.00', 'Dyski', 'eibif72', 'Synology DS220j 4TB (2xHDD,4x1.4GHz,512MB,2xUSB,1xLAN)', 'Rodzaj: Z dolaczonym dyskiem, Pojemnosc: 4 TB, Kieszenie: 2,5/3,5 - 2 szt., System plików: EXT4');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('3169.00', 'Dyski', 'wvqvc95', 'Synology DS220+ 12TB (2xHDD, 2x2-2.9GHz, 2GB, 2xUSB, 2xLAN)', 'Rodzaj: Z dolaczonym dyskiem, Pojemnosc: 12 TB, Kieszenie: 2,5/3,5 - 2 szt., System plików: EXT4, Btrfs');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('323.00', 'Dyski', 'fzse1qd', 'Seagate One Touch Portable 2TB USB 3.2 Gen. 1 Czerwony', 'Pojemnosc: 2000 GB, Interfejs: USB 3.2 Gen. 1, Format: 2.5, Kolor: Czerwony');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('1349.00', 'Dyski', 'b52zigm', 'LaCie D2 Professional 8TB USB 3.2 Gen. 2 Czarny', 'Pojemnosc: 8000 GB, Interfejs: USB 3.2 Gen. 2, Format: 3.5, Kolor: Czarny');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('499.00', 'Dyski', 'f8jukwy', 'Seagate Basic 5TB USB 3.2 Gen. 1 Czarny', 'Pojemnosc: 5000 GB, Interfejs: USB 3.2 Gen. 1, Format: 2.5, Kolor: Czarny');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('849.00', 'Dyski', 'fqbtsmu', 'Seagate Exos 4TB 7200obr. 256MB', 'Pojemnosc: 4000 GB, Interfejs: SATA III, Format: 3.5, Predkosc obr.: 7200 obr./min');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('369.00', 'Dyski', 'gbvbt22', 'WD My Passport 2TB USB 3.2 Gen. 1 Niebieski ', 'Pojemnosc: 2000 GB, Interfejs: USB 3.2 Gen. 1, Format: 2.5, Kolor: Niebieski');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('1275.00', 'Dyski', 'ac4xoyc', 'WD 2TB 2,5 SATA SSD Red SA500', 'Pojemnosc: 2000 GB, Interfejs: 2,5 SATA, Predkosc odczytu: 560 MB/s, Predkosc zapisu: 530 MB/s');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('379.00', 'Dyski', 'okt81pr', 'Kingston 512GB 2,5 SATA SSD KC600', 'Pojemnosc: 512 GB, Interfejs: 2,5 SATA, Predkosc odczytu: 550 MB/s, Predkosc zapisu: 520 MB/s');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('569.00', 'Dyski', 'xgb2lfa', 'ADATA SE800 1TB USB 3.2 Gen. 2 Czarny', 'Pojemnosc: 1000 GB, Interfejs: USB 3.2 Gen. 2, Predkosc odczytu: 1000 MB/s, Predkosc zapisu: 1000 MB/s');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('369.00', 'Dyski', 'jqvhdt5', 'ADATA HD770G 2TB USB 3.2 Gen. 1 Czarny', 'Pojemnosc: 2000 GB, Interfejs: USB 3.2 Gen. 1, Format: 2.5, Kolor: Czarny');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('769.00', 'Dyski', '3fyyoue', 'Gigabyte 1TB M.2 PCIe Gen4 NVMe AORUS', 'Pojemnosc: 1000 GB, Interfejs: M.2 PCIe NVMe 4.0 x4, Predkosc odczytu: 5000 MB/s, Predkosc zapisu: 4400 MB/s');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('479.00', 'Dyski', '6q768v1', 'ADATA 1TB 2,5 SATA SSD Ultimate SU750', 'Pojemnosc: 1000 GB, Interfejs: 2,5 SATA, Predkosc odczytu: 550 MB/s, Predkosc zapisu: 520 MB/s');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('189.00', 'Dyski', 'fsw28ct', 'ADATA SD600Q 240GB USB 3.2 Gen. 1 Niebieski', 'Pojemnosc: 240 GB, Interfejs: USB 3.2 Gen. 1, Predkosc odczytu: 440 MB/s, Predkosc zapisu: 430 MB/s');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('2109.00', 'Dyski', '5ujhv22', 'Synology DS218play 8TB (2xHDD, 4x1.4GHz, 1GB, 2xUSB, 1xLAN)', 'Rodzaj: Z dolaczonym dyskiem, Pojemnosc: 8 TB, Kieszenie: 3,5 - 2 szt., System plików: EXT4');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('144.00', 'Dyski', 'whplfiv', 'Apacer 256GB 2,5 SATA SSD AS350 Panther ', 'Pojemnosc: 256 GB, Interfejs: 2,5 SATA, Predkosc odczytu: 560 MB/s, Predkosc zapisu: 540 MB/s');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('1099.00', 'Dyski', 'e5il6m2', 'Samsung 1TB M.2 PCIe NVMe  970 PRO', 'Pojemnosc: 1000 GB, Interfejs: M.2 PCIe NVMe 3.0 x4, Predkosc odczytu: 3500 MB/s, Predkosc zapisu: 2700 MB/s');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('219.00', 'Dyski', '1e7oujd', 'ADATA HV300 1TB USB 3.2 Gen. 1 Niebieski', 'Pojemnosc: 1000 GB, Interfejs: USB 3.2 Gen. 1, Format: 2.5, Kolor: Niebieski');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('259.00', 'Dyski', '89qfql8', 'ADATA  HD710 PRO 1TB USB 3.2 Gen. 1 Czarny', 'Pojemnosc: 1000 GB, Interfejs: USB 3.2 Gen. 1, Format: 2.5, Kolor: Czarny');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('249.00', 'Dyski', 'vpr44nj', 'ADATA HD710 PRO 1TB USB 3.2 Gen. 1 Czarno-Czerwony', 'Pojemnosc: 1000 GB, Interfejs: USB 3.2 Gen. 1, Format: 2.5, Kolor: Czarno-Czerwony');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('339.00', 'Dyski', 'iru3nfb', 'ADATA SD700 512GB USB 3.2 Gen. 1 Czarny', 'Pojemnosc: 512 GB, Interfejs: USB 3.2 Gen. 1, Predkosc odczytu: 440 MB/s, Predkosc zapisu: 430 MB/s');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('999.00', 'Dyski', 'xnpc12e', 'WD My Book 8TB  USB 3.2 Gen. 1 Czarny', 'Pojemnosc: 8000 GB, Interfejs: USB 3.2 Gen. 1, Format: 3.5, Kolor: Czarny');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('555.00', 'Dyski', 'qn4brxy', 'WD GOLD 2TB 7200obr. 128MB ', 'Pojemnosc: 2000 GB, Interfejs: SATA III, Format: 3.5, Predkosc obr.: 7200 obr./min');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('409.00', 'Dyski', 'j9fy8xt', 'WD GOLD 1TB 7200obr. 128MB ', 'Pojemnosc: 1000 GB, Interfejs: SATA III, Format: 3.5, Predkosc obr.: 7200 obr./min');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('279.00', 'Dyski', 'p2sb9rr', 'Transcend StoreJet 25 H3P 1TB USB 3.2 Gen. 1 Fioletowy', 'Pojemnosc: 1000 GB, Interfejs: USB 3.2 Gen. 1, Format: 2.5, Kolor: Czarno-Fioletowy');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('319.00', 'Dyski', 'wlwhecj', 'MSI 500GB M.2 PCIe Gen4 NVMe Spatium M450', 'Pojemnosc: 500 GB, Interfejs: M.2 PCIe NVMe 4.0 x4, Predkosc odczytu: 3600 MB/s, Predkosc zapisu: 2300 MB/s');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('1129.00', 'Dyski', 'uad1t4f', 'Seagate One Touch HUB 12TB USB 3.2 Gen.1 Czarno-Srebrny', 'Pojemnosc: 12000 GB, Interfejs: USB 3.2 Gen. 1, Format: 3.5, Kolor: Czarno-Srebrny');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('639.00', 'Dyski', 'cy2m1v0', 'ADATA 1TB M.2 PCIe Gen4 NVMe LEGEND 840', 'Pojemnosc: 1000 GB, Interfejs: M.2 PCIe NVMe 4.0 x4, Predkosc odczytu: 5000 MB/s, Predkosc zapisu: 4500 MB/s');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('369.00', 'Dyski', 'sodprri', 'Patriot 512GB M.2 PCIe Gen4 NVMe P400', 'Pojemnosc: 512 GB, Interfejs: M.2 PCIe NVMe 4.0 x4, Predkosc odczytu: 5000 MB/s, Predkosc zapisu: 3300 MB/s');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('1199.00', 'Dyski', 'w8a2kw4', 'WD 2TB M.2 PCIe NVMe Blue SN570', 'Pojemnosc: 2000 GB, Interfejs: M.2 PCIe NVMe 3.0 x4, Predkosc odczytu: 3500 MB/s, Predkosc zapisu: 3500 MB/s');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('459.00', 'Dyski', 'bh5mvoy', 'Silicon Power Stream S07 4TB USB 3.2 Gen. 1 Czarny', 'Pojemnosc: 4000 GB, Interfejs: USB 3.2 Gen. 1, Format: 3.5, Kolor: Czarny');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('225.00', 'Dyski', '9b9o5nn', 'ADATA HD680 1TB USB 3.2 Gen. 1 Czarny', 'Pojemnosc: 1000 GB, Interfejs: USB 3.2 Gen. 1, Format: 2.5, Kolor: Czarny');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('1738.00', 'Dyski', 'c1zi7se', 'Seagate 2TB M.2 PCIe Gen4 NVMe FireCuda 530', 'Pojemnosc: 2000 GB, Interfejs: M.2 PCIe NVMe 4.0 x4, Predkosc odczytu: 7300 MB/s, Predkosc zapisu: 6900 MB/s');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('1379.00', 'Dyski', '8s2xub8', 'Seagate Expansion Desktop 14TB USB 3.2 Gen. 1 Czarny', 'Pojemnosc: 14000 GB, Interfejs: USB 3.2 Gen. 1, Format: 3.5, Kolor: Czarny');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('1899.00', 'Dyski', 'dc9ihma', 'Corsair 2TB M.2 PCIe Gen4 NVMe MP600 Pro', 'Pojemnosc: 2000 GB, Interfejs: M.2 PCIe NVMe 4.0 x4, Predkosc odczytu: 7000 MB/s, Predkosc zapisu: 6550 MB/s');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('1181.00', 'Dyski', 'r80egku', 'Corsair 2TB M.2 PCIe Gen4 NVMe MP600 Core', 'Pojemnosc: 2000 GB, Interfejs: M.2 PCIe NVMe 4.0 x4, Predkosc odczytu: 4950 MB/s, Predkosc zapisu: 3700 MB/s');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('2529.00', 'Dyski', 'nfbwe5u', 'Synology HAT5300 12TB', 'Pojemnosc: 12000 GB, Interfejs: SATA III, Format: 3.5, Predkosc obr.: 7200 obr./min');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('629.00', 'Dyski', 'gltndze', 'WD My Passport SSD 1TB USB 3.2 Gen. 2 Niebieski', 'Pojemnosc: 1000 GB, Interfejs: USB 3.2 Gen. 2, Predkosc odczytu: 1050 MB/s, Predkosc zapisu: 1000 MB/s');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('92.00', 'Dyski', 'yczbn15', 'Patriot 120GB 2,5 SATA SSD BURST ELITE', 'Pojemnosc: 120 GB, Interfejs: 2,5 SATA, Predkosc odczytu: 450 MB/s, Predkosc zapisu: 320 MB/s');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('339.00', 'Dyski', '90fxbmv', 'Verbatim Store &#x27;n&#x27; Go Secure 1TB USB 3.2 Gen. 1 Czarny', 'Pojemnosc: 1000 GB, Interfejs: USB 3.2 Gen. 1, Kolor: Czarny, Waga: 283 g');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('2129.00', 'Dyski', '3zdzhtt', 'Synology DS220+ 2TB (2xHDD, 2x2-2.9GHz, 2GB, 2xUSB, 2xLAN)', 'Rodzaj: Z dolaczonym dyskiem, Pojemnosc: 2 TB, Kieszenie: 2,5/3,5 - 2 szt., System plików: EXT4, Btrfs');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('549.00', 'Dyski', 'mzapgn7', 'Seagate One Touch Portable 5TB USB 3.2 Gen. 1 Niebieski', 'Pojemnosc: 5000 GB, Interfejs: USB 3.2 Gen. 1, Format: 2.5, Kolor: Niebieski');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('323.00', 'Dyski', '2p6dw73', 'Seagate One Touch Portable 2TB USB 3.2 Gen. 1 Srebrny', 'Pojemnosc: 2000 GB, Interfejs: USB 3.2 Gen. 1, Format: 2.5, Kolor: Srebrny');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('436.00', 'Dyski', '5jc4uzo', 'ADATA 1TB M.2 PCIe NVMe SWORDFISH', 'Pojemnosc: 1000 GB, Interfejs: M.2 PCIe NVMe 3.0 x4, Predkosc odczytu: 1800 MB/s, Predkosc zapisu: 1200 MB/s');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('405.00', 'Dyski', 'g70cs9n', 'Seagate 960GB 2,5 SATA SSD BarraCuda Q1', 'Pojemnosc: 960 GB, Interfejs: 2,5 SATA, Predkosc odczytu: 550 MB/s, Predkosc zapisu: 500 MB/s');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('279.00', 'Dyski', 'vpx7ful', 'Kingston 480GB M.2 SATA SSD A400', 'Pojemnosc: 480 GB, Interfejs: M.2 SATA, Predkosc odczytu: 500 MB/s, Predkosc zapisu: 450 MB/s');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('259.00', 'Dyski', 'nyvhm9h', 'Patriot 512GB M.2 PCIe NVMe P300', 'Pojemnosc: 512 GB, Interfejs: M.2 PCIe NVMe 3.0 x4, Predkosc odczytu: 1700 MB/s, Predkosc zapisu: 1200 MB/s');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('1659.00', 'Dyski', 'tktop49', 'Seagate Exos 16TB 7200obr. 256MB', 'Pojemnosc: 16000 GB, Interfejs: SATA III, Format: 3.5, Predkosc obr.: 7200 obr./min');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('419.00', 'Dyski', 'qb7x5fg', 'Seagate Skyhawk CMR 3TB 5400obr. 256MB', 'Pojemnosc: 3000 GB, Interfejs: SATA III, Format: 3.5, Predkosc obr.: 5400 obr./min');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('499.00', 'Dyski', '3bnyptf', 'WD My Passport Ultra 2TB USB 3.2 Gen. 1 Srebrny', 'Pojemnosc: 2000 GB, Interfejs: USB 3.2 Gen. 1, Format: 2.5, Kolor: Srebrny');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('349.00', 'Dyski', 'ahhrmqr', 'ADATA SE800 512GB USB 3.2 Gen. 2 Niebieski', 'Pojemnosc: 512 GB, Interfejs: USB 3.2 Gen. 2, Predkosc odczytu: 1000 MB/s, Predkosc zapisu: 1000 MB/s');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('629.00', 'Dyski', 'vqwh2gw', 'ADATA SE800 1TB USB 3.2 Gen. 2 Niebieski', 'Pojemnosc: 1000 GB, Interfejs: USB 3.2 Gen. 2, Predkosc odczytu: 1000 MB/s, Predkosc zapisu: 1000 MB/s');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('99.00', 'Dyski', 'wpxcfpf', 'ADATA 120GB M.2 SATA SSD Ultimate SU650', 'Pojemnosc: 120 GB, Interfejs: M.2 SATA, Predkosc odczytu: 550 MB/s, Predkosc zapisu: 410 MB/s');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('499.00', 'Dyski', 'o2ilofu', 'Gigabyte 1TB 2,5 SATA SSD', 'Pojemnosc: 1000 GB, Interfejs: 2,5 SATA, Predkosc odczytu: 550 MB/s, Predkosc zapisu: 500 MB/s');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('369.00', 'Dyski', 'xis8oct', 'LaCie Mobile Drive 1TB USB 3.2 Gen. 1 Srebrny', 'Pojemnosc: 1000 GB, Interfejs: USB 3.2 Gen. 1, Format: 2.5, Kolor: Szary');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('162.00', 'Dyski', 'cm8dmq6', 'ADATA 256GB M.2 PCIe NVMe XPG SX6000 Lite', 'Pojemnosc: 256 GB, Interfejs: M.2 PCIe NVMe 3.0 x4, Predkosc odczytu: 1800 MB/s, Predkosc zapisu: 900 MB/s');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('1228.00', 'Dyski', 'ukpc9ug', 'Corsair 1,92TB M.2 PCIe NVMe Force MP510', 'Pojemnosc: 1920 GB, Interfejs: M.2 PCIe NVMe 3.0 x4, Predkosc odczytu: 3480 MB/s, Predkosc zapisu: 2700 MB/s');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('219.00', 'Dyski', 'vzvkd0v', 'ADATA HV300 1TB USB 3.2 Gen. 1 Czerwony', 'Pojemnosc: 1000 GB, Interfejs: USB 3.2 Gen. 1, Format: 2.5, Kolor: Czerwony');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('429.00', 'Dyski', 'q9f8l78', 'LaCie Rugged 1TB USB 3.2 Gen. 1 Pomaranczowo-Szary', 'Pojemnosc: 1000 GB, Interfejs: USB 3.2 Gen. 1, Format: 2.5, Kolor: Pomaranczowo-Szary');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('339.00', 'Dyski', 'idkmect', 'ADATA HD710 PRO 2TB USB 3.2 Gen. 1 Czarno-Zólty', 'Pojemnosc: 2000 GB, Interfejs: USB 3.2 Gen. 1, Format: 2.5, Kolor: Czarno-Zólty');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('153.00', 'Dyski', 'd1039k4', 'WD 120GB 2,5 SATA SSD Green', 'Pojemnosc: 120 GB, Interfejs: 2,5 SATA, Predkosc odczytu: 545 MB/s, Rodzaj kosci pamieci: TLC');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('339.00', 'Dyski', 'q4iqvob', 'ADATA SD700 512GB USB 3.2 Gen. 1 Czarno-Zólty', 'Pojemnosc: 512 GB, Interfejs: USB 3.2 Gen. 1, Predkosc odczytu: 440 MB/s, Predkosc zapisu: 430 MB/s');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('495.00', 'Dyski', 's8xlc8w', 'Seagate IRONWOLF CMR 3TB 5900obr. 64MB ', 'Pojemnosc: 3000 GB, Interfejs: SATA III, Format: 3.5, Predkosc obr.: 5900 obr./min');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('655.00', 'Dyski', 'n2fbu8l', 'WD BLACK 2TB 7200obr. 64MB CMR', 'Pojemnosc: 2000 GB, Interfejs: SATA III, Format: 3.5, Predkosc obr.: 7200 obr./min');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('1669.00', 'Dyski', 'hfz5rws', 'Crucial 4TB 2,5 SATA SSD MX500', 'Pojemnosc: 4000 GB, Interfejs: 2,5 SATA, Predkosc odczytu: 560 MB/s, Predkosc zapisu: 510 MB/s');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('161.00', 'Dyski', '0vrey30', 'ADATA 256GB M.2 SATA 2280 Ultimate SU650 ', 'Pojemnosc: 256 GB, Interfejs: M.2 SATA, Predkosc odczytu: 550 MB/s, Predkosc zapisu: 510 MB/s');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('2999.00', 'Dyski', 'f8r1r61', 'Seagate One Touch HUB 18TB USB 3.2 Gen.1 Czarno-Srebrny', 'Pojemnosc: 18000 GB, Interfejs: USB 3.2 Gen. 1, Format: 3.5, Kolor: Czarno-Srebrny');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('1849.00', 'Dyski', 'fwbbe7z', 'Seagate Skyhawk AI 12TB 256MB 7200obr. ', 'Pojemnosc: 12000 GB, Interfejs: SATA III, Format: 3.5, Predkosc obr.: 7200 obr./min');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('1999.00', 'Dyski', '941onri', 'Seagate Expansion Desktop 18TB USB 3.2 Gen. 1 Czarny', 'Pojemnosc: 18000 GB, Interfejs: USB 3.2 Gen. 1, Format: 3.5, Kolor: Czarny');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('2099.00', 'Dyski', 'xswd3ts', 'Seagate Storage Expansion Card 2TB do Xbox Series X|S', 'Pojemnosc: 2000 GB, Kolor: Szary, Waga: 30 g');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('449.00', 'Dyski', 'lfgnfxi', 'WD 500GB M.2 PCIe NVMe Red SN700', 'Pojemnosc: 500 GB, Interfejs: M.2 PCIe NVMe 3.0 x4, Predkosc odczytu: 3430 MB/s, Predkosc zapisu: 3000 MB/s');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('1699.00', 'Dyski', '5ylcbvc', 'Kingston 2TB M.2 PCIe Gen4 NVMe Fury Renegade', 'Pojemnosc: 2000 GB, Interfejs: M.2 PCIe NVMe 4.0 x4, Predkosc odczytu: 7300 MB/s, Predkosc zapisu: 7000 MB/s');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('1049.00', 'Dyski', 'sy3n14b', 'WD Elements Desktop 8TB USB 3.2 Gen. 1 Czarny', 'Pojemnosc: 8000 GB, Interfejs: USB 3.2 Gen. 1, Format: 3.5, Kolor: Czarny');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('269.00', 'Dyski', '321lk2r', 'Transcend Storejet 25M3 1TB USB 3.2 Gen. 1 Szary', 'Pojemnosc: 1000 GB, Interfejs: USB 3.2 Gen. 1, Format: 2.5, Kolor: Szary');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('549.00', 'Dyski', 'o5wzmh4', 'Transcend Storejet 25M3 4TB USB 3.2 Gen. 1 Szary', 'Pojemnosc: 4000 GB, Interfejs: USB 3.2 Gen. 1, Format: 2.5, Kolor: Szary');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('519.00', 'Dyski', 'q5x9jre', 'Gigabyte 1TB M.2 PCIe NVMe M30', 'Pojemnosc: 1000 GB, Interfejs: M.2 PCIe NVMe 3.0 x4, Predkosc odczytu: 3500 MB/s, Predkosc zapisu: 3000 MB/s');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('3899.00', 'Dyski', 'foll7ge', 'Synology DS220+ 16TB (2xHDD, 2x2-2.9GHz, 2GB, 2xUSB, 2xLAN)', 'Rodzaj: Z dolaczonym dyskiem, Pojemnosc: 16 TB, Kieszenie: 2,5/3,5 - 2 szt., System plików: EXT4, Btrfs');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('2299.00', 'Dyski', '55zc1rt', 'Crucial X6 4TB USB 3.2 Gen. 2 Czarny', 'Pojemnosc: 4000 GB, Interfejs: USB 3.2 Gen. 2, Predkosc odczytu: 540 MB/s');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('429.00', 'Dyski', 'oqc661p', 'Toshiba Canvio Advance 4TB USB 3.2 Gen. 1 Czarny', 'Pojemnosc: 4000 GB, Interfejs: USB 3.2 Gen. 1, Format: 2.5, Kolor: Czarny');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('3149.00', 'Dyski', '4ynynic', 'SanDisk Extreme PRO Portable SSD V2 4TB USB 3.2 Gen 2x2 ', 'Pojemnosc: 4000 GB, Interfejs: USB 3.2 Gen. 2 x 2, Predkosc odczytu: 2000 MB/s, Predkosc zapisu: 2000 MB/s');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('1069.00', 'Dyski', '5eoqm7w', 'WD My Passport SSD 2TB USB 3.2 Gen. 2 Czerwony', 'Pojemnosc: 2000 GB, Interfejs: USB 3.2 Gen. 2, Predkosc odczytu: 1050 MB/s, Predkosc zapisu: 1000 MB/s');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('379.00', 'Dyski', 'mo0nvmu', 'WD My Passport SSD 500GB USB 3.2 Gen. 2 Niebieski', 'Pojemnosc: 500 GB, Interfejs: USB 3.2 Gen. 2, Predkosc odczytu: 1050 MB/s, Predkosc zapisu: 1000 MB/s');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('679.00', 'Dyski', 'a8xw1kc', 'ADATA SE770G 1TB USB 3.2 Gen. 2 Czarny', 'Pojemnosc: 1000 GB, Interfejs: USB 3.2 Gen. 2, Predkosc odczytu: 1000 MB/s, Predkosc zapisu: 800 MB/s');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('295.00', 'Dyski', 'nvdo1yl', 'Toshiba Canvio Gaming 2TB USB 3.2 Gen. 1 Czarny', 'Pojemnosc: 2000 GB, Interfejs: USB 3.2 Gen. 1, Format: 2.5, Kolor: Czarny');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('299.00', 'Dyski', 'z9xt8ca', 'Toshiba Canvio Slim 2TB USB 3.2 Gen. 1 Czarny', 'Pojemnosc: 2000 GB, Interfejs: USB 3.2 Gen. 1, Format: 2.5, Kolor: Czarny');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('288.00', 'Dyski', 'zlvou7b', 'Silicon Power 500GB M.2 PCIe NVMe UD70', 'Pojemnosc: 500 GB, Interfejs: M.2 PCIe NVMe 3.0 x4, Predkosc odczytu: 3400 MB/s, Predkosc zapisu: 3000 MB/s');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('479.00', 'Dyski', 'cdrkn63', 'Seagate One Touch Portable 4TB USB 3.2 Gen. 1 Czarny', 'Pojemnosc: 4000 GB, Interfejs: USB 3.2 Gen. 1, Format: 2.5, Kolor: Czarny');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('323.00', 'Dyski', '2zcw90q', 'Seagate One Touch Portable 2TB USB 3.2 Gen. 1 Niebieski', 'Pojemnosc: 2000 GB, Interfejs: USB 3.2 Gen. 1, Format: 2.5, Kolor: Niebieski');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('269.00', 'Dyski', 'tlcvilx', 'Seagate One Touch Portable 1TB USB 3.2 Gen. 1 Czarny', 'Pojemnosc: 1000 GB, Interfejs: USB 3.2 Gen. 1, Format: 2.5, Kolor: Czarny');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('449.00', 'Dyski', 'pm5xkuk', 'Lexar 1TB M.2 PCIe NVMe NM610', 'Pojemnosc: 1000 GB, Interfejs: M.2 PCIe NVMe 3.0 x4, Predkosc odczytu: 2100 MB/s, Predkosc zapisu: 1600 MB/s');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('719.00', 'Dyski', 'wbignbl', 'Seagate BARRACUDA 6TB 5400obr. 256MB', 'Pojemnosc: 6000 GB, Interfejs: SATA III, Format: 3.5, Predkosc obr.: 5400 obr./min');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('164.00', 'Dyski', 'svdm3s8', 'ADATA 250GB M.2 PCIe NVMe SWORDFISH', 'Pojemnosc: 250 GB, Interfejs: M.2 PCIe NVMe 3.0 x4, Predkosc odczytu: 1800 MB/s, Predkosc zapisu: 900 MB/s');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('1199.00', 'Dyski', 'ju70dug', 'Kingston 2TB M.2 PCIe NVMe KC2500', 'Pojemnosc: 2000 GB, Interfejs: M.2 PCIe NVMe 3.0 x4, Predkosc odczytu: 3500 MB/s, Predkosc zapisu: 2900 MB/s');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('305.00', 'Dyski', '0t3lvnw', 'Seagate Basic 2TB USB 3.2 Gen. 1 Czarny', 'Pojemnosc: 2000 GB, Interfejs: USB 3.2 Gen. 1, Format: 2.5, Kolor: Czarny');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('379.00', 'Dyski', '1xwdlsf', 'Seagate Seagate Game Drive HDD 2TB USB 3.2 Gen. 1 Czarny', 'Pojemnosc: 2000 GB, Interfejs: USB 3.2 Gen. 1, Format: 2.5, Kolor: Czarny');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('719.00', 'Dyski', 'x4qv8eb', 'WD My Passport Ultra 4TB USB 3.2 Gen. 1 Srebrny', 'Pojemnosc: 4000 GB, Interfejs: USB 3.2 Gen. 1, Format: 2.5, Kolor: Srebrny');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('369.00', 'Dyski', 'z9ip3zg', 'WD My Passport Ultra 1TB USB 3.2 Gen. 1 Srebrny', 'Pojemnosc: 1000 GB, Interfejs: USB 3.2 Gen. 1, Format: 2.5, Kolor: Srebrny');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('529.00', 'Dyski', '29ygaew', 'WD My Passport 4TB USB 3.2 Gen. 1 Niebieski', 'Pojemnosc: 4000 GB, Interfejs: USB 3.2 Gen. 1, Format: 2.5, Kolor: Niebieski');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('1025.00', 'Dyski', 'sq52xy2', 'Seagate BARRACUDA 8TB 5400obr. 256MB ', 'Pojemnosc: 8000 GB, Interfejs: SATA III, Format: 3.5, Predkosc obr.: 5400 obr./min');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('1099.00', 'Dyski', '9rjra3v', 'Seagate SKYHAWK CMR 8TB 7200obr. 256MB', 'Pojemnosc: 8000 GB, Interfejs: SATA III, Format: 3.5, Predkosc obr.: 7200 obr./min');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('2649.00', 'Dyski', '2qofpfj', 'WD 4TB 2,5 SATA SSD Red SA500', 'Pojemnosc: 4000 GB, Interfejs: 2,5 SATA, Predkosc odczytu: 560 MB/s, Predkosc zapisu: 530 MB/s');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('439.00', 'Dyski', 'ut74yq0', 'Silicon Power 1TB M.2 PCIe NVMe A60', 'Pojemnosc: 1000 GB, Interfejs: M.2 PCIe NVMe 3.0 x4, Predkosc odczytu: 2200 MB/s, Predkosc zapisu: 1600 MB/s');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('269.00', 'Dyski', 'z97lnte', 'ADATA HD770G 1TB USB 3.2 Gen. 1 Czerwony', 'Pojemnosc: 1000 GB, Interfejs: USB 3.2 Gen. 1, Format: 2.5, Kolor: Czerwony');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('559.00', 'Dyski', 'nv4kpj2', 'ADATA 1TB M.2 PCIe NVMe XPG SPECTRIX S40G RGB', 'Pojemnosc: 1000 GB, Interfejs: M.2 PCIe NVMe 3.0 x4, Predkosc odczytu: 3500 MB/s, Predkosc zapisu: 1900 MB/s');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('299.00', 'Dyski', 'q0927ua', 'Gigabyte 256GB M.2 PCIe NVMe AORUS RGB', 'Pojemnosc: 256 GB, Interfejs: M.2 PCIe NVMe 3.0 x4, Predkosc odczytu: 3100 MB/s, Predkosc zapisu: 1050 MB/s');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('779.00', 'Dyski', 'rkbu9m8', 'LaCie Mobile Drive 5TB USB 3.2 Gen. 1 Srebrny', 'Pojemnosc: 5000 GB, Interfejs: USB 3.2 Gen. 1, Format: 2.5, Kolor: Srebrny');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('429.00', 'Dyski', '7980h3i', 'Silicon Power 1TB  M.2 SATA SSD A55 ', 'Pojemnosc: 1000 GB, Interfejs: M.2 SATA, Predkosc odczytu: 560 MB/s, Predkosc zapisu: 530 MB/s');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('1432.00', 'Dyski', 'tmfwirn', 'WD 2TB M.2 PCIe NVMe Black SN750 ', 'Pojemnosc: 2000 GB, Interfejs: M.2 PCIe NVMe 3.0 x4, Predkosc odczytu: 3400 MB/s, Predkosc zapisu: 2900 MB/s');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('269.00', 'Dyski', '5u606sd', 'ADATA 512GB M.2 PCIe NVMe XPG GAMMIX S5 ', 'Pojemnosc: 512 GB, Interfejs: M.2 PCIe NVMe 3.0 x4, Predkosc odczytu: 2100 MB/s, Predkosc zapisu: 1400 MB/s');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('149.00', 'Dyski', 'u8b270h', 'Gigabyte 240GB 2,5 SATA SSD', 'Pojemnosc: 240 GB, Interfejs: 2,5 SATA, Predkosc odczytu: 500 MB/s, Predkosc zapisu: 420 MB/s');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('949.00', 'Dyski', 'y52pghq', 'LaCie Rugged 5TB USB 3.2 Gen. 2 Pomaranczowo-Szary', 'Pojemnosc: 5000 GB, Interfejs: USB 3.2 Gen. 1, Waga: 400 g, Zlacza: USB Type-C');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('789.00', 'Dyski', 'w6lirs8', 'LaCie Rugged 4TB USB 3.2 Gen. 1 Pomaranczowo-Szary', 'Pojemnosc: 4000 GB, Interfejs: USB 3.2 Gen. 1, Waga: 400 g, Zlacza: USB Type-C');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('249.00', 'Dyski', 'w3fycww', 'Patriot 480GB 2,5 SATA SSD BURST', 'Pojemnosc: 480 GB, Interfejs: 2,5 SATA, Predkosc odczytu: 560 MB/s, Predkosc zapisu: 540 MB/s');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('138.00', 'Dyski', 'zguc54m', 'Apacer 240GB 2,5 SATA SSD AS340 Panther', 'Pojemnosc: 240 GB, Interfejs: 2,5 SATA, Predkosc odczytu: 550 MB/s, Predkosc zapisu: 520 MB/s');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('549.00', 'Dyski', 'b7hk4b6', 'Silicon Power  Armor A60 4TB USB 3.2 Gen. 1 Czarno-Zielony', 'Pojemnosc: 4000 GB, Interfejs: USB 3.2 Gen. 1, Format: 2.5, Kolor: Czarno-Zielony');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('419.00', 'Dyski', 'rohbk8i', 'WD BLUE 2TB 5400obr. 128MB DM-SMR', 'Pojemnosc: 2000 GB, Interfejs: SATA III, Format: 2.5, Predkosc obr.: 5400 obr./min');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('255.00', 'Dyski', 'yu2n0g8', 'ADATA HD710 PRO 1TB USB 3.2 Gen. 1 Czarno-Zólty', 'Pojemnosc: 1000 GB, Interfejs: USB 3.2 Gen. 1, Format: 2.5, Kolor: Czarno-Zólty');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('259.00', 'Dyski', 'f7d5mu9', 'ADATA HD710 PRO 1TB USB 3.2 Gen. 1 Czarno-Niebieski', 'Pojemnosc: 1000 GB, Interfejs: USB 3.2 Gen. 1, Format: 2.5, Kolor: Czarno-Niebieski');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('149.00', 'Dyski', 'ygmmnev', 'ADATA 240GB 2,5 SATA SSD Ultimate SU650', 'Pojemnosc: 240 GB, Interfejs: 2,5 SATA, Predkosc odczytu: 520 MB/s, Predkosc zapisu: 450 MB/s');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('4699.00', 'Dyski', '0d8yrce', 'LaCie 2big Dock 16TB Thunderbolt 3 Bialy ', 'Pojemnosc: 16000 GB, Interfejs: Thunderbolt 3, Format: 3.5, Kolor: Szary');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('349.00', 'Dyski', 'n9w3zoa', 'ADATA HD710 PRO 2TB USB 3.2 Gen. 1 Czarno-Niebieski', 'Pojemnosc: 2000 GB, Interfejs: USB 3.2 Gen. 1, Format: 2.5, Kolor: Czarno-Niebieski');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('319.00', 'Dyski', 'w3y5xo6', 'ADATA HD650 2TB USB 3.2 Gen. 1 Czarno-Srebrny', 'Pojemnosc: 2000 GB, Interfejs: USB 3.2 Gen. 1, Format: 2.5, Kolor: Czarno-Srebrny');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('1144.00', 'Dyski', 'aeqqr74', 'WD 2TB 2,5 SATA SSD Blue', 'Pojemnosc: 2000 GB, Interfejs: 2,5 SATA, Predkosc odczytu: 560 MB/s, Predkosc zapisu: 530 MB/s');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('213.00', 'Dyski', 'i5z73wz', 'Transcend 256GB 2,5 SATA SSD 230S', 'Pojemnosc: 256 GB, Interfejs: 2,5 SATA, Predkosc odczytu: 530 MB/s, Predkosc zapisu: 400 MB/s');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('519.00', 'Dyski', 'q5zsd32', 'LaCie Rugged Mini 2TB USB 3.2 Gen. 1 Pomaranczowo-Szary', 'Pojemnosc: 2000 GB, Interfejs: USB 3.2 Gen. 1, Format: 2.5, Kolor: Pomaranczowo-Szary');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('335.00', 'Dyski', '9rbxf9c', 'ADATA HD720 2TB USB 3.2 Gen. 1 Czarno-Niebieski', 'Pojemnosc: 2000 GB, Interfejs: USB 3.2 Gen. 1, Format: 2.5, Kolor: Czarno-Niebieski');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('139.00', 'Dyski', 'oxr1zz0', 'Silicon Power 240GB 2,5 SATA SSD S55', 'Pojemnosc: 240 GB, Interfejs: 2,5 SATA, Predkosc odczytu: 550 MB/s, Predkosc zapisu: 450 MB/s');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('349.00', 'Dyski', '0qiaglf', 'Silicon Power Armor A80 2TB USB 3.2 Gen. 1 Niebieski', 'Pojemnosc: 2000 GB, Interfejs: USB 3.2 Gen. 1, Format: 2.5, Kolor: Niebieski');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('319.00', 'Dyski', 'd7773kf', 'Verbatim Store&#x27;n&#x27;Go 2TB USB 3.2 Gen. 1 Czarny', 'Pojemnosc: 2000 GB, Interfejs: USB 3.2 Gen. 1, Format: 2.5, Kolor: Czarny');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('2399.00', 'Dyski', '80mtveb', 'WD My Passport SSD 4TB USB 3.2 Gen. 2 Szary', 'Pojemnosc: 4000 GB, Interfejs: USB 3.2 Gen. 2, Predkosc odczytu: 1050 MB/s, Predkosc zapisu: 1000 MB/s');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('519.00', 'Dyski', 'wp4l924', 'MSI 1TB M.2 PCIe Gen4 NVMe Spatium M450', 'Pojemnosc: 1000 GB, Interfejs: M.2 PCIe NVMe 4.0 x4, Predkosc odczytu: 3600 MB/s, Predkosc zapisu: 3000 MB/s');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('1449.00', 'Dyski', 'hhgc71r', 'Samsung SSD T7 Shield 2TB USB 3.2 Gen. 2 Czarny', 'Pojemnosc: 2000 GB, Interfejs: USB 3.2 Gen. 2, Predkosc odczytu: 1050 MB/s, Predkosc zapisu: 1000 MB/s');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('849.00', 'Dyski', 'oqs8rw6', 'Samsung SSD T7 Shield 1TB USB 3.2 Gen. 2 Czarny', 'Pojemnosc: 1000 GB, Interfejs: USB 3.2 Gen. 2, Predkosc odczytu: 1050 MB/s, Predkosc zapisu: 1000 MB/s');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('1019.00', 'Dyski', 'ue1nx7q', 'Seagate One Touch HUB 10TB USB 3.2 Gen.1 Czarno-Srebrny', 'Pojemnosc: 10000 GB, Interfejs: USB 3.2 Gen. 1, Format: 3.5, Kolor: Czarno-Srebrny');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('149.00', 'Dyski', 'xegdv8m', 'PNY 250GB M.2 SATA SSD CS900', 'Pojemnosc: 250 GB, Interfejs: M.2 SATA, Predkosc odczytu: 535 MB/s, Predkosc zapisu: 500 MB/s');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('4151.00', 'Dyski', 'apyitl6', 'Corsair 4TB M.2 PCIe Gen4 NVMe Force MP600 Pro LPX', 'Pojemnosc: 4000 GB, Interfejs: M.2 PCIe NVMe 4.0 x4, Predkosc odczytu: 7100 MB/s, Predkosc zapisu: 6800 MB/s');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('1024.00', 'Dyski', 'zz56uys', 'Corsair 1TB M.2 PCIe Gen4 NVMe Force MP600 Pro LPX', 'Pojemnosc: 1000 GB, Interfejs: M.2 PCIe NVMe 4.0 x4, Predkosc odczytu: 7100 MB/s, Predkosc zapisu: 5800 MB/s');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('279.00', 'Dyski', 's5wergb', 'ADATA 500GB M.2 PCIe NVMe LEGEND 750', 'Pojemnosc: 500 GB, Interfejs: M.2 PCIe NVMe 3.0 x4, Predkosc odczytu: 3500 MB/s, Predkosc zapisu: 3000 MB/s');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('519.00', 'Dyski', 'kc9k5nt', 'Silicon Power Armor A66 4TB USB 3.2 Gen. 1 Czarno-Zólty', 'Pojemnosc: 4000 GB, Interfejs: USB 3.2 Gen. 1, Format: 2.5, Kolor: Czarno-Zólty');
INSERT INTO produkty (cena, kategoria, kod_producenta, nazwa, opis) VALUES ('319.00', 'Dyski', 'ca9l4eo', 'Silicon Power Armor A66 2TB USB 3.2 Gen. 1 Czarno-Zólty', 'Pojemnosc: 2000 GB, Interfejs: USB 3.2 Gen. 1, Format: 2.5, Kolor: Czarno-Zólty');

/*
    TODO SEED ZAMOWIEN.
*/

/*
    =========================================== CRUD: Adresy ===========================================
*/

CREATE OR REPLACE FUNCTION adresy_dodaj(
	_ulica 			adresy.ulica%TYPE,
	_nr_mieszkania 	adresy.nr_mieszkania%TYPE,
	_miasto 		adresy.miasto%TYPE,
	_kod_pocztowy 	adresy.kod_pocztowy%TYPE,
	_kraj 			adresy.kraj%TYPE
)
RETURNS INT AS
$BODY$
DECLARE
	wynik INT;
	BEGIN
		IF (_ulica IS NULL) OR (LENGTH(_ulica) = 0) THEN
			RAISE EXCEPTION 'Ulica nie może być pusta!';
		END IF;
		
		IF (_nr_mieszkania IS NULL) OR (LENGTH(_nr_mieszkania) = 0) THEN
			RAISE EXCEPTION 'Nr. mieszkania nie może być pusty!';
		END IF;
		
		IF (_miasto IS NULL) OR (LENGTH(_miasto) = 0) THEN
			RAISE EXCEPTION 'Miasto nie może być puste!';
		END IF;
		
		IF (_kod_pocztowy IS NULL) OR (LENGTH(_kod_pocztowy) = 0) THEN
			RAISE EXCEPTION 'Kod pocztowy nie może być pusty!';
		END IF;
		
		IF (_kraj IS NULL) OR (LENGTH(_kraj) = 0) THEN
			RAISE EXCEPTION 'Kraj nie może być pusty!';
		END IF;
		
		INSERT INTO adresy(ulica, nr_mieszkania, miasto, kod_pocztowy, kraj)
		VALUES(_ulica, _nr_mieszkania, _miasto, _kod_pocztowy, _kraj)
		RETURNING id INTO wynik;
		
		RETURN wynik;
	END;
$BODY$
LANGUAGE plpgsql;


/*
    =====================================================================
*/

CREATE OR REPLACE FUNCTION adresy_pobierz(
	nr_strony 		INTEGER = NULL,
	rozmiar_strony	INTEGER = NULL
)
RETURNS SETOF adresy AS
$BODY$
 BEGIN
  RETURN QUERY
	SELECT *
	FROM adresy
	ORDER BY id
	LIMIT rozmiar_strony
	OFFSET ((nr_strony-1) * rozmiar_strony);
 END;
$BODY$
LANGUAGE plpgsql;

SELECT * FROM adresy_pobierz(1, 100);

CREATE OR REPLACE FUNCTION adresy_pobierz_wszystkie()
RETURNS SETOF adresy AS
$BODY$
 BEGIN
  RETURN QUERY
	SELECT *
	FROM adresy
	ORDER BY id;
 END;
$BODY$
LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION adresy_pobierz_ilosc()
RETURNS INT AS
$BODY$
 BEGIN
  RETURN ( SELECT COUNT(*) FROM adresy );
 END;
$BODY$
LANGUAGE plpgsql;

/*
    =====================================================================
*/

CREATE OR REPLACE FUNCTION adresy_znajdz(
    _id_adresu	INTEGER = NULL
)
RETURNS SETOF adresy AS
$BODY$
 DECLARE
 	wynik adresy%ROWTYPE;
 BEGIN
    SELECT *
	INTO wynik
    FROM adresy
    WHERE id = _id_adresu;
	IF NOT FOUND THEN
    	RAISE EXCEPTION 'Adres o ID = % nie istnieje!', _id_adresu;
	END IF;
	RETURN NEXT wynik;
 END;
$BODY$
LANGUAGE plpgsql;

/*
    =====================================================================
*/

CREATE OR REPLACE FUNCTION adresy_wyszukaj(
    kryteria	VARCHAR(255)
)
RETURNS SETOF adresy AS
$BODY$
 BEGIN
  kryteria = LOWER(kryteria);
  RETURN QUERY
	SELECT *
	FROM adresy
	WHERE 
		LOWER(id::varchar(255))				LIKE '%'||kryteria||'%' OR
		LOWER(ulica)						LIKE '%'||kryteria||'%' OR
		LOWER(nr_mieszkania::varchar(255))	LIKE '%'||kryteria||'%' OR
		LOWER(miasto)						LIKE '%'||kryteria||'%' OR
		LOWER(kod_pocztowy)					LIKE '%'||kryteria||'%' OR
		LOWER(kraj)							LIKE '%'||kryteria||'%' 
	ORDER BY id;
 END;
$BODY$
LANGUAGE plpgsql;


CREATE OR REPLACE FUNCTION adresy_paginuj_wyszukaj(
    kryteria  		VARCHAR(255),
	nr_strony 		INTEGER = NULL,
	rozmiar_strony	INTEGER = NULL
)
RETURNS SETOF adresy AS
$BODY$
 BEGIN
  RETURN QUERY
	SELECT * FROM adresy_wyszukaj(kryteria)
	LIMIT rozmiar_strony
	OFFSET ((nr_strony-1) * rozmiar_strony);
 END;
$BODY$
LANGUAGE plpgsql;


/*
    =====================================================================
*/


CREATE OR REPLACE PROCEDURE adresy_edytuj(
	_id 			adresy.id%TYPE,
	_ulica 			adresy.ulica%TYPE,
	_nr_mieszkania 	adresy.nr_mieszkania%TYPE,
	_miasto 		adresy.miasto%TYPE,
	_kod_pocztowy 	adresy.kod_pocztowy%TYPE,
	_kraj 			adresy.kraj%TYPE
)
LANGUAGE plpgsql
AS $BODY$
DECLARE
	adres adresy;
	BEGIN
		SELECT * INTO adres FROM adresy WHERE id = _id;
		IF NOT FOUND THEN
    		RAISE EXCEPTION 'Adres o ID = % nie istnieje!', _id;
		END IF;
		
		IF (_ulica IS NULL) OR (LENGTH(_ulica) = 0) THEN
			_ulica = adres.ulica;
		END IF;
		
		IF (_nr_mieszkania IS NULL) OR (LENGTH(_nr_mieszkania) = 0) THEN
			_nr_mieszkania = adres.nr_mieszkania;
		END IF;
		
		IF (_miasto IS NULL) OR (LENGTH(_miasto) = 0) THEN
			_miasto = adres.miasto;
		END IF;
		
		IF (_kod_pocztowy IS NULL) OR (LENGTH(_kod_pocztowy) = 0) THEN
			_kod_pocztowy = adres.kod_pocztowy;
		END IF;
		
		IF (_kraj IS NULL) OR (LENGTH(_kraj) = 0) THEN
			_kraj = adres.kraj;
		END IF;
		
		UPDATE adresy SET
			ulica = _ulica,
			nr_mieszkania = _nr_mieszkania,
			miasto = _miasto,
			kod_pocztowy = _kod_pocztowy,
			kraj = _kraj
		WHERE id = _id;
	END;
$BODY$;


/*
    =====================================================================
*/


CREATE OR REPLACE PROCEDURE adresy_usun(
    _id             adresy.id%TYPE
)
LANGUAGE plpgsql
AS $BODY$
DECLARE
    lista_uzytkownikow VARCHAR(500);
	_temp adresy%ROWTYPE;
    BEGIN
		SELECT * INTO _temp FROM adresy WHERE id = _id;
		IF NOT FOUND THEN
    		RAISE EXCEPTION 'Adres o ID = % nie istnieje!', _id;
		END IF;
	
        CREATE TEMP TABLE temp_tbl AS SELECT * FROM uzytkownicy WHERE adres_id = _id;
        IF EXISTS (SELECT * FROM temp_tbl LIMIT 1) THEN
            SELECT STRING_AGG(temp_tbl.id::varchar(255), ', ') INTO lista_uzytkownikow FROM temp_tbl;
            RAISE EXCEPTION 'Nie można usunąć adresu o id % ponieważ istnieją użytkownicy pod tym adresem (%)', _id, lista_uzytkownikow;
        END IF;
		
        DELETE FROM adresy WHERE id = _id;
		DROP TABLE IF EXISTS temp_tbl;
    END;
$BODY$;


/*
    =========================================== CRUD: Uzytkownicy ===========================================
*/


CREATE OR REPLACE PROCEDURE uzytkownicy_dodaj(
    _imie                   uzytkownicy.imie%TYPE,
    _nazwisko               uzytkownicy.nazwisko%TYPE,
    _nazwa_uzytkownika		uzytkownicy.nazwa_uzytkownika%TYPE,
    _email                  uzytkownicy.email%TYPE,
    _telefon                uzytkownicy.telefon%TYPE,
    _haslo                  uzytkownicy.haslo%TYPE,
	_adres_id				adresy.id%TYPE
)
LANGUAGE plpgsql
AS $BODY$
DECLARE
	_temp adresy%ROWTYPE;
	error_details TEXT;
	__hashed_haslo TEXT;
    BEGIN
        IF (_imie IS NULL) OR (LENGTH(_imie) = 0) THEN
            RAISE EXCEPTION 'Imie nie może być puste!';
        END IF;
        
        IF (_nazwisko IS NULL) OR (LENGTH(_nazwisko) = 0) THEN
            RAISE EXCEPTION 'Nazwisko nie może być puste!';
        END IF;
        
        IF (_nazwa_uzytkownika IS NULL) OR (LENGTH(_nazwa_uzytkownika) = 0) THEN
            RAISE EXCEPTION 'Nazwa uzytkownika nie może być pusta!';
        END IF;
        
        IF (_email IS NULL) OR (LENGTH(_email) = 0) THEN
            RAISE EXCEPTION 'Email nie może być pusty!';
        END IF;
        
        IF (_telefon IS NULL) OR (LENGTH(_telefon) = 0) THEN
            RAISE EXCEPTION 'Numer telefonu nie może być pusty!';
        END IF;
        
        IF (_haslo IS NULL) OR (LENGTH(_haslo) = 0) THEN
            RAISE EXCEPTION 'Hasło nie może być puste!';
        END IF;
		
		SELECT * INTO _temp FROM adresy WHERE id = _adres_id;
		IF NOT FOUND THEN
    		RAISE EXCEPTION 'Adres o ID = % nie istnieje!', _adres_id;
		END IF;
        
		SELECT encode(digest(_haslo, 'sha1'), 'hex') INTO __hashed_haslo;

		BEGIN
			INSERT INTO uzytkownicy(imie, nazwisko, nazwa_uzytkownika, email, telefon, haslo, adres_id)
			VALUES(_imie, _nazwisko, _nazwa_uzytkownika, _email, _telefon, __hashed_haslo, _adres_id);
		EXCEPTION
			WHEN unique_violation THEN
				GET STACKED DIAGNOSTICS error_details = PG_EXCEPTION_DETAIL;
				RAISE EXCEPTION 'Użytkownik z taką wartością (%) już istnieje!',
				REPLACE(REPLACE(SPLIT_PART(error_details,'=',1), 'Key (', ''),')','');
			WHEN OTHERS THEN
				RAISE EXCEPTION 'Nieznany błąd.';
		END;
    END;
$BODY$;

/*
    =====================================================================
*/

CREATE OR REPLACE FUNCTION uzytkownicy_pobierz_wszystkich()
RETURNS SETOF uzytkownicy AS
$BODY$
 BEGIN
  RETURN QUERY
	SELECT *
	FROM uzytkownicy
	ORDER BY id;
 END;
$BODY$
LANGUAGE plpgsql;


CREATE OR REPLACE FUNCTION uzytkownicy_pobierz_ilosc()
RETURNS INT AS
$BODY$
 BEGIN
  RETURN ( SELECT COUNT(*) FROM uzytkownicy );
 END;
$BODY$
LANGUAGE plpgsql;


CREATE OR REPLACE FUNCTION uzytkownicy_znajdz(
    id_uzytkownika  INTEGER = NULL
)
RETURNS SETOF uzytkownicy AS
$BODY$
 DECLARE
 	wynik uzytkownicy%ROWTYPE;
 BEGIN
    SELECT *
	INTO wynik
    FROM uzytkownicy
    WHERE id = id_uzytkownika;
	IF NOT FOUND THEN
    	RAISE EXCEPTION 'Uzytkownik o ID = % nie istnieje!', id_uzytkownika;
	END IF;
	RETURN NEXT wynik;
 END;
$BODY$
LANGUAGE plpgsql;

/*
    =====================================================================
*/

CREATE OR REPLACE FUNCTION uzytkownicy_wyszukaj(
    kryteria	VARCHAR(255)
)
RETURNS SETOF uzytkownicy AS
$BODY$
 BEGIN
  kryteria = LOWER(kryteria);
  RETURN QUERY
	SELECT *
	FROM uzytkownicy
	WHERE 
		LOWER(id::varchar(255))		LIKE '%'||kryteria||'%' OR
		LOWER(imie)					LIKE '%'||kryteria||'%' OR
		LOWER(nazwisko)				LIKE '%'||kryteria||'%' OR
		LOWER(nazwa_uzytkownika)	LIKE '%'||kryteria||'%' OR
		LOWER(email)				LIKE '%'||kryteria||'%' OR
		LOWER(telefon)				LIKE '%'||kryteria||'%' 
	ORDER BY id;
 END;
$BODY$
LANGUAGE plpgsql;

/*
    =====================================================================
*/

CREATE OR REPLACE FUNCTION uzytkownicy_paginuj_wyszukaj(
    kryteria  		VARCHAR(255),
	nr_strony 		INTEGER = NULL,
	rozmiar_strony	INTEGER = NULL
)
RETURNS SETOF uzytkownicy AS
$BODY$
 BEGIN
  RETURN QUERY
	SELECT * FROM uzytkownicy_wyszukaj(kryteria)
	LIMIT rozmiar_strony
	OFFSET ((nr_strony-1) * rozmiar_strony);
 END;
$BODY$
LANGUAGE plpgsql;

/*
    =====================================================================
*/

CREATE OR REPLACE FUNCTION uzytkownicy_pobierz(
    nr_strony         INTEGER = NULL,
    rozmiar_strony    INTEGER = NULL
)
RETURNS SETOF uzytkownicy AS
$BODY$
 BEGIN
  RETURN QUERY
    SELECT *
    FROM uzytkownicy
    ORDER BY id
    LIMIT rozmiar_strony
    OFFSET ((nr_strony-1) * rozmiar_strony);
 END;
$BODY$
LANGUAGE plpgsql;

/*
    =====================================================================
*/

CREATE OR REPLACE PROCEDURE uzytkownicy_edytuj(
	_id						uzytkownicy.id%TYPE,
	_imie                   uzytkownicy.imie%TYPE,
    _nazwisko               uzytkownicy.nazwisko%TYPE,
    _nazwa_uzytkownika		uzytkownicy.nazwa_uzytkownika%TYPE,
    _email                  uzytkownicy.email%TYPE,
    _telefon                uzytkownicy.telefon%TYPE,
    _haslo                  uzytkownicy.haslo%TYPE,
	_adres_id				uzytkownicy.adres_id%TYPE
)
LANGUAGE plpgsql
AS $BODY$
DECLARE
	uzytkownik uzytkownicy;
	_temp adresy%ROWTYPE;
	__hashed_haslo TEXT;
	BEGIN
		SELECT * INTO uzytkownik FROM uzytkownicy WHERE id = _id;
		IF NOT FOUND THEN
    		RAISE EXCEPTION 'Użytkownik o ID = % nie istnieje!', _id;
		END IF;
		
		IF (_imie IS NULL) OR (LENGTH(_imie) = 0) THEN
			_imie = uzytkownik.imie;
		END IF;
		
		IF (_nazwisko IS NULL) OR (LENGTH(_nazwisko) = 0) THEN
			_nazwisko = uzytkownik.nazwisko;
		END IF;
		
		IF (_nazwa_uzytkownika IS NULL) OR (LENGTH(_nazwa_uzytkownika) = 0) THEN
			_nazwa_uzytkownika = uzytkownik.nazwa_uzytkownika;
		END IF;
		
		IF (_email IS NULL) OR (LENGTH(_email) = 0) THEN
			_email = uzytkownik.email;
		END IF;
		
		IF (_telefon IS NULL) OR (LENGTH(_telefon) = 0) THEN
			_telefon = uzytkownik.telefon;
		END IF;
		
		IF (_haslo IS NULL) OR (LENGTH(_haslo) = 0) THEN
			_haslo = uzytkownik.haslo;
		ELSE
			SELECT encode(digest(_haslo, 'sha1'), 'hex') INTO __hashed_haslo;
			_haslo = __hashed_haslo;
		END IF;
		
		IF (_adres_id IS NULL) OR (_adres_id = -1) THEN
			_adres_id = uzytkownik.adres_id;
		ELSE 
			SELECT * INTO _temp FROM adresy WHERE id = _adres_id;
			IF NOT FOUND THEN 
				RAISE EXCEPTION 'Adres o ID = % nie istnieje!', _adres_id;
			END IF;
		END IF;
		
		UPDATE uzytkownicy SET
			imie = _imie,             
			nazwisko = _nazwisko,         
			nazwa_uzytkownika = _nazwa_uzytkownika,
			email =	 _email,            
			telefon	= _telefon,          
			haslo =	_haslo,
			adres_id = _adres_id
			
		WHERE id = _id;
	END;
$BODY$;

/*
    =====================================================================
*/

CREATE OR REPLACE PROCEDURE uzytkownicy_usun(
    _id             uzytkownicy.id%TYPE
)
LANGUAGE plpgsql
AS $BODY$
DECLARE
    lista_zamowien VARCHAR(500);
	_temp uzytkownicy%ROWTYPE;
    BEGIN
		SELECT * INTO _temp FROM uzytkownicy WHERE id = _id;
		IF NOT FOUND THEN
    		RAISE EXCEPTION 'Użytkownik o ID = % nie istnieje!', _id;
		END IF;
	
        CREATE TEMP TABLE temp_tbl2 AS SELECT * FROM zamowienia WHERE uzytkownik_id = _id;
        IF EXISTS (SELECT * FROM temp_tbl2 LIMIT 1) THEN
            SELECT STRING_AGG(temp_tbl2.id::varchar(255), ', ') INTO lista_zamowien FROM temp_tbl2;
            RAISE EXCEPTION 'Nie można usunąć użytkownika o ID % ponieważ istnieją zamówienia (%)', _id, lista_zamowien;
        END IF;
		
        DELETE FROM uzytkownicy WHERE id = _id;
		DROP TABLE IF EXISTS temp_tbl2;
    END;
$BODY$;

/*
    =====================================================================
*/

CREATE OR REPLACE FUNCTION uzytkownicy_pobierz_szczegoly_wszystkie()
RETURNS TABLE (
	id						uzytkownicy.id%TYPE,
    imie                   	uzytkownicy.imie%TYPE,
    nazwisko               	uzytkownicy.nazwisko%TYPE,
    nazwa_uzytkownika		uzytkownicy.nazwa_uzytkownika%TYPE,
    email                  	uzytkownicy.email%TYPE,
    telefon                	uzytkownicy.telefon%TYPE,
    haslo                  	uzytkownicy.haslo%TYPE,
	adres_id				adresy.id%TYPE,
	ulica 					adresy.ulica%TYPE,
	nr_mieszkania 			adresy.nr_mieszkania%TYPE,
	miasto 					adresy.miasto%TYPE,
	kod_pocztowy 			adresy.kod_pocztowy%TYPE,
	kraj 					adresy.kraj%TYPE
) AS 
$BODY$
 BEGIN
  RETURN QUERY
	SELECT
		u.id,
		u.imie,
		u.nazwisko,
		u.nazwa_uzytkownika,
		u.email,
		u.telefon,
		u.haslo,
		ad.id,
		ad.ulica,
		ad.nr_mieszkania,
		ad.miasto,
		ad.kod_pocztowy,
		ad.kraj
	FROM uzytkownicy u INNER JOIN adresy ad
	ON u.adres_id = ad.id
	ORDER BY u.id;
 END;
$BODY$
LANGUAGE plpgsql;

/*
    =====================================================================
*/

CREATE OR REPLACE FUNCTION uzytkownicy_pobierz_szczegoly_wszystkie(
	_id uzytkownicy.id%TYPE
)
RETURNS TABLE (
	id						uzytkownicy.id%TYPE,
    imie                   	uzytkownicy.imie%TYPE,
    nazwisko               	uzytkownicy.nazwisko%TYPE,
    nazwa_uzytkownika		uzytkownicy.nazwa_uzytkownika%TYPE,
    email                  	uzytkownicy.email%TYPE,
    telefon                	uzytkownicy.telefon%TYPE,
    haslo                  	uzytkownicy.haslo%TYPE,
	adres_id				adresy.id%TYPE,
	ulica 					adresy.ulica%TYPE,
	nr_mieszkania 			adresy.nr_mieszkania%TYPE,
	miasto 					adresy.miasto%TYPE,
	kod_pocztowy 			adresy.kod_pocztowy%TYPE,
	kraj 					adresy.kraj%TYPE
) AS 
$BODY$
DECLARE
	__temp uzytkownicy%ROWTYPE;
 BEGIN
 
 SELECT * INTO __temp FROM uzytkownicy_znajdz(_id);
  RETURN QUERY
	SELECT
		u.id,
		u.imie,
		u.nazwisko,
		u.nazwa_uzytkownika,
		u.email,
		u.telefon,
		u.haslo,
		ad.id,
		ad.ulica,
		ad.nr_mieszkania,
		ad.miasto,
		ad.kod_pocztowy,
		ad.kraj
	FROM uzytkownicy u INNER JOIN adresy ad
	ON u.adres_id = ad.id
	WHERE u.id = _id;
 END;
$BODY$
LANGUAGE plpgsql;

/*
    =========================================== CRUD: Produkty ===========================================
*/


CREATE OR REPLACE PROCEDURE produkty_dodaj(
	_nazwa				produkty.nazwa%TYPE,
	_kod_producenta 	produkty.kod_producenta%TYPE,
	_cena 				produkty.cena%TYPE,
	_opis			 	produkty.opis%TYPE,
	_kategoria 			produkty.kategoria%TYPE,
	_ilosc				produkty.ilosc%TYPE
)
LANGUAGE plpgsql
AS $BODY$
	BEGIN
		IF (_nazwa IS NULL) OR (LENGTH(_nazwa) = 0) THEN
			RAISE EXCEPTION 'Nazwa produktu nie może być pusta!';
		END IF;
		
		IF (_kod_producenta  IS NULL) OR (LENGTH(_kod_producenta ) = 0) THEN
			RAISE EXCEPTION 'Kod producenta nie może być pusty!';
		END IF;
		
		IF (_cena IS NULL) OR (_cena <= 0) THEN
			RAISE EXCEPTION 'Cena nie może być pusta albo mniejsza od zera!';
		END IF;
		
		IF (_opis IS NULL) OR (LENGTH(_opis) = 0) THEN
			RAISE EXCEPTION 'Opis nie może być pusty!';
		END IF;
		
		IF (_kategoria IS NULL) OR (LENGTH(_kategoria) = 0) THEN
			RAISE EXCEPTION 'Kategoria nie może być pusta!';
		END IF;

		IF (_ilosc IS NULL) OR (_ilosc < 0) THEN
			RAISE EXCEPTION 'Ilość nie może być pusta albo mniejsza od zera!';
		END IF;
		
		INSERT INTO produkty(nazwa, kod_producenta, cena, opis, kategoria, ilosc)
		VALUES(_nazwa, _kod_producenta, _cena, _opis, _kategoria, _ilosc);
	END;
$BODY$;

/*
    =====================================================================
*/

CREATE OR REPLACE FUNCTION produkty_pobierz(
	nr_strony 		INTEGER = NULL,
	rozmiar_strony	INTEGER = NULL
)
RETURNS SETOF produkty AS
$BODY$
 BEGIN
  RETURN QUERY
	SELECT *
	FROM produkty
	ORDER BY id
	LIMIT rozmiar_strony
	OFFSET ((nr_strony-1) * rozmiar_strony);
 END;
$BODY$
LANGUAGE plpgsql;

/*
    =====================================================================
*/

CREATE OR REPLACE FUNCTION produkty_pobierz_wszystkie()
RETURNS SETOF produkty AS
$BODY$
 BEGIN
  RETURN QUERY
	SELECT *
	FROM produkty
	ORDER BY id;
 END;
$BODY$
LANGUAGE plpgsql;

/*
    =====================================================================
*/

CREATE OR REPLACE FUNCTION produkty_pobierz_ilosc()
RETURNS INT AS
$BODY$
 BEGIN
  RETURN ( SELECT COUNT(*) FROM produkty );
 END;
$BODY$
LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION produkty_znajdz(
    _id_produktu	INTEGER = NULL
)
RETURNS SETOF produkty AS
$BODY$
 DECLARE
 	wynik produkty%ROWTYPE;
 BEGIN
    SELECT *
	INTO wynik
    FROM produkty
    WHERE id = _id_produktu;
	IF NOT FOUND THEN
    	RAISE EXCEPTION 'Produkt o ID = % nie istnieje!', _id_produktu;
	END IF;
	RETURN NEXT wynik;
 END;
$BODY$
LANGUAGE plpgsql;

/*
    =====================================================================
*/

CREATE OR REPLACE FUNCTION produkty_wyszukaj(
    kryteria		 VARCHAR(255),
	pokazujWszystkie BOOLEAN DEFAULT FALSE
)
RETURNS SETOF produkty AS
$BODY$
 BEGIN
  kryteria = LOWER(kryteria);
  IF pokazujWszystkie THEN
	RETURN QUERY
	SELECT *
	FROM produkty
	WHERE 
		LOWER(id::varchar(255))		LIKE '%'||kryteria||'%' OR
		LOWER(nazwa)				LIKE '%'||kryteria||'%' OR
		LOWER(kod_producenta)		LIKE '%'||kryteria||'%' OR
		LOWER(cena::varchar(255))	LIKE '%'||kryteria||'%' OR
		LOWER(opis)					LIKE '%'||kryteria||'%' OR
		LOWER(kategoria)			LIKE '%'||kryteria||'%' 
	ORDER BY id;
  ELSE
	RETURN QUERY
	SELECT *
	FROM produkty
	WHERE 
		ilosc > 0 AND (
			LOWER(id::varchar(255))		LIKE '%'||kryteria||'%' OR
			LOWER(nazwa)				LIKE '%'||kryteria||'%' OR
			LOWER(kod_producenta)		LIKE '%'||kryteria||'%' OR
			LOWER(cena::varchar(255))	LIKE '%'||kryteria||'%' OR
			LOWER(opis)					LIKE '%'||kryteria||'%' OR
			LOWER(kategoria)			LIKE '%'||kryteria||'%'
		) 
	ORDER BY id;
  END IF;
 END;
$BODY$
LANGUAGE plpgsql;

/*
    =====================================================================
*/

CREATE OR REPLACE FUNCTION produkty_paginuj_wyszukaj(
    kryteria  		VARCHAR(255),
	nr_strony 		INTEGER = NULL,
	rozmiar_strony	INTEGER = NULL,
	pokazujWszystkie BOOLEAN DEFAULT FALSE
)
RETURNS SETOF produkty AS
$BODY$
 BEGIN
  RETURN QUERY
	SELECT * FROM produkty_wyszukaj(kryteria, pokazujWszystkie)
	LIMIT rozmiar_strony
	OFFSET ((nr_strony-1) * rozmiar_strony);
 END;
$BODY$
LANGUAGE plpgsql;

CREATE OR REPLACE PROCEDURE produkty_edytuj(
	_id 				produkty.id%TYPE,
	_nazwa 				produkty.nazwa%TYPE,
	_kod_producenta		produkty.kod_producenta%TYPE,
	_cena				produkty.cena%TYPE,
	_opis				produkty.opis%TYPE,
	_kategoria 			produkty.kategoria%TYPE,
	_ilosc				produkty.ilosc%TYPE
)
LANGUAGE plpgsql
AS $BODY$
DECLARE
	produkt produkty;
	BEGIN
		SELECT * INTO produkt FROM produkty WHERE id = _id;
		IF NOT FOUND THEN
    		RAISE EXCEPTION 'Produkt o ID = % nie istnieje!', _id;
		END IF;
		
		IF (_nazwa IS NULL) OR (LENGTH(_nazwa) = 0) THEN
			_nazwa = produkt.nazwa;
		END IF;
		
		IF (_kod_producenta IS NULL) OR (LENGTH(_kod_producenta) = 0) THEN
			_kod_producenta = produkt.kod_producenta;
		END IF;
		
		IF (_cena IS NULL) OR (_cena <= 0) THEN
			_cena = produkt.cena;
		END IF;
		
		IF (_opis IS NULL) OR (LENGTH(_opis) = 0) THEN
			_opis = produkt.opis;
		END IF;
		
		IF (_kategoria IS NULL) OR (LENGTH(_kategoria) = 0) THEN
			_kategoria = produkt.kategoria;
		END IF;

		IF (_ilosc IS NULL) OR (_ilosc < 0) THEN
			RAISE EXCEPTION 'Ilość nie może być pusta albo mniejsza od zera!';
		END IF;
		
		UPDATE produkty SET
			nazwa = _nazwa, 			
			kod_producenta = _kod_producenta,	
			cena = _cena,			
			opis = _opis,			
			kategoria = _kategoria,
			ilosc = _ilosc 		
		WHERE id = _id;
	END;
$BODY$;

/*
    =====================================================================
*/

CREATE OR REPLACE PROCEDURE produkty_usun(
    _id		produkty.id%TYPE
)
LANGUAGE plpgsql
AS $BODY$
DECLARE
	_temp produkty%ROWTYPE;
    BEGIN
		SELECT * INTO _temp FROM produkty WHERE id = _id;
		IF NOT FOUND THEN
    		RAISE EXCEPTION 'Produkt o ID = % nie istnieje!', _id;
		END IF;
	
        DELETE FROM produkty WHERE id = _id;
		DROP TABLE IF EXISTS temp_tbl;
    END;
$BODY$;

/*
    =====================================================================
*/

CREATE OR REPLACE FUNCTION produkty_historyczne_kopiuj(
    _id		produkty.id%TYPE
)
RETURNS INT AS
$BODY$
DECLARE
	wynik INT;
	_temp produkty%ROWTYPE;
	BEGIN
 		SELECT * INTO _temp FROM produkty_znajdz(_id);
		INSERT INTO produkty_historyczne (cena, kategoria, kod_producenta, nazwa, opis)
		VALUES (_temp.cena, _temp.kategoria, _temp.kod_producenta, _temp.nazwa, _temp.opis)
		RETURNING id INTO wynik;

		RETURN wynik;
	END;
$BODY$
LANGUAGE plpgsql;

/*
    =========================================== CRUD: Zamówienia ===========================================
*/

CREATE OR REPLACE FUNCTION zamowienia_znajdz(
    _id_zamowienia	INTEGER = NULL
)
RETURNS SETOF zamowienia AS
$BODY$
 DECLARE
 	wynik zamowienia%ROWTYPE;
 BEGIN
    SELECT *
	INTO wynik
    FROM zamowienia
    WHERE id = _id_zamowienia;
	IF NOT FOUND THEN
    	RAISE EXCEPTION 'Zamówienie o ID = % nie istnieje!', _id_zamowienia;
	END IF;
	RETURN NEXT wynik;
 END;
$BODY$
LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION zamowienia_znajdz_po_uid(
    _id_uzytkownika    INTEGER = NULL
)
RETURNS SETOF zamowienia AS
$BODY$
 DECLARE
    _temp uzytkownicy%ROWTYPE;
   BEGIN
       SELECT * into _temp  FROM uzytkownicy_znajdz(_id_uzytkownika);
       RETURN QUERY SELECT *
            FROM zamowienia
            WHERE uzytkownik_id = _id_uzytkownika;
 END;
$BODY$
LANGUAGE plpgsql;

/*
    =====================================================================
*/

CREATE OR REPLACE FUNCTION zamowienia_pobierz_ilosc()
RETURNS INT AS
$BODY$
 BEGIN
  RETURN ( SELECT COUNT(*) FROM zamowienia );
 END;
$BODY$
LANGUAGE plpgsql;

/*
    =====================================================================
*/

CREATE OR REPLACE FUNCTION zamowienia_pobierz_wszystkie()
RETURNS TABLE (
	imie		 		uzytkownicy.imie%TYPE,
	nazwisko 			uzytkownicy.nazwisko%TYPE,
	email 		 		uzytkownicy.email%TYPE,
	id_zamowienia 		zamowienia.id%TYPE,
	forma_platonosci 	zamowienia.forma_platnosci%TYPE,
	data_zamowienia 	zamowienia.data_zamowienia%TYPE,
	status_zamowienia 	zamowienia.status_zamowienia%TYPE,
	kwota 				zamowienia.kwota%TYPE
) AS 
$BODY$
 BEGIN
  RETURN QUERY
	SELECT 
		u.imie,
		u.nazwisko,
		u.email,
		z.id,
		z.forma_platnosci,
		z.data_zamowienia,
		z.status_zamowienia,
		z.kwota
	FROM uzytkownicy u INNER JOIN zamowienia z
	ON u.id = z.uzytkownik_id
	ORDER BY z.id;
 END;
$BODY$
LANGUAGE plpgsql;

/*
    =====================================================================
*/

CREATE OR REPLACE FUNCTION zamowienia_paginuj(
	nr_strony 		INTEGER = NULL,
	rozmiar_strony	INTEGER = NULL
)
RETURNS TABLE (
	imie		 		uzytkownicy.imie%TYPE,
	nazwisko 			uzytkownicy.nazwisko%TYPE,
	email 		 		uzytkownicy.email%TYPE,
	id_zamowienia 		zamowienia.id%TYPE,
	forma_platnosci 	zamowienia.forma_platnosci%TYPE,
	data_zamowienia 	zamowienia.data_zamowienia%TYPE,
	status_zamowienia 	zamowienia.status_zamowienia%TYPE,
	kwota 				zamowienia.kwota%TYPE
) AS 
$BODY$
 BEGIN
  RETURN QUERY
	SELECT * FROM zamowienia_pobierz_wszystkie()
	LIMIT rozmiar_strony
	OFFSET ((nr_strony-1) * rozmiar_strony);
 END;
$BODY$
LANGUAGE plpgsql;



CREATE OR REPLACE FUNCTION zamowienia_pobierz_produkty(
    _id_zamowienia	INTEGER = NULL
)
RETURNS SETOF _t_zamowienia_produkty AS
$BODY$
 DECLARE
 	__temp zamowienia%ROWTYPE;
 BEGIN
 	SELECT * INTO __temp FROM zamowienia_znajdz(_id_zamowienia);
	RETURN QUERY
    	SELECT ph.nazwa, ph.kod_producenta, ph.cena, ph.opis, ph.kategoria, z.ilosc
	FROM zamowienia_produkty z
	INNER JOIN produkty_historyczne ph
	ON z.produkt_id = ph.id
	WHERE z.zamowienie_id = _id_zamowienia
	ORDER BY z.id;
 END;
$BODY$
LANGUAGE plpgsql;

/*
    =====================================================================
*/

CREATE OR REPLACE PROCEDURE zamowienia_zmien_status(
    _id_zamowienia	zamowienia.id%TYPE,
	_nowy_status	zamowienia.status_zamowienia%TYPE
)
LANGUAGE plpgsql
AS $BODY$
DECLARE
	_temp 				zamowienia%ROWTYPE;
	_zwracane_produkt	_t_zamowienia_produkty%ROWTYPE;
	_produkt_z_magazynu	produkty%ROWTYPE;
	_suma_produktu  	INT;
    BEGIN
		SELECT * INTO _temp FROM zamowienia_znajdz(_id_zamowienia);
	
		IF (_nowy_status IS NULL) OR (LENGTH(_nowy_status) = 0) THEN
			RAISE EXCEPTION 'Status nie może być pusty!';
		END IF;
		
		IF LOWER(_temp.status_zamowienia) LIKE 'dostarczone' THEN
			RAISE EXCEPTION 'Nie można zmienić statusu zamówienia o ID = % ponieważ zostało już dostarczone!', _id_zamowienia;
		END IF;
		
		IF LOWER(_temp.status_zamowienia) LIKE 'anulowane' THEN
			RAISE EXCEPTION 'Nie można zmienić statusu zamówienia o ID = % ponieważ zostało już anulowane!', _id_zamowienia;
		END IF;
		
		IF LOWER(_nowy_status) LIKE 'anulowane' THEN
			FOR _zwracane_produkt IN (SELECT * FROM zamowienia_pobierz_produkty(_id_zamowienia)) LOOP
				SELECT * INTO _produkt_z_magazynu FROM produkty WHERE kod_producenta = _zwracane_produkt.kod_producenta;
				
				IF NOT FOUND THEN
    				CALL produkty_dodaj(
						_zwracane_produkt.nazwa, _zwracane_produkt.kod_producenta, _zwracane_produkt.cena, _zwracane_produkt.opis, _zwracane_produkt.kategoria, _zwracane_produkt.ilosc
					);
				ELSE
					_suma_produktu = _produkt_z_magazynu.ilosc + _zwracane_produkt.ilosc;
					CALL produkty_edytuj(_produkt_z_magazynu.id, '', '', 0, '', '', _suma_produktu);
				END IF;
				
			END LOOP;
		END IF;
	
        UPDATE zamowienia
		SET status_zamowienia = _nowy_status
		WHERE id = _id_zamowienia;
    END;
$BODY$;

/*
    =========================================== Logika biznesowa ===========================================
*/

CREATE OR REPLACE FUNCTION produkty_historyczne_kopiuj(
    _id		produkty.id%TYPE
)
RETURNS INT AS
$BODY$
DECLARE
	wynik INT;
	_temp produkty%ROWTYPE;
	BEGIN
 		SELECT * INTO _temp FROM produkty_znajdz(_id);
		INSERT INTO produkty_historyczne (cena, kategoria, kod_producenta, nazwa, opis)
		VALUES (_temp.cena, _temp.kategoria, _temp.kod_producenta, _temp.nazwa, _temp.opis)
		RETURNING id INTO wynik;

		RETURN wynik;
	END;
$BODY$
LANGUAGE plpgsql;

/*
    =====================================================================
*/

CREATE OR REPLACE FUNCTION dodaj_zamowienie(
	u_id 			zamowienia.uzytkownik_id%TYPE,
	forma_platnosci	zamowienia.forma_platnosci%TYPE,
	array_produkty	TEXT,
	array_ilosci	TEXT
)
RETURNS INT AS $$ 
DECLARE
       _produkty			INT[];
	   _ilosci				INT[];
	   _wartosc_koszyka 	FLOAT = 0;
	   _zakupione_produkty	INT[];
	   
	   __temp 			produkty%ROWTYPE;
	   __temp2			INT;
	   __temp3			uzytkownicy%ROWTYPE;
	   __temp4			INT;
	   __nowa_ilosc		INT;
BEGIN
       _produkty = string_to_array(array_produkty, ',');
	   _ilosci = string_to_array(array_ilosci, ',');
	   
	   /*
	   	W przypadku braku użytkownika, zostanie zwrócony błąd przez funkcję uzytkownicy_znajdz(id);
	   */
	   SELECT * INTO __temp3 FROM uzytkownicy_znajdz(u_id);
	   
	   	IF (forma_platnosci IS NULL) OR (LENGTH(forma_platnosci) = 0) THEN
			RAISE EXCEPTION 'Forma płatności nie może być pusta!';
		END IF;
	   
	   IF (array_produkty IS NULL) OR (LENGTH(array_produkty) = 0) OR (array_length(_produkty, 1) = 0) THEN
	   		RAISE EXCEPTION 'Lista produktów nie może być pusta!';
	   END IF;
	   
	   IF (array_ilosci IS NULL) OR (LENGTH(array_ilosci) = 0) OR (array_length(_ilosci, 1) = 0) THEN
	   		RAISE EXCEPTION 'Lista ilości porduktów nie może być pusta!';
	   END IF;
	   
	   IF array_length(_produkty, 1) != array_length(_ilosci, 1) THEN
	   		RAISE EXCEPTION 'Ilosć produktów nie zgadza się z ich ilością!';
	   END IF;
	   
       FOR _pid IN array_lower(_produkty, 1)..array_upper(_produkty, 1) LOOP
	   		SELECT * INTO __temp FROM produkty_znajdz(_produkty[_pid]);

			__nowa_ilosc = __temp.ilosc - _ilosci[_pid];

			IF (__nowa_ilosc < 0) THEN
				RAISE EXCEPTION 'Niewystarczająca ilość produktu %. Na stanie tylko %!', __temp.nazwa, __temp.ilosc;
			END IF;

			_wartosc_koszyka = _wartosc_koszyka + __temp.cena * _ilosci[_pid];

			UPDATE produkty SET ilosc = __nowa_ilosc WHERE id = __temp.id;
			
			SELECT * INTO __temp2 FROM produkty_historyczne_kopiuj(_produkty[_pid]);
			_zakupione_produkty := array_append(_zakupione_produkty, __temp2);
	   END LOOP;
	   
	   INSERT INTO zamowienia (uzytkownik_id, forma_platnosci, kwota)
	   VALUES (u_id, forma_platnosci, _wartosc_koszyka)
	   RETURNING id INTO __temp4;
	   
	   FOR _zpid IN array_lower(_zakupione_produkty, 1)..array_upper(_zakupione_produkty, 1) LOOP
	   		INSERT INTO zamowienia_produkty (zamowienie_id, produkt_id, ilosc)
			VALUES (__temp4, _zakupione_produkty[_zpid], _ilosci[_zpid]);
	   END LOOP;
	   
	   RETURN __temp4;
	   
END $$ LANGUAGE plpgsql;

/*
    =====================================================================
*/

CREATE OR REPLACE FUNCTION zaloguj(
    _login uzytkownicy.nazwa_uzytkownika%TYPE,
	_haslo uzytkownicy.haslo%TYPE
)
RETURNS SETOF uzytkownicy AS
$BODY$
 DECLARE
 	wynik uzytkownicy%ROWTYPE;
	__hashed_haslo TEXT;
 BEGIN
 	SELECT encode(digest(_haslo, 'sha1'), 'hex') INTO __hashed_haslo;
	
    SELECT *
	INTO wynik
    FROM uzytkownicy
    WHERE 
	(uzytkownicy.nazwa_uzytkownika = _login AND uzytkownicy.haslo = __hashed_haslo) OR
	(uzytkownicy.email = _login AND uzytkownicy.haslo = __hashed_haslo);
	IF NOT FOUND THEN
    	RAISE EXCEPTION 'Błędne dane logowania!';
	END IF;
	RETURN NEXT wynik;
 END;
$BODY$
LANGUAGE plpgsql;

/*
    =========================================== Triggery ===========================================
*/

CREATE OR REPLACE PROCEDURE logi_dodaj(
    _tabela VARCHAR(30),
	_akcja  VARCHAR(30),
	_uzytkownik  VARCHAR(30),
	_opis  VARCHAR(25)
)
LANGUAGE plpgsql
AS $BODY$
    BEGIN
		INSERT INTO logi (tabela, akcja, uzytkownik, opis)
		VALUES (_tabela, _akcja, _uzytkownik, _opis);
    END;
$BODY$;

/*
    =====================================================================
*/

CREATE OR REPLACE FUNCTION adresy_logi() RETURNS TRIGGER AS $BODY$
    DECLARE
        _opis    VARCHAR(255);
    BEGIN
        IF (TG_OP = 'DELETE') THEN
            _opis = 'Usunieto adres o ID = ' || OLD.id;
        ELSIF (TG_OP = 'UPDATE') THEN
            _opis = 'Zaktualizowano adres o ID = ' || OLD.id;
        ELSIF (TG_OP = 'INSERT') THEN
            _opis = 'Dodano nowy adres o ID = ' || NEW.id;
        END IF;
        
        CALL logi_dodaj(TG_TABLE_NAME::varchar(255), TG_OP, 'administrator', _opis);
        
        RETURN NULL;
    END;
$BODY$ LANGUAGE plpgsql;

CREATE TRIGGER adresy_trigger
AFTER INSERT OR UPDATE OR DELETE ON adresy
    FOR EACH ROW EXECUTE FUNCTION adresy_logi();

/*
    =====================================================================
*/

CREATE OR REPLACE FUNCTION produkty_logi() RETURNS TRIGGER AS $BODY$
    DECLARE
        _opis    VARCHAR(255);
    BEGIN
        IF (TG_OP = 'DELETE') THEN
            _opis = 'Usunieto produkt o ID = ' || OLD.id;
        ELSIF (TG_OP = 'UPDATE') THEN
            _opis = 'Zaktualizowano produkt o ID = ' || OLD.id;
        ELSIF (TG_OP = 'INSERT') THEN
            _opis = 'Dodano nowy produkt o ID = ' || NEW.id;
        END IF;
        
        CALL logi_dodaj(TG_TABLE_NAME::varchar(255), TG_OP, 'administrator', _opis);
        
        RETURN NULL;
    END;
$BODY$ LANGUAGE plpgsql;

CREATE TRIGGER produkty_trigger
AFTER INSERT OR UPDATE OR DELETE ON produkty
    FOR EACH ROW EXECUTE FUNCTION produkty_logi();

/*
    =====================================================================
*/

CREATE OR REPLACE FUNCTION uzytkownicy_logi() RETURNS TRIGGER AS $BODY$
    DECLARE
        _opis    VARCHAR(255);
    BEGIN
        IF (TG_OP = 'DELETE') THEN
            _opis = 'Usunieto uzytkownika o ID = ' || OLD.id;
        ELSIF (TG_OP = 'UPDATE') THEN
            _opis = 'Zaktualizowano uzytkownika o ID = ' || OLD.id;
        ELSIF (TG_OP = 'INSERT') THEN
            _opis = 'Dodano nowego uzytkownika o ID = ' || NEW.id;
        END IF;
        
        CALL logi_dodaj(TG_TABLE_NAME::varchar(255), TG_OP, 'administrator', _opis);
        
        RETURN NULL;
    END;
$BODY$ LANGUAGE plpgsql;

CREATE TRIGGER uzytkownicy_trigger
AFTER INSERT OR UPDATE OR DELETE ON uzytkownicy
    FOR EACH ROW EXECUTE FUNCTION uzytkownicy_logi();

/*
    =====================================================================
*/

CREATE OR REPLACE FUNCTION zamowienia_logi() RETURNS TRIGGER AS $BODY$
    DECLARE
        _opis    VARCHAR(255);
    BEGIN
        IF (TG_OP = 'DELETE') THEN
            _opis = 'Usunieto zamowienie o ID = ' || OLD.id;
        ELSIF (TG_OP = 'UPDATE') THEN
            _opis = 'Zaktualizowano zamowienie o ID = ' || OLD.id;
        ELSIF (TG_OP = 'INSERT') THEN
            _opis = 'Dodano nowe zamowienie o ID = ' || NEW.id;
        END IF;
        
        CALL logi_dodaj(TG_TABLE_NAME::varchar(255), TG_OP, 'administrator', _opis);
        
        RETURN NULL;
    END;
$BODY$ LANGUAGE plpgsql;

CREATE TRIGGER zamowienia_trigger
AFTER INSERT OR UPDATE OR DELETE ON zamowienia
    FOR EACH ROW EXECUTE FUNCTION zamowienia_logi();

/*
    =====================================================================
*/

CREATE OR REPLACE FUNCTION logi_pobierz(
    nr_strony         INTEGER = NULL,
    rozmiar_strony    INTEGER = NULL
)
RETURNS SETOF logi AS
$BODY$
 BEGIN
  RETURN QUERY
    SELECT *
    FROM logi
    ORDER BY id
    LIMIT rozmiar_strony
    OFFSET ((nr_strony-1) * rozmiar_strony);
 END;
$BODY$
LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION logi_pobierz_ilosc()
RETURNS INT AS
$BODY$
 BEGIN
  RETURN ( SELECT COUNT(*) FROM logi );
 END;
$BODY$
LANGUAGE plpgsql;

/*
    =====================================================================
*/