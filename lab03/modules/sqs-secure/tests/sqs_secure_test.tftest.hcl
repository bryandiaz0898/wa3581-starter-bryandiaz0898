variables {
  queue_name_prefix = "lab03-test-defaults"
  # enable_dlq defaults to true in the module
  # tags defaults to {} in the module
}


run "plan_default_settings" {
  command = plan
  # No assert needed; success means plan executes without errors
}

run "apply_and_check_outputs" {
  command = apply

  assert {
    condition     = output.main_queue_arn != null && substr(output.main_queue_arn, 0, 12) == "arn:aws:sqs:"
    error_message = "Main queue ARN should be a valid SQS ARN."
  }
  assert {
    condition     = output.kms_key_arn != null && substr(output.kms_key_arn, 0, 12) == "arn:aws:kms:"
    error_message = "KMS key ARN should be a valid KMS ARN."
  }
  assert {
    # DLQ is enabled by default, so its ARN should be present
    condition     = output.dlq_arn != null && substr(output.dlq_arn, 0, 12) == "arn:aws:sqs:"
    error_message = "DLQ ARN should be a valid SQS ARN when DLQ is enabled."
  }
}

run "apply_dlq_disabled" {
  command = apply
  variables {
    queue_name_prefix = "lab03-test-no-dlq"
    enable_dlq        = false
  }
  assert {
    condition     = length(aws_sqs_queue.dlq) == 0
    error_message = "DLQ should be an empty list when enable_dlq is false"
  }
  assert {
    condition     = output.dlq_arn == null
    error_message = "DLQ ARN output should be null when enable_dlq is false"
  }
  assert {
    condition     = aws_sqs_queue.main.name == "lab03-test-no-dlq"
    error_message = "Main queue should be created with correct name"
  }
  assert {
    condition     = aws_kms_key.sqs_key.arn != null
    error_message = "KMS key should be created"
  }
}

run "fail_on_empty_prefix" {
  variables {
    queue_name_prefix = ""
  }
  command = plan

  expect_failures = [
    var.queue_name_prefix
  ]
}