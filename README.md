# kaggle-python-docker

## What is this

- Docker image for kaggle competitions

## How to build

```sh
docker-compose build
```

## How to use

Pull the docker image from [DockerHub](https://hub.docker.com/repository/docker/youodf/kaggle-python)

```sh
docker pull youodf/kaggle-python
```

## Run the docker image with command

```sh
docker run youodf/kaggle-python COMMAND
```

### Example

JupyterLab

```sh
docker run youodf/kaggle-python jupyter lab --ip='0.0.0.0' --allow-root
```

Python scripts

```sh
docker run youodf/kaggle-python python xxx.py
```
