data "aws_ami" "ubuntu_ami" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] 
}

resource "aws_security_group" "allow_ssh" {
  name        = "allow-ssh"
  description = "Allow SSH access"
  vpc_id      = aws_vpc.vpc_main.id 

  ingress {
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
    Name = "allow-ssh-sg"
  }
}

resource "aws_instance" "eks_worker" {
  ami           = data.aws_ami.ubuntu_ami.id  
  instance_type = "t2.micro"
  key_name      = "aws-key"  

  vpc_security_group_ids = [aws_security_group.allow_ssh.id] 

  subnet_id = aws_subnet.subnet_1.id 

  tags = {
    Name = "EKS-Worker-Node"
  }

  associate_public_ip_address = true
}

resource "aws_eks_cluster" "EKS_example" {
  name     = "EKS-Cluster"
  role_arn = aws_iam_role.eks_role.arn
  
  vpc_config {
    subnet_ids = [
      aws_subnet.subnet_1.id,
      aws_subnet.subnet_2.id
    ]
  }

  depends_on = [
    aws_iam_role.eks_role,
    aws_security_group.allow_ssh  
  ]
}

resource "aws_iam_role" "eks_role" {
  name = "eks-role"
  
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action    = "sts:AssumeRole"
        Principal = {
          Service = "eks.amazonaws.com"
        }
        Effect    = "Allow"
        Sid       = ""
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "eks_role_policy" {
  role       = aws_iam_role.eks_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
}

resource "aws_iam_role_policy_attachment" "eks_worker_policy" {
  role       = aws_iam_role.eks_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
}
