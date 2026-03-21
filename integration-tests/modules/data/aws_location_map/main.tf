resource "random_uuid7" "this" {}

resource "aws_location_map" "this" {
  map_name = "${random_uuid7.this.result}-rg"

  configuration {
    style = "VectorHereBerlin"
  }
}
