/*******************************************************************************
 * Copyright (c) 2020 Asmakam Inc.
 ******************************************************************************/

/**
* @description          :       This is an exception wrapper class
* @since                :       1.0.0
* @version              :       1.0.0
*/
public class ExceptionContainer {
    public class ConstraintViolationException extends Exception {}
    public class InvalidParamException extends Exception {}
}