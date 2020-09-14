pipeline {
  agent { docker { image 'ruby:2.7-slim' } }
  environment {
    CI = 'true'
  }
  stages {
    stage('requirements') {
      steps {
        sh 'gem install bundler'
      }
    }
    stage('build') {
      steps {
        sh 'bundle install'
      }
    }
    stage('test') {
      steps {
        sh 'rake'
      }
    }
  }
}