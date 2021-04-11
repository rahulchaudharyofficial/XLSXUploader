public class BusinessRuleVariable implements BusinessRuleExpression {

    public String name {get; private set;} 
    public Boolean value {get; private set;}

    public BusinessRuleVariable(String name) {
        this.name = name;
    }

    public BusinessRuleExpression add(BusinessRuleExpression expr) {
        return this;
    }
    public BusinessRuleExpression set(String name, Boolean value) {
	    if(this.name != null && this.name.equalsIgnoreCase(name)) {
            this.value = value;
        }
	    return this;
	}
    public Boolean evaluate(){ return value; }
}