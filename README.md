# datascience-docker

## What is this

- Docker image for datascience tasks

## What you can do with this Docker image

This image includes

### Jupyter environment

- jupyter notebook
- jupyter lab

### Machine Learning libraries

- scikit-learn
- LightGBM
- PyTorch
- Tensorflow
- XGBoost
- CatBoost

### Python linting libraries

- flake8
- isort
- black
- mypy

### Visualizing libraries

- matplotlib
- plotly
- seaborn
- bokeh

### Natural Language Processing (NLP) Libraries

- MeCab
- Juman++
- BERT For Japanese (Refer to [BERT日本語Pretrainedモデル(黒橋・河原研究室)](http://nlp.ist.i.kyoto-u.ac.jp/index.php?BERT%E6%97%A5%E6%9C%AC%E8%AA%9EPretrained%E3%83%A2%E3%83%87%E3%83%AB))

## How to build

```bash
sh build.sh
```

## How to use

Pull the docker image from [DockerHub](https://hub.docker.com/repository/docker/youodf/datascience)

```bash
docker pull youodf/datascience
```

## Run the docker image with command

```bash
docker run youodf/datascience COMMAND
```

### Example

JupyterLab

```bash
docker run youodf/datascience jupyter lab --ip='0.0.0.0' --allow-root --no-browser
```

Jupyter Notebook

```bash
docker run youodf/datascience jupyter notebook --ip='0.0.0.0' --allow-root --no-browser
```

Python scripts

```bash
docker run youodf/datascience python xxx.py
```
