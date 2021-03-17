# Getting Started
Set the value of project_name in the pyproject.toml file and the value of PROJECT_NAME in the .env file to the name of your project.
Both of these should usually be the same as the name of the root directory of your project.

# Useage

## Launch jupyter notebook and mlflow

When you start the docker container with the following command, Jupyter Notebook will be accessible on port 8888 and mlflow on port 5000.

```
$ docker-compose up -d
```

## Run kedro run

```
$ kedro docker run --docker-args "-v ${PWD}:/home/kedro"
```
