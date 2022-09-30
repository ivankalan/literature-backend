def branch = "production"
def remoteurl = "https://github.com/ivankalan/literature-backend.git"
def remotename = "origin"
def workdir = "~/literature-backend/"
def ip = "ivanka@103.139.192.240"
def username = "ivanka"
def imagename = "ivankalan12/literature-backend"
def sshkeyid = "app-key"
def composefile = "docker-compose.yml"

pipeline {
    agent any

    stages {
        stage('Pulling from Backend Repo') {
            steps {
                sshagent([sshkeyid]) {
                    sh """ssh -o StrictHostKeyChecking=no ${ip} << EOF 
                    cd ${workdir}
                    git remote add ${remotename} ${remoteurl} || git remote set-url ${remotename} ${remoteurl}
                    git pull ${remotename} ${branch}
                    EOF"""
                }
            }
        }
        
        stage('Create Docker Image') {
            steps {
                sshagent(credentials: ["${sshkeyid}"]) {
                    sh """
                        ssh -l ${username} ${ip} <<pwd
                        cd ${workdir}
                        docker build -t ${imagename} .
                        pwd
                    """
                }
            }
        }

        stage('Deploy Image') {
            steps {
                sshagent(credentials: ["${sshkeyid}"]) {
                    sh """
                        ssh -l ${username} ${ip} <<pwd
                        cd ${workdir}
                        docker compose up -d
                        pwd
                    """
                }
            }
        }

        stage('Push to Docker Hub') {
            steps {
                sshagent(credentials: ["${sshkeyid}"]) {
                    sh """
                        ssh -l ${username} ${ip} <<pwd
                        docker push ${imagename}
                        pwd
                    """
                }
            }
        }
    }      
}  
