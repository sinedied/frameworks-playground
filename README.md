# 🛝 frameworks-playground

[![Build Status](https://github.com/sinedied/frameworks-playground/workflows/build/badge.svg)](https://github.com/sinedied/frameworks-playground/actions)
[![License](https://img.shields.io/badge/license-MIT-blue.svg)](LICENSE)

> Create samples apps for multiple frameworks.

You can view the generated samples in the [`samples`](https://github.com/sinedied/frameworks-playground/tree/samples/) branch.

## Usage

**Prerequisite:** you need [Docker](https://www.docker.com/products/docker-desktop/) installed.

To generate samples for all frameworks, run:
```bash
./docker.sh build         # build the image, only needed once
./docker.sh run [--clean] # generate samples
```

Unless you use the `--clean` option, if you run the command again, it will only generate samples for new frameworks, which is handy when adding support for new frameworks.

A [dev container](https://code.visualstudio.com/docs/remote/containers?WT.mc_id=javascript-0000-yolasors) with all needed tools is also available.
From within the devcontainer, you can run simply the command:
```bash
./init_frameworks.sh [--clean]
```

By default, log output from the generator commands are hidden, but you can see them by setting the `DEBUG` environment variable:
```bash
DEBUG=1 ./docker.sh run
```