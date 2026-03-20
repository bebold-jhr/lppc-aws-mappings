data "aws_sfn_state_machine" "this" {
  name = var.state_machine_name
}
