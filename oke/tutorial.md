# Oracle Kubernetes Engine (OKE)

OKE is an enterprise-level, developer-friendly managed Kubernetes service that runs a highly available cluster with the control, security, and predictive performance of Oracle Cloud Infrastructure. OKE is 100% compatible with the CNCF ecosystem and integrated with OCI services.

## Pre-requisites

- Kubectl, Link: https://kubernetes.io/es/docs/tasks/tools/install-kubectl/
- Docker, Link: https://docs.docker.com/install/ 

## 1. Accessing the cluster.

The first thing is to look for our cluster, for this we go to the upper left menu and under "Developer Services" -> Container Cluster (OKE). As we can see from that same menu we can also access the Container Registry, Functions and API Gateway.

![oke location](/img/oke/oke_location.jpg)

Once we are the the OKE service page we click on the name of our cluster where we can see the details of our K8s and Node Pool (worker nodes of our cluster).

![k8s dashboard](/img/oke/oke_info.jpg)

![np info](/img/oke/oke_np_info.jpg)

At the top of the dashboard we can click in the "Access Kubeconfig" button, this will display the step to follow to generate the kubeconfig to access our cluster.

![kubeconfig](/img/oke/kubeconfig_steps.jpg)

Example:

```powershell
oci ce cluster create-kubeconfig --cluster-id ocid1.cluster.oc1.phx.aaaaaaaaae4dgzrzhe3gcnrqgzrdkyldgbqwmyrwmuzdmn3cgcrtayzuga3t --file C:\Users\djfranco\.kube\config --region us-phoenix-1 --token-version 2.0.0
```
Once generated, we can now access the cluster.

![kubeconfig](/img/oke/kubeconfig_ready.jpg)

## 2. Accesing the Oracle Container Registry.

Oracle container registry is a 100% Docker Registry v2 compliant service for storing docker images and integrated with Oracle Cloud solutions and services.

To access the registry in the console, from the upper left corner in the "Developer Services" section we will find "Registry (OCIR)" when we click we will see the Registry home page.

![ocir home](/img/oke/registry_home.jpg)

The first thing we are going to do is docker login so that later we can upload images to our registry; For this, the first thing we must do is generate an authentication token. We must go to the user settings in the upper right and then in the dashboard under the "Resources" section look for the "Auth Token" option.

![user settings](/img/oke/user_settings.jpg)

![auth](/img/oke/auth_section.jpg)

Click on "Generate Token" and we must copy the token, after closing the pop-up window we will not be able to see it later.

Now to login, it will depend on what region we are in, here we can see the different "Region Key" in all OCI regions https://docs.cloud.oracle.com/en-us/iaas/Content/General/Concepts/regions.htm. If we are in ashburn our login region is ```iad.ocir.io```, the user of our registry depends on the tenant name and username ```<tenancy name>/<username>``` . Finally, the password is the token that we have previously generated.

An example of login would be the following:

```shell
docker login iad.ocir.io -u davejfranco/dave.franco@oracle.com
```

To upload images to the registry we must tag them as follows ```<region>.ocir.io/<tenancy name>/<docker repository name>``` 

Example:

```shell
docker pull nginx && docker tag nginx iad.ocir.io/davejfranco/nginx
```
Now we can upload it to our registry, this command will automatically create the repository as well.

```
docker push iad.ocir.io/<tenant name>/nginx
```

##  3. Creat access from the OKE cluster to the Docker registry.

By default our cluster does not have access to the registry and in order to enable it what we need is to create a resource using kubectl of type "secret" with the same data that we use to docker login.

```shell
$ kubectl create secret docker-registry ocirsecret
--docker-server=<region-key>.ocir.io --docker-username='<tenancy-namespace>/<oci-username>' --docker-password='<oci-auth-token>' --docker-email='<email-address>'
```

Example:

```shell
kubectl create secret docker-registry ocirsecret --docker-server=iad.ocir.io --docker-username='davejfranco/dave.franco@oracle.com' --docker-password='1AS>)HZj(ZQUfPcI}nG_' --docker-email='dave.franco@oracle.com'
```

## 4. Deploy app to our OKE.

We are going to deploy our Helidon SE based microservice on our Kubernetes cluster.

The first thing we are going to do is clone the following project.

```shell
git clone https://github.com/davejfranco/helidon-quickstart-se.git
```

With the use of docker we will compile the image.

```shell
docker build -t iad.ocir.io/<tenant name>/helidon-quickstart-se .
```

Then we upload it to our registry

```
docker push iad.ocir.io/<tenant name>/helidon-quickstart-se
```

Once finished uploading the image, now we are going to create our app in kubernetes. Edit the kubernetes.yaml file inside the project directory that we just cloned, rename our image in the "image" section inside the "Deployment" resource section with our recently tagged image.

![helidon](/img/oke/helidonimage.jpg)

and finally we create the resource.

```shell
kubectl create -f kubefile.yaml
```

To verify the pod running.

```shell
kubectl get pods 
```
to see the IP of our LoadBalancer service.

```shell
kubectl get services
```

