
/*
 * SQL Server'da Read-Only Kullan�c� Olu�turma Scripti
 * Bu script, sadece belirli bir veritaban�nda SELECT (okuma) yetkisi olan
 * ve di�er t�m de�i�iklikleri yapamayan bir kullan�c� olu�turur.
 * 
 * �NEML�: Bu kullan�c� verileri okuyabilir ama de�i�tiremez.
 * G�venlik i�in minimum yetki prensibi uygulanm��t�r.
 */

-- 1. SQL Server'a login olu�tur (server level)
CREATE LOGIN kemal WITH PASSWORD='kemal'
-- Not: Production ortam�nda daha g��l� �ifre kullan�lmal�d�r

-- 2. AdventureWorks2022 veritaban�n� kullan
use AdventureWorks2022

-- 3. Login i�in veritaban�nda kullan�c� olu�tur (database level)
CREATE USER kemall FOR LOGIN kemal
-- Dikkat: Login ad� (kemal) ve user ad� (kemall) farkl� olabilir

-- 4. Veritaban�na ba�lanabilme yetkisi ver
GRANT CONNECT to kemall
-- Bu yetki olmadan kullan�c� veritaban�na ba�lanamaz

-- 5. Sadece SELECT (okuma) yetkisi ver
GRANT SELECT TO kemall
-- Bu yetki sayesinde t�m tablolar� sorgulayabilir

-- 6. De�i�iklik yapma yetkilerini ENGELLE
DENY INSERT,UPDATE,DELETE TO kemall
-- INSERT: Yeni kay�t ekleyemez
-- UPDATE: Mevcut kay�tlar� g�ncelleyemez  
-- DELETE: Kay�t silemez

-- 7. EXECUTE yetkisini GER� AL (varsa)
REVOKE EXECUTE TO kemall
-- Stored procedure �al��t�ramaz

/*
 * TEST SENARYOLARI:
 * A�a��daki komutlarla yetkilendirmeyi test edebilirsiniz.
 */

-- Bu �al��mal� (SELECT yetkisi var)
SELECT * FROM HumanResources.Department
-- Sonu�: Departman listesini g�r�nt�ler

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
 * G�VENL�K NOTLARI:
 * 1. Kullan�c� sadece okuma yapabilir
 * 2. Veri b�t�nl��� korunur
 * 3. Yanl��l�kla yap�lacak de�i�iklikler engellenir
 * 4. Audit ve raporlama i�in idealdir
 * 
 * Production'da ayr�ca �unlar eklenebilir:
 * - Schema bazl� k�s�tlama
 * - �ifre politikas� zorunlulu�u
 * - Belirli kolonlara eri�im k�s�tlamas�
 */



 --Gelen hatalar�n Screenshot olarak dosya klas�r�n�n i�erisinde bulunmaktad�r.