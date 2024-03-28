# git-autopull

A minimalistic docker image that pulls specified git repositories every hour for backup purposes

## Usage

1. Create the following `docker-compose.yml` file and mofify it if you wish to make modifications:

```yaml
version: "3.8"

services:

  git-autopull:
    container_name: git-autopull
    image: elasticrock/git-autopull:latest
    volumes: 
      - /path/to/dir:/git-autopull
    deploy:
      restart_policy:
        condition: unless-stopped
```
2. Add a file `repo_urls.txt` with the git repos to pull to the root of the folder that is going to be mounted
3. Run `docker compose up -d` to download the image and start it
