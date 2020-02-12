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

Lo primero que vamos hacer es hacer docker login para que luego podamos subir imagenes a nuestro registry; para eso lo primero que debemos hacer es generar un token de autentication. Debemos ir a la configuración de usuarios en la parte superior derecha y luego en el dashboard buscar en la sección de "Resources" buscar la opción "Auth Token".

![user settings](/img/oke/user_settings.jpg)

![auth](/img/oke/auth_section.jpg)

Hacer click en "Generate Token" y debemos copiar el token y que no podremos ver mas adelante.

Ahora para hacer login va depender en que región nos encontramos, acá podemos ver los distintas "Region Key" en todas las regiones de OCI https://docs.cloud.oracle.com/en-us/iaas/Content/General/Concepts/regions.htm. Adicionalmente el usuarios usar tiene el formato ```<nombre del tenancy>/<usuario oci>``` y el password es el token que hemos generado anteriormente.

Un ejemplo de login seria el seguiente:

```shell
docker login iad.ocir.io -u davejfranco/dave.franco@oracle.com
```

Ahora para subir imagenes nuestros repositorios debe ser taggeados de la siquiente forma ```<region>.ocir.io/<nombre del tenant>/<nombre del repositorio>``` 

Ejemplo:

```shell
docker pull nginx && docker tag nginx iad.ocir.io/<tenant name>/nginx
```

Ahora podemos subirlo a nuestro registry, este comando automaticamente también creará el repositorio.

```

docker push iad.ocir.io/<tenant name>/nginx
```

##  3. Crear acceso del cluster al registry.

Por defecto nuestro cluster no tiene acceso al registry y para poder habilitarlo lo que necesitamos es crear un recurso mediante kubectl de tipo "secret" con los mismos datos que usamos para hacer docker login.

```shell
$ kubectl create secret docker-registry ocirsecret
--docker-server=<region-key>.ocir.io --docker-username='<tenancy-namespace>/<oci-username>' --docker-password='<oci-auth-token>' --docker-email='<email-address>'
```

Ejemplo:

```shell
kubectl create secret docker-registry ocirsecret --docker-server=iad.ocir.io --docker-username='davejfranco/dave.franco@oracle.com' --docker-password='1AS>)HZj(ZQUfPcI}nGM' --docker-email='dave.franco@oracle.com'
```

## 4. Desplegar app a nuestro OKE.

Vamos a desplegar nuestro microservicio basado en Helidon SE en nuestro cluster Kubernetes.

Lo primero que vamos hacer es a clonar el siguiente proyecto.

```shell
git clone https://github.com/davejfranco/helidon-quickstart-se.git
```

Con el uso de docker vamos a compilar la image.

```shell
docker build -t iad.ocir.io/<tenant name>/helidon-quickstart-se .
```

Luego lo subimos a nuestro registry

```
docker push iad.ocir.io/<tenant name>/helidon-quickstart-se
```

Una vez finalizado de subir la imagen, ahora vamos a crear nuestra app en kubernetes, lo que debemos hacer es editar el archivo kubernetes.yaml y en la sección de deployment cambiar el nombre de nuestra image por la que acabamos de subir.

![helidon](/img/oke/helidonimage.jpg)

y finalmente creamos el recurso.

```shell
kubectl create -f kubernetes.yaml
```

Para verificar el pod corriendo.

```shell
kubectl get pods 
```

y si quieremos ver nuestro servicio expuesto.

```shell
kubectl get services
```

