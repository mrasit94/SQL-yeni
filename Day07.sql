-- DISTINCT
-- DISTINCT clause, çağrılan terimlerden tekrarlı olanların sadece birincisini alır.

CREATE TABLE musteri_urun 
(
urun_id int, 
musteri_isim varchar(50),
urun_isim varchar(50) 
);
INSERT INTO musteri_urun VALUES (10, 'Ali', 'Portakal'); 
INSERT INTO musteri_urun VALUES (10, 'Ali', 'Portakal'); 
INSERT INTO musteri_urun VALUES (20, 'Veli', 'Elma'); 
INSERT INTO musteri_urun VALUES (30, 'Ayse', 'Armut'); 
INSERT INTO musteri_urun VALUES (20, 'Ali', 'Elma'); 
INSERT INTO musteri_urun VALUES (10, 'Adem', 'Portakal'); 
INSERT INTO musteri_urun VALUES (40, 'Veli', 'Kaysi'); 
INSERT INTO musteri_urun VALUES (20, 'Elif', 'Elma');

SELECT * FROM musteri_urun

-- Musteri urun tablosundan urun isimlerini tekrarsiz (grup) listeliyiniz

-- group by
SELECT urun_isim
FROM musteri_urun
GROUP BY urun_isim

-- Distinct
SELECT DISTINCT (urun_isim)
FROM musteri_urun

-- Tabloda kac farkli meyve vardir

SELECT urun_isim, count(DISTINCT urun_isim)
FROM musteri_urun
GROUP BY urun_isim

-- FETCH NEXT () ROW ONLY- OFFSET / LIMIT
-- 1) Tabloyu urun_id ye gore siralayiniz
-- 2) Sirali tablodan ilk 3 kaydi listeleyin
-- 3) Sirali tablodan 4. kayittan 7.kayida kadar olan kayitlari listeleyin

SELECT * FROM musteri_urun
ORDER BY urun_id
FETCH NEXT 3 ROW ONLY

--LIMIT
SELECT * FROM musteri_urun
ORDER BY urun_id
LIMIT 3

-- Musteri urun tablosundan ilk kaydi listeleyiniz

SELECT * FROM musteri_urun
ORDER BY urun_id
LIMIT 1

-- Musteri urun tablosundan son uc kaydi listeleyiniz

SELECT * FROM musteri_urun
ORDER BY urun_id
DESC LIMIT 3


CREATE TABLE maas
(
id int,
musteri_isim varchar(50),
maas int
);
INSERT INTO maas VALUES (10, 'Ali', 5000);
INSERT INTO maas VALUES (10, 'Ali', 7500);
INSERT INTO maas VALUES (20, 'Veli', 10000);
INSERT INTO maas VALUES (30, 'Ayse', 9000);
INSERT INTO maas VALUES (20, 'Ali', 6500);
INSERT INTO maas VALUES (10, 'Adem', 8000);
INSERT INTO maas VALUES (40, 'Veli', 8500);
INSERT INTO maas VALUES (20, 'Elif', 5500);


-- En yuksek maasi alan musteriyi listeleyiniz

SELECT musteri_isim, maas
FROM maas
ORDER BY maas DESC
LIMIT 1

-- Maas tablosundan en yuksek ikinci maasi listeleyiniz

SELECT musteri_isim, maas
FROM maas
ORDER BY maas DESC
LIMIT 1
OFFSET 1

-- OFFSET -> Satir atlamak istedigimizde offset komutunu kullaniriz.

SELECT * FROM maas
ORDER BY maas DESC
OFFSET 1 ROW
FETCH NEXT 1 ROW ONLY

-- Maas tablosundan en dusuk 4. maasi listeleyiniz
SELECT * FROM maas
ORDER BY maas
OFFSET 3 ROW
FETCH NEXT 1 ROW ONLY

SELECT musteri_isim, maas
FROM maas
ORDER BY maas
LIMIT 1
OFFSET 3

drop table personel -- tabloyu ortadan kaldirir


-- DLL --->  ALTER TABLE STATEMENT

