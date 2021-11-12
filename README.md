# Run DOS game with docker via an VNC server

In this project we experiment with Dosbox and VNC in order to run a DOS game. In this case, we tried to run the popular Doom. 
You can find the original project in which this one is based here: https://github.com/theonemule/dos-game

## Requirements to run the game: 

1. Install Docker Desktop

## How to run it: 

1. Create a folder in which you're going to store the files of this repository. 

2. In said folder you'll open cmd, bash or Powershell. 

3. To build the docker image you'll run this command in the folder you stored the files: 
`docker build ./ -t gdosbox_so`

4. Then you'll run this command to initialize Dosbox an run it in the VNC server: 
`docker run -p 6080:80 gdosbox_so`

5. To access the emulator and play, go to: http://localhost:6080/vnc.html

6. When you access the page you'll introduce the password: 123456

7. Play!


