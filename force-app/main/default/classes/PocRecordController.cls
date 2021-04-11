public with sharing class PocRecordController {
    private static Map<String, Object> config = new Map<String,Object> {'class' => 'COLORFUL'};
    @AuraEnabled
    public static ResponseDTO getResponse() {
        ResponseDTO toReturn = new ResponseDTO();
        List<ResponseDTO.ResultDTO> results = new List<ResponseDTO.ResultDTO>();
        List<Bot_Command__c> commands = [select id, name from Bot_Command__c];
        if(commands!=null && commands.size()>0) {
            for(Bot_Command__c bc: commands) {
                ResponseDTO.ResultDTO dto = new ResponseDTO.ResultDTO(bc.Id, bc.Name,'','');
                if(!String.isBlank(bc.Name) && bc.Name.equalsIgnoreCase('Find Account')) {
                    dto.cellAttributes = config;
                }
                results.add(dto);
            }
        }
        
        list<Resource__c> resources = [select id, name from Resource__c];
        if(resources!=null && resources.size()>0) {
            for(Resource__c rc: resources) {
                ResponseDTO.ResultDTO dto =  new ResponseDTO.ResultDTO('','',rc.Id,rc.Name);
                if(!String.isBlank(rc.Name) && rc.Name.equalsIgnoreCase('R1')) {
                    dto.cellAttributes = config;
                }
                results.add(dto);
            }
        }
        toReturn.resDTO = results;
        System.debug('Response => '+ JSON.serialize(toReturn));
        return toReturn;
    }    
}