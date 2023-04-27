## README

Image based on [rocker/shiny](https://hub.docker.com/r/rocker/shiny) and app
based on [A Shiny app for visualising DESeq2
results](https://jokergoo.github.io/InteractiveComplexHeatmap/articles/deseq2_app.html).

The `run_shiny.sh` script will start a Docker container named
shiny_(your_userid).

Once the container is running, open your browser and navigate to
`localhost:3838` (default port).

## Troubleshooting

Check log in `shinylog`.

```bash
cat shinylog/shiny-server-shiny-20220310-001302-45127.log
```

"Log" into container and check other logs.

```bash
docker exec -it shiny_dtang /bin/bash
```
