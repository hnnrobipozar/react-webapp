pipeline {
agent any

    environment{
        DOCKERHUB_CREDENTIALS = credentials('dockerhub')
        GITHUB_CREDENTIALS = credentials('cdcadc76-34bc-437e-a2c6-0f3928db1f66')
        GITHUB_REPO = 'hnnrobipozar/react-webapp'
        NEXT_VERSION = nextVersion()
    }


    stages {
        
        stage('Pull'){
            steps{
                echo "Pulling repo stage"
                git branch: 'main', url: 'https://github.com/hnnrobipozar/react-webapp'
     
            }
        }
        
        stage('Build') {
            steps {
                echo "Build stage"
                sh '''
                docker build -t react-webapp:latest  -f./building/Dockerfile .
                docker run --name build_container react-webapp:latest
                docker cp build_container:/react-webapp/build ./artefakty
                docker logs build_container > log_build.txt
                '''
            }
        }

        stage('Test') {
            steps {
                echo "Test stage"
                sh '''
                docker build -t react-webapp-test:latest -f ./test/Dockerfile .
                docker run --name test_container react-webapp-test:latest
                docker logs test_container > log_test.txt

                '''
            }
        }
        stage('Deploy') {
            steps {
                echo "Deploy stage"
                sh '''
                
                docker build -t react-webapp-deploy:latest -f ./deploy/Dockerfile .
                docker run -p 3000:3000 -d --rm --name deploy_container react-webapp-deploy:latest
                
                '''
        }
        }

        stage('Publish') {
            steps {
                echo "Publish stage"
                sh '''
                TIMESTAMP=$(date +%Y%m%d%H%M%S)
                tar -czf artifact_$TIMESTAMP.tar.gz log_build.txt log_test.txt artefakty
                git config --global user.email "adamhyzy2001@wp.pl"
                git config --global user.name "hnnrobipozar"
                git tag -a ${NEXT_VERSION} -m "tag"
                git push https://${GITHUB_CREDENTIALS_PSW}@github.com/${GITHUB_REPO} ${NEXT_VERSION}

                echo $DOCKERHUB_CREDENTIALS_PSW | docker login -u $DOCKERHUB_CREDENTIALS_USR --password-stdin
              
                docker tag react-app-deploy:latest hnnrobipozar/react-app:${NEXT_VERSION}
                docker push hnnrobipozar/react-app:${NEXT_VERSION}
                docker logout

                echo

                '''
            } 
        }

    }
                post{
            always{
            echo "Archiving artifacts"

            archiveArtifacts artifacts: 'artifact_*.tar.gz', fingerprint: true
            sh '''
            chmod +x cleanup.sh
            ./cleanup.sh
            '''
        }
}


}
