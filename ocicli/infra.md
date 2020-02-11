# Vamos a crear recursos con oci-cli

La facilidad de la infraestructura cloud es que podemos tener recursos bajo demanda o "Just in Time" no solo para su creación sino destrucción. En el siguiente tutorial vamos a probarlo haciendo uso de oci-cli.

## 1. Pre-Requisitos

Lo primero que haremos es identificar el OCID de nuestro compartment. Para ellos con ayuda de nuestro oci-cli veamos todos los compartments disponibles en nuestro tenant.

```shell
oci iam compartment list --all
```

Anotamos el "id" de este compartment que sera usado luego.

Luego necesitamos saber el OCI de la subnet donde desplegaremos nuestra VM; En la sección de "Instance information" de nuestra VM de ops hacemos click sobre el nombre de nuestra "Virtual Cloud Network"

![vmops](/img/ocicli/ops-vm-dashboard.jpg)

Esto nos llevara hasta la info de nuestra VCN, bajamos un poco y veremos nuestras subnets; justo al lado en cada subnet hay unos 3 puntos de forma vertical, hacemos click y nuevamente click  "Copy OCID"; tomamos notas.

![subnetid](/img/ocicli/subnets.jpg)

Luego vamos a necesitar el availabilty domain namede la region donde vamos a desplegar la vm.

```shell
oci iam availability-domain list
```

![ad](C:\Users\djfranco\Documents\Oracle\DevAdvocate\workshop\DevOpsFastrack\source\oci_devops_fastrack\img\ocicli\ads.jpg)

Debemos seleccionar un nombre de cualquier de los AD y tomar notas

Luego, visitamos https://docs.cloud.oracle.com/en-us/iaas/images/image/2fca4c99-1e9b-4a60-b41b-c73ee7ac36c1/ alli buscamos dependiendo de la region cual OCID debemos usar. En caso de ashburn el OCID es ocid1.image.oc1.iad.aaaaaaaasrjyeax4sznb3jxnamxrjpgiw2ked3isrmj6ktu44uso4mln7dua correspondiente a una Oracle Autonomous Linux 7.

Ejemplo:

```shell
cid="ocid1.compartment.oc1..aaaaaaaav6pdooaarurousblty4koterxpcyu3llelogqqueunopmii4j7wsd" \
sid="ocid1.compartment.oc1..aaaaaaaav6pdooaarurousblty4koterxpcyu3llelogqqueundasdwewqeqd" \
imgid="ocid1.compartment.oc1..aaaaaaaav6pdooaarurousblty4koterxdasdawdasderkjhouyuihasdoas"
```

## 2. Crear una VM.

Ahora podemos crear nuestra VM

```shell
oci compute instance launch --image-id $imgid --shape "VM.Standard2.1" --availability-domain "dvEY:US-ASHBURN-AD-1" --subnet-id $sid --compartment-id $cid
```

![newvm](C:\Users\djfranco\Documents\Oracle\DevAdvocate\workshop\DevOpsFastrack\source\oci_devops_fastrack\img\ocicli\vmcreating.jpg)

Podemos ir al Menu de OCI --> Compute --> Instances y veremos nuestra VM creada.

![uivm](C:\Users\djfranco\Documents\Oracle\DevAdvocate\workshop\DevOpsFastrack\source\oci_devops_fastrack\img\ocicli\ui_new_vm.jpg)

## 3. Destruyamos todo

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

