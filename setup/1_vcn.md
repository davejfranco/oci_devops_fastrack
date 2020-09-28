# Creación de Red Virtual

En este tutorial vamos a crear una vcn.

## Pre-Requisitos 

- Cuenta Oracle Cloud.

## Instrucciones

Debemos hacer click en el menu ubicado en la parte superior izquierda, posicionarnos en la opción "Networking" y hacemos click en la opción "Virtual Cloud Networks".

![vcn_location](/img/setup/vcn_location.jpg)

Acto seguido hacemos click en "Networking Quickstart"

![vcnquick](/img/setup/net_quick.jpg)

Con la opción "VCN with Internet Connectivity" hacemos click en "Start Workflow"

![workflow](/img/setup/vcn_option.jpg)

Llenamos los detalles

vcn name: "demovcn"
vcn cidr block: 172.16.0.0/16
public subnet cidr block: 172.16.1.0/24
private subnet cidr block: 172.16.2.0/24

En cuanto al compartment podemos seleccionar cualquiera que tengamos.

![vcn fill](/img/setup/vcn_detail.jpg)

Hacemos click en "Next", podremos ver un review de los recursos que sera creados y hacemos click en "Create" en la parte inferior.

![create](/img/setup/vcn_review.jpg)

Y listo!!
