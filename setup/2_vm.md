# VM workshop

En este tutorial vamos a crear un servidor para poder ejectura nuestro workshop.

## 1. Vamos a crear una VM

Lo primero es buscar el menú en la parte superior izquiera, hacemos click y en "Compute" --> "instances" y hacemos click.

![console](/img/setup/compute.jpg)

Luego hacemos click en el botón de "Create Instance" y llenar los detalles.

![serverName](/img/setup/vm_name.jpg)

En la sección de "Virtual cloud network compartment" nos aseguramos que estamos en el compartment donde hemos creado la vcn en el tutorial anterior.

![net](/img/setup/vcnypublicip.jpg)

Asegurarse de seleccionar la red que sea tipo pública y seleccionar "Assign a public IP  address" para que podamos acceder desde el internet.

![ssh](/img/setup/sshkey.jpg)

Seleccionamos nuestra llave ssh pública o la pegamos directamente y hacemos click en "Create".

Nota: Si te descargas el proyecto dentro de la carpeta setup --> ssh encontrarás un par de llaves que puedes usar para tu vm del workshop.

Una vez la vm este lista probamos hacer login.

```shell
ssh -i <ssh location >/id_rsa opc@<public ip>
```

Lo primero que debemos hacer una vez dentro de nuestro server es instalar git.

```shell
sudo yum install -y git
```

## 2. Descargar source code del workshop

Ahora que tenemos git, vamos a descargarnos el workshop y para esto.

```shell
git clone https://github.com/davejfranco/oci_devops_fastrack.git
```

Nos movemos al directorio setup dentro del directorio del proyecto y vamos a instalar algunos pre-requisitos ejecutamos.

```shell
cd oci_devops_fastrack/setup && chmod +x setup.sh && ./setup.sh
```

Estos nos instalará Docker y Kubectl.

y estamos listos para comenzar.