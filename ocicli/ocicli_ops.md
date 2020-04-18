# Vamos a crear algunos recursos usando oci-cli

Una de las ventajas de la infrastructura cloud es que podemos crear recursos bajo demanda o "justo a tiempo" pero no solo la creación sino la destrucción. En el siguiente tutorial vamos a probar esto haciendo uso del oci-cli

## 1. Compartment OCID

Lo primero que vamos hacer es identificar el OCID de nuestro compartment. Con la ayuda de oci-cli veamos todos los disonibles en nuestro tenant.

```shell
oci iam compartment list --all
```
Toma nota del "compartment-id" ya que este es el "root" compartment tal cual como se ve en la imagen.

![rootocid](/img/ocicli/ocid.jpg)

## 2. Crear un nuevo compartment 

Los compartments son una forma de organizar recursos dentro de OCI así que vamos a crear uno para este laboratorio. El shell ejecuta el siguiente comando.

```
cid="ocid1.tenancy.oc1..aaaaaaaax662yezpjh5nn3semo46qbt3enwcjd2w2ayk7jsl6tgrbk2kxafr" && oci iam compartment create -c $cid --name devopsft --description "compartment created via oci-cli"
```

La variables "cid" corresponde al valor del compartment root que vimos en el paso anterior y luego que ejecutes el comando toma nota del campo "id" ya que este sera nuestro nuevo compartment para este workshop.

![compartmentOut](/img/ocicli/cid_output.jpg)

## 3. Creación de una nueva red virtual


Una red virtual no es más que una red dentro de nuestro tenant en donde colocaremos nuestros recursos de computo o bases de datos, vamos a crear una nueva vcn con una subnet.

```shell
oci network vcn create --cidr-block 172.16.0.0/16 -c $cid
```
Asegurate de copiar el "id" del recursos en el resultado del comando ya que lo necesitaremos a continuación.

![vcnid](/img/ocicli/vcnoutput.jpg)

```shell
oci network subnet create -c $cid --cidr-block 172.16.1.0/24 --vcn-id $vcnid
```
El vcnid representa el id de la vcn que crearmos anteriormente y recuera ahora copiar este nuevo "id"

![subput](/img/ocicli/subnetoutput.jpg)

## 3. Dominios de disponibilidad.

Las VCN (Virtual Cloud Networks) son un servicio regional y poseen tantas zonas de disponibilidad como la región tenga. Vamos a tener que escojer una para el paso siguiente.

```shell
oci iam availability-domain list
```

![ad](/img/ocicli/ads.jpg)

Toma nota del nombre de una de ellas como por ejemplo "dvEY:US-ASHBURN-AD-1"

## 4. OCID de la imagen para nuestra VM

Lo primero que vamos a necesitar es el OCID de la imagen plantilla para nuestra vm, visita este [link](https://docs.cloud.oracle.com/en-us/iaas/images/image/2fca4c99-1e9b-4a60-b41b-c73ee7ac36c1/) y muevete a la secciín "Image OCID"; debes copiar el ocid correspondiente a la región donde te encuentres.

![ocid site](/img/ocicli/oracle_img_id_site.jpg)

Si estas en us-ashburn-1 por favor copia el OCID correspondiente a la región.

![ashburnOCID](/img/ocicli/oracle_img_id_ashburn.jpg)

Un consejo es que crees variables por cada "ocid" esto facilitará luego como ejecutes los comandos.

```shell
cid="ocid1.compartment.oc1..aaaaaaaav6pdooaarurousblty4koterxpcyu3llelogqqueunopmii4j7wsd" \
sid="ocid1.compartment.oc1..aaaaaaaav6pdooaarurousblty4koterxpcyu3llelogqqueundasdwewqeqd" \
imgid="ocid1.image.oc1.iad.aaaaaaaasrjyeax4sznb3jxnamxrjpgiw2ked3isrmj6ktu44uso4mln7dua"
```

## 5. Crear una nueva VM.

Para crear una nueva VM copia y pega el siguiente comando, asegurate de usar los ids de acuerdo a los resultados obtenidos en los pasos anteriores.

```shell
oci compute instance launch --image-id $imgid --shape "VM.Standard2.1" --availability-domain "dvEY:US-ASHBURN-AD-1" --subnet-id $sid --compartment-id $cid
```

![newvm](/img/ocicli/vmcreating.jpg)

Muévete al menu de OCI en la consola web --> Compute y podrás ver tu VM creada.

![uivm](/img/ocicli/ui_new_vm.jpg)

## 6. Eliminemos la VM

Para eliminar nuestra VM, copia el OCID de la VM; esto puedes obtener vía el resultado del comando oci-cli anterior o desde la consola web haciendo click en la VM.

```shell
oci compute instance terminate --instance-id $vmid
```
Seremos preguntados si estamos seguros de eliminar el recurso al cual responderemos con "Y"

![vmtermination](/img/ocicli/vm_deletion.jpg)


