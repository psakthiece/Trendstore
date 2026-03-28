provider "aws" {
  region = "us-east-1"
}

# Generate a new key pair from your local public key
resource "aws_key_pair" "my_key" {
  key_name   = "my-key"
  public_key = file("~/.ssh/id_rsa.pub")   # path to your public key
}

# Create EC2 instance
resource "aws_instance" "my_ec2" {
  ami           = "ami-0c3389a4fa5bddaad" # Example Amazon Linux 2 AMI
  instance_type = "t3.small"
  key_name      = aws_key_pair.my_key.key_name

  tags = {
    Name = "Jenkinsserver"
  }
}

