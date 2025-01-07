use SystemKolejowy
go

CREATE TABLE Pociagi ( 
    ID_pociagu INT PRIMARY KEY, 
    Nazwa_pociagu NVARCHAR(50) NOT NULL, 
    Liczba_wagonow INT NOT NULL, 
    Typ_pociagu NVARCHAR(50) NOT NULL
);

INSERT INTO Pociagi
VALUES 
    (1, 'Krakus', 6, 'PKP Intercity'),
    (2, 'Bryza', 3, 'Koleje œl¹skie'),
    (3, 'Piast', 8, 'PKP Intercity'),
    (4, 'Hetman', 4, 'PKP Intercity'),
    (5, 'Regionalny', 3, 'Przewozy regionalne');

CREATE TABLE Szczegoly_techniczne_pociagow (
    ID_pociagu INT PRIMARY KEY,        
    Producent NVARCHAR(100) NOT NULL,             
    Moc_silnika INT NOT NULL,                   
    Typ_silnika NVARCHAR(50) NOT NULL,           
    Rok_produkcji INT NOT NULL,                 
    FOREIGN KEY (ID_pociagu) REFERENCES Pociagi(ID_pociagu) 
);

INSERT INTO Szczegoly_techniczne_pociagow (ID_pociagu, Producent, Moc_silnika, Typ_silnika, Rok_produkcji)
VALUES
(1, 'Bombardier', 4000, 'Elektryczny', 2018),
(2, 'Siemens', 3000, 'Elektryczny', 2015),
(3, 'Pesa', 3200, 'Spalinowy', 2020),
(4, 'Alstom', 4200, 'Elektryczny', 2018),
(5, 'Stadler', 2800, 'Spalinowy', 2019);

CREATE TABLE Rozklad (
    ID_rozkladu INT PRIMARY KEY,
    ID_pociagu INT NOT NULL,
    Czas_odjazdu DATETIME NOT NULL,
    Czas_przyjazdu DATETIME NOT NULL,
    Stacja_zrodlowa NVARCHAR(100) NOT NULL,
    Stacja_docelowa NVARCHAR(100) NOT NULL,
    Trasa NVARCHAR(50),
    Numer_peronu INT NOT NULL,
    Czas_trwania TIME,
    FOREIGN KEY (ID_pociagu) REFERENCES Pociagi(ID_pociagu)
);

INSERT INTO Rozklad 
VALUES 
    (1, 1, '2024-11-27 07:00:00', '2024-11-27 11:55:00', 'Warszawa-Zachodnia', 'Kraków-G³ówny', 'Poœpieszny', 2, '04:55:00'),
    (2, 2, '2024-11-28 09:30:00', '2024-11-28 11:32:00', 'Katowice', '¯ywiec', 'Regionalny', 3, '02:32:00'),
    (3, 3, '2024-11-29 10:30:00', '2024-11-29 14:30:00', 'Wroc³aw', 'Gdynia', 'Poœpieszny', 2, '04:00:00'),
    (4, 4, '2024-11-30 11:00:00', '2024-11-30 17:45:00', 'Zamoœæ', 'Wroc³aw', 'Poœpieszny', 1, '06:45:00'),
    (5, 5, '2024-11-30 15:22:00', '2024-11-30 17:45:00', 'Kraków-G³ówny', 'Sêdziszów', 'Regionalny', 3, '02:23:00'),
    (6, 1, '2024-11-28 13:00:00', '2024-11-28 17:55:00', 'Kraków-G³ówny', 'Warszawa-Zachodnia', 'Poœpieszny', 4, '04:55:00'),
   (7, 4, '2024-12-02 15:00:00', '2024-12-02 22:45:00', 'Wroc³aw', 'Zamoœæ', 'Poœpieszny', 1, '06:45:00');

CREATE TABLE Stacje (
    ID_stacji INT PRIMARY KEY,
    Nazwa_stacji NVARCHAR(100) NOT NULL,
    Miasto NVARCHAR(100)
);

INSERT INTO Stacje
VALUES 
    (1, 'Warszawa-Zachodnia', 'Warszawa'),
    (2, 'S³omnki-Miasto', 'S³omniki'),
    (3, 'Katowice-Ligota', 'Katowice'),
    (4, 'Zamoœæ', 'Zamoœæ'),
    (5, 'Wroc³aw-G³ówny', 'Wroc³aw');

