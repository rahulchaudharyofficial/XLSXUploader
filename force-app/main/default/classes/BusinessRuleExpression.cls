public interface BusinessRuleExpression {
    BusinessRuleExpression add(BusinessRuleExpression expr);
    BusinessRuleExpression set(String name, Boolean value);
    Boolean evaluate();
}