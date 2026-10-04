Write-Host "Creando bucket..."
aws s3 mb s3://mi-primer-bucket

Write-Host "`nBuckets disponibles:"
aws s3 ls

Read-Host "`nPresiona Enter para salir"
