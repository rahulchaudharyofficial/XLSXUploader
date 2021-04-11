public with sharing class NewCaseListController {
    public List<Case> getNewCases() {
        return [Select Id,CaseNumber from Case where Status='New'];
    }
}