The goal of this repo is to showcase the capabilities of Ansible. We will be utilizing Terraform to provision our infrastructure, as outlined by the diagram above(Coming Soon). We then use Ansible to configure the provisioned VMs as webservers and pull our webpage code from github.

### You can follow the video tutorial here: Under Construction
### You can follow my "troubleshooting" video here: Under Construction

## [Prerequisites](https://youtu.be/IkYkUJjqqqA?si=gFHXAX2JPATWknC1)
- Terraform installed and connected to Terraform Cloud.
- AWS CLI configured with the necessary credentials.
- Ansible installed on your local machine.

## Terraform Deployment

1. Clone this repository to your local machine:

   ```bash
   git clone https://github.com/hyferdev/Ansible.git
   ```

2. Navigate to the cloned directory:

   ```bash
   cd Ansible
   ```

3. Review the Terraform configuration files in the directory and modify the files as per your requirements, such as the hostedzone ID, cloud provider, region, cluster size, or any other desired configuration.

4. Initialize Terraform and download the necessary provider plugins:


   ```bash
   terraform init
   ```

5. Review and validate the Terraform execution plan:

   ```bash
   terraform plan
   ```

   Ensure that the plan output matches your expectations and that no errors or warnings are present.

6. Apply the Terraform configuration to create your resources:

   ```bash
   terraform apply
   ```

   Confirm the deployment by typing `yes` when prompted. The provisioning process may take several minutes, depending on your infrastructure size.

#### Cleaning Up

To delete all resources created with Terraform, you can use the following command to destroy your infrastructure:

```bash
terraform destroy
```

When prompted, type `yes` to confirm the destruction. Be cautious, as this action is irreversible and will delete all resources created by this Terraform plan.

## Ansible deployment

1. Add IP addresses of your VMs to the inventory file

2. Review nginx.yml and modify per your enviornemt, such as webpage git repo and webserver service

3. Run your ansible playbook(Update your username and key)

   ```bash
   ansible-playbook -i inventory -u ubuntu --private-key=~/creds/RedKeys.pem nginx.yml
   ```
Step 3: Verify configuration by opening web browser and going to the public IP address of one of the instances, load balancer dns name, and hostedzone records. My webpage test webpage should appear on all three.

## Conclusion
You've successfully set up an Auto Scaling Group (ASG) using Terraform and configured the webservers using Ansible. This walkthrough provides a basic example, and you can expand on this foundation to deploy more complex applications or configurations.

Feel free to explore additional Ansible modules and playbook features to further customize and enhance your configuration management.

For more details and advanced use cases, refer to the official documentation for Terraform and Ansible.

## Contributions

Contributions to this project are welcome! If you find any issues or have suggestions for improvement, please open an issue or submit a pull request. Feel free to reach out to me directly on [LinkedIn](https://www.linkedin.com/in/desire-banyeretse/).

## License

This project is licensed under the [MIT License](LICENSE). Feel free to modify and distribute it as needed.

