# toolkit

Docker container mirror of my dev environment.

It contains my `zsh` and `vim` setup as well as some day to day used cli tools.

### How to run

```
docker run -it --rm -v /var/run/docker.sock:/var/run/docker.sock --name toolkit dnpetrovv/toolkit
```

#### Run in Current Working Directory

```
docker run -it --rm -v /var/run/docker.sock:/var/run/docker.sock -v ${PWD}:/root/wd --name toolkit dnpetrovv/toolkit
```
This will run the container and mount the current working directory under `/root/wd` `(~/wd)` inside the container. This way you can make any changes to your local file system form inside the container.
