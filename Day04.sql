-- ALIASES
SELECT * FROM calisanlar2

-- 2 filed i tek filed a indirir
SELECT id, isim || ' ' || sehir as isim_sehir FROM calisanlar2

-- 2. yol
select calisan_id as id, concat(calisan_isim,' ',calisan_dogdugu_sehir) as calisan_bilgisi
from calisanlar

-- IS NULL CONDITION 

CREATE TABLE insanlar
(
ssn char(9),
name varchar(50),  
adres varchar(50)
);
INSERT INTO insanlar VALUES(123456789, 'Ali Can', 'Istanbul');  
INSERT INTO insanlar VALUES(234567890, 'Veli Cem', 'Ankara');  
INSERT INTO insanlar VALUES(345678901, 'Mine Bulut', 'Izmir');  
INSERT INTO insanlar (ssn, adres) VALUES(456789012, 'Bursa'); 
INSERT INTO insanlar (ssn, adres) VALUES(567890123, 'Denizli');

-- Name stununda NULL olan degerleri listeleyelim

SELECT * FROM insanlar;
SELECT name FROM insanlar WHERE name IS NULL;

-- NULL OLMAYAN DEGERLER
SELECT name FROM insanlar WHERE name IS NOT NULL;

-- INSANLAR TABLOSUNDA NULL DEGER ALMIS  VERILERI NO NAME OLARAK DEGISTIRIR
UPDATE insanlar
SET name='NO NAME'
WHERE name IS NULL;

-- ORDER BY KOMUTU

/*
Tablolardaki verileri sıralamak için ORDER BY komutu kullanırız
Büyükten küçüğe yada küçükten büyüğe sıralama yapabiliriz
Default olarak küçükten büyüğe sıralama yapar
Eğer BÜYÜKTEN KÜÇÜĞE sıralmak istersek ORDER BY komutundan sonra DESC komutunu kullanırız
*/


-- belli bir field’a gore NATURAL ORDER olarak siralama yapmak icin kullanilir
-- ORDER BY komutu sadece SELECT komutu Ile kullanilir

drop table if exists insanlar
CREATE TABLE insanlar
(
ssn char(9),
isim varchar(50),
soyisim varchar(50),  
adres varchar(50)
);
INSERT INTO insanlar VALUES(123456789, 'Ali','Can', 'Istanbul');
INSERT INTO insanlar VALUES(234567890, 'Veli','Cem', 'Ankara');  
INSERT INTO insanlar VALUES(345678901, 'Mine','Bulut', 'Ankara');  
INSERT INTO insanlar VALUES(256789012, 'Mahmut','Bulut', 'Istanbul'); 
INSERT INTO insanlar VALUES (344678901, 'Mine','Yasa', 'Ankara');  
INSERT INTO insanlar VALUES (345678901, 'Veli','Yilmaz', 'Istanbul');

SELECT * FROM insanlar;

--Insanlar tablosundaki datalari adres’e gore siralayin
-- ascending

SELECT * FROM insanlar ORDER BY adres;


SELECT * FROM insanlar ORDER BY soyisim;

--Insanlar tablosundaki ismi Mine olanlari SSN sirali olarak listeleyin

SELECT * FROM insanlar
WHERE isim = 'Mine' 
ORDER BY ssn;

-- NOT : Order By komutundan sonra field ismi yerine field numarasi da kullanilabilir
-- Insanlar tablosundaki soyismi Bulut olanlari isim sirali olarak listeleyin

SELECT * FROM insanlar
WHERE soyisim = 'Bulut' 
ORDER BY 2;

-- Insanlar tablosundaki tum kayitlari SSN numarasi buyukten kucuge olarak siralayin

SELECT * FROM insanlar
ORDER BY ssn DESC;

SELECT * FROM insanlar
ORDER BY isim ASC, soyisim DESC;

-- İsim ve soyisim değerlerini soyisim kelime uzunluklarına göre sıralayınız

SELECT isim, soyisim
FROM insanlar
ORDER BY length (soyisim);

SELECT isim, soyisim
FROM insanlar
ORDER BY length (soyisim) DESC;

-- Tüm isim ve soyisim değerlerini aynı sutunda çağırarak
-- her bir sütun değerini uzunluğuna göre sıralayınız

select isim || ' ' || soyisim
from insanlar
order by length (isim || soyisim);


--GROUP BY CLAUSE
/*
Group By komutu sonuçları bir veya daha fazla sütuna göre gruplamak için SELECT
komutuyla birlikte kullanılır.
*/
CREATE TABLE manav
(
isim varchar(50),
Urun_adi varchar(50),
Urun_miktar int
);
INSERT INTO manav VALUES( 'Ali', 'Elma', 5);
INSERT INTO manav VALUES( 'Ayse', 'Armut', 3);
INSERT INTO manav VALUES( 'Veli', 'Elma', 2);
INSERT INTO manav VALUES( 'Hasan', 'Uzum', 4);
INSERT INTO manav VALUES( 'Ali', 'Armut', 2);
INSERT INTO manav VALUES( 'Ayse', 'Elma', 3);
INSERT INTO manav VALUES( 'Veli', 'Uzum', 5);
INSERT INTO manav VALUES( 'Ali', 'Armut', 2);
INSERT INTO manav VALUES( 'Veli', 'Elma', 3);
INSERT INTO manav VALUES( 'Ayse', 'Uzum', 2);

SELECT * FROM manav


-- Isme gore alinan toplam urunleri bulun ve bu urunleri buyukten kucuge listeleyiniz

SELECT isim, sum(urun_miktar) as toplam_urun
FROM manav
GROUP BY isim
ORDER BY toplam_urun DESC;


-- Urun ismine gore urunu alan toplam kisi sayisi

SELECT urun_adi, count(isim) as alan_kisi_sayisi
FROM manav
GROUP BY urun_adi;




