unit DUT.DateUtils;

interface

uses
       DUnitX.TestFramework
     , DateUtils
     , SysUtils
     ;

{
DateUtils is pretty nicely divided up into groups of functions.  Let's try to
create a TestFixture for each one.
}

type

  [TestFixture]
  TDateUtilsOfTests = class
  var
    Input: TDateTime;
    [Setup]
    procedure Setup;
  public
    [Test]
    procedure TestDateOf;
    procedure TestTimeOf;
  end;

  [TestFixture]
  TDateUtilsMiscFunctionTests = class
  private
    Input: TDateTime;
    Expected: TDateTime;
    Actual: TDateTime;
  public
    [Test]
    procedure TestIsInLeapYearWithNormalDate;
  end;


implementation

{ TDateUtilsOfTests }

procedure TDateUtilsOfTests.Setup;
begin
  Input := EncodeDateTime(1944, 1, 2, 3, 4, 5, 6);
end;

procedure TDateUtilsOfTests.TestDateOf;
var
  Expected: TDateTime;
  Actual: TDateTime;
begin
  Expected := EncodeDate(1944, 1, 2);
  Actual := DateOf(Input);
  Assert.AreEqual(Expected, Actual);
end;

procedure TDateUtilsOfTests.TestTimeOf;
var
  Expected: TDateTime;
  Actual: TDateTime;
begin
  Expected := EncodeTime(3, 4, 5, 6);
  Actual := TimeOf(Input);
  Assert.AreEqual(Expected, Actual);

end;


{ TDateUtilsMiscFunctionTests }

procedure TDateUtilsMiscFunctionTests.TestIsInLeapYearWithNormalDate;
begin
  Input := EncodeDate(1984, 6, 24); // Leap year
  Assert.IsTrue(IsInLeapYear(Input), 'Is in year says a date in 1984 is not in a leap year');
end;

initialization
  TDUnitX.RegisterTestFixture(TDateUtilsOfTests);
  TDUnitX.RegisterTestFixture(TDateUtilsMiscFunctionTests);
end.
