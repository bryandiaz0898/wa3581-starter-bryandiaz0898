variable queue_name_prefix {
  type        = string
  default     = "app-prod"
  description = "A string for the beginning of the queue names"
  validation {
    condition     = length(var.queue_name_prefix) > 0
    error_message = "The queue_name_prefix must not be empty."
  }
}

variable enable_dlq {
  type        = bool
  default     = true
  description = "A boolean flag to control whether the Dead Letter Queue is created."
}

variable tags {
  type        = map(string)
  description = "A map of tags to apply to the SQS queues and KMS key."
}
