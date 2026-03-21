data "aws_dms_replication_subnet_group" "this" {
  replication_subnet_group_id = var.replication_subnet_group_id
}
