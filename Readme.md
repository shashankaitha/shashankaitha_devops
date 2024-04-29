# Techyz Demo README

## Prerequisites
Before getting started, ensure you have the following prerequisites installed and set up:
1. Terraform
2. AWS account with appropriate access permissions
3. S3 bucket and DynamoDB table created in your AWS account

## Setup

1. Clone the repository to your local machine:
    ```bash
    git clone https://github.com/shashankaitha/shashankaitha_devops.git
    ```

2. Update the backend configuration in the `infra/backend.tf` file with your S3 bucket and DynamoDB details:
    ```hcl
    backend "s3" {
        bucket         = "your-s3-bucket-name"
        key            = "infra_state.tfstate"
        region         = "your-aws-region"
        dynamodb_table = "your-dynamodb-table-name"
        encrypt        = true
    }
    ```

3. Navigate to the `infra` directory:
    ```bash
    cd shashankaitha_devops/infra
    ```

4. Initialize Terraform:
    ```bash
    terraform init
    ```

5. Apply the Terraform configuration:
    ```bash
    terraform apply --auto-approve
    ```

6. Access AWS console and log in. Ensure that EC2, Minikube, Docker, kubectl, and Terraform are installed.

7. Start Minikube:
    ```bash
    sudo su
    minikube start --force
    ```

8. Verify the Minikube control plane is in a ready state:
    ```bash
    kubectl get nodes
    ```

9. Move to the application directory:
    ```bash
    cd /home/ubuntu/shashankaitha_devops/application/k8s
    ```

10. Apply the Kubernetes manifest files:
    ```bash
    kubectl apply -f deployment.yaml
    kubectl apply -f hpa.yaml
    kubectl apply -f service.yaml
    ```

11. Validate the deployment:
    ```bash
    kubectl get all -A
    ```

12. Test the Horizontal Pod Autoscaler (HPA):
    - Fetch the URL of the service:
    ```bash
    minikube service <servicename> --url
    ```
    - Test the load using curl:
    ```bash
    while true; do curl <URL>:30000; done
    ```
    - Watch the HPA:
    ```bash
    watch kubectl get hpa
    ```

## Note
Make sure to replace `<servicename>` and `<URL>` with appropriate values.
