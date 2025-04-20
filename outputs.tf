# outputs.tf (root)

output "aurora_cluster_endpoint" {
  value = module.aurora.cluster_endpoint
}

output "aurora_reader_endpoint" {
  value = module.aurora.reader_endpoint
}
