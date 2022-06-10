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
# Setup docker builder
docker buildx create --name mybuilder --driver-opt network=host --use

# Build docker image (multi-arch version)
docker buildx build \
    --push \
    --tag nanomathias/python-backend-environment:release-1.0.9 \
    --platform linux/amd64,linux/arm64 .
```
