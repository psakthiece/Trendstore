provider "aws" {
  region = "us-east-1"
}

# Use a public key file stored in your Terraform project directory
resource "aws_key_pair" "my_key" {
  key_name   = "my-key"
  public_key = file("${path.module}/mykey.pub")   # place mykey.pub in same folder as main.tf
}

resource "aws_instance" "my_ec2" {
  ami           = "ami-0c3389a4fa5bddaad" # Amazon Linux 2 AMI (check region-specific AMI)
  instance_type = "t3.small"
  key_name      = aws_key_pair.my_key.key_name

  tags = {
    Name = "Jenkinsserver"
  }
}

# Output the public IP so you can connect easily
output "ec2_public_ip" {
  value = aws_instance.my_ec2.public_ip
}
