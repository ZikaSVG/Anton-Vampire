@echo off
title Политика аудита
auditpol /set /subcategory:"Вход в систему" /success:enable /failure:enable
auditpol /set /subcategory:"Выход из системы" /success:enable
auditpol /set /subcategory:"Управление учётными записями пользователей" /success:enable /failure:enable
auditpol /set /subcategory:"Управление группами безопасности" /success:enable /failure:enable
auditpol /set /subcategory:"Изменение политики аудита" /success:enable /failure:enable
auditpol /set /subcategory:"Использование привилегий" /success:enable /failure:enable
auditpol /set /subcategory:"Система безопасности" /success:enable /failure:enable
auditpol /set /subcategory:"Система" /success:enable /failure:enable
echo [+] Аудит настроен.