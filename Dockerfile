# What image should the container be based on. If you're OK with Linux Precise
# 12.04 64 bit with node 0.10.8 and sshd installed, just leave this here.
FROM realyze/ubuntu-node-sshd

# Here goes the name of this Dockerfile maintainer. Please put your name & e-mail here.
MAINTAINER Bob Bobsson "please@change.me" # 42 - modify this number if you want to force the image to be rebuilt from scratch.


# This is where we install all the dependencies that should be saved
# within the image.
# ================

# Install all the Node-ish dependencies.
RUN npm install -g grunt-cli
RUN npm install -g karma
Run npm install -g bower
Run npm install -g phantomjs

# Install the necessary commands.
RUN apt-get install -y git
# Required by PhantomJS.
RUN apt-get install -y fontconfig

# Install Mongodb (see http://docs.docker.io/en/latest/examples/mongodb/).
RUN apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv 7F0CEB10
RUN echo 'deb http://downloads-distro.mongodb.org/repo/ubuntu-upstart dist 10gen' | tee /etc/apt/sources.list.d/mongodb.list
RUN dpkg-divert --local --rename --add /sbin/initctl
RUN ln -s /bin/true /sbin/initctl
RUN apt-get update
RUN apt-get install mongodb-10gen

# Create MongoDB data dir (again, see http://docs.docker.io/en/latest/examples/mongodb/).
RUN mkdir -p /data/db


# This is where we tell the world what ports should our container make visible
# from the outside (Docker will map them to random ports or ports we specify
# when we run the container).
# =================

# Expose Express.js port.
EXPOSE 3000

# Expose SSHD port.
EXPOSE 22


# This is where we tell Docker to copy something from the host filesysytem
# into our image.
# ==============

# Add the project sources to the image.
ADD . /srv/project/
