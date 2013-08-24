unit DUT.DateUtils.MiscFunctions;

interface

uses
  {$if CompilerVersion < 23 }
    DateUtils,
    SysUtils,
  {$else}
    System.DateUtils, // Delphi XE2 (CompilerVersion 23) added scopes in front of unit names
    System.SysUtils,
  {$ifend}
   DUnitX.TestFramework;

type
  [TestFixture]
  TDateUtilsMiscFunctionTests = class
  private
    Input: TDateTime;
    Expected: TDateTime;
    Actual: TDateTime;
  public
    [Test]
    procedure TestIncDay;
    [Test]
    procedure TestIncHour;
    [Test]
    procedure TestIncMilliSecond;
    [Test]
    procedure TestIncMinute;
    [Test]
    procedure TestIncMonth;
    [Test]
    procedure TestIncSecond;
    [Test]
    procedure TestIncWeek;
    [Test]
    procedure TestIncYear;
    [Test]
    procedure TestIsAMWithNormalDate;
    [Test]
    procedure TestIsInLeapYearWithNormalDate;
    [Test]
    procedure TestIsPMWithNormalDate;
    [Test]
    procedure TestIsTodayWithNotToday;
    [Test]
    procedure TestIsTodayWithToday;
  end;

implementation

{ TDateUtilsMiscFunctionTests }

procedure TDateUtilsMiscFunctionTests.TestIncDay;
begin
  Expected := 1;
  Input := 0;
  Actual := IncDay(Input);
  Assert.AreEqual(DateTimeToStr(Expected), DateTimeToStr(Actual), 'IncDay did not add 1 day');
end;

procedure TDateUtilsMiscFunctionTests.TestIncHour;
begin
  Expected := 0.5;
  Input := 0;
  Actual := IncHour(Input, 12);
  Assert.AreEqual(DateTimeToStr(Expected), DateTimeToStr(Actual), 'IncHour did not add 12 hours');
end;

procedure TDateUtilsMiscFunctionTests.TestIncMilliSecond;
begin
  Expected := EncodeDateTime(1944, 1, 2, 3, 4, 6, 0);
  Input := EncodeDateTime(1944, 1, 2, 3, 4, 5, 999);
  Actual := IncMilliSecond(Input, 1);
  Assert.AreEqual(DateTimeToStr(Expected), DateTimeToStr(Actual), 'IncMilliSecond did not add 1 millisecond');
end;

procedure TDateUtilsMiscFunctionTests.TestIncMinute;
begin
  Expected := 1;
  Input := 0;
  Actual := IncMinute(Input, 24 * 60);
  Assert.AreEqual(DateTimeToStr(Expected), DateTimeToStr(Actual), 'IncMinute did not add 1440 minutes');
end;

procedure TDateUtilsMiscFunctionTests.TestIncMonth;
begin
  Expected := EncodeDate(1984, 7, 1);
  Input := EncodeDate(1984, 6, 1);
  Actual := IncMonth(Input, 1);
  Assert.AreEqual(DateTimeToStr(Expected), DateTimeToStr(Actual), 'IncMonth did not add 1 month');
end;

procedure TDateUtilsMiscFunctionTests.TestIncSecond;
begin
  Expected := 1;
  Input := 0;
  Actual := IncSecond(Input, 24 * 60 * 60);
  Assert.AreEqual(DateTimeToStr(Expected), DateTimeToStr(Actual), 'IncSecond did not add 86400 seconds');
end;

procedure TDateUtilsMiscFunctionTests.TestIncWeek;
begin
  Expected := 7;
  Input := 0;
  Actual := IncWeek(Input, 1);
  Assert.AreEqual(DateTimeToStr(Expected), DateTimeToStr(Actual), 'IncWeek did not add 1 week');
end;

procedure TDateUtilsMiscFunctionTests.TestIncYear;
begin
  Expected := 365;
  Input := 0;
  Actual := IncYear(Input, 1);
  Assert.AreEqual(DateTimeToStr(Expected), DateTimeToStr(Actual), 'IncYear did not add 1 year');
end;

procedure TDateUtilsMiscFunctionTests.TestIsAMWithNormalDate;
begin
  Input := EncodeDateTime(1933, 6, 23, 0, 23, 23, 23);
  Assert.IsTrue(IsAM(Input), 'IsAM says a date in the evening is not in the AM');
end;

procedure TDateUtilsMiscFunctionTests.TestIsInLeapYearWithNormalDate;
begin
  Input := EncodeDate(1984, 6, 24); // Leap year
  Assert.IsTrue(IsInLeapYear(Input), 'IsInLeapYear says a date in 1984 is not in a leap year');
end;

procedure TDateUtilsMiscFunctionTests.TestIsPMWithNormalDate;
begin
  Input := EncodeDateTime(1933, 6, 23, 23, 23, 23, 23);
  Assert.IsTrue(IsPM(Input), 'IsPM says a date in the evening is not in the PM');
end;

procedure TDateUtilsMiscFunctionTests.TestIsTodayWithNotToday;
begin
  Input := 0;
  Assert.IsFalse(IsToday(Input), 'IsToday says 12/30/1899 is the current date');
end;

procedure TDateUtilsMiscFunctionTests.TestIsTodayWithToday;
begin
  Assert.IsTrue(IsToday(Today()), 'IsToday says Today() is not the current date');
end;

initialization
  TDUnitX.RegisterTestFixture(TDateUtilsMiscFunctionTests);

end.
