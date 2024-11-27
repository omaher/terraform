pipeline {
    agent any

    tools {
        terraform 'Terraform-1.9.8' // Match the name from Global Tool Configuration
    }

    parameters {
        string(name: 'BRANCH', defaultValue: 'main', description: 'Git branch to checkout') // User-provided branch
    }

    environment {
        GIT_REPO = 'https://github.com/omaher/terraform.git' // Replace with your repository URL
    }

    stages {
        stage ('Checkout') {
            steps {
                withCredentials([string(credentialsId: 'Github-access', variable: 'GITHUB_TOKEN')]) {
                script {
                    try {
                        // Attempt to checkout the specified branch
                        checkout([
                            $class: 'GitSCM',
                            branches: [[name: "*/${params.BRANCH}"]],
                            userRemoteConfigs: [[url: "${GIT_REPO}", credentialsId: 'Github-access']],
                            extensions: [[$class: 'CleanBeforeCheckout']]
                        ])
                    } catch (Exception e) {
                        // Fail the pipeline if branch is not found
                        error("Branch '${params.BRANCH}' not found in repository '${GIT_REPO}'.")
                    }
                }
                }
            }
        }
        stage('Setup AWS CLI') {
            steps {
                withCredentials([[
                    $class: 'AmazonWebServicesCredentialsBinding', 
                    credentialsId: 'aws_credentials' // Use the ID of your Jenkins credentials
                ]]) {
                    sh '''
                    # Configure AWS CLI with credentials from Jenkins
                    aws configure set aws_access_key_id $AWS_ACCESS_KEY_ID
                    aws configure set aws_secret_access_key $AWS_SECRET_ACCESS_KEY
                    aws configure set default.region $AWS_REGION
                    aws configure set output json

                    # Test AWS CLI configuration
                    aws sts get-caller-identity
                    '''
                }
            }
        }
        stage ('Terraform Init') {
            steps {
                dir("$WORKSPACE/environments/dev/") {
                    sh 'terraform init'
                }
            }
        }
        stage ('Terraform Validate') {
            steps {
                dir("$WORKSPACE/environments/dev/") {
                    sh 'terraform validate'
                }
            }
        }
        stage ('Terraform Plan') {
            steps {
                dir("$WORKSPACE/environments/dev/") {
                    sh 'terraform plan'
                }
            }
        }
        stage('Confirmation to Proceed') {
            steps {
                script {
                    // Prompt user for confirmation
                    input message: "Do you want to proceed to the next stage?", ok: "Proceed", parameters: [
                        booleanParam(name: 'CONFIRM', description: 'Check to confirm if you want to proceed')
                    ]
                }
            }
        }
        stage ('Terraform Apoly') {
            when {
                    expression {
                        currentBuild.Result == null || currentBuild.Result == 'SUCCESS'
                    }
                }
            steps {
                dir("$WORKSPACE/environments/dev/") {
                    sh 'terraform apply -auto-approve'
                }
            }
        }
    }
    post {
        always {
            echo 'Pipeline execution completed.'
        }
    }
}