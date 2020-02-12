# DevOps Day Fasttrack

Este proyecto tiene como propósito servir de workshop para el aprendizaje de conceptos básicos de la práctica de DevOps usando herramientas opensource sobre Oracle Cloud Infrastructure.

## Agenda

En cada directorio de este proyecto existe un tutorial y a continuación les describo la secuencia de como seguirlo.

### 1. Setup

El primer paso es movernos al directorio "setup". Allí veremos con una cuenta de OCI crear una red básica, luego crear una VM en donde instalaremos oci-cli, docker y kubectl con un script; nuestro amiente de workshop.

### 2. OCI command line tool

Seguidamente nos vamos al directorio "ocicli" donde veremos los pasos para instalar y configuar oci-cli tool, una herramienta de linea de comando para interactuar con los recursos de OCI y donde también veremos como a través de esta herramienta podemos crear o destruir recursos de manera rápida e instantánea.

### 3. Infraestructura como código

 Una vez finalizado nos vamos hacia el directorio "resourcemanager" en donde usaremos oci-cli para invocar un servicio  de OCI llamado Resource Manager que sirve como lugar centralizado para la ejecución de Terraform donde enseñaremos como desplegar infraestructura más compleja incluyendo Oracle Kubernetes Engine.

### 4. Oracle Kubernetes Engine (OKE)

Finalmente nos vamos hacia el directorio "oke". Acá veremos como generar nuestro kubeconfig para conectarnos al cluster creado en el tutorial pasado, explicaremos como conectarnos al servicios "Oracle Container Registry", subiremos imagenes como prueba y finalmente desplegaremos un microservicio basado en Java.

### Bonus

Existe un directorio iac que contiene como sub directorio "terraform" donde se encuentra los archivos TF que se usan para el tutorial de infraestructura como código y otro archivo "packer" donde hay un ejemplo de como generar Vm templates a través de código usando la solución de Hashicorp llamada "Packer"

![keepcalm](/img/keep-calms-and-do-devops.png)





