# setup
configure jenkins tools (jdk and maven).
you can get rid of the plugins you dont need like blueocean, while building the jenkins image it may take time to install some of the plugins.

if you get a "com.mongodb.MongoSecurityException: Exception authenticating MongoCredential" and 500 error, you should check
check the logs on the containers to see more details. for example, i saw on the mongodb that i get authentication denied for
the devuser to the campaignsDB db. i connected to the mongodb container using the admin, and noticed that both the db and the
user i was trying to create in the docker compose and init-mongo.js, does not exit. in the internet i learned that
this init script runs only once the mongodb is initialized, and, quote, "Docker-compose tries really hard to preserve your
data volumes between container recreations.". so i tried removing the image, purging it with "docker-compose rm -fv mongodb" 
but nada. for now my workaround is to connect to the mongodb, "use campaignsDB" and running the init-mongo.js myself.
make sure you write the db name correctly in the whole process 😳.

install oc on jenkins (soon using tools):
https://gist.github.com/mehdihasan/3399998cba54bdec78deb9be4a002acb

# todo
1. add parallel where can in the jenkinsfile?
2. add sonarqube test
3. gradle https://codingnconcepts.com/spring-boot/deployment-of-microservices-using-docker-and-jenkins/
4. dedicate docker agent to run this https://phoenixnap.com/kb/how-to-configure-docker-in-jenkins
5. junit allowEmptyResults: true, testResults: '**/target/surefire-reports/TEST-*.xml, **/target/failsafe-reports/*.xml'

# resources
1. https://pavankjadda.medium.com/spring-boot-application-deployment-with-jenkins-pipeline-on-open-shift-cluster-f9fafdb0d6a9
2. https://github.com/openshift/jenkins-client-plugin#setting-up-jenkins-nodes
