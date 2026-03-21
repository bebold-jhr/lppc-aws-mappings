data "aws_dx_locations" "all" {}

data "aws_dx_location" "this" {
  location_code = sort(data.aws_dx_locations.all.location_codes)[0]
}
