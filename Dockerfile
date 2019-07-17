## Custom Dockerfile
FROM consol/ubuntu-xfce-vnc
ENV REFRESHED_AT 2019-07-15

# Switch to root user to install additional software
USER 0

# use custom mirrors
RUN apt-get update

## Install a gedit sudo htop
RUN apt-get install language-pack-zh-hans sudo htop -y\
    && apt-get clean -y

# Use default wallpaper
RUN sed -i 's/\/headless\/.config\/bg_sakuli.png/\/usr\/share\/backgrounds\/xfce\/xfce-teal.jpg/g'  $HOME/.config/xfce4/xfconf/xfce-perchannel-xml/xfce4-desktop.xml

# Add custom user
ENV USERNAME=-impdev PASSWORD=impdev
RUN useradd -d $HOME --shell /bin/bash --user-group --groups adm,sudo ${USERNAME}\
    && echo "$USERNAME:$PASSWORD" | chpasswd

# Add aliases
RUN echo "alias ll='ls -alF'" >> $HOME/.bashrc

## Switch back to default user
USER 1000
