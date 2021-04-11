public class AndBusinessRuleComposit extends BusinessRuleComposit {
    public override Boolean evaluate() {
        for(BusinessRuleExpression expr : children) {
            if(!expr.evaluate()) {
                return false;
            }
        }
	    return true;
    }
}