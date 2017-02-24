# env
```bash
echo 'alias monokal="docker pull monokal/env:latest && docker run -h monokal --rm -ti -v ${HOME}/:/host -v ${HOME}/.ssh:/root/.ssh monokal/env:latest"' >> ~/.bashrc
```
