unit DUT.DateUtils.Encode;


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

{
DateUtils is pretty nicely divided up into groups of functions.  Let's try to
create a TestFixture for each one.
}

type
  [TestFixture]
  TDateUtilsEncodeDateTimeTests = class
  public
    [Test]
    procedure TestEncodeDateTimeDetectCorrectLeapYear;
    [Test]
    procedure TestEncodeDateTimeDetectIncorrectLeapYear;
    [Test]
    procedure TestEncodeDateTimeOutOfRangeDay;
    [Test]
    procedure TestEncodeDateTimeOutOfRangeHour;
    [Test]
    procedure TestEncodeDateTimeOutOfRangeMin;
    [Test]
    procedure TestEncodeDateTimeOutOfRangeMonth;
    [Test]
    procedure TestEncodeDateTimeOutOfRangeMSec;
    [Test]
    procedure TestEncodeDateTimeOutOfRangeSec;
    [Test]
    procedure TestEncodeDateTimeOutOfRangeYear;
    [Test]
    procedure TestEncodeDateTime;
  end;

type
  [TestFixture]
  TDateUtilsEncodeDateDayTests = class
  public
    [Test]
    procedure TestEncodeDateDayOutOfRangeDay;
    [Test]
    procedure TestEncodeDateDayOutOfRangeYear;
    [Test]
    procedure TestEncodeDateDay;
  end;

type
  [TestFixture]
  TDateUtilsEncodeDateMonthWeekTests = class
  public
    [Test]
    procedure TestEncodeDateMonthWeekOutOfRangeDayOfWeek;
    [Test]
    procedure TestEncodeDateMonthWeekOutOfRangeMonth;
    [Test]
    procedure TestEncodeDateMonthWeekOutOfRangeWeekOfMonth;
    [Test]
    procedure TestEncodeDateMonthWeekOutOfRangeYear;
    [Test]
    procedure TestEncodeDateMonthWeekRule1;
    [Test]
    procedure TestEncodeDateMonthWeekRule2;
    [Test]
    procedure TestEncodeDateMonthWeek;
  end;

type
  [TestFixture]
  TDateUtilsEncodeDateWeekTests = class
  public
    [Test]
    procedure TestEncodeDateWeekOutOfRangeDayOfWeek;
    [Test]
    procedure TestEncodeDateWeekOutOfRangeWeekOfYear;
    [Test]
    procedure TestEncodeDateWeekOutOfRangeYear;
    [Test]
    procedure TestEncodeDateWeekRule1;
    [Test]
    procedure TestEncodeDateWeekRule2;
    [Test]
    procedure TestEncodeDateWeek;
  end;

type
  [TestFixture]
  TDateUtilsEncodeDayOfWeekInMonthTests = class
  public
    [Test]
    procedure TestEncodeDayOfWeekInMonthOutOfRangeDayOfWeek;
    [Test]
    procedure TestEncodeDayOfWeekInMonthOutOfRangeMonth;
    [Test]
    procedure TestEncodeDayOfWeekInMonthOutOfRangeNthDayOfWeek;
    [Test]
    procedure TestEncodeDayOfWeekInMonthOutOfRangeYear;
    [Test]
    procedure TestEncodeDayOfWeekInMonth;
  end;

implementation

{ TDateUtilsEncodeDateTimeTests }

procedure TDateUtilsEncodeDateTimeTests.TestEncodeDateTimeDetectCorrectLeapYear;
var
  TempMethod: TTestLocalMethod;
begin
  TempMethod := procedure begin EncodeDateTime(4,2,29,0,0,0,0) end;  // Year 4 is the first leap year
  Assert.WillNotRaise(TempMethod, EConvertError, 'EncodeDateTime incorrectly allowed for Day = 29 for a leap year');
end;

procedure TDateUtilsEncodeDateTimeTests.TestEncodeDateTimeDetectIncorrectLeapYear;
var
  TempMethod: TTestLocalMethod;
begin
  TempMethod := procedure begin EncodeDateTime(100,2,29,0,0,0,0) end;  // 100 is the first year divisible by 4 which is not a leap year
  Assert.WillRaise(TempMethod, EConvertError, 'EncodeDateTime failed to throw EConvertError exception for Day = 29 for a non leap year');
