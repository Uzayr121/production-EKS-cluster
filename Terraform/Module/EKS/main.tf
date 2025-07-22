module "eks" {
  source = "terraform-aws-modules/eks/aws"

  cluster_name = var.cluster_name
  cluster_version = 1.29 
 
  vpc_id = var.vpc_id
  subnet_ids = [var.private_subnet_id_1, var.private_subnet_id_2, var.private_subnet_id_3]
  control_plane_subnet_ids = [var.public_subnet_id_1, var.public_subnet_id_2, var.public_subnet_id_3]
 
  cluster_endpoint_public_access = true
  cluster_endpoint_public_access_cidrs = ["0.0.0.0/0"]
  enable_irsa = true
  enable_cluster_creator_admin_permissions = true

 eks_managed_node_group_defaults = {
    disk_size = 50
    instance_type = "t3a.large, t3.large"
 } 
 eks_managed_node_groups = {
    default = {
      desired_size = 3
      max_size     = 4
      min_size     = 1
    }
 }

 tags = var.tags
 
}