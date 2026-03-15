output "dynamodb_table_endpoint" {
  value = aws_dynamodb_table.example_table.table_stream_arn
}

output "dynamodb_table_name" {
  value = aws_dynamodb_table.example_table.name
}