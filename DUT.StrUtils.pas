unit DUT.StrUtils;

interface

uses
      DUnitX.TestFramework
    , System.StrUtils
    ;

type
  [TestFixture]
  TStrUtilsResemblesTests = class
  private
    Input1, Input2: String;
    Actual: Boolean;
  public
    [Test]
    procedure TestResembleAlmostSame;
    [Test]
    procedure TestResembleTextTotallyDifferent;
    [Test]
    procedure TestResembleTextVeryDifferentButShouldMatch;
  end;

  [TestFixture]
  TStrUtilsContainsTextTests = class
  private
    aText, aSubText: String;
    Actual: Boolean;
  public
    [Test]
    procedure TestContainsTextWithSimpleContains;
    [Test]
    procedure TestContainsTextLastChar;
    [Test]
    procedure TestContainsTextFirstChar;
    [Test]
    procedure TestContainsTextContainsSelf;
  end;

implementation

uses
      SysUtils
    ;

{ TStrUtilsResemblesTests }

procedure TStrUtilsResemblesTests.TestResembleAlmostSame;
begin
  Input1 := 'Smith';
  Input2 := 'Smyth';
  Actual := ResemblesText(Input1, Input2);
  Assert.IsTrue(Actual, 'ResembleText says two similar strings aren''t.');
  Actual := AnsiResemblesText(Input1, Input2);
  Assert.IsTrue(Actual, 'AnsiResembleText says two similar strings aren''t.');
end;

procedure TStrUtilsResemblesTests.TestResembleTextTotallyDifferent;
begin
  Input1 := 'Smith';
  Input2 := 'Jones';
  Actual := ResemblesText(Input1, Input2);
  Assert.IsFalse(Actual, 'ResembleText says two dissimilar strings are similar.');
  Actual := AnsiResemblesText(Input1, Input2);
  Assert.IsFalse(Actual, 'AnsiResembleText says two dissimilar strings are similar.');
end;

procedure TStrUtilsResemblesTests.TestResembleTextVeryDifferentButShouldMatch;
begin
  Input1 := 'Soundex';
  Input2 := 'Sownteks';
  Actual := ResemblesText(Input1, Input2);
  Assert.IsTrue(Actual, 'ResembleText says two strings don''t match when they should.');
  Actual := ResemblesText(Input1, Input2);
  Assert.IsTrue(Actual, 'AnsiResembleText says two strings don''t match when they should.');
end;

{ TStrUtilsContainsTextTests }

procedure TStrUtilsContainsTextTests.TestContainsTextFirstChar;
begin
  aText := 'abc';
  aSubText := 'a';
  Actual := ContainsText(aText, aSubText);
  Assert.IsTrue(Actual, Format('ContainsText says that %s is not contained within %s.', [aSubText, aText]));
end;

procedure TStrUtilsContainsTextTests.TestContainsTextLastChar;
begin
  aText := 'abc';
  aSubText := 'c';
  Actual := ContainsText(aText, aSubText);
  Assert.IsTrue(Actual, Format('ContainsText says that %s is not contained within %s.', [aSubText, aText]));
end;

procedure TStrUtilsContainsTextTests.TestContainsTextContainsSelf;
begin
  aText := 'abc';
  Actual := ContainsText(aText, aText);
  Assert.IsTrue(Actual, Format('ContainsText says that %s is not contained within %s.', [aSubText, aText]));
end;

procedure TStrUtilsContainsTextTests.TestContainsTextWithSimpleContains;
begin
  aText := 'abc';
  aSubText := 'b';
  Actual := ContainsText(aText, aSubText);
  Assert.IsTrue(Actual, Format('ContainsText says that %s is not contained within %s.', [aSubText, aText]));
end;

initialization
  TDUnitX.RegisterTestFixture(TStrUtilsResemblesTests);
  TDUnitX.RegisterTestFixture(TStrUtilsContainsTextTests);

end.
