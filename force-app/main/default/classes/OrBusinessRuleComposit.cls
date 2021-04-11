public class OrBusinessRuleComposit extends BusinessRuleComposit {
    public override Boolean evaluate(){
	    for(BusinessRuleExpression expr : children) {
            if(expr.evaluate()) {
                return true;
            }
        }
	    return false;
	}
}