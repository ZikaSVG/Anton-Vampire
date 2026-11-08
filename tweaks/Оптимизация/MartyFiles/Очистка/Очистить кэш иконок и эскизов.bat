@echo off
pushd "%LocalAppData%\Microsoft\Windows\Explorer" >nul 2>&1
del /s /q /a:h "IconCache*" "thumbcache*" >nul 2>&1
del /s /q /f "IconCache*" "thumbcache*" >nul 2>&1
popd
pushd "%LocalAppData%" >nul 2>&1
if exist IconCache.db del /a /q IconCache.db >nul 2>&1
if exist IconCache.db-wal del /a /q IconCache.db-wal >nul 2>&1
popd
