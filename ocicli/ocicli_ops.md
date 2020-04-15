# Let's create some resources in using oci-cli

The ease of cloud infrastructure is that we can have resources on demand or "Just in Time" not only for their creation but destruction. In the next tutorial we are going to test it using oci-cli.

## 1. Compartment OCID

The first thing we will do is identify the OCID of our compartment. With the help of oci-cli let's see all the compartments available in our tenant.

```shell
oci iam compartment list --all
```

Take note of the "compartment-id" as this is the "root" compartment as is shown in the next image.

![rootocid](/src/img/ocicli/ocid.jpg)

## 2. Create a new compartment 

Compartments are a way to organize resources in OCI si lets  create a new compartment  for this lab, so type the following command.

```
cid="ocid1.tenancy.oc1..aaaaaaaax662yezpjh5nn3semo46qbt3enwcjd2w2ayk7jsl6tgrbk2kxafr" && oci iam compartment create -c $cid --name devopsft --description "compartment created via oci-cli"
```

Make sure you copy de "id" value of the out as shown in the image below as this will be the compartment we be using to create resources from now on.

![compartmentOut](/src/img/ocicli/cid_output.jpg)

## 3. Create new virtual cloud network

A virtual cloud network is just a network inside our tenant where we placed our compute or database resources, we are going to create a new vcn with a subnet.

```shell
oci network vcn create --cidr-block 172.16.0.0/16 -c $cid
```

Make sure you copy the ocid in the "id" field of the output as we will need it to create the subnet.

![vcnid](/src/img/ocicli/vcnoutput.jpg)

```shell
oci network subnet create -c $cid --cidr-block 172.16.1.0/24 --vcn-id $vcnid
```

the vcnid represents the id of the vcn we just created, once again copy the id field in the output.

![subput](/src/img/ocicli/subnetoutput.jpg)

## 3. Availability Domains

A vcn is a regional service as such it has as many availability domains as the region has available. we are goind to need to choose at least one AD fot the next steps.

```shell
oci iam availability-domain list
```

![ad](/src/img/ocicli/ads.jpg)

Take note of the name of one of them for example: "dvEY:US-ASHBURN-AD-1"

## 4. VM image OCID

Now we going to launch a new VM into our recently created vcn. Now we our going to need an OCID for our new VM, visit  https://docs.cloud.oracle.com/en-us/iaas/images/image/2fca4c99-1e9b-4a60-b41b-c73ee7ac36c1/, and move to the section "Image OCIDs". Copy de ocid of the region your executing this lab. 

![ocid site](/src/img/ocicli/oracle_img_id_site.jpg)

If you are in us-ashburn-1 please copy the OCID correspondent to this region.

![ashburnOCID](/src/img/ocicli/oracle_img_id_ashburn.jpg)

As an advice, you should create variable of each id as it will be easier to execute oci-cli commands later on.

```shell
cid="ocid1.compartment.oc1..aaaaaaaav6pdooaarurousblty4koterxpcyu3llelogqqueunopmii4j7wsd" \
sid="ocid1.compartment.oc1..aaaaaaaav6pdooaarurousblty4koterxpcyu3llelogqqueundasdwewqeqd" \
imgid="ocid1.image.oc1.iad.aaaaaaaasrjyeax4sznb3jxnamxrjpgiw2ked3isrmj6ktu44uso4mln7dua"
```

## 5. Create a new VM.

To create a new VM just copy and paste the following command, make sure your using your results of the ids in the previous steps.

```shell
oci compute instance launch --image-id $imgid --shape "VM.Standard2.1" --availability-domain "dvEY:US-ASHBURN-AD-1" --subnet-id $sid --compartment-id $cid
```

![newvm](/src/img/ocicli/vmcreating.jpg)

Lets move to the OCI menu --> Compute and we will see our recently created VM.

![uivm](/src/img/ocicli/ui_new_vm.jpg)

## 6. Destroy the  VM

Finally lets destroy this VM, copy de ocid of our recently created server either from the oci-cli output or from the GUI and execute the following command.

```shell
oci compute instance terminate --instance-id $vmid
```

We will be asked if we want to remove the resource to which we respond with "Y"

![vmtermination](/src/img/ocicli/vm_deletion.jpg)


