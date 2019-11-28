# jenkins-docker
Jenkins Docker image that adds installation of Git, Maven, Docker, Ansible, default-jdk and Node.js, plus the Jenkins Git SCM and Docker build step plugins.

## Run

```
docker run -d \
  -p 8080:8080 \
  --restart=always \
  -v /home/ubuntu/jenkins:/var/jenkins_home \
  --add-host docker:172.17.0.100 \ # Replace with your docker host IP address
  --name jenkins \
  carlosmonari/jenkins
```

 * runs a container;
 * maps the host port 8080 to the container port 8080;
 * sets an "always" restart policy;
 * maps the host folder /home/ubuntu/jenkins into the container as the Jenkins home folder; and
 * adds the Docker host to the container `/etc/hosts` file so that Jenkins can access the Docker API
 * names the image jenkins.

## Setup

To set up MAVEN_HOME and the Docker remote API:
 * Manage Jenkins
 * Configure System
 * (Keep Git default)
 * Add Maven, untick “install automatically”, MAVEN_HOME: /usr/share/maven
 * Set `Docker URL` to `http://docker:2375` (see --add-host above)

And start adding your jobs.

---

Carlos Monari
