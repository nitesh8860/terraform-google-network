# Terraform Google Network Modules

This repository provides Terraform modules for creating Virtual Private Cloud (VPC) networks on Google Cloud Platform (GCP) following best practices.

## Modules Included

This repository includes the following Terraform modules:

- **vpc**: Creates a VPC network with specified subnets and firewall rules.

- **subnets**: Manages subnets within a VPC, including IP range allocation.

- **firewall-rules**: Defines firewall rules for controlling network traffic.

## Usage

To use these Terraform modules for setting up your GCP network infrastructure, follow these steps:

1. Clone the Repository:

   ```shell
   git clone https://github.com/your-username/terraform-google-network.git
   cd terraform-google-network
   ```

2. Create a Terraform Configuration File:

   Create a `.tf` configuration file and define the necessary variables for your network setup.

3. Initialize and Apply Terraform:

   Run the following commands to initialize and apply the Terraform configuration:

   ```shell
   terraform init
   terraform apply
   ```

4. Review and Confirm Changes:

   Terraform will generate a plan for your network infrastructure. Review the plan and confirm by typing `yes` when prompted.

5. Provision Your Network:

   Terraform will provision the specified VPC network, subnets, and firewall rules according to your configuration.

6. Enjoy Your GCP Network:

   Your Google Cloud Platform VPC network is now set up following best practices.

## Contributing

Contributions to this repository are welcome! If you have additional Terraform modules or improvements to existing modules, please create a pull request.

## License

This project is open-source and available under the [MIT License](LICENSE). You are free to use and modify the Terraform modules as needed for your GCP network infrastructure.

Enjoy building robust VPC networks on Google Cloud Platform with Terraform!
