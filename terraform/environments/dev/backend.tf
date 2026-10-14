terraform {
  backend "s3" {
    bucket = "mern-blog-terraform-state-subendra-2026"
    key    = "env/dev/terraform.tfstate"
    region = "ap-south-1"
  }
}
