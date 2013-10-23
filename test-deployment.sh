set -e
set -x

PLAYER=player
DOCKER_BOX=docker-playground

read -p "Enter your project's name (on GitHub): " project

if [ -z ${1} ]; then
  echo "Please pass the path to your project root directory as the first parameter."
  exit -1
fi;

ssh ${PLAYER}@${DOCKER_BOX} /bin/bash -c "cd /tmp/ && rm -rf /tmp/${project} && mkdir -p /tmp/${project}"

if [ $? -ne 0 ]; then
  echo "Are you sure you have the SSH key authentication set up for ${PLAYER}@${DOCKER_BOX}?"
  exit -1
fi

rsync -v -r ${1}/* ${PLAYER}@${DOCKER_BOX}:/tmp/${project}/

ssh ${PLAYER}@${DOCKER_BOX} <<EOF
  cd /tmp/${project};
  sudo docker build -t "${project}-test" .

  cd deploy
  mkdir -p /tmp/${project}-log

  echo "Docker will now build & run your project. Logs can be found at /tmp/${project}-test on the '${DOCKER_BOX}' box"
  echo "When this is done, please ssh to ${DOCKER_BOX} and run `sudo docker ps` to see if your app is running and what port it maps to."

  sudo docker run -v "/tmp/${project}-log:/data/log" ${project}-test /bin/bash -c "cd /srv/project/deploy && make build && make run"
EOF
