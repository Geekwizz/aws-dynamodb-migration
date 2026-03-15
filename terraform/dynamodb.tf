resource "aws_dynamodb_table" "migration_table" {
  name         = "migration_table"
  billing_mode = "PAY_PER_REQUEST"
  attribute {
    name = "id"
    type = "S"
  }
  attribute {
    name = "created_at"
    type = "S"
  }
  global_secondary_index {
    name               = "gsi_created_at"
    hash_key           = "created_at"
    projection_type    = "ALL"
    read_capacity      = 5
    write_capacity     = 5
  }
  stream_enabled = true
  stream_view_type = "NEW_AND_OLD_IMAGES"
  ttl {
    attribute_name = "ttl"
    enabled        = true
  }
  point_in_time_recovery = true
}

resource "aws_dynamodb_table" "source_validation_table" {
  name         = "source_validation_table"
  billing_mode = "PAY_PER_REQUEST"
  attribute {
    name = "id"
    type = "S"
  }
  attribute {
    name = "source_id"
    type = "S"
  }
  global_secondary_index {
    name               = "gsi_source_id"
    hash_key           = "source_id"
    projection_type    = "ALL"
    read_capacity      = 5
    write_capacity     = 5
  }
  stream_enabled = true
  stream_view_type = "NEW_AND_OLD_IMAGES"
  ttl {
    attribute_name = "ttl"
    enabled        = true
  }
  point_in_time_recovery = true
}