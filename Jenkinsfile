pipeline {
    environment {
      GIT_COMMIT_HASH = sh (script: "git log -n 1 --pretty=format:'%h' | xargs", returnStdout: true).trim()
      GIT_CUR_BRANCH = sh (script: "git rev-parse --abbrev-ref HEAD", returnStdout: true).trim()
    }

    agent any

    stages {
        stage ('Build') {
          parallel {
            stage('Build-Backend') {
              when {
                changeset "*server/*"
              }
              agent any
              steps {
                echo "Build-Backend"
              }
            }
            stage('Build-FrontEnd') {
                agent any
                when {
                  changeset "*client/*"
                }
                steps {
                    echo 'Buid FrontEnd'
                }
            }
          }
        }
        stage ('Deploy') {
          parallel {
            stage('Deploy-Backend-RollingUpdates') {
              agent any
              steps {
                  echo 'Upload-Backend-DockerImage'
              }
            }
            stage('Deploy-FrontEnd-RollingUpdates') {
              agent any
              steps {
                  echo 'Upload-FrontEnd-DockerImage'
              }
            }
          }
        }
    }
}
