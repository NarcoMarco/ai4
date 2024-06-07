#!/bin/bash

apt install apache2 php libapache2-mod-php -y
cp upload.php /var/www/html/upload.php
mkdir /var/www/html/uploads
chmod 777 /var/www/html/uploads
cp flag.py /var/www/html/flag.py
mkdir /.inhere

# Create 200 files
for i in {1..200}; do
  # Generate a random file name
  FILE_NAME=$(tr -dc A-Za-z0-9 </dev/urandom | head -c 12)

  # Generate a random file size between 14 and 412
  FILE_SIZE=$(shuf -i 14-412 -n 1)

  # Generate random content of the specified size
  CONTENT=$(tr -dc A-Za-z0-9 </dev/urandom | head -c $FILE_SIZE)

  # Create the file with the random content
  echo $CONTENT > "/.inhere/$FILE_NAME"

done

sleep 5

FILE_NAME=$(tr -dc A-Za-z0-9 </dev/urandom | head -c 12)

echo "dKYYNuEvAFAe8IDuUJNYS8zTBsu3cePv" > "/.inhere/$FILE_NAME"

echo "200 files created with random names and contents."
