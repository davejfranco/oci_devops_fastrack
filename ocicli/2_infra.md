# Vamos a crear recursos con oci-cli

La facilidad de la infraestructura cloud es que podemos tener recursos bajo demanda o "Just in Time" no solo para su creación sino destrucción. En el siguiente tutorial vamos a probarlo haciendo uso de oci-cli.

## 1. Compartment OCID

Lo primero que haremos es identificar el OCID de nuestro compartment. Para ellos con ayuda de nuestro oci-cli veamos todos los compartments disponibles en nuestro tenant.

```shell
oci iam compartment list --all
```

Anotamos el "id" de este compartment que sera usado luego.

## 2. Subnet OCID.

Luego necesitamos saber el OCID de la subnet donde desplegaremos nuestra VM; En la sección de "Instance information" de nuestra VM de ops hacemos click sobre el nombre de nuestra "Virtual Cloud Network"

![vmops](/img/ocicli/ops-vm-dashboard.jpg)

Esto nos llevara hasta la info de nuestra VCN, bajamos un poco y veremos nuestras subnets; justo al lado en cada subnet hay unos 3 puntos de forma vertical, hacemos click y nuevamente click  "Copy OCID"; tomamos notas.

![subnetid](/img/ocicli/subnets.jpg)

## 3. Availability Domains

Luego vamos a necesitar el availabilty domain name de la region donde vamos a desplegar la vm.

```shell
oci iam availability-domain list
```

![ad](/img/ocicli/ads.jpg)

Debemos seleccionar un nombre de cualquier de los AD y tomar notas; ejemplo "dvEY:US-ASHBURN-AD-1"

## 4. VM image OCID

Necesitamos indicar el OCID de la imagen que usaremos para nuestra vm. Para esto, visitamos https://docs.cloud.oracle.com/en-us/iaas/images/image/2fca4c99-1e9b-4a60-b41b-c73ee7ac36c1/, nos movemos a la sección "Image OCIDs"; alli buscamos dependiendo de la region cual OCID debemos usar. 

![ocid site](/img/ocicli/oracle_img_id_site.jpg)

Acá vemos el OCID para la región de ashburn y phoenix

![ashburnOCID](/img/ocicli/oracle_img_id_ashburn.jpg)

Copiamos el OCID de acuerdo a nuestra región; en este caso us-ashburn-1

Ejemplo:

```shell
cid="ocid1.compartment.oc1..aaaaaaaav6pdooaarurousblty4koterxpcyu3llelogqqueunopmii4j7wsd" \
sid="ocid1.compartment.oc1..aaaaaaaav6pdooaarurousblty4koterxpcyu3llelogqqueundasdwewqeqd" \
imgid="ocid1.image.oc1.iad.aaaaaaaasrjyeax4sznb3jxnamxrjpgiw2ked3isrmj6ktu44uso4mln7dua"
```

## 5. Crear una VM.

Ahora podemos crear nuestra VM

```shell
oci compute instance launch --image-id $imgid --shape "VM.Standard2.1" --availability-domain "dvEY:US-ASHBURN-AD-1" --subnet-id $sid --compartment-id $cid
```

![newvm](/img/ocicli/vmcreating.jpg)

Podemos ir al Menu de OCI --> Compute --> Instances y veremos nuestra VM creada.

![uivm](/img/ocicli/ui_new_vm.jpg)

## 6. Destruyamos la VM

Vamos primero a destruir la vm recien creada. Debemos copiar el OCID de nuestra VM.

```shell
oci compute instance terminate --instance-id $vmid
```

Se nos preguntará si deseamos eliminar el recurso a lo que respodemos con "Y"

![vmtermination](/img/ocicli/vm_deletion.jpg)