CREATE TABLE Informacje_o_trasie (
    ID_trasy INT PRIMARY KEY,
    ID_stacji_zrodlowej INT NOT NULL,
    ID_stacji_docelowej INT NOT NULL,
    Odleglosc_km INT,
    FOREIGN KEY (ID_stacji_zrodlowej) REFERENCES Stacje(ID_stacji),
    FOREIGN KEY (ID_stacji_docelowej) REFERENCES Stacje(ID_stacji)
);

INSERT INTO Informacje_o_trasie
VALUES 
    (1, 1, 3, 295),
    (2, 4, 1, 260),
    (3, 3, 5, 200),
    (4, 1, 5, 370);

CREATE TABLE Pasazerowie (
    ID_pasazera INT PRIMARY KEY,
    Imie NVARCHAR(100) NOT NULL,
    Nazwisko NVARCHAR(100) NOT NULL,
    Adres_email NVARCHAR(100) NOT NULL UNIQUE,
    Haslo NVARCHAR(50) NOT NULL
);

INSERT INTO Pasazerowie 
VALUES 
    (1,'Micha³','Wójcik', 'm.wojcik@wp.pl', 'haslo123'),
    (2,'Julia','Ma³ysz', 'j.malysz@wp.pl', 'haslo098'),
    (3,'Tomasz','Nowak', 't.nowak123@o2.pl', 'haslo231'),
    (4, 'Anna','Mucha', 'anna.mucha@onet.pl', 'haslo999'),
    (5,'Mateusz','Kowalski', 'm.kowalski@onet.pl', 'haslo111'),
    (6, 'Pawe³','Mickiewicz', 'p.mickiewicz@onet.pl', 'haslo122');

CREATE TABLE Rezerwacje_biletow (
    ID_rezerwacji INT PRIMARY KEY,
    ID_pasazera INT NOT NULL,
    ID_rozkladu INT NOT NULL,
    Typ_biletu NVARCHAR(50) NOT NULL,
    Cena DECIMAL(10, 2) NOT NULL,
    Data_rezerwacji DATETIME NOT NULL,
    Czas_wyjazdu DATETIME NOT NULL,
    Czas_przyjazdu DATETIME NOT NULL,
    Czas_trwania TIME,
    Stacja_poczatkowa NVARCHAR(100) NOT NULL,
    Stacja_koncowa NVARCHAR(100) NOT NULL,
    Numer_wagonu INT,
    Numer_miejsca INT,
    Znizka_procentowa INT,
    Typ_znizki NVARCHAR(255),
    Status_rezerwacji NVARCHAR(50),
    FOREIGN KEY (ID_rozkladu) REFERENCES Rozklad(ID_rozkladu),
    FOREIGN KEY (ID_pasazera) REFERENCES Pasazerowie(ID_pasazera)
);

INSERT INTO Rezerwacje_biletow
VALUES 
(1, 1, 2, 'Normalny', 35.60, '2024-11-27 10:40:20', '2024-11-28 09:30:00', '2024-11-28 10:38:00', '01:08:00', 'Katowice', 'Tychy', NULL, NULL, NULL, NULL, 'Anulowano'),
(2, 2, 3, 'Ulgowy', 29.90, '2024-11-27 13:25:41', '2024-11-29 10:30:00', '2024-11-29 13:44:00', '03:14:00', 'Wroc³aw', 'Poznañ', 8, 35, 51, 'Zni¿ka dla studentów', 'Zarezerwowano'), 
(3, 4, 6, 'Ulgowy', 38.15, '2024-11-27 14:33:11', '2024-11-28 13:00:00', '2024-11-28 17:55:00', '04:55:00', 'Kraków-G³ówny', 'Warszawa-Zachodnia', 12, 88, 51, 'Zni¿ka dla studentów', 'Zarezerwowano'), 
(4, 3, 4, 'Normalny', 40.00, '2024-11-28 11:15:11', '2024-11-30 15:10:00', '2024-11-30 16:22:00', '01:12:00', 'Rzeszów-G³ówny', 'Katowice', 1, 22, NULL, NULL, 'Zarezerwowano'),
(5, 5, 5, 'Ulgowy', 10.04, '2024-11-29 19:11:06', '2024-11-30 15:22:00', '2024-11-30 17:45:00', '02:23:00', 'Kraków-G³ówny', 'Sêdziszów', NULL, NULL, 30, 'Zni¿ka dla Seniora', 'Zarezerwowano'),
(6, 6, 4, 'Normalny', 78.00, '2024-11-29 10:22:11', '2024-11-30 11:00:00', '2024-11-30 17:45:00', '06:45:00', 'Zamoœæ', 'Wroc³aw', 4, 14, NULL, NULL, 'Oczekuje na p³atnoœæ'),
(7, 6,7, 'Normalny', 78.00, '2024-11-29 10:30:00', '2024-12-02 15:00:00', '2024-12-02 22:45:00', '06:45:00', 'Wroc³aw', 'Zamoœæ', 5, 38, NULL, NULL, 'Oczekuje na p³atnoœæ');


