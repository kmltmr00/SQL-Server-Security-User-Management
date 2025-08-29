# SQL Server Minimum Permission Examples - Backup & ReadOnly Users

Bu repo, SQL Server'da **minimum yetki prensibi** ile güvenli kullanıcı oluşturma örneklerini içerir. Backup ve ReadOnly kullanıcı senaryolarını kapsar.

## 🎯 **Örnek Senaryolar**

### 1. 🔐 Backup User
Sadece backup alabilen kullanıcı:
- ✅ Backup yetkisi
- ❌ Veri görüntüleme yok
- ❌ Değişiklik yapma yok
- ❌ Diğer DB erişimi yok

### 2. 👁️ ReadOnly User  
Sadece veri okuyabilen kullanıcı:
- ✅ SELECT yetkisi
- ❌ INSERT/UPDATE/DELETE yok
- ❌ EXECUTE yok
- ❌ Diğer DB erişimi yok

## 🛠️ **Kurulum**
1. SQL Server Management Studio (SSMS) açın
2. İstenilen script'i seçin:
   - `backup-user/backup_permission.sql` - Backup kullanıcısı için
   - `readonly-user/readonly_permission.sql` - Readonly kullanıcısı için
3. Script'i çalıştırın
4. Test komutlarıyla çalışmayı doğrulayın
