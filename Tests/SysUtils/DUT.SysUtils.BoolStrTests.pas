unit DUT.SysUtils.BoolStrTests;

interface

uses
  System.SysUtils,
  DUnitX.TestFramework;

type
  [TestFixture]
  TSysUtilsFalseBoolStrsTests = class
  private
    Expected, Actual: string;
  public
    [Setup]
    procedure Setup;
    [Test]
    procedure TestFalseBoolStrsInitWithBoolToStr;
    [Test]
    procedure TestFalseBoolStrsInitWithBoolToStrWithoutDefParams;
    [Test]
    procedure TestFalseBoolStrsInitWithStrToBool;
    [Test]
    procedure TestFalseBoolStrsInitWithTryStrToBool;
    [Test]
    procedure TestFalseBoolStrs;
  end;

type
  [TestFixture]
  TSysUtilsTrueBoolStrsTests = class
  private
    Expected, Actual: string;
  public
    [Setup]
    procedure Setup;
    [Test]
    procedure TestTrueBoolStrsInitWithBoolToStr;
    [Test]
    procedure TestTrueBoolStrsInitWithBoolToStrWithoutDefParams;
    [Test]
    procedure TestTrueBoolStrsInitWithStrToBool;
    [Test]
    procedure TestTrueBoolStrsInitWithTryStrToBool;
    [Test]
    procedure TestTrueBoolStrs;
  end;

implementation

{ TSysUtilsFalseBoolStrsTests }

procedure TSysUtilsFalseBoolStrsTests.Setup;
begin
  Expected := 'False';
end;

procedure TSysUtilsFalseBoolStrsTests.TestFalseBoolStrsInitWithBoolToStr;
begin
  FalseBoolStrs := Nil;
  BoolToStr(False);
  Assert.IsFalse(Length(FalseBoolStrs) > 0, 'FalseBoolStrs should not be initialized when BoolToStr is called with UseBoolStrs = False');
end;

procedure TSysUtilsFalseBoolStrsTests.TestFalseBoolStrsInitWithBoolToStrWithoutDefParams;
begin
  FalseBoolStrs := Nil;
  Actual := '';
  BoolToStr(False,True); // default of arg2 is False - passing True initializes FalseBoolStrs (and TrueBoolStrs)
  if Length(FalseBoolStrs) > 0 then
    Actual := FalseBoolStrs[0];
  Assert.AreEqual(Expected, Actual, 'FalseBoolStrs[0] should be the string False');
end;

procedure TSysUtilsFalseBoolStrsTests.TestFalseBoolStrsInitWithStrToBool;
begin
  FalseBoolStrs := Nil;
  StrToBool('0');
  Assert.IsFalse(Length(FalseBoolStrs) > 0, 'FalseBoolStrs should not be initialized when StrToBool is called with a valid numeric string');
end;

procedure TSysUtilsFalseBoolStrsTests.TestFalseBoolStrsInitWithTryStrToBool;
var
  _val : Boolean;
begin
  FalseBoolStrs := Nil;
  TryStrToBool('0',_val);
  Assert.IsFalse(Length(FalseBoolStrs) > 0, 'FalseBoolStrs should not be initialized when TryStrToBool is called with a valid numeric string');
end;

procedure TSysUtilsFalseBoolStrsTests.TestFalseBoolStrs;
begin
  // this test should be run before FalseBoolStrs is ever used
  Assert.IsTrue(Length(FalseBoolStrs) = 0, 'FalseBoolStrs should be empty on initialization');
end;

{ TSysUtilsTrueBoolStrsTests }

procedure TSysUtilsTrueBoolStrsTests.Setup;
begin
  Expected := 'True';
end;

procedure TSysUtilsTrueBoolStrsTests.TestTrueBoolStrsInitWithBoolToStr;
begin
  TrueBoolStrs := Nil;
  BoolToStr(True);
  Assert.IsFalse(Length(TrueBoolStrs) > 0, 'TrueBoolStrs should not be initialized when BoolToStr is called with UseBoolStrs = False');
end;

procedure TSysUtilsTrueBoolStrsTests.TestTrueBoolStrsInitWithBoolToStrWithoutDefParams;
begin
  TrueBoolStrs := Nil;
  Actual := '';
  BoolToStr(True,True); // default of arg2 is False - passing True initializes TrueBoolStrs (and FalseBoolStrs)
  if Length(TrueBoolStrs) > 0 then
    Actual := TrueBoolStrs[0];
  Assert.AreEqual(Expected, Actual, True, 'TrueBoolStrs[0] should be the string True');
end;

procedure TSysUtilsTrueBoolStrsTests.TestTrueBoolStrsInitWithStrToBool;
begin
  TrueBoolStrs := Nil;
  StrToBool('1');
  Assert.IsFalse(Length(TrueBoolStrs) > 0, 'TrueBoolStrs should not be initialized when StrToBool is called with a valid numeric string');
end;

procedure TSysUtilsTrueBoolStrsTests.TestTrueBoolStrsInitWithTryStrToBool;
var
  _val : Boolean;
begin
  TrueBoolStrs := Nil;
  TryStrToBool('1',_val);
  Assert.IsFalse(Length(TrueBoolStrs) > 0, 'TrueBoolStrs should not be initialized when TryStrToBool is called with a valid numeric string');
end;

procedure TSysUtilsTrueBoolStrsTests.TestTrueBoolStrs;
begin
  // this test should be run before TrueBoolStrs is ever used
  Assert.IsTrue(Length(TrueBoolStrs) = 0, 'TrueBoolStrs should be empty on initialization');
end;

initialization
  TDUnitX.RegisterTestFixture(TSysUtilsFalseBoolStrsTests);
  TDUnitX.RegisterTestFixture(TSysUtilsTrueBoolStrsTests);

end.
