@echo off
echo 🔵 Preparando aplicación para Bluehost...

REM Crear directorio de distribución
echo [INFO] Creando directorio de distribución...
if exist dist-bluehost rmdir /s /q dist-bluehost
mkdir dist-bluehost\public_html
mkdir dist-bluehost\nodejs

REM Copiar archivos del backend
echo [INFO] Preparando backend para Bluehost...
xcopy backend\* dist-bluehost\nodejs\ /s /e /y
copy backend\.env.bluehost dist-bluehost\nodejs\.env

REM Limpiar archivos innecesarios del backend
del dist-bluehost\nodejs\server.js
ren dist-bluehost\nodejs\server-bluehost.js app.js

REM Construir frontend
echo [INFO] Construyendo frontend para producción...
cd frontend

REM Usar configuración específica de Bluehost
copy .env.bluehost .env.production.local

REM Construir aplicación
call npm run build

REM Copiar archivos del frontend construido
echo [INFO] Copiando archivos del frontend...
xcopy build\* ..\dist-bluehost\public_html\ /s /e /y

REM Volver al directorio raíz
cd ..

REM Copiar .htaccess
copy .htaccess dist-bluehost\public_html\

REM Crear package.json simplificado para Bluehost
echo [INFO] Creando package.json optimizado...
(
echo {
echo   "name": "suma-app-bluehost",
echo   "version": "1.0.0",
echo   "description": "Aplicación de suma optimizada para Bluehost",
echo   "main": "app.js",
echo   "scripts": {
echo     "start": "node app.js"
echo   },
echo   "dependencies": {
echo     "express": "^4.18.2",
echo     "cors": "^2.8.5",
echo     "dotenv": "^16.0.3"
echo   },
echo   "engines": {
echo     "node": ">=16.0.0"
echo   }
echo }
) > dist-bluehost\nodejs\package.json

REM Crear archivo de instrucciones
echo [INFO] Creando archivo de instrucciones...
(
echo INSTRUCCIONES PARA SUBIR A BLUEHOST
echo ===================================
echo.
echo 1. SUBIR ARCHIVOS:
echo    - Subir contenido de 'public_html/' al directorio public_html de tu cPanel
echo    - Subir contenido de 'nodejs/' a un directorio como 'suma-app' en tu hosting
echo.
echo 2. CONFIGURAR NODE.JS EN CPANEL:
echo    - Ir a cPanel ^> Software ^> Node.js
echo    - Crear nueva aplicación Node.js
echo    - Directorio de la aplicación: suma-app ^(o donde subiste los archivos^)
echo    - Archivo de inicio: app.js
echo    - Versión de Node.js: 16.x o superior
echo.
echo 3. CONFIGURAR VARIABLES DE ENTORNO:
echo    - En cPanel Node.js, agregar variables:
echo      * NODE_ENV=production
echo      * PORT=3000 ^(o el puerto asignado por Bluehost^)
echo.
echo 4. INSTALAR DEPENDENCIAS:
echo    - En el terminal de cPanel Node.js, ejecutar: npm install
echo.
echo 5. CONFIGURAR DOMINIO:
echo    - Editar el archivo .env en nodejs/
echo    - Cambiar tu-dominio.com por tu dominio real
echo.
echo 6. INICIAR APLICACIÓN:
echo    - En cPanel Node.js, hacer clic en "Restart"
echo.
echo 7. VERIFICAR:
echo    - Visitar https://tu-dominio.com/health
echo    - Debería mostrar estado OK
echo.
echo ¡Tu aplicación estará funcionando en tu dominio de Bluehost!
) > dist-bluehost\INSTRUCCIONES-BLUEHOST.txt

echo.
echo ✅ Preparación completada!
echo 📁 Archivos listos en: dist-bluehost\
echo 📋 Lee las instrucciones en: dist-bluehost\INSTRUCCIONES-BLUEHOST.txt
echo.
echo Ahora puedes:
echo 1. Comprimir la carpeta dist-bluehost en un ZIP
echo 2. Subir los archivos manualmente a tu hosting Bluehost
echo.
pause