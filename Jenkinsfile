pipeline {
    agent any
    tools {
        maven "MAVEN"
    }

    stages {
        stage('pull changes from github') {
            steps {
                git 'https://github.com/alexmarqs/springboot-rest-api-mongodb.git'
            }
        }
        stage('build') {
            steps {
                sh 'docker compose up --build -d'
            }
        }
        stage('build system test') {
            steps {
                sh "mvn -v"
                // sh 'mvn verify'
                sh "mvn clean package"
            }
        }
        stage('unit test') {
            steps {
                sh 'mvn -Dtest=CampaignsControllerTest test'
            }
            // post {
            //     always {
            //         junit 'target/surefire-reports/*.xml'
            //     }
            // }
        }
        stage('integration test') {
            steps {
                sh 'mvn -Dtest=CampaignsRepositoryTest test'
                // sh 'mvn failsafe:integration-test failsafe:verify'
            }
        }
        stage('s2i build') {
            steps {
                echo ":("
                // sh "oc login <IP-Address> --token=<token> --insecure-skip-tls-verify"
                // script {
                //     openshift.withCluster('https://<IP-Address>:8443', '<token>') {
                //         openshift.withProject('test') {
                //             def build = openshift.selector("bc", "rest-api");
                //             def startedBuild = build.startedBuild("--from-file='./target/rest-api.jar'")
                //             startedBuild.logs('-f');
                //             echo "build status: ${startedBuild.object().status}";
                //             echo "Hello from project ${openshift.project()} in cluster ${openshift.cluster()}"
                //         }
                //    }
                // }
            }
        }
        stage('verify service connectivity') {
            steps {
                sh "curl http://host.docker.internal:8080/campaigns"
                // script {
                //     openshift.withCluster('https://<IP-Address>:8443', '<token>') {
                //         openshift.withProject('test') {
                //             def connected = openshift.verifyService("rest-api")
                //             if (connected) {
                //                 echo "successfully connected"
                //             } else {
                //                 echo "unable to connect"
                //             }
                //         }
                //     }
                // }
            }
        }
        stage('system test (health test)') {
            steps {
                echo "heartbeat / probe / get openshift cluster health?"
            }
        }
    }
}