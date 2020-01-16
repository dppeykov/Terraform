# GOAL: deploy a single web server in an EC2 Instance that responds to HTTP requests

# On Unix-like operating systems, the nohup command executes another command, and instructs the system to continue running it even if the session is disconnected.
# busybox - utility installed by default on all ubuntu servers that can fire up a web server and serve a file

resource "aws_instance" "example" {
  ami                    = "ami-0c55b159cbfafe1f0"
  instance_type          = "t2.micro"
  vpc_security_group_ids = [aws_security_group.instance.id] # the security group resource is exporting an ID

  user_data = <<-EOF
                #!/bin/bash
                echo "Hello, World" > index.html
                nohup busybox httpd -f -p 8080 &
                EOF
  tags = {
    Name = "terraform-example"
  }
}

# <<-EOF and EOF are Terraform’s heredoc syntaxwhich allows you to create multiline strings without having to insert newline characters all over the place

# By default AWS does not allow any incoming or outgoing traffic from an EC2 Instance - we need a security group to allow that
resource "aws_security_group" "instance" {
  name = "terraform-example-instance"

  ingress {
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# Just creating a security group is not enough - we need to tell the servet to use it by passing the ID of the security group into the vpc_security_group_ids argument of the aws_instance resource.
# resource attribute reference format: <PROVIDER>_<TYPE>.<NAME>.<ATTRIBUTE>
######################################################################################
