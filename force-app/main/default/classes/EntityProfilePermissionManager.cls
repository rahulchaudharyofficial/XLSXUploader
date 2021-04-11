public class EntityProfilePermissionManager {
    public static void perform(List<String> sObjTypeName) {
        try {
         	List<ObjectPermissions> permissions = [select id,Parent.Profile.Name,SobjectType,PermissionsRead from ObjectPermissions where SObjectType in :sObjTypeName];
        	List<ObjectPermissions> output = new List<ObjectPermissions>();
        	for(ObjectPermissions perm : permissions) {            
            	if(!String.isBlank(perm.Parent.Profile.Name) && !perm.PermissionsRead) {
                	perm.PermissionsRead=true;
                	output.add(perm);
            	}
        	}
        
        	if(!output.isEmpty()) {
            	List<Database.SaveResult> results =  Database.update(output);
            	/*if (results!=null && !results.isEmpty()) {
                    for(Database.SaveResult result : results) {
                        System.debug('Updated permission for '+ result.Id);
                    }
            	}*/
        	}   
        }
        catch(Exception ex) {
            System.debug(LoggingLevel.ERROR, 'Error caught when running permission manager: message = '+ ex.getMessage());
        }
    }
}