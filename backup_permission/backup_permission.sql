--Aþaðýdaki kod parçacýðýnda 'AdventureWorks2022' için login ve kullanýcý oluþturduk
--bu kullanýcý sadece 'AdventureWorks2022' veritabanýna eriþip sadece backup almak içindir.
use AdventureWorks2022
CREATE LOGIN backuplogin 
WITH PASSWORD='backuplogin'

CREATE USER backuplogin
FOR LOGIN backuplogin

ALTER ROLE db_backupoperator
ADD MEMBER backuplogin

-- Login zaten varsa oluþturma
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

--aþaðýdaki komutu çalýþtýrýrsak 'permission_backup.png'deki hatayý alýrýz.
use socialmedia

--aþaðýdaki komutu çalýþtýrýrsak 'permission_backup2.png'deki hatayý alýrýz.
SELECT * FROM HumanResources.Department


