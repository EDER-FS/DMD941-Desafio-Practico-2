# Publicación en GitHub

Repositorio de destino: https://github.com/EDER-FS/DMD941-Desafio-Practico-2

> Este archivo es una guía. El paquete no se ha publicado automáticamente en GitHub.

## Antes de publicar

1. Completa el carné universitario del informe Word y, si lo modificas, vuelve a exportar el PDF.
2. Copia desde tu computadora la solución SSAS real (`.sln`, `.dwproj`, `.ds`, `.dsv`, `.dim`, `.cube`) dentro de `proyecto_ssas/`.
3. Copia el archivo original `Desafio2_AdventureWorks.pbix` en `powerbi/`.
4. Comprueba que no hay respaldos `.bak`, contraseñas, archivos temporales o artefactos de compilación.
5. Mantén la estructura de carpetas `docs/`, `sql/`, `evidencias/`, `proyecto_ssas/`, `powerbi/`.

## Opción 1: Git desde PowerShell (recomendada para conservar carpetas)

En una carpeta de trabajo ejecuta:

```powershell
git clone https://github.com/EDER-FS/DMD941-Desafio-Practico-2.git
cd .\DMD941-Desafio-Practico-2
```

Descomprime el ZIP de entrega en una carpeta diferente y **copia el contenido interior** de `DMD941_Entrega_Final_OLAP/` a la carpeta del repositorio recién clonado (sin reemplazar la carpeta `.git`). Después ejecuta:

```powershell
git status
git add .
git status
git commit -m "Documentar cubo OLAP SSAS, consultas y evidencias del desafio 2"
git push -u origin HEAD
```

Si `git status` muestra archivos que no deberían publicarse, retíralos antes de `git add .`. Si Git solicita autenticación, completa el inicio de sesión mediante el administrador de credenciales de Git; no coloques un token en documentos ni capturas.

## Opción 2: Subida web desde GitHub

Abre el repositorio, utiliza **Add file > Upload files**, y carga los archivos y carpetas extraídos desde el explorador de archivos. Verifica que GitHub conserve correctamente la estructura. Escribe un mensaje de commit y confirma. **No subas solamente el ZIP**, porque GitHub no extrae automáticamente su contenido como archivos de repositorio.

## Confirmación

Tras subir, revisa que aparezcan:

- `README.md`
- `docs/Informe_DMD941_Desafio_2_Actualizado_OLAP.pdf`
- `docs/Informe_DMD941_Desafio_2_Actualizado_OLAP.docx`
- `sql/` y sus tres scripts
- `evidencias/OLAP_06_Comparacion_Cuatro_Medidas.png`
- Los archivos fuente de `proyecto_ssas/` y el `.pbix` original en `powerbi/`

Guarda la URL del commit, la fecha y una captura de la página **Code** como prueba de publicación.
