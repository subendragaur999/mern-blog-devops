resource "aws_ecr_repository" "blog_client" {
  name                 = "blog-client"
  image_tag_mutability = "IMMUTABLE"
  force_delete         = false

  image_scanning_configuration {
    scan_on_push = true
  }

  encryption_configuration {
    encryption_type = "AES256"
  }

  tags = {
    Name      = "blog-client"
    Component = "frontend"
  }
}

resource "aws_ecr_repository" "blog_server" {
  name                 = "blog-server"
  image_tag_mutability = "IMMUTABLE"
  force_delete         = false

  image_scanning_configuration {
    scan_on_push = true
  }

  encryption_configuration {
    encryption_type = "AES256"
  }

  tags = {
    Name      = "blog-server"
    Component = "backend"
  }
}
