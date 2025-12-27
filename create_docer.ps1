# Параметры
param(
[string]$ProjectPath = "D:\my_project\FocusFlow\front\focus_flow",
[string]$ImageName   = "focus_flow",
[string]$ContainerName = "focus_flow_container",
[string]$DockerHubUser = "budemzhit",
[string]$Tag           = "latest",
[string]$LogFile       = "docker_build_push.log",
[int]$Port = 8080
)

# Переходим в проект
Set-Location $ProjectPath

# 1. Проверяем наличие Dockerfile
$dockerfilePath = Join-Path $ProjectPath "Dockerfile"
if (-Not (Test-Path $dockerfilePath)) {
    Write-Host "[INFO] Dockerfile not found. Creating default Dockerfile..."
    @"
FROM nginx:alpine
RUN rm -rf /usr/share/nginx/html/*
COPY build/web /usr/share/nginx/html
EXPOSE 80
"@ | Out-File -Encoding UTF8 $dockerfilePath
    Add-Content -Path $LogFile -Value "[INFO] Default Dockerfile created"
}

# 2. Собираем Flutter web --base-href /focus_flow/
Write-Host "[INFO] Building Flutter web..."
flutter build web --base-href /focus_flow/ 2>&1 | Tee-Object -FilePath $LogFile -Append

# 3. Собираем Docker image
Write-Host "[INFO] Building Docker image..."
docker build -t $ImageName . 2>&1 | Tee-Object -FilePath $LogFile -Append

# 4. Проверяем успешность сборки
if (docker images -q $ImageName) {
    Write-Host "[INFO] Image $ImageName built successfully."
    Add-Content -Path $LogFile -Value "[INFO] Image $ImageName built successfully."

    # 5. Логинимся в Docker Hub (если не залогинен)
    Write-Host "[INFO] Logging in to Docker Hub..."
    docker login 2>&1 | Tee-Object -FilePath $LogFile -Append

    # 6. Тэгируем образ для Docker Hub
    $fullImageName = "${DockerHubUser}/${ImageName}:${Tag}"
    docker tag $ImageName $fullImageName
    Add-Content -Path $LogFile -Value "[INFO] Tagged image as $fullImageName"

    # 7. Публикуем образ в Docker Hub
    Write-Host "[INFO] Pushing image to Docker Hub..."
    try {
        docker push $fullImageName 2>&1 | Tee-Object -FilePath $LogFile -Append

        if ($LASTEXITCODE -eq 0) {
            Write-Host "[SUCCESS] Image pushed successfully: $fullImageName"
            Add-Content -Path $LogFile -Value "[SUCCESS] Image pushed successfully: $fullImageName"
        }
        else {
            Write-Host "[ERROR] Docker push failed with exit code $LASTEXITCODE"
            Add-Content -Path $LogFile -Value "[ERROR] Docker push failed with exit code $LASTEXITCODE"
        }
    }
    catch {
        $errorMessage = $_.Exception.Message
        Write-Host "[EXCEPTION] $errorMessage"
        Add-Content -Path $LogFile -Value "[EXCEPTION] $errorMessage"
    }

    Write-Host "[NEXT STEP] On Ubuntu server run:"
    Write-Host "  docker pull $fullImageName"


    Write-Host "  docker run -d -p $Port:80 --name ${ImageName}_container $fullImageName"
} else {
    Write-Host "[ERROR] Docker image $ImageName not found. Build failed."
    Add-Content -Path $LogFile -Value "[ERROR] Docker image $ImageName not found. Build failed."
}
