data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] # Canonical
}

resource "aws_subnet" "public" {
  vpc_id = aws_vpc.main.id
  #cidr_block        = "172.16.10.0/24"
  cidr_block        = "10.0.1.0/24"
  availability_zone = "us-east-1a"

  map_public_ip_on_launch = true

  tags = {
    Name = "lab01-public-subnet"
  }
}


### Make a network adapter for our machine

resource "aws_network_interface" "primary" {
  subnet_id = aws_subnet.public.id

  tags = {
    Name = "primary_network_interface"
  }
}


resource "aws_instance" "web" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = "t3.micro"

  tags = {
    Name = "HelloWorld"
  }
}