end;

procedure TDateUtilsEncodeDateTimeTests.TestEncodeDateTimeOutOfRangeDay;
var
  TempMethod: TTestLocalMethod;
begin
  TempMethod := procedure begin EncodeDateTime(1,1,0,0,0,0,0) end;
  Assert.WillRaise(TempMethod, EConvertError, 'EncodeDateTime failed to throw EConvertError exception for Day = 0');
end;

procedure TDateUtilsEncodeDateTimeTests.TestEncodeDateTimeOutOfRangeHour;
var
  TempMethod: TTestLocalMethod;
begin
  TempMethod := procedure begin EncodeDateTime(1,1,1,25,0,0,0) end;
  Assert.WillRaise(TempMethod, EConvertError, 'EncodeDateTime failed to throw EConvertError exception for Hour = 25');
end;

procedure TDateUtilsEncodeDateTimeTests.TestEncodeDateTimeOutOfRangeMin;
var
  TempMethod: TTestLocalMethod;
begin
  TempMethod := procedure begin EncodeDateTime(1,1,1,0,60,0,0) end;
  Assert.WillRaise(TempMethod, EConvertError, 'EncodeDateTime failed to throw EConvertError exception for Min = 60');
end;

procedure TDateUtilsEncodeDateTimeTests.TestEncodeDateTimeOutOfRangeMonth;
var
  TempMethod: TTestLocalMethod;
begin
  TempMethod := procedure begin EncodeDateTime(1,0,1,0,0,0,0) end;;
  Assert.WillRaise(TempMethod, EConvertError, 'EncodeDateTime failed to throw EConvertError exception for Month = 0');
end;

procedure TDateUtilsEncodeDateTimeTests.TestEncodeDateTimeOutOfRangeMSec;
var
  TempMethod: TTestLocalMethod;
begin
  TempMethod := procedure begin EncodeDateTime(1,1,1,0,0,0,1000) end;
  Assert.WillRaise(TempMethod, EConvertError, 'EncodeDateTime failed to throw EConvertError exception for MSec = 1000');
end;

procedure TDateUtilsEncodeDateTimeTests.TestEncodeDateTimeOutOfRangeSec;
var
  TempMethod: TTestLocalMethod;
begin
  TempMethod := procedure begin EncodeDateTime(1,1,1,0,0,60,0) end;
  Assert.WillRaise(TempMethod, EConvertError, 'EncodeDateTime failed to throw EConvertError exception for Sec = 60');
end;

procedure TDateUtilsEncodeDateTimeTests.TestEncodeDateTimeOutOfRangeYear;
var
  TempMethod: TTestLocalMethod;
begin
  TempMethod := procedure begin EncodeDateTime(0,1,1,0,0,0,0) end;
    Assert.WillRaise(TempMethod, EConvertError, 'EncodeDateTime failed to throw EConvertError exception for Year = 0');
end;

procedure TDateUtilsEncodeDateTimeTests.TestEncodeDateTime;
var
  _date : TDateTime;
  _format_settings : TFormatSettings;
begin
  //
  // this test is NOT for out of range errors
  //
  _date := EncodeDateTime(1944, 1, 2, 3, 4, 5, 6);
  _format_settings.DateSeparator := '-';
  _format_settings.ShortDateFormat := 'm-d-yyyy';
  _format_settings.TimeSeparator := ':';
  _format_settings.LongTimeFormat := 'h:m:s';
  Assert.AreEqual('1-2-1944 3:4:5', DateTimeToStr(_date,_format_settings), 'EncodeDateTime failed to encode 1-2-1944 3:4:5');
end;

{ TDateUtilsEncodeDateDayTests }

procedure TDateUtilsEncodeDateDayTests.TestEncodeDateDayOutOfRangeDay;
var
  TempMethod: TTestLocalMethod;
begin
  TempMethod := procedure
    begin
      EncodeDateDay(1, 0)
    end;
  Assert.WillRaise(TempMethod, EConvertError,
    'EncodeDateDay failed to throw EConvertError exception for Day = 0');
end;

