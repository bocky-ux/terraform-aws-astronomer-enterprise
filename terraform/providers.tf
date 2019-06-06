provider "google" {
  version = "~> 2.7"
  region  = "${var.region}"
  project = "${var.project}"
  zone    = "${var.zone}"
}

provider "google-beta" {
  version = "~> 2.7"
  region  = "${var.region}"
  project = "${var.project}"
  zone    = "${var.zone}"
}

provider "acme" {
  version = "~> 1.3"
  server_url = "${var.acme_server}"
}

provider "random" {
  version = "~> 2.1"
}

provider "tls" {
  version = "~> 2.0"
}

provider "kubernetes" {
  config_path = "${local_file.kubeconfig.filename}"
  load_config_file = true
}

provider "helm" {
  service_account = "tiller"
  debug           = true
  kubernetes {
    config_path = "${local_file.kubeconfig.filename}"
    load_config_file = true
  }
}


