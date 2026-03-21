resource "random_uuid7" "this" {}

resource "aws_batch_job_definition" "this" {
  name = "${random_uuid7.this.result}-rg"
  type = "container"

  container_properties = jsonencode({
    image   = "busybox"
    command = ["echo", "hello"]
    resourceRequirements = [
      { type = "VCPU", value = "0.25" },
      { type = "MEMORY", value = "512" }
    ]
  })
}
