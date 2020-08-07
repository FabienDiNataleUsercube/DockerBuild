# DockerBuild
Dockerfile creating an environment with the base of .Net Framework 3.5 and tools from VisualStudio 2017

To build the container : docker build -t buildtools:latest -m 2GB .<br/>
To run the docker file : docker run  --mount type=volume,source=data,destination=c:\source\,readonly buildtools<br/>
* buildtools is the container name used
* data is the volume name created before with the source files
* c:\source\ is the destination file of the volume into the container (readonly file)