CREATE TABLE Platnosci (
    ID_platnosci INT PRIMARY KEY,
    ID_rezerwacji INT NOT NULL,
    Kwota DECIMAL(10,2) NOT NULL,
    Metoda_platnosci NVARCHAR(50) NOT NULL, -- np. Karta, Przelew, Blik
    Data_platnosci DATETIME NOT NULL,
    FOREIGN KEY (ID_rezerwacji) REFERENCES Rezerwacje_biletow(ID_rezerwacji)
);

INSERT INTO Platnosci 
VALUES 
(1,1, 35.60, 'Blik', '2024-11-27'), 
(2,2,29.90, 'P³atnoœæ przelewem', '2024-11-27'), 
(3,3,38.15, 'Blik', '2024-11-27'),
(4,4, 40.00, 'P³atnoœæ przelewem', '2024-11-28'),
(5,5,10.04, 'P³atnoœæ przelewem','2024-11-29');


CREATE TABLE Opoznienia (
    ID_opoznienia INT PRIMARY KEY,
    ID_rozkladu INT NOT NULL,
    Czas_opoznienia TIME NOT NULL,
    Powod NVARCHAR(255) NOT NULL,
    FOREIGN KEY (ID_rozkladu) REFERENCES Rozklad(ID_rozkladu)
);


INSERT INTO Opoznienia 
 VALUES 
(1,2, '00:25:00', 'Usterka lokomotywy'), 
(2,4, '01:00:00', 'Problem techniczny na trasie'), 
(3,5, '00:10:00', 'OpóŸnienie z powodu z³ej pogody');

CREATE TABLE Anulowanie_biletu (
    ID_anulowania INT PRIMARY KEY, 
    ID_rezerwacji INT NOT NULL,                 
    Powód_anulowania NVARCHAR(255),   
    Data_anulowania DATETIME NOT NULL,       
    Zwrot_kwoty DECIMAL(10, 2) NOT NULL,                
    Status_zwrotu NVARCHAR(50),               
    FOREIGN KEY (ID_rezerwacji) REFERENCES Rezerwacje_biletow(ID_rezerwacji) 
);


INSERT INTO Anulowanie_biletu 
VALUES 
    (1,1, 'Zmiana planów podró¿y', '2024-11-28 08:00:00', 32.04, 'Zatwierdzony');


select *from Pociagi
select *from Rezerwacje_biletow

--Widoki
create view Aktualne_rezerwacje as
select 
	r.ID_rezerwacji,
	p.imie + ' ' + nazwisko as pasazer,
	r.stacja_poczatkowa,
	r.stacja_koncowa,
	r.cena,
	r.status_rezerwacji,
	r.data_rezerwacji
from rezerwacje_biletow r
join pasazerowie p on r.ID_pasazera = p.ID_pasazera
join rozklad roz on r.ID_rozkladu = roz.ID_rozkladu
where r.status_rezerwacji = 'Zarezerwowano';

select *from Aktualne_rezerwacje

create view Anulowane_rezerwacje as
select 
		a.ID_anulowania,
		p.Imie + ' ' + p.Nazwisko as Pasazer,
		r.typ_biletu,
		r.stacja_poczatkowa,
		r.stacja_koncowa,
		a.Data_anulowania,
		a.Powód_anulowania,
		a.Zwrot_kwoty,
		a.Status_zwrotu
