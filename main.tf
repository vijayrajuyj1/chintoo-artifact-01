provider "aws" {
  region = "us-east-1"
}

# Create a new VPC
resource "aws_vpc" "myvpc" {
  cidr_block = "10.0.0.0/16"

  tags = {
    Name = "My-New-VPC"
  }
}

# Create public and private subnets
resource "aws_subnet" "sub1" {
  vpc_id                  = aws_vpc.myvpc.id
  availability_zone       = "us-east-1a"
  cidr_block              = "10.0.1.0/24"
  map_public_ip_on_launch = true

  tags = {
    Name = "Public-Subnet"
  }
}

resource "aws_subnet" "sub2" {
  vpc_id            = aws_vpc.myvpc.id
  availability_zone = "us-east-1b"
  cidr_block        = "10.0.2.0/24"

  tags = {
    Name = "Private-Subnet"
  }
}

# Create an Internet Gateway for public access
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.myvpc.id

  tags = {
    Name = "My-IGW"
  }
}

# Create a Route Table for public access
resource "aws_route_table" "RT" {
  vpc_id = aws_vpc.myvpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    Name = "Public-Route-Table"
  }
}

# Associate the public subnet with the route table
resource "aws_route_table_association" "rta1" {
  subnet_id      = aws_subnet.sub1.id
  route_table_id = aws_route_table.RT.id
}

# Create a security group for the EC2 instances
resource "aws_security_group" "webSg" {
  name   = "web-sg"
  vpc_id = aws_vpc.myvpc.id  # Ensure SG is in the correct VPC

  ingress {
    description = "Allow HTTP"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "Allow SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "Web-Security-Group"
  }
}

# Create an S3 bucket
resource "aws_s3_bucket" "bucket" {
  bucket = "vijay-980-oi"
}

# Create a public EC2 instance in the public subnet
resource "aws_instance" "web1" {
  ami                    = "ami-084568db4383264d4"  # Ensure this AMI exists in us-east-1
  instance_type          = "t2.micro"
  vpc_security_group_ids = [aws_security_group.webSg.id]
  subnet_id              = aws_subnet.sub1.id

  tags = {
    Name = "Public-EC2"
  }
}

# Create a private EC2 instance in the private subnet
resource "aws_instance" "web2" {
  ami                    = "ami-084568db4383264d4"
  instance_type          = "t2.micro"
  vpc_security_group_ids = [aws_security_group.webSg.id]
  subnet_id              = aws_subnet.sub2.id

  tags = {
    Name = "Private-EC2"
  }
}
