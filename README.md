# env
Personal Docker development environment.

For ease of use, you can add the following alias to your shell's RC file.
```bash
alias monokal="docker run --rm -ti -v ${HOME}/:/host/ -v ${HOME}/.bash_history:/root/.bash_history monokal/env:latest"
```
