
# SQL Server Backup Kullanıcısı Oluşturma

Bu repo, SQL Server'da **minimum yetki prensibi** ile sadece backup alabilen özel bir kullanıcı oluşturmayı gösterir.

## 🎯 **Senaryo**
- `backuplogin` isimli bir kullanıcı oluştur
- Sadece `AdventureWorks2022` veritabanına erişebilsin  
- **Sadece backup** alabilsin
- Verileri **göremesin** veya **değiştiremesin**
- Diğer veritabanlarına **erişemesin**

## 📋 **Özellikler**
- ✅ Server-level yetki kısıtlamaları
- ✅ Database-level erişim kontrolü  
- ✅ Sadece BACKUP yetkisi
- ✅ Gereksiz izinlerin kaldırılması
- ✅ Güvenlik audit için test komutları

## 🛠️ **Kurulum**
1. SQL Server Management Studio (SSMS) açın
2. `backup_permission.sql` dosyasını çalıştırın
3. Script içindeki test komutlarıyla çalışmayı doğrulayın

## 🔍 **Test Komutları**

```sql
-- Bu ÇALIŞMALI (Backup yetkisi)
BACKUP DATABASE AdventureWorks2022 TO DISK = 'C:\test.bak'

-- Bu HATA VERMELİ (Select yetkisi yok)
SELECT * FROM HumanResources.Department

-- Bu HATA VERMELİ (Diğer veritabanı)
USE other_database
