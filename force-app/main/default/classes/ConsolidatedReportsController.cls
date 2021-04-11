public class ConsolidatedReportsController {
    public String recordId {get;set;}
    public String selectedTemplate {get;set;}
    private void populateRecordId() {
        if(!String.isBlank(recordId) && UserInfo.getUiThemeDisplayed().indexOf('Theme3')>=0) {
            recordId = ApexPages.currentPage().getparameters().get('id');
        }
    }
    public ConsolidatedReportsController() {
        populateRecordId();
    } 
    
    public List<ConsolidatedReportsService.ReportTemplate> getRecordTemplatesBySObjectType() {
        return ConsolidatedReportsService.getTemplateMetaBySObjectType(recordId);
    }

    @AuraEnabled
    public static ReportTemplateDAO getRecordTemplatesBySObjectType(String recordId) {
        ReportTemplateDAO toReturn = new ReportTemplateDAO();
        if(!String.isBlank(recordId)) {
            Id recordSfId = recordId;
            toReturn.data = ConsolidatedReportsService.getTemplateConfigBySObjectType(recordSfId.getSobjectType().getDescribe().getName());
        }
        System.debug('Response => '+ JSON.serialize(toReturn));
        return toReturn;
    }

    public void submit() {
    }

    public void close() {}
}