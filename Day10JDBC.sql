SELECT * FROM companies

--        //1. Örnek: Prepared statement kullanarak company adı IBM olan number_of_employees değerini 9999 olarak güncelleyin.


UPDATE companies
SET number_of_employees = 9999
WHERE companies = 'IBM'

CREATE OR REPLACE FUNCTION toplamaF (x NUMERIC,y NUMERIC)
RETURNS NUMERIC
LANGUAGE plpgsql
AS 
$$
BEGIN

RETURN x+y;

END
$$

SELECT * FROM toplamaF(4,6) AS toplam;