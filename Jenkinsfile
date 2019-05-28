#!groovy
import groovy.json.JsonSlurperClassic
node {

    def BUILD_NUMBER=env.BUILD_NUMBER
    def RUN_ARTIFACT_DIR="tests/${BUILD_NUMBER}"
    def SFDC_USERNAME

    def HUB_ORG=env.HUB_ORG_DH
    def SFDC_HOST = env.SFDC_HOST_DH
    def JWT_KEY_CRED_ID = env.JWT_CRED_ID_DH
    def CONNECTED_APP_CONSUMER_KEY=env.CONNECTED_APP_CONSUMER_KEY_DH



    def toolbelt = tool 'toolbelt'

    stage('checkout source') {

    printf BUILD_NUMBER
    printf RUN_ARTIFACT_DIR
    printf HUB_ORG
    printf SFDC_HOST
    printf JWT_KEY_CRED_ID
    printf CONNECTED_APP_CONSUMER_KEY

        // when running in multi-branch job, one must issue this command
        checkout scm
    }

    withCredentials([file(credentialsId: JWT_KEY_CRED_ID, variable: 'jwt_key_file')]) {

        stage('Create Scratch Org') {

            rc = sh returnStatus: true, script: "${toolbelt}/sfdx force:auth:jwt:grant --clientid ${CONNECTED_APP_CONSUMER_KEY} --username ${HUB_ORG} --jwtkeyfile ${jwt_key_file} --setdefaultdevhubusername --instanceurl ${SFDC_HOST}"
            if (rc != 0) { error 'hub org authorization failed' }

        }

        /*stage('Deploy to DevHub') {
        	printf 'Converting source to mdapi format...'
        	rc = sh returnStatus: true, script: "${toolbelt}/sfdx force:source:convert --outputdir app_package --json"
        	if(rc != 0) { error 'Conversion to mdapi format failed' }

        	printf 'Deploying to DevHub...'
        	rc = sh returnStatus: true, script: "${toolbelt}/sfdx force:source:deploy --manifest app_package/package.xml"
        	if(rc != 0) { error 'Deployment to DevHub failed' }
        }
        */

    }
}