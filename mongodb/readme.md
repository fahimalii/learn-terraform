# How to run

First ensure you have `terraform` installed in your machine and the path is set properly to the executable. [Install Terraform](https://developer.hashicorp.com/terraform/tutorials/docker-get-started/install-cli)

Then ensure that you are in the `mongodb` folder in your terminal and run the following commands.

```bash
terraform init
```

```bash
terraform apply
```

Verify containers are running with

```bash
docker ps
```

Connect to one of the containers

```bash
docker exec -it mongo6 bin/bash
```

> In the above command `mongo6` is the name of the container.

Execute the following command to connect to the database

```bash
mongosh
```

Execute the following command to run the replica set

> **NOTE**: Please make sure to change the `ip` from `192.168.0.240` to your `host machine` ip address. Also be sure to change the ports as well if the external ports are changed in the `main.tf` file.

```bash
rs.initiate({
    "_id" : "rs0",
    "members" :
    [
        {
            "_id" : 0,
            "host" : "192.168.0.240:27031"
        },
        {
            "_id" : 1,
            "host" : "192.168.0.240:27032"
        },
        {
            "_id" : 2,
            "host" : "192.168.0.240:27033"
        }
    ]
})
```

Check `replica set status` with following

```bash
rs.status()
```

## Some extra information

In the `replica set` initialize command `_id: rs0`, here `rs0` refers to the `--replSet` we passed in the `entrypoint` of the containers in `main.tf` file.

## TODO

- How to move the `rs.initialize` to a `mongo initialize` container and execute command from there instead of manual process.
