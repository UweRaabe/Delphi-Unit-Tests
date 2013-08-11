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

implementation

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

initialization
  TDUnitX.RegisterTestFixture(TStrUtilsResemblesTests);

end.
