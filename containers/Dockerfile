# pull tensorflow base docker image
FROM tensorflow/tensorflow:1.5.0-py3

# maintainer details
MAINTAINER Shweta Gopal "sgopal@tacc.utexas.edu" 

# copy the python script into root directory 
COPY classify_image.py /usr/local/bin

# make the classification python script executable
RUN ["chmod", "+x", "/usr/local/bin/classify_image.py"]

# set environment variable path to detect python executable script
ENV PATH="/usr/local/bin:${PATH}"

# set the command to display a help message on how to use this image
CMD echo "To use this image: docker run -v /hostdirectory_withimage:/data reshg/image_classifier:latest classify_image.py --model_dir /model --image_file /data/imagename.jpg"









