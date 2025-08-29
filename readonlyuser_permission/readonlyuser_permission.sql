
/*
 * SQL Server'da Read-Only Kullanýcý Oluþturma Scripti
 * Bu script, sadece belirli bir veritabanýnda SELECT (okuma) yetkisi olan
 * ve diðer tüm deðiþiklikleri yapamayan bir kullanýcý oluþturur.
 * 
 * ÖNEMLÝ: Bu kullanýcý verileri okuyabilir ama deðiþtiremez.
 * Güvenlik için minimum yetki prensibi uygulanmýþtýr.
 */

-- 1. SQL Server'a login oluþtur (server level)
CREATE LOGIN kemal WITH PASSWORD='kemal'
-- Not: Production ortamýnda daha güçlü þifre kullanýlmalýdýr

-- 2. AdventureWorks2022 veritabanýný kullan
use AdventureWorks2022

-- 3. Login için veritabanýnda kullanýcý oluþtur (database level)
CREATE USER kemall FOR LOGIN kemal
-- Dikkat: Login adý (kemal) ve user adý (kemall) farklý olabilir

-- 4. Veritabanýna baðlanabilme yetkisi ver
GRANT CONNECT to kemall
-- Bu yetki olmadan kullanýcý veritabanýna baðlanamaz

-- 5. Sadece SELECT (okuma) yetkisi ver
GRANT SELECT TO kemall
-- Bu yetki sayesinde tüm tablolarý sorgulayabilir

-- 6. Deðiþiklik yapma yetkilerini ENGELLE
DENY INSERT,UPDATE,DELETE TO kemall
-- INSERT: Yeni kayýt ekleyemez
-- UPDATE: Mevcut kayýtlarý güncelleyemez  
-- DELETE: Kayýt silemez

-- 7. EXECUTE yetkisini GERÝ AL (varsa)
REVOKE EXECUTE TO kemall
-- Stored procedure çalýþtýramaz

/*
 * TEST SENARYOLARI:
 * Aþaðýdaki komutlarla yetkilendirmeyi test edebilirsiniz.
 */

-- Bu çalýþmalý (SELECT yetkisi var)
SELECT * FROM HumanResources.Department
-- Sonuç: Departman listesini görüntüler

-- Bu HATA vermeli (INSERT yetkisi YOK)
INSERT INTO HumanResources.Department (Name) VALUES ('Test')
-- Beklenen hata: The INSERT permission was denied...

-- Bu HATA vermeli (UPDATE yetkisi YOK) 
UPDATE HumanResources.Department SET Name = 'Test'
-- Beklenen hata: The UPDATE permission was denied...

-- Bu HATA vermeli (DELETE yetkisi YOK)
DELETE FROM HumanResources.Department
-- Beklenen hata: The DELETE permission was denied...

/*
 * GÜVENLÝK NOTLARI:
 * 1. Kullanýcý sadece okuma yapabilir
 * 2. Veri bütünlüðü korunur
 * 3. Yanlýþlýkla yapýlacak deðiþiklikler engellenir
 * 4. Audit ve raporlama için idealdir
 * 
 * Production'da ayrýca þunlar eklenebilir:
 * - Schema bazlý kýsýtlama
 * - Þifre politikasý zorunluluðu
 * - Belirli kolonlara eriþim kýsýtlamasý
 */



 --Gelen hatalarýn Screenshot olarak dosya klasörünün içerisinde bulunmaktadýr.