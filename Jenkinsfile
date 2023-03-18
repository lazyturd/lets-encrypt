#!/usr/bin/env groovy
pipeline {
    agent any 
    environment {
        AWS_ACCESS_KEY_ID     = credentials('AWS_ACCESS_KEY_ID')
        AWS_SECRET_ACCESS_KEY = credentials('AWS_SECRET_ACCESS_KEY')
        AWS_DEFAULT_REGION    = "us-east-1"
    }
    stages {
        stage('Create EKS Cluster') {
            steps {
                //
                script {
                    dir('terraform') {
                        sh "terraform init"
                        // sh "terraform apply --auto-approve"
                        sh "terraform destroy --auto-approve"
                    }
                } 
            }
        }
        // stage('deploy socks-shop') {
        //     steps {
        //         // 
        //         script {
        //             script {
        //                 dir('example') {
        //                     sh "aws eks update-kubeconfig --name myapp-eks-cluster"
        //                     sh "kubectl apply -f clusterIssuerStage.yml"
        //                     sh "kubectl apply -f nginx-deployment.yaml"
        //                 }
        //             }
        //         }
        //     }
        // }
    }
}