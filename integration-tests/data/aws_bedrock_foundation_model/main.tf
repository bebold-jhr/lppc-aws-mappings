data "aws_bedrock_foundation_model" "this" {
  model_id = data.aws_bedrock_foundation_models.all.model_summaries[0].model_id
}
