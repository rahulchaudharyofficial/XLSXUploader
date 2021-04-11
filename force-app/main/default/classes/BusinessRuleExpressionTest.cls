@IsTest
private class BusinessRuleExpressionTest {

    @IsTest
    static void test1() {
        BusinessRuleExpression expr1 = new AndBusinessRuleComposit();
        BusinessRuleVariable v1 = new BusinessRuleVariable('1');
        v1.evaluate();
        expr1.add(v1);
        expr1.add(new BusinessRuleVariable('2'));

        System.debug(expr1);
    }
}