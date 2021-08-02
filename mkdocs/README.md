## README

Start new project.

```bash
docker run \
  --rm \
  -u $(stat -c "%u:%g" README.md) \
  -v $(pwd):/work \
  davetang/mkdocs:0.0.1 \
  mkdocs new test
```

Build.

```bash
docker run \
  --rm \
  -u $(stat -c "%u:%g" README.md) \
  -v $(pwd)/test:/work \
  davetang/mkdocs:0.0.1 \
  mkdocs build
```

Serving is work in progress.

