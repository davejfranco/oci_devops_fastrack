# Desplegando infraestructura como código - Oracle Resource Manager

Cuando deseamos desplegar infraestructuras más complejas, que poseen muchos recursos que dependen entre si, es necesario hacer uso de una herramienta mucho más robusta. Para este tutorial haremos uso de Terraform que nos permite precisamente esto mediante el uso de una lenguaje sencillo conocido como HCL (Hashicorp Configuration Language) para describir nuestra arquitectura.

¿Pero cómo desplegamos este código? es mala prácticamente que lo hagamos desde nuestra propia laptop por tanto es ideal un lugar centralizado que guarde un registro de los cambios y tareas ejecutadas con este código; para esto usaremos Resource Manager que es una solución de OCI que te permite precisamente centralizar los deployments de terraform y mantener un registro de cambios de ejecución.

A continuación usaremos Oci-cli, Terraform y Resource Manager para desplegar una VCN nueva y un cluster de Kubernetes para mas tarde podamos desplegar microservicios en Docker.

## Prerequisitos

- oci-cli
- Descarga el código con el siguiente comando.

```
git clone https://github.com/davejfranco/oci-devopsft-src.git
```
## Resource Manager Workflow

Resource Manager tasks flow.

![rm](/img/resourcemanager/resource_manager_workflow.jpg)

## 1. Editar nuestro terraform template

Ve al directorio oci-devopsft-src. Una ve dentro localizamos el archivo variables.tf en donde vamos a reemplazar algunas variables con respecto a nuestro tenant.

![vtf](/img/iac/variablestf.jpg)

- Lo primero es llenar el espacio entre comillas correspondiente a la region; si estas en Ashburn el valor es "us-ashburn-1".

- Luego vamos a reemplazar la variable "compartment_id" donde tenemos que llenarlo con el OCID del compartment donde estamos desplegando nuestro recursos. Recuerda que en la consola si nos vamos al Menú --> Identity --> Comparments veremos la lista de compartments y encontraremos el OCID buscado.

## Pasos 2. Crear el stack

Ahora que modificamos nuestro terraform vamos a comprimir los archivos terraform con extención tf ubicados en el directorio ./iac/terraform en formato zip.

```shell
zip stack.zip *.tf
```
Copiamos el compartment id en donde se creará el stack

```
oci iam compartment list --all #Listar todos los compartments en tu tenant
```
Ahora vamos a crear el stack, como puedes ver más abajo la variable $cid representa el OCID del compartment donde vamos a crear el stack, adicionalmente añadimos un nombre al stack y la versión de terraform que vamos a usar que en este caso es 0.12.x.

```shell
oci resource-manager stack create --compartment-id $cid --config-source stack.zip --display-name "Demo Stack" --terraform-version "0.12.x"
```
Ejecutado el comando debemos tener el siguiente output en nuestra terminal, tomemos nota del "id"; este es nuestro stack-id para futuras operaciones.

![stack create out](/img/resourcemanager/create_stack_output.jpg)

### Si nos vamos a la consola, veremos el stack creado via oci-cli

Vamos a ver nuestro recién creado stack y además podemos hacer clic y explorar todas las opciones que podemos tomar en Resource Manager. La idea es que podamos desplegar nuestras receta terraform tal y como lo hariamos desde nuestra máquina pero desde una lugar centralizado sin la necesidad de tener un servidor de CI/CD para esto.

![new stack](/img/resourcemanager/create_stack_output_ui.jpg)

![stack console](/img/resourcemanager/stack_created_dashboard.jpg)

## 3. Terraform Plan

Vamos primero primero a ejecutar un Terraform plan via Resource manager.

   ```powershell
 oci resource-manager job create-plan-job --stack-id "ocid1.ormstack.oc1.phx.aaaaaaaa35d5mvdzdlmdabjevxuk3sb6vh3weld4nq6jcldnv5fw5fdhnvqq"
   ```

   ![plan output](/img/resourcemanager/terminal_plan_stack_output.jpg)

Como podemos observar en la imagen de arriba, vemos que el plan fue aceptado, lo que ocurre ahora es que en Resource Manager se esta ejecutando un "Terraform plan".

![plan UI out](/img/resourcemanager/plan_stack_output.jpg)

En el output en terminal, debemos anotar el "id" para luego ejecutar nuestro Terraform apply.

## 4. Terraform apply

Vamos a ejecturar terraform apply haciendo uso del terraform plan previo.

   ```shell
oci resource-manager job create-apply-job --stack-id "ocid1.ormstack.oc1.phx.aaaaaaaa35d5mvdzdlmdabjevxuk3sb6vh3weld4nq6jcldnv5fw5fdhnvqq" --execution-plan-strategy "FROM_PLAN_JOB_ID" --execution-plan-job-id "ocid1.ormjob.oc1.phx.aaaaaaaa27tt62iwp3gixrbp2cekhzqwku62xt5w5qmlmhk6vrozlwsvvzoa"
   ```
El "execution plan strategy" determina si se usara un plan Job previo o si primero hará plan y luego apply.

![apply output](/img/resourcemanager/terminal_appy_stack_output.jpg)

En consola mientras esta en pending veremos esto.

![pending ui](/img/resourcemanager/apply_stack_output_pending.jpg)

Nos toca esperar un poco mientras se crear nuestra Red, Cluster de Kubernetes y su nodo!!!... just chill!

Luego vamos de nuevo a la consola y veremos el resultado de nuestro apply. Ya tenemos nuestro cluster listo!

![terraform output](/img/resourcemanager/apply_stack_output_success.jpg)

## 5. Actualizar el Stack

Once our cluster is ready and you can take a look at Menu --> Developer Services --> Container Cluster (OKE), lets now say that we need to scale our cluster as right now it only has only one worker node. For this go back to the variable.tf file in the demo source code and modify the variable "nodes_per_net" and set the value to 2.

Una vez el cluster kubernetes esta listo; podemos verlo si vamos al Menu --> Developer Services --> Container Cluster (OKE). Digamos que necesitamos escalar nuestro cluster y añadir un noda adicional ya que el que creamos solo tiene un nodo worker. Para esto nos vamos al archivo variables.tf que se encuentra dentro del directorio del código terraform y en la variables "nodes_per_net" cambiamos el valor a 2.

![variablestf node size](/img/resourcemanager/var_nodes.jpg)

- Comprimimos los archivos nuevamente ```zip stack.zip *.tf```

- Hacemos la actualización con el sieguiente comando.

  ```shell
  oci resource-manager stack update --config-source stack.zip --stack-id $stackid
  ```

- En esta oportunidad haremos un "Terraform apply" directamente.

  ```shell
  oci resource-manager  job create-apply-job --stack-id $stackid --execution-plan-strategy "AUTO_APPROVED"
  ```

Nuestro cluster se va actualizar y pasará a tener dos nodos.