#

## Pasos 1. Instalar oci-cli

### Requisitos

- Python
- 

## Instalación en Linux

1. Abrir terminal
2. Ejecutar script
```shell
bash -c "$(curl -L https://raw.githubusercontent.com/oracle/oci-cli/master/scripts/install/install.sh)"
```

## Instalación Windows

1. Abrir PowerShell como Administrador

2. Habilitar RemoteSigned

   ```powershell
   Set-ExecutionPolicy RemoteSigned
   ```

3. Correr Script de instalación

   ```powershell
   powershell -NoProfile -ExecutionPolicy Bypass -Command "iex ((New-Object System.Net.WebClient).DownloadString('https://raw.githubusercontent.com/oracle/oci-cli/master/scripts/install/install.ps1'))"
   ```

4. Responder a las preguntas durante la instalación.

## Setup Inicial de oci-cli 

1. Ejecutar oci setup

   ```shell
   oci setup config
   ```

   