procedure TDateUtilsEncodeDateDayTests.TestEncodeDateDayOutOfRangeYear;
var
  TempMethod: TTestLocalMethod;
begin
  TempMethod := procedure
    begin
      EncodeDateDay(0, 1)
    end;
  Assert.WillRaise(TempMethod, EConvertError,
    'EncodeDateDay failed to throw EConvertError exception for Year = 0');
end;

procedure TDateUtilsEncodeDateDayTests.TestEncodeDateDay;
var
  _date: TDateTime;
  _format_settings: TFormatSettings;
begin
  //
  // this test is NOT for out of range errors
  //
  _date := EncodeDateDay(1944, 2);
  _format_settings.DateSeparator := '-';
  _format_settings.ShortDateFormat := 'm-d-yyyy';
  Assert.AreEqual('1-2-1944', DateTimeToStr(_date, _format_settings),
    True, 'EncodeDateDay failed to encode 1-2-1944');
end;

{ TestEncodeDateMonthWeekTests }

procedure TDateUtilsEncodeDateMonthWeekTests.TestEncodeDateMonthWeekOutOfRangeDayOfWeek;
var
  TempMethod: TTestLocalMethod;
begin
  TempMethod := procedure
    begin
      EncodeDateMonthWeek(1933, 6, 4, 0);
    end;
  Assert.WillRaise(TempMethod, EConvertError,
    'EncodeDateMonthWeek failed to throw EConvertError exception for DayOfWeek = 0');
end;

procedure TDateUtilsEncodeDateMonthWeekTests.TestEncodeDateMonthWeekOutOfRangeMonth;
var
  TempMethod: TTestLocalMethod;
begin
  TempMethod := procedure
    begin
      EncodeDateMonthWeek(1933, 0, 4, DayFriday);
    end;
  Assert.WillRaise(TempMethod, EConvertError,
    'EncodeDateMonthWeek failed to throw EConvertError exception for Month = 0');
end;

procedure TDateUtilsEncodeDateMonthWeekTests.TestEncodeDateMonthWeekOutOfRangeWeekOfMonth;
var
  TempMethod: TTestLocalMethod;
begin
  TempMethod := procedure
    begin
      EncodeDateMonthWeek(1933, 6, 0, DayFriday);
    end;
  Assert.WillRaise(TempMethod, EConvertError,
    'EncodeDateMonthWeek failed to throw EConvertError exception for WeekOfMonth = 0');
end;

procedure TDateUtilsEncodeDateMonthWeekTests.TestEncodeDateMonthWeekOutOfRangeYear;
var
  TempMethod: TTestLocalMethod;
begin
  TempMethod := procedure
    begin
      EncodeDateMonthWeek(0, 6, 4, DayFriday);
    end;
  Assert.WillRaise(TempMethod, EConvertError,
    'EncodeDateMonthWeek failed to throw EConvertError exception for Year = 0');
end;

procedure TDateUtilsEncodeDateMonthWeekTests.TestEncodeDateMonthWeekRule1;
var
  _date: TDateTime;
  _format_settings: TFormatSettings;
begin
  //
  // from the XE4 documentation
  //
  // if the first calendar day of the month is a Friday, Saturday, or Sunday,
  // then those three days must be expressed using AMonth set to the previous
  // month and AWeekOfMonth set to the number of weeks in the previous month
  //
  // October 1, 1933 is a Sunday so asking for the date of the Sunday in the
  // last week of September should return October 1
  //
  _date := EncodeDateMonthWeek(1933, 9, 4, DaySunday);
  _format_settings.DateSeparator := '-';
  _format_settings.ShortDateFormat := 'm-d-yyyy';
  Assert.AreEqual('10-1-1933', DateTimeToStr(_date, _format_settings),
    True, 'EncodeDateMonthWeek failed to encode 10-1-1933');
end;

procedure TDateUtilsEncodeDateMonthWeekTests.TestEncodeDateMonthWeekRule2;
var
  _date: TDateTime;
  _format_settings: TFormatSettings;
