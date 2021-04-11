public with sharing class ResponseDTO {
    
    public void setCellColor(Map<String,String> cellAttr) {
        for(Column col : this.columns) {
            col.cellAttributes = cellAttr;
        }
    }

    Map<String,Object> typeAttr = new Map<String,Object> {
        'iconName'=>'utility:view',
        'label' => 'View Record',
        'name' => 'viewRecord',
        'disabled'=> false,
        'value'=> 'viewBtn'
    };
    @AuraEnabled public List<Column> columns = new List<Column> {
        new Column('Related Record','Related_Record','button',typeAttr,null),
        new Column ('Command Id','CommandId','text',null, new Map<String,String> {'class' => 'green'}),
        new Column ('Command Name','CommandName','text',null,new Map<String,String> {'class' => 'red'}),
        new Column ('Resource Id','ResourceId','text',null,null),
        new Column ('Resource Name','ResourceName','text',null,null)
    };
    @AuraEnabled public List<ResultDTO> resDTO {get;set;}
   

    public class Column {
        @AuraEnabled public String label {get;set;}
        @AuraEnabled public String fieldName {get;set;}
        @AuraEnabled public String type {get;set;}
        @AuraEnabled public Map<String,Object> typeAttributes {get;set;}
        @AuraEnabled public Map<String,Object> cellAttributes {get;set;}

        public Column(String label,String fieldName, String type,Map<String,Object> typeAttributes,Map<String,Object> cellAttributes) {
            this.label = label;
            this.fieldName = fieldName;
            this.type = type;
            this.typeAttributes = typeAttributes;
            this.cellAttributes = cellAttributes;
        }
    }

    public class ResultDTO {
        @AuraEnabled public Map<String,Object> cellAttributes {get;set;}
        @AuraEnabled public String cssClass {get;set;}
        @AuraEnabled public String CommandId {get;set;}
        @AuraEnabled public String CommandName {get;set;}
        @AuraEnabled public String ResourceId {get;set;}
        @AuraEnabled public String ResourceName {get;set;}
        public ResultDTO(String CommandId,String CommandName,String ResourceId,String ResourceName) {
            this.CommandId = CommandId;
            this.CommandName = CommandName;
            this.ResourceName = ResourceName;
            this.ResourceId = ResourceId;
        }
    }
}