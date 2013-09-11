unit DUT.DateUtils.EndOf;

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
  TDateUtilsEndOfADayTests = class
  private
    Expected: TDateTime;
    Actual: TDateTime;
  public
    [Test]
    procedure TestEndOfADayOutOfRangeDayOfYear;
    [Test]
    procedure TestEndOfADayOutOfRangeYear;
    [Test]
    procedure TestEndOfADay;
  end;

type
  [TestFixture]
  TDateUtilsEndOfAMonthTests = class
  private
    Expected: TDateTime;
    Actual: TDateTime;
  public
    [Test]
    procedure TestEndOfAMonthOutOfRangeMonth;
    [Test]
    procedure TestEndOfAMonthOutOfRangeYear;
    [Test]
    procedure TestEndOfAMonth;
  end;

type
  [TestFixture]
  TDateUtilsEndOfAWeekTests = class
  private
    Expected: TDateTime;
    Actual: TDateTime;
  public
    [Test]
    procedure TestEndOfAWeekOutOfRangeDayOfWeek;
    [Test]
    procedure TestEndOfAWeekOutOfRangeWeekOfYear;
    [Test]
    procedure TestEndOfAWeekOutOfRangeYear;
    [Test]
    procedure TestEndOfAWeek;
  end;

type
  [TestFixture]
  TDateUtilsEndOfAYearTests = class
  private
    Expected: TDateTime;
    Actual: TDateTime;
  public
    [Test]
    procedure TestEndOfAYearOutOfRangeYear;
    [Test]
    procedure TestEndOfAYear;
  end;

type
  [TestFixture]
  TDateUtilsEndOfTheDayTests = class
  private
    Expected: TDateTime;
    Actual: TDateTime;
  public
    [Test]
    procedure TestEndOfTheDay;
  end;

type
  [TestFixture]
  TDateUtilsEndOfTheMonthTests = class
  private
    Expected: TDateTime;
    Actual: TDateTime;
  public
    [Test]
    procedure TestEndOfTheMonth;
  end;

type
  [TestFixture]
  TDateUtilsEndOfTheWeekTests = class
  private
    Expected: TDateTime;
    Actual: TDateTime;
  public
    [Test]
    procedure TestEndOfTheWeek;
  end;

type
  [TestFixture]
  TDateUtilsEndOfTheYearTests = class
  private
    Expected: TDateTime;
    Actual: TDateTime;
  public
    [Test]
    procedure TestEndOfTheYear;
  end;

implementation

{ TDateUtilsEndOfADayTests }

procedure TDateUtilsEndOfADayTests.TestEndOfADayOutOfRangeDayOfYear;
var
  TempMethod: TTestLocalMethod;
begin
  TempMethod := procedure
    begin
      EndOfADay(1, 0);
    end;
  Assert.WillRaise(TempMethod, EConvertError,
    'EndOfADay failed to throw EConvertError exception for DayOfYear = 0');
end;

procedure TDateUtilsEndOfADayTests.TestEndOfADayOutOfRangeYear;
var
  TempMethod: TTestLocalMethod;
begin
  TempMethod := procedure
    begin
      EndOfADay(0, 1);
    end;
  Assert.WillRaise(TempMethod, EConvertError,
    'EndOfADay failed to throw EConvertError exception for Year = 0');
end;

procedure TDateUtilsEndOfADayTests.TestEndOfADay;
begin
  //
  // this test is NOT for out of range errors
  //
  Expected := EncodeDateTime(1933, 1, 1, 23, 59, 59, 999);
  Actual := EndOfADay(1933, 1);
  Assert.IsTrue(Expected = Actual,
    'EndOfADay failed to encode 1-1-1933 11:59:59.999 PM');
end;

{ TDateUtilsEndOfAMonthTests }

procedure TDateUtilsEndOfAMonthTests.TestEndOfAMonthOutOfRangeMonth;
var
  TempMethod: TTestLocalMethod;
begin
  TempMethod := procedure
    begin
      EndOfAMonth(1, 0);
    end;
  Assert.WillRaise(TempMethod, EConvertError,
    'EndOfAMonth failed to throw EConvertError exception for Month = 0');
end;

procedure TDateUtilsEndOfAMonthTests.TestEndOfAMonthOutOfRangeYear;
var
  TempMethod: TTestLocalMethod;
begin
  TempMethod := procedure
    begin
      EndOfAMonth(0, 1);
    end;
  Assert.WillRaise(TempMethod, EConvertError,
    'EndOfAMonth failed to throw EConvertError exception for Year = 0');
end;

procedure TDateUtilsEndOfAMonthTests.TestEndOfAMonth;
begin
  //
  // this test is NOT for out of range errors
  //
  Expected := EncodeDateTime(1933, 1, 31, 23, 59, 59, 999);
  Actual := EndOfAMonth(1933, 1);
  Assert.IsTrue(Expected = Actual,
    'EndOfAMonth failed to encode 1-1-1933 11:59:59.999 PM');
end;

{ TDateUtilsEndOfAWeekTests }

