terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = ">= 2.13.0"
    }
  }
}

provider "docker" {
  host = "npipe:////.//pipe//docker_engine"
}

resource "docker_network" "mongo_cluster_network" {
  name = "mongo_cluster_2"
}

# get the mongo docker image
resource "docker_image" "mongo" {
  name         = "mongo:latest"
  keep_locally = true
}

# start a container and expose the 27031 port
resource "docker_container" "mongo4" {
  name  = "mongo4"
  image = docker_image.mongo.name
  ports {
    internal = 27017
    external = 27031
  }
  entrypoint = [ "/usr/bin/mongod", "--bind_ip_all", "--replSet", "rs0" ]
  network_mode = "bridge"
  networks_advanced {
    name = docker_network.mongo_cluster_network.name
  }
}

resource "docker_container" "mongo5" {
  name  = "mongo5"
  image = docker_image.mongo.name
  ports {
    internal = 27017
    external = 27032
  }
  entrypoint = [ "/usr/bin/mongod", "--bind_ip_all", "--replSet", "rs0" ]
  network_mode = "bridge"
  networks_advanced {
    name = docker_network.mongo_cluster_network.name
  }
}

resource "docker_container" "mongo6" {
  name  = "mongo6"
  image = docker_image.mongo.name
  ports {
    internal = 27017
    external = 27033
  }
  entrypoint = [ "/usr/bin/mongod", "--bind_ip_all", "--replSet", "rs0" ]
  network_mode = "bridge"
  networks_advanced {
    name = docker_network.mongo_cluster_network.name
  }
}