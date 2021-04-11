public with sharing class ExpressionResolver {
    private WorkflowDTO payload;
    
    public ExpressionResolver(String content) {
        this.payload = (WorkflowDTO) JSON.deserialize(content, WorkflowDTO.class);
    }

    public WorkflowDTO resolve() {
        return this.payload;
    }

    public class WorkflowDTO {
        public Map<String,String> fact {get;set;}
        public List<WorkflowAction> action {get;set;}

        public WorkflowDTO() {
            this.fact = new Map<String,String>();
            this.action = new List<WorkflowAction>();
        }
    }

    public class WorkflowAction {
        public String actionName {get;set;}
        public String actionHandler {get;set;}
        public Integer actionSequence {get;set;}
        public Map<String,String> actionParams {get;set;}

        public WorkflowAction() {
            this.actionParams = new Map<String,String>();
        }
    }
}