#Extraemos todo lo referente al enviroment
FROM ubuntu:20.10
#Escogemos usuario y contraseña para el servidor
ENV USER=root
ENV PASSWORD=123456
#Paramétros del enviroment
ENV DEBIAN_FRONTEND=noninteractive 
ENV DEBCONF_NONINTERACTIVE_SEEN=true
#Extrae el la carpeta del juego del root
COPY DOOMS /dos/DOOMS
#Se configura el servidor VNC
RUN apt-get update && \
	echo "tzdata tzdata/Areas select America" > ~/tx.txt && \
	echo "tzdata tzdata/Zones/America select New York" >> ~/tx.txt && \
	debconf-set-selections ~/tx.txt && \
#Añadimos dosbox
	apt-get install -y tightvncserver ratpoison dosbox novnc websockify && \
	mkdir ~/.vnc/ && \
	mkdir ~/.dosbox && \
	echo $PASSWORD | vncpasswd -f > ~/.vnc/passwd && \
	chmod 0600 ~/.vnc/passwd && \
#Se configura el emulador DOSBOX para nuestro servidor VNC (qué archivos ejecutará)
	echo "set border 0" > ~/.ratpoisonrc  && \
#Se monta el exe del juego en el emulador
	echo "exec dosbox -conf ~/.dosbox/dosbox.conf -fullscreen -c 'MOUNT C: /dos' -c 'C:' -c 'cd DOOMS' -c 'DOOM.EXE'">> ~/.ratpoisonrc && \
	export DOSCONF=$(dosbox -printconf) && \
	cp $DOSCONF ~/.dosbox/dosbox.conf && \
	sed -i 's/usescancodes=true/usescancodes=false/' ~/.dosbox/dosbox.conf && \
	openssl req -x509 -nodes -newkey rsa:2048 -keyout ~/novnc.pem -out ~/novnc.pem -days 3650 -subj "/C=US/ST=NY/L=NY/O=NY/OU=NY/CN=NY emailAddress=email@example.com"
#Abrimos los puertos para acceder al servidor VNC
EXPOSE 80
CMD vncserver && websockify -D --web=/usr/share/novnc/ --cert=~/novnc.pem 80 localhost:5901 && tail -f /dev/null
