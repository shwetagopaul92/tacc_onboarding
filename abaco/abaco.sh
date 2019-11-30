#!/bin/bash

# print the special MSG variable:
echo "Contents of MSG: "$MSG

mkdir /app

python /app/classify_image.py --image_file=$MSG