from Anulowanie_biletu a
inner join rezerwacje_biletow r on a.ID_rezerwacji = r.ID_rezerwacji
inner join pasazerowie p on r.ID_pasazera = p.ID_pasazera;


select *from Anulowane_rezerwacje

create view Suma_cen_biletow as
select status_rezerwacji, sum(Cena) as Suma_cen
from rezerwacje_biletow 
group by status_rezerwacji;

select *from Suma_cen_biletow

create view Czas_z_opoznieniem as
select r.ID_rozkladu, r.Czas_trwania, o.Czas_opoznienia AS Czas_opoznienia, 
dateadd(second, datediff(second,0,o.Czas_opoznienia), r.Czas_trwania) AS Czas_calkowity 
from Rozklad r 
inner join Opoznienia o ON r.ID_rozkladu = o.ID_rozkladu;

select *from opoznienia
select *from Czas_z_opoznieniem

--Procedury

--procedura sprawdza czy istnieje anulowana rezerwacja w tabeli rezerwacje_biletow wyswietlaj¹c odpowiednie komunikaty, 
--nastêpnie oblicza kwote zwrotu po odstêpnym 10%, 
--dodaje rekord do tabeli Anulowanie_biletu
--aktualizuje status 'Anulowano' w tabeli rezerwacje_biletow

create procedure Realizacja_anulowania
	@ID_rezerwacji INT,
	@Powód_anulowania nvarchar(255) = null, --domyœlnie NULL
	@Data_anulowania datetime
as
begin
	--sprawdzenie, czy istnieje ju¿ anulowanie dla tej rezerwacji
	if exists (select 1 from Anulowanie_biletu where ID_rezerwacji = @ID_rezerwacji)
	begin
		raiserror('Rezerwacja zosta³a ju¿ anulowana.', 16, 1);
		return;
	end
	 --sprawdzenie, czy rezerwacja istnieje w tabeli rezerwacje_biletow
	 if not exists(select 1 from rezerwacje_biletow where ID_rezerwacji = @ID_rezerwacji)
	 begin
		raiserror('Rezerwacja o podanym ID nie istnieje.', 16, 1);
		return;
	end

	--sprawdzenie, czy status rezerwacji to 'Zarezerwowano'
	if not exists (select 1 from rezerwacje_biletow where ID_rezerwacji = @ID_rezerwacji and status_rezerwacji = 'Zarezerwowano')
	begin
		raiserror('Rezerwacjê mo¿na anulowaæ tylko, jeœli jej status to "Zarezerwowano".', 16, 1);
		return;
	end

	--obliczenie kwoty zwrotu po odstêpnym (10%)
	declare @Cena_biletu decimal(10,2);
	declare @Zwrot_kwoty decimal(10,2);

	select @Cena_biletu = cena
	from rezerwacje_biletow
	where ID_rezerwacji = @ID_rezerwacji;

	set @Zwrot_kwoty = @Cena_biletu *0.9; -- potr¹cenie 10%

	-- dodanie rekordu do tabeli anulowanie_biletu
	insert into Anulowanie_biletu(ID_anulowania, ID_rezerwacji, Powód_anulowania, Data_anulowania, Zwrot_kwoty, Status_zwrotu)
	values ( (select isnull(max(ID_anulowania),0) + 1 from Anulowanie_biletu), --generowanie ID
		@ID_rezerwacji,
		@Powód_anulowania,
		@Data_anulowania,
		@Zwrot_kwoty,
		'W trakcie');

		--aktualizacja statusu rezerwacji w tabeli rezerwacje_biletow
		update rezerwacje_biletow
		set status_rezerwacji = 'Anulowano'
		where ID_rezerwacji = @ID_rezerwacji;

		-- zwrócenie informacji o kwocie zwrotu
		print 'Anulowanie zosta³o przetworzone pomyœlnie.';
		print 'Kwota zwrotu po odstêpnym: ' + cast(@Zwrot_kwoty as nvarchar(50));
end;
go

select *from Rezerwacje_biletow
exec Realizacja_anulowania
    @ID_rezerwacji = 1,  --rezerwacja juz anulowana
    @Data_anulowania = '2024-11-28 08:00:00';

