## Hugo

[Hugo](https://gohugo.io/).

Usage.

```console
docker run --rm -u $(stat -c "%u:%g" $HOME) -v $(pwd):$(pwd) -w $(pwd) davetang/hugo:0.113.0 new site quickstart
```
```
Congratulations! Your new Hugo site is created in /home/dtang/github/learning_docker/hugo/quickstart.

Just a few more steps and you're ready to go:

1. Download a theme into the same-named folder.
   Choose a theme from https://themes.gohugo.io/ or
   create your own with the "hugo new theme <THEMENAME>" command.
2. Perhaps you want to add some content. You can add single files
   with "hugo new <SECTIONNAME>/<FILENAME>.<FORMAT>".
3. Start the built-in live server via "hugo server".

Visit https://gohugo.io/ for quickstart guide and full documentation.
```
