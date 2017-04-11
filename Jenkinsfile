#!groovy

stage('Test: Compile Time Validation') {
  node {
    checkout scm

    if (env.BRANCH_NAME =~ /^feature\/.*$|^develop$/) {
      withEnv(["ENVIRONMENT=DEV"]) {
        run_validations()
      }
    }
    if (env.BRANCH_NAME =~ /^release\/.*$|^hotfix\/.*$/) {
      withEnv(["ENVIRONMENT=DEV"]) {
        run_validations()
      }
    }
    if (env.BRANCH_NAME =~ /^master$/) {
      withEnv(["ENVIRONMENT=DEV"]) {
        run_validations()
      }
    }
  }
}

stage('Test: Fugue Dry Run') {
  node {
    if (env.BRANCH_NAME =~ /^feature\/.*$/) {
      withEnv(["ENVIRONMENT=DEV"]) {
        withCredentials([[$class: 'StringBinding', credentialsId: 'DEMO_AWS_ACCESS_KEY_ID', variable: 'AWS_ACCESS_KEY_ID'],
                         [$class: 'StringBinding', credentialsId: 'DEMO_AWS_SECRET_ACCESS_KEY', variable: 'AWS_SECRET_ACCESS_KEY']]) {
          run_dry_run()
        }
      }
    }
    if (env.BRANCH_NAME =~ /^develop$/) {
      withEnv(["ENVIRONMENT=DEV"]) {
        withCredentials([[$class: 'StringBinding', credentialsId: 'DEMO_AWS_ACCESS_KEY_ID', variable: 'AWS_ACCESS_KEY_ID'],
                         [$class: 'StringBinding', credentialsId: 'DEMO_AWS_SECRET_ACCESS_KEY', variable: 'AWS_SECRET_ACCESS_KEY']]) {
          run_dry_run()
        }
      }
    }
    if (env.BRANCH_NAME =~ /^release\/.*$|^hotfix\/.*$/) {
      withEnv(["ENVIRONMENT=DEV"]) {
        withCredentials([[$class: 'StringBinding', credentialsId: 'DEMO_AWS_ACCESS_KEY_ID', variable: 'AWS_ACCESS_KEY_ID'],
                         [$class: 'StringBinding', credentialsId: 'DEMO_AWS_SECRET_ACCESS_KEY', variable: 'AWS_SECRET_ACCESS_KEY']]) {
          run_dry_run()
        }
      }
    }
    if (env.BRANCH_NAME =~ /^master$/) {
      withEnv(["ENVIRONMENT=DEV"]) {
        withCredentials([[$class: 'StringBinding', credentialsId: 'DEMO_AWS_ACCESS_KEY_ID', variable: 'AWS_ACCESS_KEY_ID'],
                         [$class: 'StringBinding', credentialsId: 'DEMO_AWS_SECRET_ACCESS_KEY', variable: 'AWS_SECRET_ACCESS_KEY']]) {
          run_dry_run()
        }
      }
    }
  }
}

stage('Deploy: Fugue Run and Update') {
  node {
    if (env.BRANCH_NAME =~ /^feature\/.*$/) {
      withEnv(["ENVIRONMENT=DEV"]) {
        withCredentials([[$class: 'StringBinding', credentialsId: 'DEMO_AWS_ACCESS_KEY_ID', variable: 'AWS_ACCESS_KEY_ID'], 
                         [$class: 'StringBinding', credentialsId: 'DEMO_AWS_SECRET_ACCESS_KEY', variable: 'AWS_SECRET_ACCESS_KEY']]) {
          def ret = sh(script: "fugue status ${env.BRANCH_NAME}", returnStatus: true)
          if(ret == 0) {
            sh("fugue update ${env.BRANCH_NAME} compositions/CreateDeveloperEnvironment.lw -y")
          } else {
            sh("fugue run compositions/CreateDeveloperEnvironment.lw -a ${env.BRANCH_NAME}")
          }
        }
      }
    }
    if (env.BRANCH_NAME =~ /^develop$/) {
      withEnv(["ENVIRONMENT=DEV"]) {
        withCredentials([[$class: 'StringBinding', credentialsId: 'DEMO_AWS_ACCESS_KEY_ID', variable: 'AWS_ACCESS_KEY_ID'],
                         [$class: 'StringBinding', credentialsId: 'DEMO_AWS_SECRET_ACCESS_KEY', variable: 'AWS_SECRET_ACCESS_KEY']]) {
          def ret = sh(script: 'fugue status develop', returnStatus: true)
          if(ret == 0) {
            sh('fugue update develop compositions/CreateDeveloperEnvironment.lw -y')
          } else {
            sh('fugue run compositions/CreateDeveloperEnvironment.lw -a develop')
          }
        }
      }
    }
    if (env.BRANCH_NAME =~ /^release\/.*$|^hotfix\/.*$/) {
      withEnv(["ENVIRONMENT=DEV"]) {
        withCredentials([[$class: 'StringBinding', credentialsId: 'DEMO_AWS_ACCESS_KEY_ID', variable: 'AWS_ACCESS_KEY_ID'], 
                         [$class: 'StringBinding', credentialsId: 'DEMO_AWS_SECRET_ACCESS_KEY', variable: 'AWS_SECRET_ACCESS_KEY']]) {
          def ret = sh(script: 'fugue status staging', returnStatus: true)
          if(ret == 0) {
            sh('fugue update staging compositions/CreateDeveloperEnvironment.lw -y')
          } else {
            sh('fugue run compositions/CreateDeveloperEnvironment.lw -a staging')
          }
        }
      }
    }
    if (env.BRANCH_NAME =~ /^master$/) {
      withEnv(["ENVIRONMENT=DEV"]) {
        withCredentials([[$class: 'StringBinding', credentialsId: 'DEMO_AWS_ACCESS_KEY_ID', variable: 'AWS_ACCESS_KEY_ID'], 
                         [$class: 'StringBinding', credentialsId: 'DEMO_AWS_SECRET_ACCESS_KEY', variable: 'AWS_SECRET_ACCESS_KEY']]) {
          def ret = sh(script: 'fugue status production', returnStatus: true)
          if(ret == 0) {
            sh('fugue update production compositions/CreateDeveloperEnvironment.lw -y')
          } else {
            sh('fugue run compositions/CreateDeveloperEnvironment.lw -a production')
          }
        }
      }
    }
  }
}

def debug() {
  echo(env.BRANCH_NAME)
  echo(env.LUDWIG_PATH)
  echo(env.AWS_ACCESS_KEY_ID)
  echo(env.AWS_SECRET_ACCESS_KEY)
}

def run_validations() {
  sh('make')
}

def run_dry_run() {
  withCredentials([[$class: 'StringBinding', credentialsId: 'FUGUE_ROOT_USER', variable: 'FUGUE_ROOT_USER']]) {
    sh('fugue init ami-491bbb5f')
    sh("fugue user set root ${env.FUGUE_ROOT_USER}")
    sh('fugue status')
    sh('fugue run compositions/CreateDeveloperEnvironment.lw --dry-run')
  }
}
