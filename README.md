# modemuze-pipeline

## Install
Clone the repository and build the Docker image.
```
$ git clone https://github.com/netwerk-digitaal-erfgoed/modemuze-pipeline.git
$ docker-compose build mapper
```

## Preparation
Copy the CSV data into [sources](./sources) directory. 

When an adequate mapping definiton for the CSV doesn't exist yet create one in the based on the existing mapping files in the [mappings](./mappings) directory. 

*Note:* The reference to the (new) source file is done through the RML file. 


## Run
Start the conversion with the following command:
```
$ docker-compose up
```

Adjust the SPARQL construct query in order to get desired semantic output format. See the [toSchema.rq](./mappings/toSchema.rq) query for more detail on the mapping. 