#

## Pasos 1. Instalar oci-cli

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

   ![oci setup](/img/ocicli/oci_setup_config.jpg)

2. Responder a preguntas.

   <img src="/img/ocicli/oci_setup_config_qa.jpg" alt="seup qa" style="zoom:50%;" />

3. Subir oci_api_key_public.pem al usuario en la consola de oci.

   ![api paste](/img/ocicli/api_key_on_oci.jpg)

4. Probamos el funcionamiento de oci-cli

   ```powershell
   oci iam availability-domain list
   ```

   Deberiamos obtener esto:

   ![output test](/img/ocicli/oci_setup_test.jpg)

   y si es asi pues... we are ready to rock and roll!!!

   