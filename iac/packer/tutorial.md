# Construir nuesto Ops Server

Dentro del Concepto de GitOps es importante que tengamos nuestro servidor centralizado de donde ejecutaremos de manera automatica nuestra operación, para esto y siguiente el concepto de "Infraestructura como código" vamos a crear la imagen de nuestro servidor haciendo uso de packer.

Packer es una solution open source que nos permite llevar en código la creación de nuestras plantillas de VM para que de esta manera tengamos bajo source control incluso las versiones de nuestros servidores.

## Pre-requisito 

- Git
- Ambiente OCI
- oci-cli configurado

## 1. Instalar Packer

Si estas en Linux.

```shell
wget https://releases.hashicorp.com/packer/1.5.1/packer_1.5.1_linux_amd64.zip && unzip packer_1.5.1_linux_amd64.zip && mv packer /usr/local/bin
```

Si estas usando OSx

```shell
brew install packer
```

Si estas en Windows te recomiento instalar scoop como manejador de paquetes.

```powershell
Set-ExecutionPolicy RemoteSigned -scope CurrentUser 
iex (new-object net.webclient).downloadstring('https://get.scoop.sh')
```

y luego instalamos packer

```powershell
scoop install packer
```



## 2. Creamos nuestro secret file

Lo primero que haremos es renombrar el archivo secret.json.template a secret.json y en el rellenaremos cada campo según nuestro ambiente.

Lo primero que buscaremos es el "comparment_id"; esto lo encontramos si desplegamos el menú de la parte superior izquierda y seguidamente nos vamos a "Identity" -> "Compartments" hacemos click y veremos un unico comparment si es que no tenemos mas y sobre la columna OCID nos posicionamos para copiar el id que pegaremos en el secret.json

![compartment_menu](C:\Users\djfranco\Documents\Oracle\DevAdvocate\workshop\DevOpsFastrack\source\oci_devops_fastrack\img\iac\comparment_menu.jpg)

Luego desplegamos el mismo menu pero esta vez nos vamos a la opcion de "Networking" y hacemos clic en "Virtual Cloud Networks". Si ya tenemos una red creada la podremos ver, hacemos click sobre ella y navegamos para ver nuestras subnets. Alli debemos anotar el "AD" que se encuentra en la columna "Subnet Access" de la red que queremos usar, debe ser pública nuestra red. EJ: "dvEY:PHX-AD-1".

![AD](C:\Users\djfranco\Documents\Oracle\DevAdvocate\workshop\DevOpsFastrack\source\oci_devops_fastrack\img\iac\subnet_info.jpg)

 Luego hacemos click en el nombre de la subnet para consguier el OCID que necesitamos pegar en nuestro secret.

![subnetid](C:\Users\djfranco\Documents\Oracle\DevAdvocate\workshop\DevOpsFastrack\source\oci_devops_fastrack\img\iac\subnet_detail.jpg)

Seguidamente necesitamos el "base_image_ocid", si esas en ashburn usa "ocid1.image.oc1.iad.aaaaaaaawufnve5jxze4xf7orejupw5iq3pms6cuadzjc7klojix6vmk42va" y si tu region es phoenix "ocid1.image.oc1.phx.aaaaaaaadjnj3da72bztpxinmqpih62c2woscbp6l3wjn36by2cvmdhjub6a"

## 3. Validar template packer

Packer te permite validar el template con el siguiente comando.

Linux / OSx

```shell
packer validate -var-file=secret.json packer.json
```

Windows

```powershell
packer validate -var-file=".\secret.json" .\packer.json
```

Al ejecutar debemos conseguir la siguiente respuesta.

```shell
Template validated successfully.
```

## 4. Construir imagen

Si tenemos todos los pasos ya ejecutados entonces podemos crear nuestro template de VM.

```shell
packer build -var-file=secret.json packer.json
```

```powershell
packer build -var-file=".\secret.json" .\packer.json
```

![packer validate build](C:\Users\djfranco\Documents\Oracle\DevAdvocate\workshop\DevOpsFastrack\source\oci_devops_fastrack\img\iac\packer_validate_and_build.jpg)

Esto puede tomar unos minutos mientras crear, ejecuta el script de instalación, crear la imagen y luego eliminar la VM temporal. El resultado si todo sale bien es.

![build success](C:\Users\djfranco\Documents\Oracle\DevAdvocate\workshop\DevOpsFastrack\source\oci_devops_fastrack\img\iac\packer_build_complete.jpg)

y podemos ver nuestra imagen creada.

![vmready](C:\Users\djfranco\Documents\Oracle\DevAdvocate\workshop\DevOpsFastrack\source\oci_devops_fastrack\img\iac\vm_image_created.jpg)