begin
  //
  // from the XE4 documentation
  //
  // if the last calendar day of the month is a Monday, Tuesday, or Wednesday,
  // then those three days are expressed with AMonth set to the following month
  // and AWeekOfMonth set to 1
  //
  // May 31, 1933 is a Wednesday so asking for the date of the Monday in the
  // first week of Jun should return May 29
  //
  _date := EncodeDateMonthWeek(1933, 6, 1, DayMonday);
  _format_settings.DateSeparator := '-';
  _format_settings.ShortDateFormat := 'm-d-yyyy';
  Assert.AreEqual('5-29-1933', DateTimeToStr(_date, _format_settings),
    True, 'EncodeDateMonthWeek failed to encode 5-29-1933');
end;

procedure TDateUtilsEncodeDateMonthWeekTests.TestEncodeDateMonthWeek;
var
  _date: TDateTime;
  _format_settings: TFormatSettings;
begin
  //
  // this test is NOT for out of range errors
  //
  _date := EncodeDateMonthWeek(1933, 6, 4, DayFriday);
  _format_settings.DateSeparator := '-';
  _format_settings.ShortDateFormat := 'm-d-yyyy';
  Assert.AreEqual('6-23-1933', DateTimeToStr(_date, _format_settings),
    True, 'EncodeDateDay failed to encode 6-23-1933');
end;

{ TDateUtilsEncodeDateWeekTests }

procedure TDateUtilsEncodeDateWeekTests.TestEncodeDateWeekOutOfRangeDayOfWeek;
var
  TempMethod: TTestLocalMethod;
begin
  TempMethod := procedure
    begin
      EncodeDateWeek(1933, 1, 0);
    end;
  Assert.WillRaise(TempMethod, EConvertError,
    'EncodeDateWeek failed to throw EConvertError exception for DayOfWeek = 0');
end;

procedure TDateUtilsEncodeDateWeekTests.TestEncodeDateWeekOutOfRangeWeekOfYear;
var
  TempMethod: TTestLocalMethod;
begin
  TempMethod := procedure
    begin
      EncodeDateWeek(1933, 0, DayFriday);
    end;
  Assert.WillRaise(TempMethod, EConvertError,
    'EncodeDateWeek failed to throw EConvertError exception for WeekOfYear = 0');
end;

procedure TDateUtilsEncodeDateWeekTests.TestEncodeDateWeekOutOfRangeYear;
var
  TempMethod: TTestLocalMethod;
begin
  TempMethod := procedure
    begin
      EncodeDateWeek(0, 1, DayFriday);
    end;
  Assert.WillRaise(TempMethod, EConvertError,
    'EncodeDateWeek failed to throw EConvertError exception for Year = 0');
end;

procedure TDateUtilsEncodeDateWeekTests.TestEncodeDateWeekRule1;
var
  _date: TDateTime;
  _format_settings: TFormatSettings;
begin
  //
  // from the XE4 documentation
  //
  // Note that if the first calendar day of the year is a Friday, Saturday,
  // or Sunday, then those three days must be expressed using AYear set to the
  // previous year and AWeekOfYear set to the number of weeks in the previous year.
  //
  // January 1, 1933 is a Sunday so that is the value that should be returned
  // when asking for the Sunday in the last week of 1932
  //
  _date := EncodeDateWeek(1932, 52, DaySunday);
  _format_settings.DateSeparator := '-';
  _format_settings.ShortDateFormat := 'm-d-yyyy';
  Assert.AreEqual('1-1-1933', DateTimeToStr(_date, _format_settings),
    'EncodeDateDay failed to encode 1-1-1933');
end;

procedure TDateUtilsEncodeDateWeekTests.TestEncodeDateWeekRule2;
var
  _date: TDateTime;
  _format_settings: TFormatSettings;
begin
  //
  // from the XE4 documentation
  //
  // if the last calendar day of the year is a Monday, Tuesday, or Wednesday,
  // then those three days are expressed with AYear set to the following year
  // and AWeekOfYear set to 1.
  //
  // December 31, 1934 is a Monday so that is the value that should be returned
  // when asking for the first Monday in the first week of 1935
  //
  _date := EncodeDateWeek(1935, 1, DayMonday);
  _format_settings.DateSeparator := '-';
  _format_settings.ShortDateFormat := 'm-d-yyyy';
  Assert.AreEqual('12-31-1934', DateTimeToStr(_date, _format_settings),
    True, 'EncodeDateWeek failed to encode 12-31-1934');
