module "hello_world" {
  source = "../../../../modules/cloud-function/"

  name                    = "hello-world"
  runtime                 = "python312"
  project                 = local.project
  region                  = local.region
  create_dedicated_bucket = true
  bucket_name             = "nflp-hello-world-01"
}
