unit DUT.StrUtils;

interface

uses
  System.StrUtils,
  DUnitX.TestFramework;

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
    [Test]
    procedure TestContainsTextShouldReturnTrueForSameStringsDifferentCase;
  end;

  [TestFixture]
  TStrUtilsContainsStrTests = class
  private
    aText, aSubText: String;
    Actual: Boolean;
  public
    [Test]
    procedure TestContainsStrWithSimpleContains;
    [Test]
    procedure TestContainsStrShouldReturnFalseForSameStringsDifferentCase;
  end;

  [TestFixture]
  TStrUtilsIfThenTests = class
  private
    aTrueText, aFalseText: String;
    Actual: String;
  public
    [Test]
    procedure TestIfThenReturnsTrue;
    [Test]
    procedure TestIfThenReturnsFalse;
    [Test]
    procedure TestIfThenReturnsFalseIsOptional;
  end;

  [TestFixture]
  TStrUtilsStartsTextTests = class
    [Test]
    procedure TestThatStartTestRecognizesFirstLetter;
    [Test]
    procedure TestThatStartTextSeesFirstTwoLetters;
    [Test]
    procedure TestThatCompleteTextReturnsTrue;
    [Test]
    procedure TestToMakeSureLongerStringFails;
  end;

  TStrUtilsAnsiStartsTextTests = class
    [Test]
    procedure TestThatCompleteTextReturnsTrue;
    [Test]
    procedure TestThatStartTestRecognizesFirstLetter;
    [Test]
    procedure TestThatStartTextSeesFirstTwoLetters;
    [Test]
    procedure TestToMakeSureLongerStringFails;
  end;

  [TestFixture]
  TStrUtilsEndsTextTests = class
    [Test]
    procedure TestSimpleExampleWithAlphabet;
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

procedure TStrUtilsContainsTextTests.TestContainsTextShouldReturnTrueForSameStringsDifferentCase;
begin
  aText := 'abc';
  aSubText := 'ABC';
  Actual := ContainsText(aText, aSubText);
  Assert.IsTrue(Actual, Format('ContainsText says that "%s" is not contained within "%s".', [aSubText, aText]));
end;

{ TStrUtilsContainsStrTests }
procedure TStrUtilsContainsStrTests.TestContainsStrWithSimpleContains;
begin
  aText := 'abc';
  aSubText := 'b';
  Actual := ContainsStr(aText, aSubText);
  Assert.IsTrue(Actual, Format('ContainsStr says that "%s" is not contained within "%s".', [aSubText, aText]));
end;

procedure TStrUtilsContainsStrTests.TestContainsStrShouldReturnFalseForSameStringsDifferentCase;
begin
  aText := 'abc';
  aSubText := 'ABC';
  Actual := ContainsStr(aText, aSubText);
  Assert.IsFalse(Actual, Format('ContainsStr says that "%s" is contained within "%s".', [aSubText, aText]));
end;

{ TStrUtilsIfThenTests }

procedure TStrUtilsIfThenTests.TestIfThenReturnsTrue;
begin
  aTrueText := 'true';
  aFalseText := 'false';
  Actual := IfThen( True, aTrueText, aFalseText );
  Assert.IsTrue(Actual = aTrueText, Format('IfThen should have returned %s', [ aTrueText ] ));
end;

procedure TStrUtilsIfThenTests.TestIfThenReturnsFalse;
begin
  aTrueText := 'true';
  aFalseText := 'false';
  Actual := IfThen( False, aTrueText, aFalseText );
  Assert.IsTrue(Actual = aFalseText, Format('IfThen should have returned %s', [ aFalseText ] ));
end;

procedure TStrUtilsIfThenTests.TestIfThenReturnsFalseIsOptional;
begin
  aTrueText := 'true';
  Actual := IfThen( False, aTrueText );
  Assert.IsTrue(Actual = '', 'IfThen should have returned an empty string');
end;


{ TStrUtilsStartsTextTests }


procedure TStrUtilsStartsTextTests.TestThatCompleteTextReturnsTrue;
var
  Expected, Actual: Boolean;
begin
  Expected := True;
  Actual := StartsText('boondoggle', 'boondoggle');

  Assert.AreEqual(Expected, Actual);

end;

procedure TStrUtilsStartsTextTests.TestThatStartTestRecognizesFirstLetter;
var
  Expected, Actual: Boolean;
begin
  Expected := True;
  Actual := StartsText('b', 'boondoggle');

  Assert.AreEqual(Expected, Actual);

end;

procedure TStrUtilsStartsTextTests.TestThatStartTextSeesFirstTwoLetters;
var
  Expected, Actual: Boolean;
begin
  Expected := True;
  Actual := StartsText('bo', 'boondoggle');

  Assert.AreEqual(Expected, Actual);

end;

procedure TStrUtilsStartsTextTests.TestToMakeSureLongerStringFails;
var
  Expected, Actual: Boolean;
begin
  Expected := False;
  Actual := StartsText('boondoggles', 'boondoggle');

  Assert.AreEqual(Expected, Actual);

end;

{ TStrUtilsAnsiStartsTextTests }

procedure TStrUtilsAnsiStartsTextTests.TestThatCompleteTextReturnsTrue;
var
  Expected, Actual: Boolean;
begin
  Expected := True;
  Actual := AnsiStartsText('boondoggle', 'boondoggle');

  Assert.AreEqual(Expected, Actual);

end;

procedure TStrUtilsAnsiStartsTextTests.TestThatStartTestRecognizesFirstLetter;
var
  Expected, Actual: Boolean;
begin
  Expected := True;
  Actual := AnsiStartsText('b', 'boondoggle');

  Assert.AreEqual(Expected, Actual);

end;

procedure TStrUtilsAnsiStartsTextTests.TestThatStartTextSeesFirstTwoLetters;
var
  Expected, Actual: Boolean;
begin
  Expected := True;
  Actual := AnsiStartsText('bo', 'boondoggle');

  Assert.AreEqual(Expected, Actual);

end;

procedure TStrUtilsAnsiStartsTextTests.TestToMakeSureLongerStringFails;
var
  Expected, Actual: Boolean;
begin
  Expected := False;
  Actual := AnsiStartsText('boondoggles', 'boondoggle');

  Assert.AreEqual(Expected, Actual);

end;

{ TStrUtilsEndsTextTests }

procedure TStrUtilsEndsTextTests.TestSimpleExampleWithAlphabet;
var
  Expected: Boolean;
  Actual: Boolean;
begin
  Expected := True;
  Actual := EndsText('c', 'abc');

  Assert.AreEqual(Expected, Actual);
end;

initialization
  TDUnitX.RegisterTestFixture(TStrUtilsResemblesTests);
  TDUnitX.RegisterTestFixture(TStrUtilsContainsTextTests);
  TDUnitX.RegisterTestFixture(TStrUtilsContainsStrTests);
  TDUnitX.RegisterTestFixture(TStrUtilsIfThenTests);
  TDUnitX.RegisterTestFixture(TStrUtilsStartsTextTests);
  TDUnitX.RegisterTestFixture(TStrUtilsAnsiStartsTextTests);
  TDUnitX.RegisterTestFixture(TStrUtilsEndsTextTests);

end.
