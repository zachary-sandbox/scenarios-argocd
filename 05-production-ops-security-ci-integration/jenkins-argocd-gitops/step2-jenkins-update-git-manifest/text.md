# Step2 Jenkins pipeline fragment example

Jenkinsfile core logic snippet:
```groovy
pipeline {
  agent any
  stages {
    stage('Build & Push Image') {
      steps {
        sh 'docker build -t my-app: .'
        sh 'docker push my-app:'
      }
    }
    stage('Update Git manifest image tag') {
      steps {
        sh '''
          git clone git@github.com:org/gitops-manifests.git
          cd gitops-manifests
          # use yq / kustomize to modify deployment image tag
          git config user.email ci-bot@example.com
          git config user.name jenkins-bot
          git add .
          git commit -m ci:
