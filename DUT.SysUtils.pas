unit DUT.SysUtils;

interface

uses
     DUnitX.TestFramework
   , System.SysUtils
   ;

type
  [TestFixture]
  TSysUtilsTests = class
    [Test]
    procedure TestUpperCaseWithAllLowerCase;
    [Test]
    procedure TestUpperCaseWithMixedCase;
    [Test]
    procedure TestUpperCaseWithAlreadyUpperCase;
  end;

implementation

{ TSysUtilsTests }

procedure TSysUtilsTests.TestUpperCaseWithAllLowerCase;
var
  Expected, Actual: string;
begin
  Expected := 'UPPER';
  Actual := UpperCase('upper');
  Assert.AreEqual(Expected, Actual, 'UpperCase with all lower case input failed');
end;

procedure TSysUtilsTests.TestUpperCaseWithAlreadyUpperCase;
var
  Expected, Actual: string;
begin
  Expected := 'UPPER';
  Actual := UpperCase('UPPER');
  Assert.AreEqual(Expected, Actual, 'UpperCase with already upper case input failed');
end;

procedure TSysUtilsTests.TestUpperCaseWithMixedCase;
var
  Expected, Actual: string;
begin
  Expected := 'UPPER';
  Actual := UpperCase('uPpEr');
  Assert.AreEqual(Expected, Actual, 'UpperCase with mixed case input failed');
end;

initialization
  TDUnitX.RegisterTestFixture(TSysUtilsTests);

end.
