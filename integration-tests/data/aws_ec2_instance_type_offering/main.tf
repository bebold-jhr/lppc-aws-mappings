data "aws_ec2_instance_type_offering" "this" {
  filter {
    name   = "instance-type"
    values = ["t2.micro"]
  }
  location_type = "region"
}
