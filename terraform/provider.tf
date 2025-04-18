terraform {
    required_providers {
        aws = {
            source  = "hashicorp/aws"
            version = "~> 5.0"
        }
    }
    
    required_version = ">= 1.0.0"
}

provider "aws" {
    region     = "us-east-1"
    access_key = "AKIA47CRYMJCPD7SJFYC"    
    secret_key = "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" 
}
