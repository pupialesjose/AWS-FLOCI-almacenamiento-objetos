# Ejemplo 1: Crear un bucket S3 con floci

Práctica de AWS en local: creación de un bucket de S3 mediante un script de PowerShell, usando [floci](https://github.com/) como emulador local de AWS. No se necesita una cuenta real de AWS ni se generan costos.

## Tabla de contenidos

- [Requisitos previos](#requisitos-previos)
- [Estructura del proyecto](#estructura-del-proyecto)
- [Uso](#uso)
- [Verificación](#verificación)
- [Solución de problemas](#solución-de-problemas)

## Requisitos previos

- Windows con PowerShell
- [floci](https://github.com/) instalado
- [AWS CLI](https://aws.amazon.com/cli/) instalado

## Estructura del proyecto

```text
EJEMPLO 1/
├── crear-bucket.ps1   # Script que crea el bucket en floci
└── README.md          # Este archivo
```

## Uso

### 1. Iniciar floci

```powershell
floci start
```

Déjalo corriendo en esa terminal y abre una nueva para los siguientes pasos.

### 2. Configurar las variables de entorno

Estas variables apuntan el AWS CLI al emulador local en lugar de AWS real. Las credenciales son ficticias.

```powershell
$env:AWS_ENDPOINT_URL = "http://localhost:4566"
$env:AWS_ACCESS_KEY_ID = "test"
$env:AWS_SECRET_ACCESS_KEY = "test"
$env:AWS_DEFAULT_REGION = "us-east-1"
```

> Las variables solo duran mientras la sesión de PowerShell esté abierta. Si abres una terminal nueva, vuelve a definirlas.

### 3. Crear el script

Crea el archivo `crear-bucket.ps1` en la carpeta del proyecto con el siguiente contenido:

```powershell
Write-Host "Creando bucket..."
aws s3 mb s3://mi-primer-bucket

Write-Host "`nBuckets disponibles:"
aws s3 ls

Read-Host "`nPresiona Enter para salir"
```

El script hace tres cosas:

1. Crea el bucket `mi-primer-bucket` con `aws s3 mb` (*make bucket*).
2. Lista los buckets disponibles con `aws s3 ls`.
3. Pausa la ejecución hasta que presiones Enter, para que puedas leer la salida.

### 4. Ejecutar el script

```powershell
.\crear-bucket.ps1
```

## Verificación

El script ya lista los buckets al terminar, pero también puedes confirmarlo manualmente:

```powershell
aws s3 ls
```

Deberías ver `mi-primer-bucket` en la salida, con la fecha y hora de creación.

## Solución de problemas

| Problema | Posible causa | Solución |
|---|---|---|
| `Connection refused` o no conecta | floci no está corriendo | Ejecuta `floci start` |
| El bucket aparece en AWS real o pide credenciales válidas | Variables de entorno no definidas en esta sesión | Repite el paso 2 |
| `BucketAlreadyOwnedByYou` | El bucket ya fue creado en una ejecución anterior | Es normal; el bucket ya existe. Para repetir la práctica, elimínalo con `aws s3 rb s3://mi-primer-bucket` |
| `.\crear-bucket.ps1 cannot be loaded` | Política de ejecución de PowerShell | `Set-ExecutionPolicy -Scope Process -ExecutionPolicy Bypass` |
