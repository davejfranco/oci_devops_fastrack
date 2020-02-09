# Oracle Kubernetes Engine (OKE)

OKE es un servicio manejado de Kubernetes amigable al desarrollador, nivel enterprise que corre un cluster altamente disponible con el control, seguridad, y rendimiento predictivo de Oracle Cloud Infrastructure. OKE es 100% compatible con el ecosistema CNCF e integrado con los servicios de OCI.

## Pre-Requisitos

- Kubectl, Link: https://kubernetes.io/es/docs/tasks/tools/install-kubectl/
- Docker, Link: https://docs.docker.com/install/ 

## 1. Paso Acceder al cluster.

Lo primero es que buscamos nuestro cluster, para ello vamos al menu superior izquierdo y bajo "Developer Services" --> Container Cluster (OKE) hacemos click. Como podemos ver desde ese mismo menú también podremos accerder al Container Registry, Functions y API Gateway.

![oke location](/img/oke/oke_location.jpg)

A hacemos click en el nombre de nuestro cluster donde podremos ver los detalles de nuestro K8s y Node Pool (nodos workers de nuestro cluster).

![k8s dashboard](/img/oke/oke_info.jpg)

![np info](/img/oke/oke_np_info.jpg)

En la parte superior del dashboard podemos acceder al Kubeconfig de nuestro cluster, este esta correlacionado con nuestro usuario IAM del tenant. Si hacemos click se despliegan unos pasos a seguir para generarlo.

![kubeconfig](/img/oke/kubeconfig_steps.jpg)

A continuación un ejemplo del comando ejecutado con powershell

```powershell
oci ce cluster create-kubeconfig --cluster-id ocid1.cluster.oc1.phx.aaaaaaaaae4dgzrzhe3gcnrqgzrdkyldgbqwmyrwmuzdmn3cgcrtayzuga3t --file C:\Users\djfranco\.kube\config --region us-phoenix-1 --token-version 2.0.0
```

Una vez generado, ya podemos acceder al cluster.

![kubeconfig](/img/oke/kubeconfig_ready.jpg)

## 2. Acceder al Oracle Container Registry.

Oracle container registry es un servicio 100% compatible con Docker Registry v2 para almacenar images docker e integrado con las soluciones y servicios de Oracle Cloud.

Para accerder al registry en la consola, desde la esquina superior izquiera en la sección "Developer Services" nos encontraremos "Registry (OCIR)" al hacer click veremos el home del Registry.

![ocir home](/img/oke/registry_home.jpg)

Lo primero que vamos hacer es hacer docker login para que luego podamos subir imagenes a nuestro registry; para eso lo primero que debemos hacer es un token de autentication. Debemos ir a la configuración de usuarios en la parte superior derecha y luego en el dashboard buscar en la sección de "Resources" buscar la opción "Auth Token".

![user settings](/img/oke/user_settings.jpg)

![auth](/img/oke/auth_section.jpg)

Hacer click en "Generate Token" y debemos copiar el token y que no podremos ver mas adelante.

Ahora para hacer login va depender en que región nos encontramos y aca podemos ver los distintas Region Key en todas las regiones de OCI https://docs.cloud.oracle.com/en-us/iaas/Content/General/Concepts/regions.htm. Adicionalmente el usuarios usar tiene el formato <nombre del tenancy>/<usuario oci> y el password es el token que hemos generado anteriormente.

Un ejemplo de login seria el seguiente:

```shell
docker login iad.ocir.io -u davejfranco/dave.franco@oracle.com
```

Ahora para subir imagenes nuestros repositorios debe ser taggeados de la siquiente forma "<region>.ocir.io/<nombre del tenant>/<nombre del repositorio>" 

Ejemplo:

```shell
docker pull nginx && docker tag nginx iad.ocir.io/davejfranco/nginx
```

Ahora podemos subirlo a nuestro registry, este comando automaticamente también creará el repositorio.

```

docker push iad.ocir.io/davejfranco/nginx
```

##  3. Crear acceso del cluster al registry.

Por defecto nuestro cluster no tiene acceso al registry y para poder habilitarlo lo que necesitamos es crear un recurso mediante kubectl de tipo "secret" con los mismos datos que usamos para hacer docker login.

```shell
$ kubectl create secret docker-registry ocirsecret
--docker-server=<region-key>.ocir.io --docker-username='<tenancy-namespace>/<oci-username>' --docker-password='<oci-auth-token>' --docker-email='<email-address>'
```

Ejemplo:

```shell
kubectl create secret docker-registry ocisecret --docker-server=iad.ocir.io --docker-username='davejfranco/dave.franco@oracle.com' --docker-password='1AS>)HZj(ZQUfPcI}nGM' --docker-email='dave.franco@oracle.com'
```

## 4. Probar acceso al registry desde nuestro cluster

Para probarlo lo mejor es crear un recurso en nuestro cluster que haga uso de la imagen que subimos en pasos anteriores. En este mismo directorio vamos a crear un deployment con la imagen nginx que previamente subimos y un servicio tipo LoadBalancer para exponerlo a Internet.

![nginx](/img/oke/nginxyaml.jpg)

Como pueden ver en la figura de arriba referenciamos en nuestro deployment que las credenciales de nuestro registry estan en el secret "ocisecret"

```shell
kubectl create -f nginx.yaml
```

Una vez creado vamos a poder ver nuestro pod corriendo sin problemas.

![pods](/img/oke/getpods.jpg)