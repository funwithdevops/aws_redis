variable "name" {
  type = string
}

variable "node_type" {
  type    = string
  default = "cache.t3.small" # We are going to use t3 because automatic failover is not available for t2 nodes
}

variable "subnet_ids" {
  type = list(string)
}

variable "port" {
  type    = number
  default = 6379
}

variable "vpc_id" {
  type = string
}

variable "num_of_nodes" {
  type    = number
  default = 2
}
