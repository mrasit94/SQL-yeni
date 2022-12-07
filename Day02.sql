CREATE TABLE ogrenciler2
(
ogrenci_no char(7),
isim varchar(20),
soyisim varchar(25),
not_ort real,  --ondalikli sayilar icin kullanilir, double gibi
kayit_tarih date
);

--varolan bir tablodan yeni bir tablo olusturma
create table notlar
as
select isim,not_ort from ogrenciler2;

select * from ogrenciler2;

--tablo icine veri ekleme

insert into notlar values ('Mert', 85.5);
insert into notlar values ('Ali', 85.5);
insert into notlar values ('Veli', 85.5);
insert into notlar values ('Kerem', 85.5);
insert into notlar values ('Buse', 85.5);

select * from notlar;


create table ogrenciler3(
isim varchar(10),
notlar real
);

select isim from notlar;

--constraint
--unique


CREATE TABLE ogrenciler4
(
ogrenci_no char(7) unique,
isim varchar(20) not null,
soyisim varchar(25),
not_ort real,  --ondalikli sayilar icin kullanilir, double gibi
kayit_tarih date
);

select * from ogrenciler4;

CREATE TABLE ogrenciler5
(
ogrenci_no char(7) unique,
isim varchar(20) not null,
soyisim varchar(25),
not_ort real,  --ondalikli sayilar icin kullanilir, double gibi
kayit_tarih date
);

select * from ogrenciler5;
insert into ogrenciler5 values ('1234567', 'Burak', 'Mert', 75, now());

insert into ogrenciler5 (ogrenci_no, soyisim,not_ort) values ('7654321', 'soyisim', 85.5); -- not null kisitlamasi oldugu icin bu veri eklenemez


--primary key atamasi

CREATE TABLE ogrenciler6
(
ogrenci_no char(7) primary key,
isim varchar(20),
soyisim varchar(25),
not_ort real,  --ondalikli sayilar icin kullanilir, double gibi
kayit_tarih date
);

--primary key atamasi 2.yol
-- eger constraint ismini kendimiz vermek istersek bu yolu kullanabiliriz.

CREATE TABLE ogrenciler7
(
ogrenci_no char(7),
isim varchar(20),
soyisim varchar(25),
not_ort real,  --ondalikli sayilar icin kullanilir, double gibi
kayit_tarih date,
constraint ogr primary key(ogrenci_no)
);

CREATE TABLE ogrenciler8
(
ogrenci_no char(7),
isim varchar(20),
soyisim varchar(25),
not_ort real,  --ondalikli sayilar icin kullanilir, double gibi
kayit_tarih date,
primary key(ogrenci_no)
);

--Foreign Key

/*
“tedarikciler3” isimli bir tablo olusturun. Tabloda “tedarikci_id”, “tedarikci_ismi”,
“iletisim_isim” field’lari olsun ve “tedarikci_id” yi Primary Key yapin.
“urunler” isminde baska bir tablo olusturun “tedarikci_id” ve “urun_id” field’lari olsun ve
“tedarikci_id” yi Foreign Key yapin.
*/

create table tedarikciler3
(
tedarikci_id char(5) primary key,
tedarikci_ismi varchar(20),
iletisim_isim varchar(20)
);

create table urunler
(
tedarikci_id char (5),
urun_id char(5),
foreign key (tedarikci_id) references tedarikciler3(tedarikci_id)
);

select * from tedarikciler3;


/*
“calisanlar” isimli bir Tablo olusturun. Icinde “id”, “isim”, “maas”, “ise_baslama” field’lari olsun. “id” yi Primary Key yapin, “isim” i Unique, “maas” i Not Null yapın.
“adresler” isminde baska bir tablo olusturun.Icinde “adres_id”, “sokak”, “cadde” ve “sehir” fieldlari olsun. “adres_id” field‘i ile Foreign Key oluşturun.
*/
create table calisanlar
(
id char(5) primary key,
isim varchar(20) unique,
maas int not null,
ise_baslama date

);

create table adresler
(
adres_id char(5) ,
sokak varchar(20) ,
cadde varchar(20),
sehir varchar(20),
foreign key (adres_id) references calisanlar (id)
);

