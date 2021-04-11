public class XLSXUploaderController {
    

    @AuraEnabled
    public static String uploadController(FileUploadWrapper uploadedFiles)
    {
        String toReturn = '';
        String uploadedDocumentId = uploadedFiles.documentId;
       
        List<ContentVersion> fileContent = [SELECT VersionData,ContentSize,FileType,FileExtension,PublishStatus,Title FROM ContentVersion WHERE ContentDocumentId = :uploadedDocumentId  AND IsLatest = true];
      
        if(fileContent!=null && !fileContent.isEmpty())
        {
            Blob fileBlob = fileContent.get(0).VersionData;
            String fileText =  EncodingUtil.base64Encode(fileBlob);
            System.debug('File Text => '+ fileText);
            toReturn = fileText;
        }

        return toReturn;
    }    
}