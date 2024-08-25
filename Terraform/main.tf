#creating a mysql instance

resource "google_sql_database_instance" "instance" {
    name = "mysql-database"
    region = "asia-south1"
    database_version = "MYSQL_8_0"
    root_password = "abcABC123!"
    
    settings {
    tier = "db-f1-micro"
#allowing only the authorized networks
ip_configuration {
      authorized_networks {
        name            = "default network"
        value           = "0.0.0.0/0"
        expiration_time = "3021-11-15T16:19:00.094Z"
      }
      ipv4_enabled = true

    }


     }

deletion_protection=false

}

#creating a mysql database
resource "google_sql_database" "database" {
  name     = "appdb"
  instance = google_sql_database_instance.instance.name
}

#creating a user other than root user
resource "google_sql_user" "users" {
  name     = "appuser"
  instance = google_sql_database_instance.instance.name
  password = "abcd"
}

#this will output the public IPaddress of the sql instance
output "public_ip_address" {
    description = "The public IPv4 address of the master instance."
    value       = google_sql_database_instance.instance.public_ip_address
  
}
