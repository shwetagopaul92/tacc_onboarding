# Tapis Actors:

  If your project or role in the group will depend on Abaco (it probably will), review the following materials:
  https://github.com/TACC-Cloud/abaco-cli/
  https://github.com/TACC/abaco

## Objectives:
  Create a new abaco reactor using the same image classifier from the Containers section
  Send a message to that actor with a URL of an image to classify.
  Try running it synchronously and asynchronously


## Requirements

1. TACC Account: https://portal.tacc.utexas.edu/account-request
2. Create a Docker account: https://hub.docker.com/
3. Install the TACC Cloud Python SDK - ` pip3 install agavepy `

## Getting Started

### With Python-SDK

With the requirements in place, you are now ready to get started.

* We need to create an OAuth Client:

  ```
  from agavepy.agave import Agave
  ag = Agave(api_server='https://api.tacc.utexas.edu',
  ...            username='your username',
  ...            password='your password')
  ag.clients.create(body={'clientName': 'enter a client name'})
  ```

  Save your consumerKey and consumerSecret. The OAuth client keys can be reused as well.

* Once we have this in place, generate a Token:

  ```
  ag.token.create()
  ```
  Grab the token generated and store it.

  Running ` ag.profiles.get() ` would show the current user's profile.

* To reuse an existing token:

  ```
  ag = Agave(api_server='https://api.tacc.utexas.edu',
  ...            username='your username', password='your password',
  ...            client_name='my_client',
  ...            api_key='key',
  ...            api_secret='secret')
  ```

## Running Image Classifier with Abaco

* Create a file abaco.sh with contents

  ```

  #!/bin/bash

  # print the special MSG variable:
  echo "Contents of MSG: "$MSG

  mkdir /app

  python /app/classify_image.py --image_file=$MSG
  ```
* Create a Dockerfile

```
  # image: taccsciapps/abaco_classifier

  FROM tensorflow/tensorflow:1.5.0-py3

  # install requirements
  RUN pip install requests

  # add our app
  RUN mkdir /app
  ADD classify_image.py /app/classify_image.py
  RUN chmod +x /app/classify_image.py
  ADD abaco.sh /app/abaco.sh
  RUN chmod +x /app/abaco.sh
  RUN chmod -R 777 /app

  CMD ["/app/abaco.sh"]
```

* Build and push the image to Docker Hub

```
  docker build -t reshg/abaco_classifier .
  docker push reshg/abaco_classifier
```

* Create an Abaco actor with curl

```
  $ curl -k -H "Authorization: Bearer $TOKEN" \
  -H "Content-Type: application/json" \
  -d '{"image": "reshg/abaco_classifier", "name": "abaco_classifier", "description": "Using the image classifier with abaco."}' \
  https://api.tacc.cloud/actors/v2
```

Grab the Actor ID

* Send a message to the actor

```
  $ curl -k -H "Authorization: Bearer $TOKEN" -d "message=https://s3.amazonaws.com/cdn-origin-etr.akc.org/wp-content/uploads/2017/11/12231410/Labrador-Retriever-On-White-01.jpg" https://api.tacc.cloud/actors/v2/$ACTOR_ID/messages
```

Grab the Execution ID

* View results of execution

```

  $ curl -k -H "Authorization: Bearer $TOKEN" https://api.tacc.cloud/actors/v2/$ACTOR_ID/executions/$EXECUTION_ID/logs

```

### To run synchronously

### To run asynchronously
