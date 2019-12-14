# kaggle-python-docker

## What is this

- Docker image for kaggle competitions

## How to build

```bash
sh build.sh
```

## How to push

```bash
docker-compose push
```

## How to use

Pull the docker image from [DockerHub](https://hub.docker.com/repository/docker/youodf/kaggle-python)

```bash
docker pull youodf/kaggle-python
```

## Run the docker image with command

```bash
docker run youodf/kaggle-python COMMAND
```

### Example

JupyterLab

```bash
docker run youodf/kaggle-python jupyter lab --ip='0.0.0.0' --allow-root
```

Python scripts

```bash
docker run youodf/kaggle-python python xxx.py
```
