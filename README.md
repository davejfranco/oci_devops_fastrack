# DevOps Day Fasttrack

Este proyecto busca servir como material workshop para aprender conceptos básicos de las prácticas de DevOps usando herramientas opensource en Oracle Cloud.

## Agenda

Este material cubre los siguientes topicos:

- Cloud Shell and Oracle Command Line Tool (oci-cli).
- Oracle Resource Manager (Terraform deployment plattform).
- Oracle Kubernetes Engine (OKE).

### Prerequisitos

Para seguir este workshop lo primero necesario es tener una cuenta de OCI (Oracle Cloud Infrastructure), si no tienes una puedes visitar este [link](https://www.oracle.com/cloud/free/) y sigue los pasos. Una vez tengas la cuenta ve a la [consola](https://console.us-ashburn-1.oraclecloud.com/) deberás colocar el nombre del tenant el cual asignaste al momento de crear la cuenta seguido del usuario y password.

### 1. [OCI command line tool](/ocicli/tutorial.md)

La "forma de DevOps" de hacer cosas es usar la terminal, en este sentido Oracle Cloud tiene dos herramientas sorprendentes; el primero es el cloud shell que le permite tener un shell en el navegador con algunas herramientas útiles ya instaladas para trabajar, el segundo es la herramienta de línea de comando de oci (oci-cli) que le permite realizar operaciones a través del terminal. En este laboratio trabajaremos con ambos para familiarizarnos con OCI usando el terminal.

### 3.  [Infraestructura como código](/resourcemanager/tutorial.md)

DevOps se apoya en la automatización, incluyendo la creación de infraestructura. Hay muchas herramientas que pueden ayudarnos en esta tarea, pero Terraform es la herramienta de Infraestructura como código más conocida en el mundo y en conjunto con Oracle Resource Manger podemos tener una plataforma centralizada para implementar y monitorear nuestros cambios en el ciclo de vida de la Infraestructura.

En este laboratorio modificaremos un código terraform y lo desplegaremos usando Resource Manager a través del oci-cli.

### 4. [Oracle Kubernetes Engine (OKE)](/oke/tutorial.md)

Finalmente en este último laboratior veremos como generar el kubeconfig de nuestro recién creado cluster de Kubernetes, nos conectaremos al Oracle Container Registry y finalmente desplegaremos una aplicación.

![keepcalm](/img/keep-calms-and-do-devops.png)





