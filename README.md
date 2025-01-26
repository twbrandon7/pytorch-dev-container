# PyTorch Dev-container
A Reusable PyTorch Dev Container Template

## Goal
Building multiple containers for different projects can be a hassle. In addition, it
might consume a lot of disk space due to the duplication of the same dependencies across
multiple projects' images.

This repository aims to provide a off-the-shelf dev container template for PyTorch
projects, while preserving the flexibility to customize the environment for different
projects.

## Features
- Includes PyTorch and its derivatives (e.g. torchvision, torchaudio)
- Uses globally installed PyTorch in virtual environment to save disk space
- Automatically setup virtual environment after container creation
- Uses poetry for dependency management

## Usage
1. Clone this repository:
    ```bash
    git clone https://github.com/twbrandon7/pytorch-dev-container.git
    ```

2. Open Visual Studio Code in the cloned directory:
    ```bash
    code pytorch-dev-container
    ```

3. Use short cut `Ctrl+Shift+P` to open the command palette, and select
`Dev Containers: Rebuild and Reopen in Container`

4. After the container is opened, you can add dependencies by running:
    ```bash
    poetry add matplotlib
    ```

    Note that PyTorch and its derivatives are already installed in the container image.
    You don't need to add them again.

## Customization
By default, the container image `twbrandon7/pytorch-dev-container` is used. However, you
can customize the image by modifying the `Dockerfile` in the `containers` directory to
add your desired dependencies.

For example, if `transformers` is the common dependency across all your projects, you
can add the following line above the `USER jupyter` section in the `Dockerfile`:
```Dockerfile
# ...

# Install desired dependencies before switching to jupyter user
RUN pip install transformers

USER jupyter
ENV PIP_TARGET=/home/jupyter/.site-packages
```

After modifying the `Dockerfile`, you can modify the parameters of the build command in
`containers/build.sh`:
```bash
USERNAME="your-name"
IMAGE_NAME="pytorch-dev-container"
TAG="torch-2.5.1-cu124-py3.11"
```

Then, you can build the container image by running:
```bash
bash ./containers/build.sh
```

Once the image is built, you can push it to Docker Hub by running:
```bash
docker push your-name/pytorch-dev-container:torch-2.5.1-cu124-py3.11
```

Finally, update the `docker-compose.yml` file in the `.devcontainer` directory to use the new image:
```yaml
services:
  workspace:
    image: your-name/pytorch-dev-container:torch-2.5.1-cu124-py3.11
    # ...existing code...
```

It is encouraged to use the same container image across all your projects to save disk
space.

### Add volumes
If you want to add volumes to the container to persist the content in some directories,
you can add the following lines to the `docker-compose.yml` file:
```yaml
services:
  workspace:
    # ...existing code...
    volumes:
      - /path/to/host/directory:/path/to/container/directory
      - named-volume:/path/to/container/directory

# ...existing code...

volumes:
  named-volume:
```
