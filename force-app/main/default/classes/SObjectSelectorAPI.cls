public with sharing class SObjectSelectorAPI {
    private Schema.SObjectType sObjTy;
    public SObjectSelectorAPI(Schema.SObjectType sObjTy) {
        this.sObjTy = sObjTy;
    }

    /*
     * Considering fields are accessible to user, another words (User has access to fields)
    */
    private List<String> getAllFields() {
        List<String> toReturn = new List<String>();
        Map<String,Schema.SObjectField> fieldsMap = this.sObjTy.getDescribe().fields.getMap();
        
        if(fieldsMap.keySet().contains('ownerid')) {
            toReturn.add('Owner.Name');
        }

        for(String key : fieldsMap.keySet()) {
            Schema.DescribeFieldResult result = fieldsMap.get(key).getDescribe();
            if(result.isAccessible()) {
                toReturn.add(result.getName());
            }
        }
        return toReturn;
    }

    public String getBaseQuery() {
        String baseQuery = 'SELECT {0} FROM {1}';

        return String.format(baseQuery, new List<String> {
            String.join(getAllFields(), ','),
            this.sObjTy.getDescribe().getName()
        });
    }
}