INSERT INTO calisanlar VALUES('10002', 'Mehmet Yılmaz' ,12000, '2018-04-14');
INSERT INTO calisanlar VALUES('10008', null, 5000, '2018-04-14');
--INSERT INTO calisanlar VALUES('10010', 'Mehmet Yılmaz', 5000, '2018-04-14'); --unique cons. kabul etmez
INSERT INTO calisanlar VALUES('10004', 'Veli Han', 5000, '2018-04-14');
INSERT INTO calisanlar VALUES('10005', 'Mustafa Ali', 5000, '2018-04-14');
--INSERT INTO calisanlar VALUES('10006', 'Canan Yaş', NULL, '2019-04-12');  -- not nul cons. kabul etmez
INSERT INTO calisanlar VALUES('10003', 'CAN', 5000, '2018-04-14');
--INSERT INTO calisanlar VALUES('10007', 'CAN', 5000, '2018-04-14');  -- unique cons. kabul etmez
--INSERT INTO calisanlar VALUES('10009', 'cem', '', '2018-04-14');  --int/string
INSERT INTO calisanlar VALUES('', 'osman', 2000, '2018-04-14');
--INSERT INTO calisanlar VALUES('', 'osman can', 2000, '2018-04-14');  --primary key
--INSERT INTO calisanlar VALUES( '10002', 'ayse Yılmaz' ,12000, '2018-04-14');  --primary key
--INSERT INTO calisanlar VALUES( null, 'filiz ' ,12000, '2018-04-14');  --primary key


INSERT INTO adresler VALUES('10003','Mutlu Sok', '40.Cad.','IST');
INSERT INTO adresler VALUES('10003','Can Sok', '50.Cad.','Ankara');
INSERT INTO adresler VALUES('10002','Ağa Sok', '30.Cad.','Antep');

-- Parent tabloda olmayan id ile child a ekleme yapamayiz
INSERT INTO adresler VALUES('10012','Ağa Sok', '30.Cad.','Antep');

-- FK'ye null değeri atanabilir.
INSERT INTO adresler VALUES(NULL,'Ağa Sok', '30.Cad.','Antep');
INSERT INTO adresler VALUES(NULL,'Ağa Sok', '30.Cad.','Maraş');


select * from calisanlar;
select * from adresler;

-- check constraint

create table calisanlar1
(
id char(5) primary key,
isim varchar(20) unique,
maas int check (maas > 10000),
ise_baslama date
);


INSERT INTO calisanlar1 VALUES('10002', 'Mehmet Yılmaz' ,19000, '2018-04-14');
select * from calisanlar1;

-- DQL Where kullanimi

select * from calisanlar;

select isim from calisanlar;

--calisanlar tablosundan maasi 5k dan buyuk olanlari listeleyiniz
select isim,maas from calisanlar where maas>5000;

--calisanlar tablosundan ismi veli han olan tum verileri listeleyiniz

select * from calisanlar where isim='Veli Han';


--calisanlar tablosundan maasi 5k  olan tum verileri listeleyiniz

select * from calisanlar where maas=5000;

-- DML -- Delete komutu
delete from calisanlar; -- eger parent table baska bir child tablo ile iliskili ise once child table silinmelidir.
delete from adresler;

select * from adresler;

-- adresler tablosunda sehri antep olan verileri silelim.
delete from adresler where sehir='Antep';


-- ismi Nesibe Yilmaz veya Mustafa Bak olan kayıtları silelim.
CREATE TABLE ogrenciler9
(
id int,
isim VARCHAR(50),
veli_isim VARCHAR(50),
yazili_notu int
);
INSERT INTO ogrenciler9 VALUES(123, 'Ali Can', 'Hasan',75);
INSERT INTO ogrenciler9 VALUES(124, 'Merve Gul', 'Ayse',85);
INSERT INTO ogrenciler9 VALUES(125, 'Kemal Yasa', 'Hasan',85);
INSERT INTO ogrenciler9 VALUES(126, 'Nesibe Yilmaz', 'Ayse',95);
INSERT INTO ogrenciler9 VALUES(127, 'Mustafa Bak', 'Can',99);
INSERT INTO ogrenciler9 VALUES(127, 'Mustafa Bak', 'Ali', 99);