end;

procedure TDateUtilsEncodeDateWeekTests.TestEncodeDateWeek;
var
  _date: TDateTime;
  _format_settings: TFormatSettings;
begin
  //
  // this test is NOT for out of range errors
  //
  _date := EncodeDateWeek(1933, 52, DaySunday);
  _format_settings.DateSeparator := '-';
  _format_settings.ShortDateFormat := 'm-d-yyyy';
  Assert.AreEqual('12-31-1933', DateTimeToStr(_date, _format_settings),
    True, 'EncodeDateWeek failed to encode 12-31-1933');
end;

{ TDateUtilsEncodeDayOfWeekInMonthTests }

procedure TDateUtilsEncodeDayOfWeekInMonthTests.TestEncodeDayOfWeekInMonthOutOfRangeDayOfWeek;
var
  TempMethod: TTestLocalMethod;
begin
  //
  // no exception is thrown when ADayOfWeek is out of range - tested with both
  // 0 and 8. if this intentional then this test can be removed however other
  // functions which include a DayOfWeek argument throw exceptions when the
  // value is not from 1-7.
  //
  TempMethod := procedure
    begin
      EncodeDayOfWeekInMonth(1933, 1, 1, 0);
    end;
  Assert.WillRaise(TempMethod, EConvertError,
    'EncodeDayOfWeekInMonth failed to throw EConvertError exception for DayOfWeek = 0');
end;

procedure TDateUtilsEncodeDayOfWeekInMonthTests.TestEncodeDayOfWeekInMonthOutOfRangeMonth;
var
  TempMethod: TTestLocalMethod;
begin
  TempMethod := procedure
    begin
      EncodeDayOfWeekInMonth(1933, 0, 1, DayMonday);
    end;
  Assert.WillRaise(TempMethod, EConvertError,
    'EncodeDayOfWeekInMonth failed to throw EConvertError exception for Month = 0');
end;

procedure TDateUtilsEncodeDayOfWeekInMonthTests.TestEncodeDayOfWeekInMonthOutOfRangeNthDayOfWeek;
var
  TempMethod: TTestLocalMethod;
begin
  TempMethod := procedure
    begin
      EncodeDayOfWeekInMonth(1933, 1, 5, DayFriday);
    end;
  Assert.WillRaise(TempMethod, EConvertError,
    'EncodeDayOfWeekInMonth failed to throw EConvertError exception for NthDayOfWeek = 5');
end;

procedure TDateUtilsEncodeDayOfWeekInMonthTests.TestEncodeDayOfWeekInMonthOutOfRangeYear;
var
  TempMethod: TTestLocalMethod;
begin
  TempMethod := procedure
    begin
      EncodeDayOfWeekInMonth(0, 1, 1, DayMonday);
    end;
  Assert.WillRaise(TempMethod, EConvertError,
    'EncodeDayOfWeekInMonth failed to throw EConvertError exception for Year = 0');
end;

procedure TDateUtilsEncodeDayOfWeekInMonthTests.TestEncodeDayOfWeekInMonth;
var
  _date: TDateTime;
  _format_settings: TFormatSettings;
begin
  //
  // this test is NOT for out of range errors
  //
  _date := EncodeDayOfWeekInMonth(1933, 1, 5, DayMonday);
  _format_settings.DateSeparator := '-';
  _format_settings.ShortDateFormat := 'm-d-yyyy';
  Assert.AreEqual('1-30-1933', DateTimeToStr(_date, _format_settings),
    True, 'EncodeDayOfWeekInMonth failed to encode 1-30-1933');
end;

initialization
  TDUnitX.RegisterTestFixture(TDateUtilsEncodeDateTimeTests);
  TDUnitX.RegisterTestFixture(TDateUtilsEncodeDateDayTests);
  TDUnitX.RegisterTestFixture(TDateUtilsEncodeDateMonthWeekTests);
  TDUnitX.RegisterTestFixture(TDateUtilsEncodeDateWeekTests);
  TDUnitX.RegisterTestFixture(TDateUtilsEncodeDayOfWeekInMonthTests);

end.