CREATE TABLE personel  (
id int,
isim varchar(50),  sehir varchar(50),  maas int,  
sirket varchar(20),
CONSTRAINT personel_pk PRIMARY KEY (id)
);
INSERT INTO personel VALUES(123456789, 'Ali Yilmaz', 'Istanbul', 5500, 'Honda');  
INSERT INTO personel VALUES(234567890, 'Veli Sahin', 'Istanbul', 4500, 'Toyota');  
INSERT INTO personel VALUES(345678901, 'Mehmet Ozturk', 'Ankara', 3500, 'Honda');  
INSERT INTO personel VALUES(456789012, 'Mehmet Ozturk', 'Izmir', 6000, 'Ford');  
INSERT INTO personel VALUES(567890123, 'Mehmet Ozturk', 'Ankara', 7000, 'Tofas');  
INSERT INTO personel VALUES(456715012, 'Veli Sahin', 'Ankara', 4500, 'Ford');  
INSERT INTO personel VALUES(123456710, 'Hatice Sahin', 'Bursa', 4500, 'Honda');

-- 1) ADD default deger ile tabloya bir field ekleme

SELECT * FROM personel

ALTER TABLE personel
ADD ulke varchar(30)

ALTER TABLE personel
ADD adres varchar(50) DEFAULT 'Turkiye' -- DEFAULT yazarsak olusturdugumuz sutuna belirttigimiz veriyi tum satirlara girer

ALTER TABLE personel
ADD zip_code varchar(30)

-- 2) DROP tablodan sutun silme

ALTER TABLE personel
DROP COLUMN zip_code

ALTER TABLE personel
DROP COLUMN ulke

ALTER TABLE personel
DROP adres, drop sirket -- iki stunu birden silme

-- 3) RENAME COLUMN stun adi degistirme
SELECT * FROM personel


ALTER TABLE personel
RENAME COLUMN sehir TO il


-- 4) RENAME tablionun ismini degistirme

ALTER TABLE personel
RENAME TO isci

SELECT * FROM isci

-- 5) TYPE/SET (modify --> MySql) sutunlarin ozelliklerini degistirme

ALTER TABLE isci
ALTER COLUMN il TYPE varchar(30),
ALTER COLUMN maas SET NOT NULL;

-- Eger numerik data turune sahip bir stunun data turune string bir data turu atamak istersek
-- TYPE varchar(30) USING (maas::varchar(30)) bu formati kullaniriz.

ALTER COLUMN maas
TYPE varchar(30) USING (maas::varchar(30))

ORDER BY maas DESC


/*
			TRANSACTION (BEGIN - SAVEPOINT - ROLLBACK - COMMIT
	Transaction veritabani sistemlerinde bir islem basladiginda baslar ve bitince sona erer. Bu
	islemler veritabani olusturma, veri silme, veri guncelleme, veriyi geri getirme gibi islemler olabilir.
 */
DROP TABLE ogrenciler2

-- Transaction baslatmak icin BEGIN komutu gerekir, sonlandirmak icin COMMIT komutunu calisitirmaliyiz.

CREATE TABLE ogrenciler2
(
id serial, -- Serial data turu otomatik olarak 1den baslayarak sirali olarak sayi atamasi yapar.
		   -- Insert Into ile tabloya veri eklerken, serial data turunu kullandigim ver degeri yerine
		   -- Default yazariz
isim VARCHAR(50),
veli_isim VARCHAR(50),
yazili_notu real       
);
BEGIN;
INSERT INTO ogrenciler2 VALUES(default, 'Ali Can', 'Hasan',75.5);
INSERT INTO ogrenciler2 VALUES(default, 'Merve Gul', 'Ayse',85.3);

savepoint x;

INSERT INTO ogrenciler2 VALUES(default, 'Kemal Yasa', 'Hasan',85.6);
INSERT INTO ogrenciler2 VALUES(default, 'Nesibe Yilmaz', 'Ayse',95.3);

savepoint y;

INSERT INTO ogrenciler2 VALUES(default, 'Mustafa Bak', 'Can',99);
INSERT INTO ogrenciler2 VALUES(default, 'Can Bak', 'Ali', 67.5);

ROLLBACK to y;
COMMIT;

SELECT * FROM ogrenciler2

DELETE FROM ogrenciler2
DROP TABLE ogrenciler2