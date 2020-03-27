# Deploying Infrastructure as Code - Oracle Resource Manager

When we want to deploy more complex infrastructures, which have many resources that depend on each other, it is necessary to use a much more robust tool. For this tutorial we will make use of Terraform that allows us to do just this by using a simple language known as HCL (Hashicorp Configuration Language) to describe our architecture.

But how do we deploy this code? It is practically bad idea to do it from our own laptop, so a centralized place that keeps a record of the changes and tasks executed with this code is ideal; For this we will use Oracle Resource Manager which is an OCI solution that allows us to achieve precisely this. A centralize terraform deployments platform and keep a record of execution changes.

In this lab we will make use if Oci-cli, Terraform and Resource Manager to deploy a new virtual cloud network and a Kubernetes cluster (OKE).

## Resource Manager Workflow

Resource Manager tasks flow.

![rm](/img/resourcemanager/resource_manager_workflow.jpg)

## 1. Edit our terraform template

Move to iac/terraform directory within the project. Once inside we are going to locate the variables.tf file where we will replace some variables according to our tenant.

![vtf](/img/iac/variablestf.jpg)

- The first thing is to fill the space between quotes corresponding to the region; if you are in Ashburn the value is "us-ashburn-1".

- Then we are going to replace the variable "compartment_id" fill it with the OCID of the compartment where we are deploying our resources, remember that in the console if we go to Menu -> Identity -> Comparments we will see the list of compartments and we will find the OCID we want to use.

- Finally, as we did in the oci-cli tutorial, you need the OCID of the image to use for the worker nodes of our k8s cluster. Remember that you can visit https://docs.cloud.oracle.com/en-us/iaas/images/image/2fca4c99-1e9b-4a60-b41b-c73ee7ac36c1/ and obtain this validation according to the region where you are creating the resources; use this value to replace the "node_image_id" variable.

  Note: 

  - If your in us-ashburn-1 the OCID you should use in the variable "node_image_id" es ocid1.image.oc1.iad.aaaaaaaamspvs3amw74gzpux4tmn6gx4okfbe3lbf5ukeheed6va67usq7qq
  - Or if you are executing this lab on us-phoenix-1 the OCID you shoudl use in the "node_image_id" variable is ocid1.image.oc1.phx.aaaaaaaamff6sipozlita6555ypo5uyqo2udhjqwtrml2trogi6vnpgvet5q

## Pasos 2. Create the stack

Now that we modified our variable file we are going to compress all the terraform files with tf extension located in the ./iac/terraform directory in a zip format.

```shell
zip stack.zip *.tf
```

Copy the compartment_id where the stack will be created

```
oci iam compartment list --all #Listar todos los compartments en tu tenant
```
Now we are going to create the stack, as you can see below the variable $cid represents the OCID of the compartment where we are going to create the stack, additionally we add a name to the stack and the version of terraform that we are going to use which in this case is 0.12.x.

```shell
oci resource-manager stack create --compartment-id $cid --config-source stack.zip --display-name "Demo Stack" --terraform-version "0.12.x"
```

Executed the command we must have the following output in our terminal, take note of the "id"; this is our stack-id for future operations.

![stack create out](/img/resourcemanager/create_stack_output.jpg)

### Go to the Oracle cloud console, you will see our recently created stack 

We are going to see our newly created stack and we can also click and explore all the options that we can take in Resource Manager. The idea is that we can deploy our terraform recipies just as we would do it from our machine but from a centralized place without the need to have a CI/CD server just for this.

![new stack](/img/resourcemanager/create_stack_output_ui.jpg)

![stack console](/img/resourcemanager/stack_created_dashboard.jpg)

## 3. Terraform Plan

Let's first run a Terraform plan via Resource manager first.

   ```powershell
 oci resource-manager job create-plan-job --stack-id "ocid1.ormstack.oc1.phx.aaaaaaaa35d5mvdzdlmdabjevxuk3sb6vh3weld4nq6jcldnv5fw5fdhnvqq"
   ```

   ![plan output](/img/resourcemanager/terminal_plan_stack_output.jpg)

As we can see in the image above, we see that the plan was accepted, what happens now is that in Resource Manager a "Terraform plan" is being executed.

![plan UI out](/img/resourcemanager/plan_stack_output.jpg)

In the output in terminal, we must write down the "id" and then run our Terraform apply.

## 4. Terraform apply

We are going to execute terraform apply using the previous plan terraform.

   ```shell
oci resource-manager job create-apply-job --stack-id "ocid1.ormstack.oc1.phx.aaaaaaaa35d5mvdzdlmdabjevxuk3sb6vh3weld4nq6jcldnv5fw5fdhnvqq" --execution-plan-strategy "FROM_PLAN_JOB_ID" --execution-plan-job-id "ocid1.ormjob.oc1.phx.aaaaaaaa27tt62iwp3gixrbp2cekhzqwku62xt5w5qmlmhk6vrozlwsvvzoa"
   ```

The "execution plan strategy" determines whether to use a previous Job plan or whether to make a plan first and then apply.

![apply output](/img/resourcemanager/terminal_appy_stack_output.jpg)

In console while it is pending we will see this.

![pending ui](/img/resourcemanager/apply_stack_output_pending.jpg)

We have to wait a bit while creating our Network, Kubernetes Cluster and its nodes so...just chill!!!

Then we go back to the console and we will see the result of our apply. We already have our cluster ready!

![terraform output](/img/resourcemanager/apply_stack_output_success.jpg)

## 5. Update Stack (Opcional)

If we have made a mistake, we can update the stack as follows.

- We make the necessary changes to fix the problem.

- Zip compress the stack files ```zip stack.zip *.tf```

- We do the update with the following command.

  ```shell
  oci resource-manager stack update --config-source stack.zip --stack-id $stackid
  ```

- Again we will have to execute the steps of Terraform Plan and Terraform apply.

  