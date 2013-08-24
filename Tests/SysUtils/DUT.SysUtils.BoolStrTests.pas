unit DUT.SysUtils.BoolStrTests;

interface

uses
  {$if CompilerVersion < 23 }
    SysUtils,
  {$else}
    System.SysUtils, // Delphi XE2 (CompilerVersion 23) added scopes in front of unit names
  {$ifend}
  DUnitX.TestFramework
  ;

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


implementation

{ TSysUtilsFalseBoolStrsTests }

procedure TSysUtilsFalseBoolStrsTests.Setup;
begin
  Expected := 'False';
end;

procedure TSysUtilsFalseBoolStrsTests.TestFalseBoolStrsInitWithBoolToStr;
begin
  FalseBoolStrs := Nil;
  Actual := '';
  BoolToStr(False);
  if Length(FalseBoolStrs) > 0 then
    Actual := FalseBoolStrs[0];
  Assert.AreEqual(Expected, Actual, 'FalseBoolStrs[0] should be the string False');
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
  Actual := '';
  StrToBool('0');
  if Length(FalseBoolStrs) > 0 then
    Actual := FalseBoolStrs[0];
  Assert.AreEqual(Expected, Actual, 'FalseBoolStrs[0] should be the string False');
end;

procedure TSysUtilsFalseBoolStrsTests.TestFalseBoolStrsInitWithTryStrToBool;
var
  _val : Boolean;
begin
  FalseBoolStrs := Nil;
  Actual := '';
  TryStrToBool('0',_val);
  if Length(FalseBoolStrs) > 0 then
    Actual := FalseBoolStrs[0];
  Assert.AreEqual(Expected, Actual, 'FalseBoolStrs[0] should be the string False');
end;

procedure TSysUtilsFalseBoolStrsTests.TestFalseBoolStrs;
begin
  // this test should be run before FalseBoolStrs is ever used
  Assert.IsTrue(Length(FalseBoolStrs) = 0, 'FalseBoolStrs should be empty on initialization');
end;

initialization
  TDUnitX.RegisterTestFixture(TSysUtilsFalseBoolStrsTests);

end.
