# 🛝 framework-detection-playground

> Create samples apps for multiple frameworks.

## Usage

To generate samples for all frameworks, run:
```bash
./init_frameworks.sh [--clean]
```

Unless you use the `--clean` option, if you run the command again, it will only generate samples for new frameworks, which is handy when adding support for new frameworks.

#### Prerequisites
- [Node.js v16+](https://nodejs.org/en/download/)
- [Azure Functions Core Tools](https://aka.ms/functions-core-tools)

A [dev container](https://code.visualstudio.com/docs/remote/containers?WT.mc_id=javascript-0000-yolasors) with all needed tools is also available.
