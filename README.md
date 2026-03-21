# lppc-aws-mappings

This repository provides mapping files for [lppc](https://github.com/bebold-jhr/lppc). Always use [mapping-creator](https://github.com/bebold-jhr/lppc/tree/main/mapping-creator) to create new mappings.

Coverage:

|Block type|source|mappings| test checked |
|-|-|-|-|
|action|10|10|0|
|data|645|392|276|
|ephemeral|10|0|0|
|resource|1621|23|23|

## General mapping info

+ Block types for creating resources normally contain any read permission with wildcards (example: `List*`, `Get*`, `Describe*`) which merge perfectly with data blocks and create smaller policies
  + An exception are `organizations` and `account`, because they contain sensitive data
+ Block types for creating resources contain tagging permissions and additionally the permission necessary to create, update and delete the respective resource
  + Tagging permissions are not listed under the `conditional` key, because it is possible to set tag directly in the provider via `default_Tags`
+ Mappings are validated by integration tests if possible. Not every type can have an integration tests. Here some reasons (not an exhaustive list):
  + Cost
  + EOL service
  + Difficult setup (e.g. configs that can only be done once per organization).
  + Resources take a long time to delete (organization account)

## Repository structure

+ `integration-tests/` contains integration-test for the mappings.
  + `{BOCK_TYPE}/{TYPE}/` general structure for subdirectories. Example: `resource/aws_vpc` contains the integration test for the VPC resource.
  + `modules/` contains helper submodules.
    + `deployer-role/` helper submodule which creates the deployer roles based in the permissions of the respective mapping YAML
    + `{BOCK_TYPE}/{TYPE}/` helper submodules which are necessary to create a environment. Example: `data/aws_s3_bucket` creates a bucket so that the integration test in `integration-tests/data/aws_s3_bucket` can successfully fetch a bucket. Otherwise, the test would fail. 
+ `mappings/` contains the YAML files used by [lppc](https://github.com/bebold-jhr/lppc)
+ `sources/` contains data necessary for [mapping-creator](https://github.com/bebold-jhr/lppc/tree/main/mapping-creator)

## Test types

Here are some different test setups with examples for reference.

+ **Default:** Creates a resource or fetches a resource using the dynamically created deployer role. Examples: `resource/aws_vpc`, `data/aws_regions`
+ **Test with setup:** Before running the test a test setup has to be created using an independent role (`LppcTestSetupCreator`). Examples: `data/aws_iam_account_alias`, `data/aws_s3_bucket`
+ **Organization context:** Requires a dedicated role in the management account. Naming convention `lppc/{BLOCK_TYPE}{TYPE}` in PascalCase. Examples: `data/aws_organizations_organization`, `data/aws_organizations_delegated_services`
+ **Account context:** Requires a dedicated role in the management account, because the integration test account is not a delegated admin. Naming convention `lppc/{BLOCK_TYPE}{TYPE}` in PascalCase. Examples: `resource/aws_account_region`