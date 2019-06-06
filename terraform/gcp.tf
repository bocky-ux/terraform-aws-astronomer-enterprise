module "astronomer" {
  source  = "astronomer/astronomer/kubernetes"
  version = "0.0.1"
  admin_email = "${var.email}"
  base_domain = "${module.astronomer_gcp.base_domain}"
  db_connection_string = "${module.astronomer_gcp.db_connection_string}"
  tls_cert = "${module.astronomer_gcp.tls_cert}"
  tls_key = "${module.astronomer_gcp.tls_key}"
}

module "astronomer_gcp" {
  source  = "astronomer/astronomer-gcp/google"
  version = "0.1.3"
  bastion_admin_emails = ["${var.email}"]
  bastion_user_emails = ["${var.email}"]
  deployment_id = "${var.deployment_id}"
  dns_managed_zone = "${var.dns_managed_zone}"
  proxy_port = "${var.proxy_port}"
  project = "${var.project}"
}

resource "local_file" "kubeconfig" {
  sensitive_content = "${module.astronomer_gcp.kubeconfig}"
  filename = "${path.module}/kubeconfig"
}