procedure TDateUtilsEndOfAWeekTests.TestEndOfAWeekOutOfRangeDayOfWeek;
var
  TempMethod: TTestLocalMethod;
begin
  TempMethod := procedure
    begin
      EndOfAWeek(1, 1, 0);
    end;
  Assert.WillRaise(TempMethod, EConvertError,
    'EndOfAWeek failed to throw EConvertError exception for WeekOfYear = 0');
end;

procedure TDateUtilsEndOfAWeekTests.TestEndOfAWeekOutOfRangeWeekOfYear;
var
  TempMethod: TTestLocalMethod;
begin
  TempMethod := procedure
    begin
      EndOfAWeek(1, 0, DaySunday);
    end;
  Assert.WillRaise(TempMethod, EConvertError,
    'EndOfAWeek failed to throw EConvertError exception for WeekOfYear = 0');
end;

procedure TDateUtilsEndOfAWeekTests.TestEndOfAWeekOutOfRangeYear;
var
  TempMethod: TTestLocalMethod;
begin
  TempMethod := procedure
    begin
      EndOfAWeek(0, 1, DaySunday);
    end;
  Assert.WillRaise(TempMethod, EConvertError,
    'EndOfAWeek failed to throw EConvertError exception for Year = 0');
end;

procedure TDateUtilsEndOfAWeekTests.TestEndOfAWeek;
begin
  //
  // this test is NOT for out of range errors
  //
  Expected := EncodeDateTime(1899, 1, 8, 23, 59, 59, 999);
  Actual := EndOfAWeek(1899, 1, DaySunday);
  Assert.IsTrue(Expected = Actual,
    'EndOfAWeek failed to encode 1-8-1899 11:59:59.999 PM');
end;

{ TDateUtilsEndOfAYearTests }

procedure TDateUtilsEndOfAYearTests.TestEndOfAYearOutOfRangeYear;
var
  TempMethod: TTestLocalMethod;
begin
  TempMethod := procedure
    begin
      EndOfAYear(0);
    end;
  Assert.WillRaise(TempMethod, EConvertError,
    'EndOfAYear failed to throw EConvertError exception for Year = 0');
end;

procedure TDateUtilsEndOfAYearTests.TestEndOfAYear;
begin
  //
  // this test is NOT for out of range errors
  //
  Expected := EncodeDateTime(1899, 12, 31, 23, 59, 59, 999);
  Actual := EndOfAYear(1899);
  Assert.IsTrue(Expected = Actual,
    'EndOfAYear failed to encode 12-31-1899 11:59:59.999 PM');
end;

{ TDateUtilsEndOfTheDayTests }

procedure TDateUtilsEndOfTheDayTests.TestEndOfTheDay;
begin
  Expected := EncodeDateTime(1899, 12, 30, 23, 59, 59, 999);
  Actual := EndOfTheDay(0);
  Assert.IsTrue(Expected = Actual,
    'EndOfTheDay failed to encode 12-30-1899 11:59:59.999 PM');
end;

{ TDateUtilsEndOfTheMonthTests }

procedure TDateUtilsEndOfTheMonthTests.TestEndOfTheMonth;
begin
  Expected := EncodeDateTime(1899, 12, 31, 23, 59, 59, 999);
  Actual := EndOfTheMonth(0);
  Assert.IsTrue(Expected = Actual,
    'EndOfTheMonth failed to encode 12-31-1899 11:59:59.999 PM');
end;

{ TDateUtilsEndOfTheWeekTests }

procedure TDateUtilsEndOfTheWeekTests.TestEndOfTheWeek;
begin
  Expected := EncodeDateTime(1899, 12, 31, 23, 59, 59, 999);
  Actual := EndOfTheWeek(0);
  Assert.IsTrue(Expected = Actual,
    'EndOfTheWeek failed to encode 12-31-1899 11:59:59.999 PM');
end;

{ TDateUtilsEndOfTheWeekTests }

procedure TDateUtilsEndOfTheYearTests.TestEndOfTheYear;
begin
  Expected := EncodeDateTime(1899, 12, 31, 23, 59, 59, 999);
  Actual := EndOfTheYear(0);
  Assert.IsTrue(Expected = Actual,
    'EndOfTheYear failed to encode 12-31-1899 11:59:59.999 PM');
end;

initialization
  TDUnitX.RegisterTestFixture(TDateUtilsEndOfADayTests);
  TDUnitX.RegisterTestFixture(TDateUtilsEndOfAMonthTests);
  TDUnitX.RegisterTestFixture(TDateUtilsEndOfAWeekTests);
  TDUnitX.RegisterTestFixture(TDateUtilsEndOfAYearTests);
  TDUnitX.RegisterTestFixture(TDateUtilsEndOfTheDayTests);
  TDUnitX.RegisterTestFixture(TDateUtilsEndOfTheMonthTests);
  TDUnitX.RegisterTestFixture(TDateUtilsEndOfTheWeekTests);
  TDUnitX.RegisterTestFixture(TDateUtilsEndOfTheYearTests);

end.
