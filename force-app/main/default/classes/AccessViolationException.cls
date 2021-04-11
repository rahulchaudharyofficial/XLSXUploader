public class AccessViolationException extends Exception {
    public Enum Type {READ_ERROR, CREATE_ERROR, UPDATE_ERROR, DELETE_ERROR}
    
    public static final String NO_FIELD = 'NO FIELD';
    
    private static final String OBJECT_NOT_INSERTABLE = Label.error_object_not_insertable;
    private static final String OBJECT_NOT_UPDATEABLE = Label.error_object_not_updateable;
    private static final String OBJECT_NOT_DELETABLE = Label.error_object_not_deletable;
    private static final String OBJECT_NOT_READABLE = Label.error_object_not_readable;
    
    private static final String FIELD_NOT_INSERTABLE = Label.error_field_not_insertable;
    private static final String FIELD_NOT_UPDATEABLE = Label.error_field_not_updateable;
    private static final String FIELD_NOT_READABLE = Label.error_field_not_readable;
    
    
    private SObjectType objectType;
    private String fieldName;
    private Type errorType;
    
    public AccessViolationException(Type errorType, SObjectType objectType, String fieldName) {
        this();
        this.errorType = errorType;
        this.objectType = objectType;
        this.fieldName = fieldName;
        buildMessage( errorType, objectType, fieldName );
    }

    public AccessViolationException(Type errorType, SObjectType objectType) {
        this();
        this.errorType = errorType;
        this.objectType = objectType;
        this.fieldName = NO_FIELD;
        buildMessage( errorType, objectType );
    }

    public Type getErrorType() {
        return this.errorType;
    }

    public SObjectType getSObjectType() {
        return this.objectType;
    }

    public String getFieldName() {
        return this.fieldName;
    }

    private void buildMessage(Type errorType, SObjectType objectType) {
    
        if (errorType == Type.READ_ERROR) {
            List<String> replacements = new List<String>{ String.valueOf(objectType) };
            this.setMessage( String.format( OBJECT_NOT_READABLE, replacements));
        }
        else if (errorType == Type.CREATE_ERROR) {
            List<String> replacements = new List<String>{ String.valueOf(objectType) };
            this.setMessage( String.format( OBJECT_NOT_INSERTABLE, replacements));
        }
        else if (errorType == Type.UPDATE_ERROR) {
            List<String> replacements = new List<String>{ String.valueOf(objectType) };
            this.setMessage( String.format( OBJECT_NOT_UPDATEABLE, replacements));
        }
        else if (errorType == Type.DELETE_ERROR) {
            List<String> replacements = new List<String>{ String.valueOf(objectType) };
            this.setMessage( String.format( OBJECT_NOT_DELETABLE, replacements));
        }
    
    }

    private void buildMessage(Type errorType, SObjectType objectType, String fieldName) {
    
        if (errorType == Type.READ_ERROR) {
            List<String> replacements = new List<String>{ String.valueOf(objectType), fieldName };
            this.setMessage( String.format( FIELD_NOT_READABLE, replacements));
        }
        else if (errorType == Type.CREATE_ERROR) {
            List<String> replacements = new List<String>{ String.valueOf(objectType), fieldName };
            this.setMessage( String.format( FIELD_NOT_INSERTABLE, replacements));
        }
        else if (errorType == Type.UPDATE_ERROR) {
            List<String> replacements = new List<String>{ String.valueOf(objectType), fieldName };
            this.setMessage( String.format( FIELD_NOT_UPDATEABLE, replacements));
        }
        
    }
}