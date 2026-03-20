data "aws_bedrock_inference_profiles" "all" {}

data "aws_bedrock_inference_profile" "this" {
  inference_profile_id = data.aws_bedrock_inference_profiles.all.inference_profile_summaries[0].inference_profile_id
}
