-- GROUP BY

CREATE TABLE personel
(
id int,
isim varchar(50),  sehir varchar(50),  maas int,  
sirket varchar(20)
);
INSERT INTO personel VALUES(123456789, 'Ali Yilmaz', 'Istanbul', 5500, 'Honda');  
INSERT INTO personel VALUES(234567890, 'Veli Sahin', 'Istanbul', 4500, 'Toyota');  
INSERT INTO personel VALUES(345678901, 'Mehmet Ozturk', 'Ankara', 3500, 'Honda');  
INSERT INTO personel VALUES(456789012, 'Mehmet Ozturk', 'Izmir', 6000, 'Ford');  
INSERT INTO personel VALUES(567890123, 'Mehmet Ozturk', 'Ankara', 7000, 'Tofas');  
INSERT INTO personel VALUES(456789012, 'Veli Sahin', 'Ankara', 4500, 'Ford');  
INSERT INTO personel VALUES(123456710, 'Hatice Sahin', 'Bursa', 4500, 'Honda');


delete from personel
-- Isme gore toplam maaslari bulun

SELECT isim, SUM (maas)
FROM personel
GROUP BY isim

-- personel tablosundaki isimleri gruplayiniz
SELECT isim FROM personel
GROUP BY isim

--Sirketlere gore maasi 5000 liradan fazla olan personel sayisini bulun

SELECT sirket, count(calisan_sayisi)
FROM personel
WHERE  maas>5000
GROUP BY sirket

-- HAVING KULLANIMI

/*
Having komuutu yalnizca group by komutu ile kullanilir.
Eger gruplamadan sonra bir sart varsa having komutu kullanilir.
*/

--Her sirketin MIN maaslarini eger 4000’den buyukse goster
SELECT * FROM personel

SELECT sirket, min (maas) as en_dusuk_maas
FROM personel
GROUP BY sirket
HAVING min(maas) >4000

-- ayni isimdeki kisilerin aldigi toplam gelir 10000 liradan fazla ise ismi
-- ve toplam maasi gosteren sorgu yaziniz.

SELECT isim, sum(maas) as toplam_maas
FROM personel
GROUP BY isim
HAVING sum(maas)>10000


--Eger bir sehirde calisan sayisi 1den coksa sehir ismini
--ve personel sayisini veren sorgu yaziniz.

SELECT sehir, count(isim) as calisan_personel_sayisi
FROM personel
GROUP BY sehir
HAVING count(isim)>1


-- Eger bir sehirde alinan MAX maas 5000den dusukse sehir ismini
-- ve max maasi veren sorguyu yaziniz

SELECT sehir, max(maas)
FROM personel
GROUP BY sehir
HAVING max(maas)<5000

-- UNION OPERATOR
-- Iki farkli sorgulamanin sonucunu birlestiren islemdir. Secilen Field SAYISI
-- ve DATA TYPE’i ayni olmalidir.

-- Maasi 4000 den cok olan isci isimlerini ve
-- 5000 liradan fazla maas alinan sehirleri gosteren sorguyu yaziniz

SELECT sehir as isim_ve_sehirler, maas
FROM personel
WHERE maas > 5000
UNION
SELECT isim, maas
FROM personel
WHERE maas>4000

-- Mehmet Ozturk ismindeki kisilerin aldigi maaslari ve
-- Istanbul’daki personelin maaslarini bir tabloda gosteren sorgu yaziniz


SELECT isim, maas
FROM personel
WHERE isim='Mehmet Ozturk'
UNION
SELECT sehir, maas
FROM personel
WHERE sehir='Istanbul'
ORDER BY maas DESC


drop table if exists personel

CREATE TABLE personel
(
id int,
isim varchar(50),  
sehir varchar(50), 
maas int,  
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

CREATE TABLE personel_bilgi  (
id int,
tel char(10) UNIQUE ,  
cocuk_sayisi int,
CONSTRAINT personel_bilgi_fk FOREIGN KEY (id) REFERENCES personel(id)
);
INSERT INTO personel_bilgi VALUES(123456789, '5302345678', 5);  
INSERT INTO personel_bilgi VALUES(234567890, '5422345678', 4);
INSERT INTO personel_bilgi VALUES(345678901, '5354561245', 3);
INSERT INTO personel_bilgi VALUES(456789012, '5411452659', 3);
INSERT INTO personel_bilgi VALUES(567890123, '5551253698', 2);
INSERT INTO personel_bilgi VALUES(456789012, '5524578574', 2);
INSERT INTO personel_bilgi VALUES(123456710, '5537488585', 1);

SELECT * FROM personel
SELECT * FROM personel_bilgi

-- id’si 123456789 olan personelin    Personel tablosundan sehir ve maasini, 
-- personel_bilgi  tablosundan da tel ve cocuk sayisini yazdirin

SELECT sehir as sehir_ve_tel,maas
FROM personel
WHERE id='123456789'
UNION
SELECT tel, cocuk_sayisi
FROM personel_bilgi
WHERE id='123456789'

-- Union All

/*
Union tekrarli verileri teke dusurur ve bize o sekilde sonuc verir
Union All ise tekrarli verilerle birlikte tum sorgulari getirir.
*/

-- Personel tablosundada maasi 5000’den az olan tum isimleri ve maaslari bulunuz

SELECT isim , maas 
FROM personel
WHERE maas < 5000
union all
SELECT isim , maas 
FROM personel
WHERE maas < 5000

-- Intersect (kesisim)


/*
Farkli iki tablodaki ortak verileri INTERSECT komutu ile getirebiliriz
*/
--Personel tablosundan Istanbul veya Ankara’da calisanlarin id’lerini yazdir
--Personel_bilgi tablosundan 2 veya 3 cocugu olanlarin id lerini yazdirin
--Iki sorguyu INTERSECT ile birlestirin

SELECT id
FROM personel
WHERE sehir IN ('Istanbul', 'Ankara')
INTERSECT
SELECT id
FROM personel_bilgi
WHERE cocuk_sayisi IN (2,3)

-- 1) Maasi 4800’den az olanlar veya 5000’den cok olanlarin id’lerini listeleyin
-- 2) Personel_bilgi tablosundan 2 veya 3 cocugu olanlarin id lerini yazdirin
-- 3) Iki sorguyu INTERSECT ile birlestirin

SELECT id
FROM personel
WHERE maas NOT BETWEEN 4800 and 5000
INTERSECT
SELECT id
FROM personel_bilgi
WHERE cocuk_sayisi IN (2,3)

-- Honda,Ford ve Tofas’ta calisan ortak isimde personel varsa listeleyin

SELECT isim
FROM personel
WHERE sirket='Honda'

INTERSECT

SELECT isim
FROM personel
WHERE sirket='Ford'

INTERSECT

SELECT isim
FROM personel
WHERE sirket='Tofas'


-- Except operator

/*
iki sorgulamada harici bir sorgulama istenirse EXCEPT komutu kullanilir
 */
 
-- 500 den az maas alip Honda da calismayanlar


SELECT isim,sirket
FROM personel
WHERE maas<5000
Except
SELECT isim, sirket
FROM personel
WHERE sirket='Honda'