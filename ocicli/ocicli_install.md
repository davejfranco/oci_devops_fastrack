# Oracle Command Line Interface Tool 

El cli es una herramienta de linea de comando que provee las mismas funcionalidades que la consola más algunas otras adicionales como crear script para extender y automatizar las capacidad de OCI.

## Pasos 1. Instalar oci-cli.

Lo primero que debemos hacer es loggearnos via ssh en la VM que creamos en la sección de "setup". Una vez dentro del terminal, ejecutamos el siguiente script.

```shell
bash -c "$(curl -L https://raw.githubusercontent.com/oracle/oci-cli/master/scripts/install/install.sh)"
```

## Paso 2. Setup Inicial de oci-cli 

1. Ejecutar oci setup

   ```shell
   oci setup config
   ```

   ![oci setup](/img/ocicli/oci_setup_config.jpg)

2. Ahora nos disponemos a responder a las preguntas para configurar nuestro oci-cli.

   - Se nos preguntará primero la locación de nuestra config, por defecto es en ~/.oci/config, le damos enter.

   - Luego necesitamos es pegar el User OCID. Para ello nos vamos a la parte superior derecha de nuestra consola, hacemos click en "User settings" y luego le damos a copiar en el OCID tal y como se muestran en las imagenes a continuación y lo pegamos en el terminal.

   ![user_settings](/img/ocicli/user_settings.jpg)
   ![user_ocid](/img/ocicli/copy_user_ocid.jpg)

   - A continuación nos pide el "tenancy OCID"; lo conseguimos en el mismo menu de usuario en la parte superior derecha en la opción "Tenancy: nombre de tenancy". Copiamos el OCID y lo pegamos en el terminal.

   ![tenancy](/img/ocicli/tenancy_settings.jpg)
   
   - Luego se nos preguntará cual sera nuestra región default, acá podemos utilizar us-ashburn-1.
   - Nos preguntara si queremos generar nuevo par de llaves RSA y debemos decir que si con la letra Y.
   - Nos indicara el directorio default, nombre de las llaves y frase; a todo esto le podemos dar enter para tomar los valores default

### Listo Tenemos nuestro confi generado.

<img src="/img/ocicli/oci_setup_config_qa.jpg" alt="seup qa" style="zoom:50%;" />

3. Subir oci_api_key_public.pem al usuario en la consola de oci.

   Nos debemos devolver a la configuración de usuarios para que peguemos el contenido de la llave pública haciendo click en "API Keys" y pegando el contenido de nuestra llave pública en ~/.oci/oci_api_key_public.pem.

   ![add key](/img/ocicli/add_public_key.jpg)


   ![api paste](/img/ocicli/api_key_on_oci.jpg)

4. Probamos el funcionamiento de oci-cli

   ```powershell
   oci iam availability-domain list
   ```

   Deberiamos obtener esto:

   ![output test](/img/ocicli/oci_setup_test.jpg)

### y si es asi pues... we are ready to rock and roll!!!

   
   

