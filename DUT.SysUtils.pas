unit DUT.SysUtils;

interface

uses
     DUnitX.TestFramework
   , System.SysUtils
   ;

type
  [TestFixture]
  TSysUtilsCaseTests = class
  private
    Expected, Actual: string;
  public
    [Test]
    procedure TestUpperCaseWithAllLowerCase;
    [Test]
    procedure TestUpperCaseWithMixedCase;
    [Test]
    procedure TestUpperCaseWithAlreadyUpperCase;
    [Test]
    procedure TestLowerCaseWithAllUpperCase;
    [Test]
    procedure TestLowerCaseWithMixedCase;
    [Test]
    procedure TestLowerCaseWithAllLowerCase;
  end;

implementation

{ TSysUtilsTests }

procedure TSysUtilsCaseTests.TestLowerCaseWithAllLowerCase;
begin
  Expected := 'lower';
  Actual := LowerCase('lower');
  Assert.AreEqual(Expected, Actual, 'LowerCase starting with all lower case failed');
end;

procedure TSysUtilsCaseTests.TestLowerCaseWithAllUpperCase;
begin
  Expected := 'lower';
  Actual := LowerCase('LOWER');
  Assert.AreEqual(Expected, Actual, 'LowerCase starting with all upper case failed');
end;

procedure TSysUtilsCaseTests.TestLowerCaseWithMixedCase;
begin
  Expected := 'lower';
  Actual := LowerCase('LoWeR');
  Assert.AreEqual(Expected, Actual, 'LowerCase with mixed case input failed');
end;

procedure TSysUtilsCaseTests.TestUpperCaseWithAllLowerCase;
begin
  Expected := 'UPPER';
  Actual := UpperCase('upper');
  Assert.AreEqual(Expected, Actual, 'UpperCase with all lower case input failed');
end;

procedure TSysUtilsCaseTests.TestUpperCaseWithAlreadyUpperCase;
begin
  Expected := 'UPPER';
  Actual := UpperCase('UPPER');
  Assert.AreEqual(Expected, Actual, 'UpperCase with already upper case input failed');
end;

procedure TSysUtilsCaseTests.TestUpperCaseWithMixedCase;
begin
  Expected := 'UPPER';
  Actual := UpperCase('uPpEr');
  Assert.AreEqual(Expected, Actual, 'UpperCase with mixed case input failed');
end;

initialization
  TDUnitX.RegisterTestFixture(TSysUtilsCaseTests);

end.
