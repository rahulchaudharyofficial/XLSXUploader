@IsTest
private class EntityProfilePermissionManagerTest {
    @IsTest
    static void testPerform() {
        List<String> input = new List<String> {
            'Account'
        };
        EntityProfilePermissionManager.perform(input);
    }
}