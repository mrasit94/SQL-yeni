--database olusturma
-- create database asd;

--DDL - DATA DEFINITION LANG
--CREATE - TABLO OLUSTURMA

CREATE TABLE ogrenciler (
ogrenci_no char(7),
isim varchar(20),
soyisim varchar(25),
not_ort real,  --ondalikli sayilar icin kullanilir, double gibi
kayit_tarih date
)

--var olan tablodan ynei tablo olusturmak
create table ogrenci_notlari
as -- benzer tablodaku basliklarla ve data tipleriyle yeni bir tablo olusturmak icin normal tablo olusturururkenki
-- parantezler yerine AS kullanip Select komutuyla almak istedigimiz verileri aliriz.
select isim, soyisim, not_ort from ogrenciler;

--DML - Data manipulation lang
-- insert - data base e veri ekleme
insert into ogrenciler values ('1234567', 'John', 'Doe', 84.5, now());
insert into ogrenciler values ('1234567', 'John', 'Doe', 84.5, '2022-12-03');

--bir tabloya parcali veri eklemek

insert into ogrenciler (isim, soyisim) values ('Emin', 'Eren');

--DQL - data query lang
--select

select * from ogrenciler;  -- burdaki * sembolu herseyi anlamindadir.
