# Vamos a crear recursos con oci-cli

La facilidad de la infraestructura cloud es que podemos tener recursos bajo demanda o "Just in Time" no solo para su creación sino destrucción. En el siguiente tutorial vamos a probarlo haciendo uso de oci-cli.

## 1. Primero necesitamos una red

Para esto, vamos a buscar el compartment donde queremos desplegar nuestra red.

```shell
oci iam compartment list
```

Deberiamos tener una salida como la siguiente

![iam output](C:\Users\djfranco\Documents\Oracle\DevAdvocate\workshop\DevOpsFastrack\source\oci_devops_fastrack\img\ocicli\get_compartments.jpg)

y anotamos el valor "id"

## 2. Vamos a crear una red con una subnet.

```shell
oci network vcn create --cird-block 172.16.0.0/16 --display-name "demovcn" --compartment-id $cid
```

$cid es la variable que contiene el valor de "id" de nuestro compartment. Debemos tener un output de esta forma.

![vcnadd](C:\Users\djfranco\Documents\Oracle\DevAdvocate\workshop\DevOpsFastrack\source\oci_devops_fastrack\img\ocicli\vcn_created.jpg)

Acá debemos también anotar el id, que se refuere al OCID de nuestra VCN. También podemos ver nuestra VCN creada si vamos al Menu --> Networking --> Virtual Cloud Networks.

![uivcn](C:\Users\djfranco\Documents\Oracle\DevAdvocate\workshop\DevOpsFastrack\source\oci_devops_fastrack\img\ocicli\uivcn.jpg)

## 3. Vamos añadir una subnet.

Para añadir una nuevo subnet asociada para nuestra red.

```shell
oci network subnet create --cidr-block 172.16.1.0/24 --display-name "demosub" --vcn-id $vcn --compartment-id $cid
```

La variable vcn es el id de nuestra salida anterior y cid es el OCID del compartment donde desplegamos la red. Debemos tener una salida como esta.

![subnet](C:\Users\djfranco\Documents\Oracle\DevAdvocate\workshop\DevOpsFastrack\source\oci_devops_fastrack\img\ocicli\newsubnet.jpg)

Debemos tomar nota de id de la subnet.

## 4. Vamos a crear una VM

Para crear una VM necesitamos obtener los siguientes datos, el availability domain, compartment-id, la subnet-id donde vamos a crearla y el image-id que vamos a usar como plantilla para levantar la VM.

Para conseguir el availability domain de la region donde vamos a desplegar la vm.

```shell
oci iam availability-domain list
```

![ad](C:\Users\djfranco\Documents\Oracle\DevAdvocate\workshop\DevOpsFastrack\source\oci_devops_fastrack\img\ocicli\ads.jpg)

Debemos seleccionar el nombre de cualquier de los AD.

Luego, visitamos https://docs.cloud.oracle.com/en-us/iaas/images/image/2fca4c99-1e9b-4a60-b41b-c73ee7ac36c1/ alli buscamos dependiendo de la region cual OCID debemos usar. En caso de ashburn el OCID es ocid1.image.oc1.iad.aaaaaaaasrjyeax4sznb3jxnamxrjpgiw2ked3isrmj6ktu44uso4mln7dua

 Finalmente con el compartment-id y la subnet-id de los recursos creados anteriormente, creamos nuestra VM.

```shell
oci compute instance launch --image-id $imgid --shape "VM.Standard2.1" --availability-domain "dvEY:US-ASHBURN-AD-1" --subnet-id $sid --compartment-id $cid
```

--image-id colocamos el OCID de la imagen a utilizar, luego el availability-domain name, seguido del del OCID de la subnet y finalmente el compartment OCID. El resultado debe ser algo como esto.

![newvm](C:\Users\djfranco\Documents\Oracle\DevAdvocate\workshop\DevOpsFastrack\source\oci_devops_fastrack\img\ocicli\vmcreating.jpg)

Podemos ir al Menu de OCI --> Compute --> Instances y veremos nuestra VM creada.

![uivm](C:\Users\djfranco\Documents\Oracle\DevAdvocate\workshop\DevOpsFastrack\source\oci_devops_fastrack\img\ocicli\ui_new_vm.jpg)

## 5. Destruyamos todo

Vamos primero a destruir la vm recien creada. Debemos copiar el OCID de nuestra VM.

```shell
oci compute instance terminate --instance-id $vmid
```

Se nos preguntará si deseamos eliminar el recurso a lo que respodemos con "Y"

![vmtermination](C:\Users\djfranco\Documents\Oracle\DevAdvocate\workshop\DevOpsFastrack\source\oci_devops_fastrack\img\ocicli\vm_deletion.jpg)

Ahora vamos con la red y para esto debemos primero borrar la subnet y luego vcn.

```shell
oci network subnet delete --subnet-id $sid 
```

```shell
oci network vcn delete --vcn-id $vcn
```

$sid representa el OCID de la subnet y $vcn el OCID de la red creada.

