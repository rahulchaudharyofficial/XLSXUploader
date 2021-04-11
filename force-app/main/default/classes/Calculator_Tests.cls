@IsTest
private class Calculator_Tests {
@IsTest
  static void testAddition() {
      System.assert(Calculator.addition(1,2)==3);
  }

  @IsTest
  static void testSubtraction(){
      System.assert(Calculator.subtraction(2,1)==1);
  }

  @IsTest
  static void testMultiply(){
      System.assert(Calculator.multiply(2,3)==6);
      Boolean expCatch = false;
      try {
          Calculator.multiply(0,5);
      }
      catch(Calculator.CalculatorException ex) {
          expCatch=true;
      }
      System.assert(expCatch);
  }

  @IsTest
  static void testDivide(){
      SYstem.assert(Calculator.divide(6,2)==3);
      Boolean expCatch = false;
      try {
          Calculator.divide(5,0);
      }
      catch(Calculator.CalculatorException ex) {
          expCatch=true;
      }
      System.assert(expCatch);
      expCatch = false;
      try {
          Calculator.divide(6,-2);
      }
      catch(Calculator.CalculatorException ex) {
          expCatch=true;
      }
      System.assert(expCatch);
  }
}