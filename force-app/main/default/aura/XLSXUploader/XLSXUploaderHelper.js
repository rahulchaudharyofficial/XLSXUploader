({
    handleUploadFinished : function(component, event) {
        var uploadedFiles = event.getParam("files");
        var fileDetail = {};
        // Get the file name
        uploadedFiles.forEach(file => {
            fileDetail.name = file.name;
            fileDetail.documentId = file.documentId;
            fileDetail.contentVersionId = file.contentVersionId;
        });
        console.log(JSON.stringify(uploadedFiles));
        var serverAction = component.get("c.uploadController");
        serverAction.setParams({"uploadedFiles": fileDetail});
        serverAction.setCallback(this, function(response) {
            var state = response.getState();
            if(state === "SUCCESS")
            {
                var responseValue = response.getReturnValue(); 
                console.log("SUCCESS : "+ responseValue);
                //this.showToast(component,event,responseValue);
            }
            else if(state==="INCOMPLETE")
            {
                console.log("Inside incompplete state");
            }
            else if( state==="ERROR")
            {
                var errors = response.getError();
                if (errors) {
                    if (errors[0] && errors[0].message) {
                        console.log("Error message: " + 
                                 errors[0].message);
                    }
                } else {
                    console.log("Unknown error");
                }
            }
        });
        // Enqueue Action
        console.log("Before Action Queues");
        $A.enqueueAction(serverAction);
        

    },
    showToast : function(component, event, message) {
        var toastEvent = $A.get("e.force:showToast");
        toastEvent.setParams({
            "title": "Success!",
            "message": "The record has been uploaded successfully. \n"+ message
        });
        toastEvent.fire();
    }
})