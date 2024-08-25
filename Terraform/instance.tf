# create a instnace template
resource "google_compute_instance_template" "default" {
  name        = "instance-template1"
  region = "asia-south1"
  description = "This template is used to create a three-tierapp instances."
  machine_type = "e2-medium"
  tags           = ["http-server", "https-server", "lb-health-check"]
disk {
    source_image      = "debian-cloud/debian-11"
    auto_delete       = true
    boot              = true
  }

   network_interface {
    network = "default"
    access_config {}

  }

metadata = {
      startup-script = local.startup_script_content # this is where startup script file is passed.
    }
}

#To send the startup script file from local machine to terraform
locals {
  startup_script_path = "/workspaces/terraform-zero-to-hero/three-tier/startup-script.sh"
  startup_script_content = file(local.startup_script_path)
}

#creating a managed instance group
resource "google_compute_region_instance_group_manager" "default" {
  name = "appserver"

  base_instance_name         = "app"
  region                     = "asia-south1"
  distribution_policy_zones  = ["asia-south1-a", "asia-south1-b"]

  named_port {
    name = "http"
    port = 8080
  }
  
  version {
    instance_template = google_compute_instance_template.default.id
    name              = "primary"
  }

   

}

#creating autoscaling for the managed instance group
resource "google_compute_region_autoscaler" "autoscaler" {
  name = "autoscaling-group-1"
  target = google_compute_region_instance_group_manager.default.id
  autoscaling_policy {
    min_replicas    = 2
    max_replicas    = 3
    cooldown_period = 60

    cpu_utilization {
      target = 0.5
    }
  }
}

