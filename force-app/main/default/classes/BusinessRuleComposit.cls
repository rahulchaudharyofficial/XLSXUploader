public abstract class BusinessRuleComposit implements BusinessRuleExpression {
    public List<BusinessRuleExpression> children {get; private set;}
    
    public BusinessRuleComposit() {
        this.children = new List<BusinessRuleExpression>();
    }

    public BusinessRuleExpression add(BusinessRuleExpression expr) {
        children.add(expr);
        return this;
    }

    public BusinessRuleExpression set(String name, Boolean value) {
        for(BusinessRuleExpression expr : children) {
            expr.set(name, value);
        }
        return this;
    }

    public Boolean hasChildren {
        get {
            return !children.isEmpty();
        }
    }

    public abstract Boolean evaluate();
}