output main_queue_arn {
  value       = aws_sqs_queue.main.arn
  sensitive   = true
  description = "The ARN of the main SQS queue."
}

output main_queue_url {
  value       = aws_sqs_queue.main.id
  description = "The URL of the main SQS queue."
}

output dlq_arn {
  value       = try(aws_sqs_queue.dlq[0].arn, null)
  description = "The ARN of the Dead Letter Queue (DLQ), if created."
}

output kms_key_arn {
  value       = aws_kms_key.sqs_key.arn
  description = "The ARN of the KMS key used for queue encryption."
}


