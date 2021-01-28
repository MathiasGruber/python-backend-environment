# python-backend-image

Docker image for python backend image to be used on Azure App Service deployements of e.g. Django, Flask, etc.

# Use in docker-compose

Typically I use this image in docker-compose as follows

With the `Dockerfile` as follows:

```dockerfile
# Note: You can use any Debian/Ubuntu based image you want.
FROM nanomathias/python-backend-environment

# [Optional] Uncomment this section to install additional OS packages.
# RUN apt-get update && apt-get -y install --no-install-recommends <your-package-list-here>
```

# Build locally

```bash
# Build docker image
docker build --tag python-backend-environment .
```
