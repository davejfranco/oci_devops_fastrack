# VM workshop

En este tutorial vamos a crear un servidor para poder ejectura nuestro workshop.

## 1. Vamos a crear una VM

Lo primero es buscar el menú en la parte superior izquiera, hacemos click y en "Compute" --> "instances" y hacemos click.

![console](/img/setup/compute.jpg)

Luego hacemos click en el botón de "Create Instance" y llenar los detalles.

![serverName](/img/setup/\vm_name.jpg)

En la sección de "Virtual cloud network compartment" nos aseguramos que estamos en el compartment donde hemos creado la vcn en el tutorial anterior.

![net](/img/setup/vcnypublicip.jpg)

Asegurarse de seleccionar la red que sea tipo pública y seleccionar "Assign a public IP  address" para que podamos acceder desde el internet.

![ssh](/img/setup/sshkey.jpg)

Seleccionamos nuestra llave ssh pública o la pegamos directamente y hacemos click en "Create".

Una vez la vm este lista probamos hacer login.

```shell
ssh -i <ssh location >/id_rsa.pub opc@<public ip>
```

Desde otra ventana podemos copiar el script setup.sh o simplemente seleccionamos el contenido y lo copiamos en un archivo en nuestro servidor.

```shell
scp -i <ssh location >/id_rsa.pub setup.sh opc@<public ip>:/home/opc/
```

Le damos permisos de ejecución y lo ejecutamos.

```shell
chmod +x setup.sh && ./setup.sh
```

Estos nos instalará Docker y Kubectl.