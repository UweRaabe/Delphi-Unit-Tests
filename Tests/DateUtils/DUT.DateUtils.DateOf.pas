unit DUT.DateUtils.DateOf;

interface

uses
  System.DateUtils,
  System.SysUtils,
  DUnitX.TestFramework;


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

initialization
  TDUnitX.RegisterTestFixture(TDateUtilsOfTests);

end.
