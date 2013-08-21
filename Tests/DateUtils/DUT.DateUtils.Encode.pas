unit DUT.DateUtils.Encode;

interface

uses
       DUnitX.TestFramework
     , DateUtils
     , SysUtils
     ;


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
  Assert.AreEqual('1-2-1944 3:4:5', DateTimeToStr(_date,_format_settings), 'EncodeDate failed to encode 1-2-1944 3:4:5');
end;

initialization
  TDUnitX.RegisterTestFixture(TDateUtilsEncodeDateTimeTests);

end.