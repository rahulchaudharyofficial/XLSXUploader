public class ReportTemplateDAO {
    @AuraEnabled public List<Column> columns {get;set;}
    @AuraEnabled public List<TemplateDAO> data {get;set;}

    private void populateColumns() {
        columns = new List<Column> {
            new Column('id','id','text'),
            new Column('title','title','text'),
            new Column('name','name','text'),
            new Column('templateId','templateId','text'),
            new Column('enabled','enabled','boolean'),
            new Column('landscape','landscape','boolean'),
            new Column('esignature','esignature','boolean'),
            new Column('description','description','text'),
            new Column('createdBy','createdBy','text')
        };
    }
    public ReportTemplateDAO() {
        populateColumns();
    }

    public class Column {
        @AuraEnabled public String label {get;set;}
        @AuraEnabled public String fieldName {get;set;}
        @AuraEnabled public String type {get;set;}
        //@AuraEnabled public Boolean sortable {get;set;}
        //@AuraEnabled public List<String> typeAttributes = new List<String>();
        public Column(String label,String fieldName,String type/*,Boolean sortable*/) {
            this.label = label;
            this.fieldName = fieldName;
            this.type = type;
            //this.sortable = sortable;

        }
    }
}