# Oracle Command Line Interface Tool 

En este laboratorio vamos a interactuar con la herramienta oci-cli para esto vas a tener dos opciones; puedes instalar el oci-cli en tu máquina o en una VM en la misma cuanta de OCI tal y como esta descrito en la sección "setup" de este mismo repositorio; las instrucciones se encuentran en el siguiente [link](./ocicli_install.md) o puedes usar el Oracle Cloud Shell cuyas instrucciones encontrarás a continuación.

## Oracle Cloud Shell

Oracle Cloud Infrastructure (OCI) Shell es un terminal web accesible desde la consola de Oracle Cloud, el shell es de uso gratuito (dentro de los limites mensuales del tenant) y provee acceso a un shell Linux con pre authenticación al Oracle CLoud Infrastructure command line tool y otras utiles herramientas. Puedes ver más detalles siguiente este [link](https://docs.cloud.oracle.com/en-us/iaas/Content/API/Concepts/cloudshellintro.htm).

## Oci-cli

El CLI es una herramiente pequeña que puedes usar unicamente o en conjunto con la consola web de Oracle Cloud para completar cualquier tipo de tarea. El CLI provee las mismas funcionalidades proincipales de la consola más otros comandos. Algunas funcionalidades adicionales incluyen la posibilidad de correr scripts para extender las capacidades de la consola web.

## Prerequisitos

Para hacer uso del Cloud Sheel lo primero es tener una cuenta valida de Oracle Cloud y tener permisos de acceso al servicio. Para más información por favor visita el siguiente [link](https://docs.cloud.oracle.com/en-us/iaas/Content/API/Concepts/cloudshellintro.htm) y busca la sección "Required IAM Policy".

## Instrucciones

Localiza el cloud shell en el icono en la parte superior derecha del sitio principal. Click izquierdo y esos es todo!

![cloudshell](/img/ocicli/cloudshell.jpg)

Una vez que el cloud shell haya cargado lo primero que debemos hacer es tipear ```help``` lo que desplegará información importante sobre cloud que incluye limitaciones y como copiar y pegar si estas usando una máquina Windows o MAC.

![cloud_shell](/img/ocicli/cloudshell_help.jpg)

Una de las ventajas de usar cloud shell es que el oci-cli ya esta listo para ser usado. Adicionalmente incluye las siguientes herramientas pre instaladas.

- Git
- Java 
- Python (2 and 3)
- SQL Plus
- kubectl
- helm
- maven
- gradle
- terraform
- ansible

Así que estas listo, por favor ve al [siguiente](./ocicli_ops.md) lab de este workshop.

para instalar y configurar oci-cli ve a este [tutorial](./ocicli_install.md) (Optional)