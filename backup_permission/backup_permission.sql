--A�a��daki kod par�ac���nda 'AdventureWorks2022' i�in login ve kullan�c� olu�turduk
--bu kullan�c� sadece 'AdventureWorks2022' veritaban�na eri�ip sadece backup almak i�indir.
use AdventureWorks2022
CREATE LOGIN backuplogin 
WITH PASSWORD='backuplogin'

CREATE USER backuplogin
FOR LOGIN backuplogin

ALTER ROLE db_backupoperator
ADD MEMBER backuplogin

-- Login zaten varsa olu�turma
IF NOT EXISTS (SELECT * FROM sys.sql_logins WHERE name = 'backuplogin')
CREATE LOGIN backuplogin WITH PASSWORD = 'backuplogin', CHECK_POLICY = ON
GO

-- SERVER-LEVEL yetkileri AYNI DATABASE'de (master) yap
DENY VIEW ANY DATABASE TO backuplogin
GO

use AdventureWorks2022

GRANT CONNECT ON DATABASE ::AdventureWorks2022 to backuplogin

REVOKE SELECT,INSERT,UPDATE,DELETE ,EXECUTE TO backuplogin

GRANT BACKUP DATABASE TO backuplogin

--a�a��daki komutu �al��t�r�rsak 'permission_backup.png'deki hatay� al�r�z.
use socialmedia

--a�a��daki komutu �al��t�r�rsak 'permission_backup2.png'deki hatay� al�r�z.
SELECT * FROM HumanResources.Department