exec Realizacja_anulowania
    @ID_rezerwacji = 2,  
    @Data_anulowania = '2024-11-28 11:17:55';

select *from Anulowanie_biletu

exec Realizacja_anulowania
    @ID_rezerwacji = 7,  --brak statusu 'Zarezerwowano'
    @Data_anulowania = '2024-11-29 11:17:55';

-- procedura sprawdza czy pasazer istnieje, nastêpnie oblicza kwote przed zni¿k¹ i zapisuje do nowej kolumny w tabeli rezerwacje_biletow
--jeœli brak zni¿ki, kwota przed zni¿k¹ jest równa aktualnej cenie
create procedure Kwota_przed_zni¿ka
	@ID_pasazera INT
as 
begin
	if not exists(select 1 from pasazerowie where ID_pasazera = @ID_pasazera)
	begin
		raiserror('Pasa¿er o podanym ID nie istnieje.', 16, 1);
		return;
	end
	
	--obliczenie kwoty przed zni¿k¹ dla rezerwacji pasa¿era
	select r.ID_rezerwacji, r.cena as Cena_po_zni¿ce,
		case 
			when r.znizka_procentowa is not null and r.znizka_procentowa > 0 then
				round(r.cena /(1-(cast(r.znizka_procentowa as float)/100.0)),2)
			else r.cena --jeœli brak zni¿ki, kwota przed zni¿k¹ jest równa aktualnej cenie
		end as cena_przed_znizka,
		r.znizka_procentowa, r.typ_znizki
	from rezerwacje_biletow as r
	where r.ID_pasazera=@ID_pasazera;

	print 'Kwota przed zni¿k¹ zosta³a obliczona.';
end;
go

exec Kwota_przed_zni¿ka @ID_pasazera = 5;
select *from rezerwacje_biletow

--procedura aktualizuje status na 'Zarezerwowano' w tabeli Rezerwacje_biletow, jesli zostanie rezerwacja op³acona w tabeli Platnosci
--pobierana jest cena z tabeli Rezerwacje_biletow a nastêpnie jest dodawany rekord w tabeli platnosci
create procedure Zmiana_statusu_na_zarezerwowano
	@ID_rezerwacji int,
	@Metoda_platnosci nvarchar(50),
	@Data_platnosci datetime
as
begin
	--sprawdzenie, czy rezerwacja istnieje i ma status "Oczekuje na p³atnoœæ"
	if not exists(select 1 from rezerwacje_biletow where ID_rezerwacji = @ID_rezerwacji and status_rezerwacji = 'Oczekuje na p³atnoœæ')
	begin
		raiserror('Rezerwacja nie istnieje lub jest ju¿ zap³acona.', 16, 1);
		return;
	end

	--pobranie ceny biletu z tabeli rezerwacje_biletow
	declare @Cena_biletu decimal(10,2);
	select @Cena_biletu = Cena
	from rezerwacje_biletow
	where ID_rezerwacji = @ID_rezerwacji;

	--dodanie szczegó³ów p³atnoœci do tabeli platnosci
	insert into platnosci (ID_platnosci, ID_rezerwacji, kwota, metoda_platnosci, data_platnosci)
	values ((select isnull(max(ID_platnosci),0) + 1 from platnosci),
		@ID_rezerwacji,
		@Cena_biletu, --cena z tabeli rezerwacji
		@Metoda_platnosci,
		@Data_platnosci );

	-- aktualizacja statusu rezerwacji na "Zarezerwowano"
	update rezerwacje_biletow
	set status_rezerwacji = 'Zarezerwowano'
	where ID_rezerwacji = @ID_rezerwacji;

	print 'Status rezerwacji zosta³ zmieniony na Zarezerwowano.';

end;
go

select *from rezerwacje_biletow
select *from platnosci

exec Zmiana_statusu_na_zarezerwowano -- dodanie rekordu
	@ID_rezerwacji = 6,
	@Metoda_platnosci = 'Blik',
	@Data_platnosci = '2024-11-29 10:24:00';

exec Zmiana_statusu_na_zarezerwowano --wyswietla sie komunikat
	@ID_rezerwacji = 1,
	@Metoda_platnosci = 'Blik',
	@Data_platnosci = '2024-11-29 10:24:00';

--Triggery

