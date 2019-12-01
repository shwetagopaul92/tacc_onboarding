# docker_image_classifier

Simple Image Classifier with Tensor Flow using Docker

This is an illustration of an Image Classifier based on Tensor Flow. 
The python script used can be found at: https://raw.githubusercontent.com/tensorflow/models/master/tutorials/image/imagenet/classify_image.py

- Docker Hub Image can be got from:
  > docker pull reshg/image_classifier

- To get started:

  > docker run reshg/image_classifier:latest
    would throw a help message on how to use this image
  
    Output: To use this image: docker run -v /hostdirectory_withimage:/data reshg/image_classifier:latest         
    classify_image.py --model_dir /model --image_file /data/imagename.jpg
  
      
- To use your own image, follow these steps:
  
  > docker run -v $PWD:/data reshg/image_classifier:latest classify_image.py --model_dir /model --image_file 
  /data/demo_images/imagename
  
  Here we mount a host directory($PWD) with our required image file to the docker container and specify the command to call   the python script and required arguments. 
  
  For example, with the golden retriever dog image present in this repository, you could:
  
  > docker run -v $PWD:/data reshg/image_classifier:latest classify_image.py 
  --model_dir /model --image_file /data/dog.jpg
  
  Results: 
  Successfully downloaded inception-2015-12-05.tgz 88931400 bytes.
  golden retriever (score = 0.90329)
  Labrador retriever (score = 0.00466)
  kuvasz (score = 0.00458)
  Saluki, gazelle hound (score = 0.00371)
  English setter (score = 0.00307)
  
