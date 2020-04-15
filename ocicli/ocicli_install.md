# Oracle Command Line Interface Tool 

The cli is a command line tool that provides the same functionalities as the console plus some other additional ones such as creating scripts to extend and automate OCI capabilities.

## 1. Install oci-cli.

The first thing we must do is login to our VM via ssh that we created in the "setup" section of this workshop. Once inside the terminal, we execute the following script.

```shell
bash -c "$(curl -L https://raw.githubusercontent.com/oracle/oci-cli/master/scripts/install/install.sh)"
```

## 2. Initial Setup oci-cli 

1. Execute oci setup

   ```shell
   oci setup config
   ```

   ![oci setup](/src/img/ocicli/oci_setup_config.jpg)

2. Now we need to answer the questions to configure our oci-cli.

   - We will be asked the location to store our config, by default it is in ~/.oci / config, press enter.
- Then we need to paste the User OCID. To do this we go to the top right of our console, click on "User settings" and then click on the OCID as shown in the images below and paste it in the terminal.
   
![user_settings](/src/img/ocicli/user_settings.jpg)
   ![user_ocid](/src/img/ocicli/copy_user_ocid.jpg)
   
- Next it asks for the "tenancy OCID"; We get it in the same user menu in the upper right in the "Tenancy: tenancy name" option. We copy the OCID and paste it in the terminal.
   
![tenancy](/src/img/ocicli/tenancy_settings.jpg)
   
   - Then we will be asked what our default region will be, here we can use us-ashburn-1.
   - It will ask us if we want to generate a new pair of RSA keys and we must say yes with the letter Y, then press enter.
   - It will indicate the default directory, name of the keys and phrase; to all this we can give enter to take the default values.

Done!!! we have successfully configured our oci-cli tool.

<img src="/src/img/ocicli/oci_setup_config_qa.jpg" alt="seup qa" style="zoom:50%;" />

3. Upload our recently crated oci public key in our user settings.

   We must return to the user configuration so that we paste the content of the public key by clicking on "API Keys" and pasting the content of our public key in ~/.oci/oci_api_key_public.pem.

   ![add key](/src/img/ocicli/add_public_key.jpg)


   ![api paste](/src/img/ocicli/api_key_on_oci.jpg)

4. Lets test if our oci-cli is working.

   ```powershell
   oci iam availability-domain list
   ```

   We should get this:

   ![output test](/src/img/ocicli/oci_setup_test.jpg)

   ### and if so then ... we are ready to rock and roll !!!

   

