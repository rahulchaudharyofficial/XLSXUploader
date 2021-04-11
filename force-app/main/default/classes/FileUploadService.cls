public with sharing class FileUploadService {
    
    @future(callout=true)
    public static void upload(String path,String fileContent) {
        String token = 'sl.AXkeELxwu6jySAPbfp0sPHBz4-dra84x8NXPRXFvyjSTQ3aWUVeUJRlinv24UQD4rpJHVYUKwCjAeY5KfAFaAuHoDn8FdLkRSOyPbItOSBbLDolXdumgNMPRAd__Dy2u6DfAusk8';
        Http service = new Http();
        HttpRequest request = new HttpRequest();
        request.setMethod('POST');
        request.setEndpoint('https://content.dropboxapi.com/2/files/upload');
        request.setHeader('Authorization','Bearer '+token);
        request.setHeader('Content-Type', 'application/octet-stream');
        String p = '{"path":"/API/'+path+'"}';
        request.setHeader('Dropbox-API-Arg', p);
        request.setBody(fileContent);
        HttpResponse response = service.send(request);
        System.debug('response => '+ response.getBody());
    }
}