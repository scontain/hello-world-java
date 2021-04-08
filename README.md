This a demonstration of one step transformation of Java native image (`registry.scontain.com:5050/sconecuratedimages/iexecsgx:hello-world-java`) to SCONE-enabled image (`hello-world-java-scone`).

Execute `sconify.sh` to sconify the native java image.

`sconify.sh` leverages `sconify_image` container that takes an input native image `--from` (`--from=registry.scontain.com:5050/sconecuratedimages/iexecsgx:hello-world-java`) and transform it to `--to` (`--to=hello-world-java-scone \`).
All other option related to the `sconify_image` tool could be obtained by running 
```
docker run -it --rm  registry.scontain.com:5050/sconecuratedimages/sconecli:sconify-image-latest

```

To run the the sconified image, execute `run.sh`
