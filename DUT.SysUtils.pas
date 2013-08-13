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
    procedure TestUpperCaseWithAllLowerCase;
    [Test]
    procedure TestUpperCaseWithAllUpperCase;
    [Test]
    procedure TestUpperCaseWithMixedCase;
end;

type
  [TestFixture]
  TSysUtilsCompareStrTests = class
  public
    [Test]
    procedure TestCompareStrS1EqualsS2;
    [Test]
    procedure TestCompareStrS1LessThanS2;
    [Test]
    procedure TestCompareStrS1GreaterThanS2;
    [Test]
    procedure TestCompareStrWithEmptyStrings;
end;

type
  [TestFixture]
  TSysUtilsCompareTextTests = class
  public
    [Test]
    procedure TestCompareTextS1EqualS2;
    [Test]
    procedure TestCompareTextS1LessThanS2;
    [Test]
    procedure TestCompareTextS1GreaterThanS2;
    [Test]
    procedure TestCompareTextWithEmptyStrings;
end;

type
  [TestFixture]
  TSysUtilsSameTextTests = class
  public
    [Test]
    procedure TestSameTextS1EqualS2;
    [Test]
    procedure TestSameTextS1NotEqualS2;
    [Test]
    procedure TestSameTextWithEmptyStrings;
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


{ TSysUtilsCompareStrTests }

procedure TSysUtilsCompareStrTests.TestCompareStrS1EqualsS2;
begin
  Assert.IsTrue(CompareStr('T','T') = 0, 'CompareStr failed with S1 = S2');
end;

procedure TSysUtilsCompareStrTests.TestCompareStrS1LessThanS2;
begin
  Assert.IsTrue(CompareStr('T','t') < 0, 'CompareStr failed with S1 < S2 ');
end;

procedure TSysUtilsCompareStrTests.TestCompareStrS1GreaterThanS2;
begin
  Assert.IsTrue(CompareStr('t','T') > 0, 'CompareStr failed with S1 > S1 ');
end;

procedure TSysUtilsCompareStrTests.TestCompareStrWithEmptyStrings;
begin
  Assert.IsTrue(CompareStr('','') = 0, 'CompareStr failed comparing two empty strings');
end;

{ TSysUtilsCompareTextTests }

procedure TSysUtilsCompareTextTests.TestCompareTextS1EqualS2;
begin
  Assert.IsTrue(CompareText('T','t') = 0, 'CompareText failed with S1 = S2');
end;

procedure TSysUtilsCompareTextTests.TestCompareTextS1LessThanS2;
begin
  Assert.IsTrue(CompareText('t','u') < 0, 'CompareText failed with S1 < S2 ');
end;

procedure TSysUtilsCompareTextTests.TestCompareTextS1GreaterThanS2;
begin
  Assert.IsTrue(CompareText('u','t') > 0, 'CompareText failed with S1 > S1 ');
end;

procedure TSysUtilsCompareTextTests.TestCompareTextWithEmptyStrings;
begin
  Assert.IsTrue(CompareText('','') = 0, 'CompareText failed comparing two empty strings');
end;

{ TSysUtilsSameTextTests }

procedure TSysUtilsSameTextTests.TestSameTextS1EqualS2;
begin
  Assert.IsTrue(SameText('T','t'), 'SameText failed with S1 = S2');
end;

procedure TSysUtilsSameTextTests.TestSameTextS1NotEqualS2;
begin
  Assert.IsFalse(SameText('T','u'), 'SameText failed with S1 <> S2');
end;

procedure TSysUtilsSameTextTests.TestSameTextWithEmptyStrings;
begin
  Assert.IsTrue(SameText('',''), 'SameText failed comparing two empty strings');
end;

initialization
  TDUnitX.RegisterTestFixture(TSysUtilsCaseTests);
  TDUnitX.RegisterTestFixture(TSysUtilsCompareStrTests);
  TDUnitX.RegisterTestFixture(TSysUtilsCompareTextTests);
  TDUnitX.RegisterTestFixture(TSysUtilsSameTextTests);

end.