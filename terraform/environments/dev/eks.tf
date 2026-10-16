resource "aws_eks_cluster" "main" {
  name     = "mern-blog-eks"
  role_arn = aws_iam_role.eks_cluster.arn

  version = "1.36"
  # Verify the Kubernetes version is supported in ap-south-1
  # before setting version explicitly.

  vpc_config {
    subnet_ids = [
      for subnet in aws_subnet.private : subnet.id
    ]

    endpoint_private_access = true
    endpoint_public_access  = true

    public_access_cidrs = [
      "13.204.159.13/32"
    ]
  }

  access_config {
    authentication_mode                         = "API_AND_CONFIG_MAP"
    bootstrap_cluster_creator_admin_permissions = true
  }

  depends_on = [
    aws_iam_role_policy_attachment.eks_cluster
  ]

  tags = {
    Name = "mern-blog-eks"
  }
}

resource "aws_eks_node_group" "main" {
  cluster_name    = aws_eks_cluster.main.name
  node_group_name = "mern-blog-workers"
  node_role_arn   = aws_iam_role.eks_nodes.arn

  subnet_ids = [
    for subnet in aws_subnet.private : subnet.id
  ]

  instance_types = ["m7i-flex.large"]
  capacity_type  = "ON_DEMAND"
  disk_size      = 30

  scaling_config {
    desired_size = 2
    min_size     = 2
    max_size     = 3
  }

  update_config {
    max_unavailable = 1
  }

  depends_on = [
    aws_iam_role_policy_attachment.nodes_worker,
    aws_iam_role_policy_attachment.nodes_ecr,
    aws_iam_role_policy_attachment.nodes_cni
  ]

  tags = {
    Name = "mern-blog-workers"
  }
}
