# Semaphore CI 2.0

## Requirements:

- Install [Semaphore CLI](https://docs.semaphoreci.com/reference/sem-command-line-tool/)

## Setup the CI

### Secrets

Setup the following secrets in order to run the pipeline:

Secret name: `reportedly_api`

- DOCKER_HUB_USERNAME
- DOCKER_HUB_TOKEN
- HEROKU_API_KEY

### Deployment dashboard

After the project is created on Semaphore CI (on first push),
use the sem CLI to create the deployment dashboard.

```
# Get the project id
> sem get project reportedly_api

# Create the deployment dashboard
> sem create dashboard reportedly_api
> sem edit dashboard reportedly_api
```

Configure the widgets to show the deployment pipelines

```
spec:
  widgets:
  - name: Production
    type: list_pipelines
    filters:
      pipeline_file: .semaphore/promotion-production.yml
      project_id: <project_id>
  - name: Staging
    type: list_pipelines
    filters:
      pipeline_file: .semaphore/promotion-staging.yml
      project_id: <project_id>
```
