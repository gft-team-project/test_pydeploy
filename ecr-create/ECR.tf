resource "aws_ecr_repository" "ecrrepo" {
  name                 = "Pyflaskrepo"
  image_tag_mutability = "MUTABLE"

  image_scanning_configuration {
    scan_on_push = true
  }
}
#data "aws_ecr_image" "ecrrepo" {
 # repository_name = "ecrrepo"
  #image_tag       = "latest"
#}
