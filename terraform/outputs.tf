
output "eks_worker_ip" {
  value = aws_instance.eks_worker.public_ip
}