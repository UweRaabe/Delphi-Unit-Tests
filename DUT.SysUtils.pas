unit DUT.SysUtils;

interface

uses
     DUnitX.TestFramework
{$IFDEF VER220 }
   , SysUtils
{$ELSE}
   , System.SysUtils
{$ENDIF}
   ;

type
  [TestFixture]
  TSysUtilsCaseTests = class
  private
    Expected, Actual: string;
  public
    [Test]
    procedure TestLowerCaseWithAllLowerCase;
    [Test]
    procedure TestLowerCaseWithAllUpperCase;
    [Test]
    procedure TestLowerCaseWithMixedCase;
    [Test]
    procedure TestUpperCaseWithAllUpperCase;
    [Test]
    procedure TestUpperCaseWithAllLowerCase;
    [Test]
    procedure TestUpperCaseWithMixedCase;
    [Test]
    procedure TestSameText;
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

procedure TSysUtilsCaseTests.TestUpperCaseWithAllUpperCase;
begin
  Expected := 'UPPER';
  Actual := UpperCase('UPPER');
  Assert.AreEqual(Expected, Actual, 'UpperCase with already upper case input failed');
end;

procedure TSysUtilsCaseTests.TestUpperCaseWithAllLowerCase;
begin
  Expected := 'UPPER';
  Actual := UpperCase('upper');
  Assert.AreEqual(Expected, Actual, 'UpperCase with all lower case input failed');
end;

procedure TSysUtilsCaseTests.TestUpperCaseWithMixedCase;
begin
  Expected := 'UPPER';
  Actual := UpperCase('uPpEr');
  Assert.AreEqual(Expected, Actual, 'UpperCase with mixed case input failed');
end;

procedure TSysUtilsCaseTests.TestSameText;
begin
  Assert.IsTrue(SameText('T','t'), 'SameText failed comparing T = t');
  Assert.IsTrue(SameText('T','T'), 'SameText failed comparing T = T');
  Assert.IsTrue(SameText('T',''), 'SameText failed comparing T to an empty string');
  Assert.IsTrue(SameText('','T'), 'SameText failed comparing and empty string T');
  Assert.IsTrue(SameText('',''), 'SameText failed comparing two empty strings');  
end;

initialization
  TDUnitX.RegisterTestFixture(TSysUtilsCaseTests);

end.