--tabela Historia_zmian_pasazerow zawiera dane po modyfikacji i przed modyfikacj¹
--trigger automatycznie wykonuje okreœlone dzia³ania po aktualizacji danych w tabeli pasazerowie, porównuje dane przed aktualizacj¹ i po aktualizacji,
--jeœli dane s¹ zmienione zostaj¹ dodane do tabeli Pasazerowie, a tak¿e wpisane do tabeli Historia_zmian_pasazerow wraz z nowymi danymi jak i ze starymi
create table Historia_zmian_pasazerow (
    ID_zmiany int identity primary key,      
    ID_pasazera int not null,              
    Stare_imie nvarchar(100),              
    Nowe_imie nvarchar(100),              
    Stare_nazwisko nvarchar(100),           
    Nowe_nazwisko nvarchar(100),            
    Stary_email nvarchar(100),           
    Nowy_email nvarchar(100),              
    Data_zmiany datetime not null           
);

create trigger Aktualizacja_danych_pasazera
on pasazerowie
after update
as
begin
		-- wstawienie do tabeli historia_zmian_pasazerow danych przed i po aktualizacji
		insert into Historia_zmian_pasazerow
    (
        ID_pasazera, 
        Stare_imie, 
        Nowe_imie, 
        Stare_nazwisko, 
        Nowe_nazwisko, 
        Stary_email, 
        Nowy_email, 
        Data_zmiany
    )
	select
        d.ID_pasazera, 
        d.Imie as Stare_imie, 
        i.Imie as Nowe_imie, 
        d.Nazwisko as Stare_nazwisko, 
        i.Nazwisko as Nowe_nazwisko, 
        d.Adres_email as Stary_email, 
        i.Adres_email as Nowy_email, 
        getdate() as Data_zmiany
    from
        deleted d --(wartoœci przed aktualizacj¹)
    inner join
        inserted i on d.ID_pasazera = i.ID_pasazera --(wartoœci po aktualizacji)
    where 
        d.Imie <> i.Imie or 
        d.Nazwisko <> i.Nazwisko or 
        d.Adres_email <> i.Adres_email;
end;
go

select *from pasazerowie
select *from historia_zmian_pasazerow
update pasazerowie
set Adres_email = 'zmiana@example.com' where id_pasazera = 6;

--trigger umozliwia usuniêcie rekordu w tabeli Platnosci, jesli w tabeli Rezerwacje_biletow jest status na 'Anulowano'
--usuniêty rekord jest dodany do tabeli Log_usuniecia_platnosci
create trigger Usuwanie_platnosci
on Platnosci
instead of delete
as
begin
    -- sprawdzenie, czy powi¹zana rezerwacja ma status 'Anulowano'
    if exists (select 1 from deleted d inner join Rezerwacje_biletow r on d.ID_rezerwacji = r.ID_rezerwacji where r.Status_rezerwacji = 'Anulowano')
    begin
        -- zapisanie danych usuwanego rekordu do tabeli Logi
        insert into Log_usuniecia_platnosci (Opis, Szczegoly, Data)
        select
            'Usuniêcie p³atnoœci', 
            'ID P³atnoœci: ' + cast(d.ID_platnosci as nvarchar(10)) + 
            ', Kwota: ' + cast(d.Kwota as nvarchar(20)),
            getdate()
        from deleted d;

        -- usuniêcie rekordu z tabeli Platnosci
        delete from Platnosci
        where ID_platnosci in (select ID_platnosci from deleted);
    end
    else
    begin
        -- Jeœli rezerwacja ma inny status, wyœwietl komunikat o b³êdzie
        raiserror ('Nie mo¿na usun¹æ p³atnoœci, poniewa¿ powi¹zana rezerwacja nie ma statusu "Anulowano".', 16, 1);
        -- Zatrzymanie dalszego dzia³ania triggera
        rollback;
        return;
    end
end;
go

create table Log_usuniecia_platnosci (
    ID_log int primary key identity,
    Opis nvarchar(255),
    Szczegoly nvarchar(500),
    Data datetime
);

select *from platnosci
select *from rezerwacje_biletow
select *from Log_usuniecia_platnosci

delete from Platnosci where ID_platnosci = 1; -- usuniêcie rekordu
delete from Platnosci where ID_platnosci = 3; --komunikat