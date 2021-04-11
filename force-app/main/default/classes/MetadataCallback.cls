public class MetadataCallback implements Metadata.DeployCallback {
    public void handleResult(Metadata.DeployResult result, Metadata.DeployCallbackContext context) {
        if(result.status == Metadata.DeployStatus.SUCCEEDED) {
            //Do something once successfull
            System.debug('Successfully deployed');
        }
        else {
            //Do something when failed
            System.debug('Failed deployed'+ JSON.serialize(result.errorMessage));
        }
    }
}