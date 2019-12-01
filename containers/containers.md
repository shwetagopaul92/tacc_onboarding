
# Containers:

We use Docker to develop containers and run them on our laptops.  We use Singularity as a runtime on our HPC systems.  Take the time to setup your laptop as a development environment for Docker.  This works on Windows with WSL (instructions here: https://nickjanetakis.com/blog/setting-up-docker-for-windows-and-wsl-to-work-flawlessly) The setup is simpler on a mac.
https://cyverse-container-camp-workshop-2018.readthedocs-hosted.com/en/latest/singularity/singularityadvanced.html#hands-on-exercise

Deliverable:

Successfully run the hand-on exercise above using Docker as the runtime (i.e. report the image you used, the CLI command you ran, and the classification result.)
Learn to run containers on the HPC systems.  
Try running the same classification container on a TACC HPC system using the “tacc-singularity” module. Singularity differs the most from Docker in how it mounts host directories.  Note: Old training material may talk about issues with the “overlay” filesystem that can now be ignored.  You can directly run Docker containers at TACC using Singularity without any modification.

# Simple Image Classifier with Tensor Flow using Docker

This is an illustration of an Image Classifier based on Tensor Flow. The python script used can be found at: https://raw.githubusercontent.com/tensorflow/models/master/tutorials/image/imagenet/classify_image.py

* Docker Hub Image can be got from:

```
  docker pull reshg/image_classifier
  
```

* To get started:

```
  docker run reshg/image_classifier:latest would throw a help message on how to use this image

```

Output: To use this image:

```

  docker run -v /hostdirectory_withimage:/data reshg/image_classifier:latest
  classify_image.py --model_dir /model --image_file /data/imagename.jpg

```

* To use your own image, follow these steps:

```

  docker run -v $PWD:/data reshg/image_classifier:latest classify_image.py --model_dir /model --image_file /data/demo_images/imagename

```

Here we mount a host directory($PWD) with our required image file to the docker container and specify the command to call the python script and required arguments.

* For example, with the golden retriever dog image present in this repository, you could:

```
  docker run -v $PWD:/data reshg/image_classifier:latest classify_image.py --model_dir /model --image_file /data/dog.jpg

```

```

Results: Successfully downloaded inception-2015-12-05.tgz 88931400 bytes. golden retriever (score = 0.90329) Labrador retriever (score = 0.00466) kuvasz (score = 0.00458) Saluki, gazelle hound (score = 0.00371) English setter (score = 0.00307)

```

# Running Singularity on Stampede2

* Start an interactive development session

```
  idev
```

* Once you are on a compute node, load the tacc-singularity module

```
  module load tacc-singularity
```

```
  module list (would now show tacc-singularity if it is loaded properly)
```

You now have access to singularity commands on Stampede2

```
  git clone the https://github.com/shwetagopaul92/docker_image_classifier

  cd docker_image_classifier

  singularity pull docker://reshg/image_classifier

```

This would create a .simg file which can be used to execute the image.

```
  singularity exec /work/06935/sgopal/singularity_cache/image_classifier.simg classify_image.py --image_file dog.jpg

  singularity run -B $PWD:/data docker://reshg/image_classifier classify_image.py --model_dir /model --image_file /data/dog.jpg #not correct
```

* The way Singularity mounts the volume is different.

Result:

```
  Successfully downloaded inception-2015-12-05.tgz 88931400 bytes. 2019-10-29 20:55:31.858613: I tensorflow/core/platform/cpu_feature_guard.cc:137] Your CPU supports instructions that this TensorFlow binary was not compiled to use: SSE4.1 SSE4.2 AVX AVX2 AVX512F FMA 2019-10-29 20:55:33.162185: W tensorflow/core/framework/op_def_util.cc:343] Op BatchNormWithGlobalNormalization is deprecated. It will cease to work in GraphDef version 9. Use tf.nn.batch_normalization().

  golden retriever (score = 0.90329)
  Labrador retriever (score = 0.00466)
  kuvasz (score = 0.00458)
  Saluki, gazelle hound (score = 0.00371)
  English setter (score = 0.00307)

```

* Some useful singularity commands for running docker images:

```
  singularity shell docker://ubuntu:latest
  singularity run docker://ubuntu:latest
  singularity exec docker://ubuntu:latest echo "Hello Dinosaur!"
  singularity pull docker://ubuntu:latest singularity build ubuntu.img docker://ubuntu:latest
```
