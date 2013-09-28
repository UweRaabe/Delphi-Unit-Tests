unit DUT.SysUtils;

interface

uses
  {$if CompilerVersion < 23 }
    SysUtils,
  {$else}
    System.SysUtils, // Delphi XE2 (CompilerVersion 23) added scopes in front of unit names
  {$ifend}
  DUnitX.TestFramework;

type
  [TestFixture]
  TSysUtilsCaseTests = class
  private
    Expected, Actual: string;
  public
    [Test]
    procedure TestLowerCaseWithAllLowerCase;
    [Test]
    procedure TestLowerCaseWithAllUpperCase;
    [Test]
    procedure TestLowerCaseWithMixedCase;
    [Test]
    procedure TestUpperCaseWithAllLowerCase;
    [Test]
    procedure TestUpperCaseWithAllUpperCase;
    [Test]
    procedure TestUpperCaseWithMixedCase;
end;

type
  [TestFixture]
  TSysUtilsCompareStrTests = class
  public
    [Test]
    procedure TestCompareStrS1EqualsS2;
    [Test]
    procedure TestCompareStrS1LessThanS2;
    [Test]
    procedure TestCompareStrS1GreaterThanS2;
    [Test]
    procedure TestCompareStrWithEmptyStrings;
end;

type
  [TestFixture]
  TSysUtilsCompareTextTests = class
  public
    [Test]
    procedure TestCompareTextS1EqualS2;
    [Test]
    procedure TestCompareTextS1LessThanS2;
    [Test]
    procedure TestCompareTextS1GreaterThanS2;
    [Test]
    procedure TestCompareTextWithEmptyStrings;
end;

type
  [TestFixture]
  TSysUtilsSameTextTests = class
  public
    [Test]
    procedure TestSameTextS1EqualS2;
    [Test]
    procedure TestSameTextS1NotEqualS2;
    [Test]
    procedure TestSameTextWithEmptyStrings;
  end;

type
  [TestFixture]
  TSysUtilsTimeToStrTests = class
  public
    [Test]
    procedure TestTimeToStr;
    [Test]
    procedure TestEncodeTimeOutOfRangeHour;
  end;

type
  [TestFixture]
  TSysUtilsEncodeTimeTests = class
  public
    [Test]
    procedure TestEncodeTimeOutOfRangeMin;
    [Test]
    procedure TestEncodeTimeOutOfRangeMSec;
    [Test]
    procedure TestEncodeTimeOutOfRangeSec;
    [Test]
    procedure TestEncodeTime;
  end;

type
  [TestFixture]
  TSysUtilsDateToStrTests = class
  public
    [Test]
    procedure TestDateToStr;
  end;

type
  [TestFixture]
  TSysUtilsEncodeDateTests = class
  public
    [Test]
    procedure TestEncodeDateDetectCorrectLeapYear;
    [Test]
    procedure TestEncodeDateDetectIncorrectLeapYear;
    [Test]
    procedure TestEncodeDateOutOfRangeDay;
    [Test]
    procedure TestEncodeDateOutOfRangeMonth;
    [Test]
    procedure TestEncodeDateOutOfRangeYear;
    [Test]
    procedure TestEncodeDate;
  end;

type
  [TestFixture]
  TSysUtilsDateTimeToStrTests = class
  public
    [Test]
    procedure TestDateTimeToStr;
  end;

implementation

{ TSysUtilsTests }

procedure TSysUtilsCaseTests.TestLowerCaseWithAllLowerCase;
begin
  Expected := 'lower';
  Actual := LowerCase('lower');
  Assert.AreEqual(Expected, Actual, 'LowerCase starting with all lower case failed');
end;

procedure TSysUtilsCaseTests.TestLowerCaseWithAllUpperCase;
begin
  Expected := 'lower';
  Actual := LowerCase('LOWER');
  Assert.AreEqual(Expected, Actual, 'LowerCase starting with all upper case failed');
end;

procedure TSysUtilsCaseTests.TestLowerCaseWithMixedCase;
begin
  Expected := 'lower';
  Actual := LowerCase('LoWeR');
  Assert.AreEqual(Expected, Actual, 'LowerCase with mixed case input failed');
end;

procedure TSysUtilsCaseTests.TestUpperCaseWithAllUpperCase;
begin
  Expected := 'UPPER';
  Actual := UpperCase('UPPER');
  Assert.AreEqual(Expected, Actual, 'UpperCase with already upper case input failed');
end;

procedure TSysUtilsCaseTests.TestUpperCaseWithAllLowerCase;
begin
  Expected := 'UPPER';
  Actual := UpperCase('upper');
  Assert.AreEqual(Expected, Actual, 'UpperCase with all lower case input failed');
end;

procedure TSysUtilsCaseTests.TestUpperCaseWithMixedCase;
begin
  Expected := 'UPPER';
  Actual := UpperCase('uPpEr');
  Assert.AreEqual(Expected, Actual, 'UpperCase with mixed case input failed');
end;


{ TSysUtilsCompareStrTests }

procedure TSysUtilsCompareStrTests.TestCompareStrS1EqualsS2;
begin
  Assert.IsTrue(CompareStr('T','T') = 0, 'CompareStr failed with S1 = S2');
end;

procedure TSysUtilsCompareStrTests.TestCompareStrS1LessThanS2;
begin
  Assert.IsTrue(CompareStr('T','t') < 0, 'CompareStr failed with S1 < S2 ');
end;

procedure TSysUtilsCompareStrTests.TestCompareStrS1GreaterThanS2;
begin
  Assert.IsTrue(CompareStr('t','T') > 0, 'CompareStr failed with S1 > S1 ');
end;

procedure TSysUtilsCompareStrTests.TestCompareStrWithEmptyStrings;
begin
  Assert.IsTrue(CompareStr('','') = 0, 'CompareStr failed comparing two empty strings');
end;

{ TSysUtilsCompareTextTests }

procedure TSysUtilsCompareTextTests.TestCompareTextS1EqualS2;
begin
  Assert.IsTrue(CompareText('T','t') = 0, 'CompareText failed with S1 = S2');
end;

procedure TSysUtilsCompareTextTests.TestCompareTextS1LessThanS2;
begin
  Assert.IsTrue(CompareText('t','u') < 0, 'CompareText failed with S1 < S2 ');
end;

procedure TSysUtilsCompareTextTests.TestCompareTextS1GreaterThanS2;
begin
  Assert.IsTrue(CompareText('u','t') > 0, 'CompareText failed with S1 > S1 ');
end;

procedure TSysUtilsCompareTextTests.TestCompareTextWithEmptyStrings;
begin
  Assert.IsTrue(CompareText('','') = 0, 'CompareText failed comparing two empty strings');
end;

{ TSysUtilsSameTextTests }

procedure TSysUtilsSameTextTests.TestSameTextS1EqualS2;
begin
  Assert.IsTrue(SameText('T','t'), 'SameText failed with S1 = S2');
end;

procedure TSysUtilsSameTextTests.TestSameTextS1NotEqualS2;
begin
  Assert.IsFalse(SameText('T','u'), 'SameText failed with S1 <> S2');
end;

procedure TSysUtilsSameTextTests.TestSameTextWithEmptyStrings;
begin
  Assert.IsTrue(SameText('',''), 'SameText failed comparing two empty strings');
end;

{ TSysUtilsTimeToStrTests }

procedure TSysUtilsTimeToStrTests.TestEncodeTimeOutOfRangeHour;
var
  TempMethod: TTestLocalMethod;
begin
  TempMethod := procedure begin EncodeTime(24,0,0,0); end;
  Assert.WillRaise(TempMethod, EConvertError, 'EncodeTime failed to throw EConvertError exception for Hour = 24');
end;

procedure TSysUtilsEncodeTimeTests.TestEncodeTimeOutOfRangeMin;
var
  TempMethod: TTestLocalMethod;
begin
  TempMethod := procedure begin EncodeTime(0,60,0,0) end;
  Assert.WillRaise(TempMethod, EConvertError, 'EncodeTime failed to throw EConvertError exception for Min = 60');
end;

procedure TSysUtilsEncodeTimeTests.TestEncodeTimeOutOfRangeSec;
var
  TempMethod: TTestLocalMethod;
begin
  TempMethod := procedure begin EncodeTime(0,0,60,0); end;
  Assert.WillRaise(TempMethod, EConvertError, 'EncodeTime failed to throw EConvertError exception for Sec = 60');
end;

procedure TSysUtilsEncodeTimeTests.TestEncodeTimeOutOfRangeMSec;
var
  TempMethod: TTestLocalMethod;
begin
  TempMethod := procedure begin EncodeTime(0,0,0,1000) end;
  Assert.WillRaise(TempMethod, EConvertError,'EncodeTime failed to throw EConvertError exception for MSec = 1000');
end;

procedure TSysUtilsTimeToStrTests.TestTimeToStr;
var
  _time : TDateTime;
  _format_settings : TFormatSettings;
begin
  _time := 0;
  _format_settings.TimeSeparator := ':';
  _format_settings.LongTimeFormat := 'h:m:s';
  Assert.AreEqual('0:0:0', TimeToStr(_time,_format_settings), 'TimeToStr failed to return 0:0:0');
end;

{ TSysUtilsEncodeTimeTests }

procedure TSysUtilsEncodeTimeTests.TestEncodeTime;
var
  _time : TDateTime;
  _format_settings : TFormatSettings;
begin
  //
  // this test is NOT for out of range errors
  //
  _time := EncodeTime(0,0,0,999); // 999 should be ignored by TimeToStr
  _format_settings.TimeSeparator := ':';
  _format_settings.LongTimeFormat := 'h:m:s';
  Assert.AreEqual('0:0:0', TimeToStr(_time,_format_settings), 'EncodeTime failed to encode 0:0:0');
end;


{ TSysUtilsDateToStrTests }

procedure TSysUtilsDateToStrTests.TestDateToStr;
var
  _date : TDateTime;
  _format_settings : TFormatSettings;
begin
  _date := 0;
  _format_settings.DateSeparator := '-';
  _format_settings.ShortDateFormat := 'm-d-yyyy';
  Assert.AreEqual('12-30-1899', DateToStr(_date,_format_settings), 'DateToStr failed to return 12-30-1899');
end;

{ TSysUtilsEncodeDateTests }

procedure TSysUtilsEncodeDateTests.TestEncodeDate;
var
  _date : TDateTime;
  _format_settings : TFormatSettings;
begin
  //
  // this test is NOT for out of range errors
  //
  _date := EncodeDate(1970,1,1);
  _format_settings.DateSeparator := '-';
  _format_settings.ShortDateFormat := 'm-d-yyyy';
  Assert.AreEqual('1-1-1970', DateToStr(_date,_format_settings), 'EncodeDate failed to encode 1-1-1970');
end;

procedure TSysUtilsEncodeDateTests.TestEncodeDateOutOfRangeYear;
var
  TempMethod: TTestLocalMethod;
begin
  TempMethod := procedure begin EncodeDate(0,1,1) end;
    Assert.WillRaise(TempMethod, EConvertError, 'EncodeDate failed to throw EConvertError exception for Year = 0');
end;

procedure TSysUtilsEncodeDateTests.TestEncodeDateOutOfRangeMonth;
var
  TempMethod: TTestLocalMethod;
begin
  TempMethod := procedure begin EncodeDate(1,0,1) end;;
  Assert.WillRaise(TempMethod, EConvertError, 'EncodeDate failed to throw EConvertError exception for Month = 0');
end;

procedure TSysUtilsEncodeDateTests.TestEncodeDateOutOfRangeDay;
var
  TempMethod: TTestLocalMethod;
begin
  TempMethod := procedure begin EncodeDate(1,1,0) end;
  Assert.WillRaise(TempMethod, EConvertError, 'EncodeDate failed to throw EConvertError exception for Day = 0');
end;

procedure TSysUtilsEncodeDateTests.TestEncodeDateDetectCorrectLeapYear;
var
  TempMethod: TTestLocalMethod;
begin
  TempMethod := procedure begin EncodeDate(4,2,29) end;  // Year 4 is the first leap year
  Assert.WillNotRaise(TempMethod, EConvertError, 'EncodeDate incorrectly allowed for Day = 29 for a leap year');
end;

procedure TSysUtilsEncodeDateTests.TestEncodeDateDetectIncorrectLeapYear;
var
  TempMethod: TTestLocalMethod;
begin
  TempMethod := procedure begin EncodeDate(100,2,29) end;  // 100 is the first year divisible by 4 which is not a leap year
  Assert.WillRaise(TempMethod, EConvertError, 'EncodeDate failed to throw EConvertError exception for Day = 29 for a non leap year');
end;

{ TSysUtilsDateToStrTests }

procedure TSysUtilsDateTimeToStrTests.TestDateTimeToStr;
var
  _date : TDateTime;
  _format_settings : TFormatSettings;
begin
  // if we a whole number - like 0 or 1 - DateTimeToStr does not return a time in the string
  // if we use _date := 0, DateTimeToStr returns '12-30-1899'
  _date := 0.5;
  _format_settings.DateSeparator := '-';
  _format_settings.ShortDateFormat := 'm-d-yyyy';
  _format_settings.TimeSeparator := ':';
  _format_settings.LongTimeFormat := 'h:m:s';
  Assert.AreEqual('12-30-1899 12:0:0', DateTimeToStr(_date,_format_settings), 'DateTimeToStr failed to return 12-30-1899 12:0:0');
end;


initialization
  TDUnitX.RegisterTestFixture(TSysUtilsCaseTests);
  TDUnitX.RegisterTestFixture(TSysUtilsCompareStrTests);
  TDUnitX.RegisterTestFixture(TSysUtilsCompareTextTests);
  TDUnitX.RegisterTestFixture(TSysUtilsSameTextTests);
  TDUnitX.RegisterTestFixture(TSysUtilsTimeToStrTests);
  TDUnitX.RegisterTestFixture(TSysUtilsEncodeTimeTests);
  TDUnitX.RegisterTestFixture(TSysUtilsDateToStrTests);
  TDUnitX.RegisterTestFixture(TSysUtilsEncodeDateTests);
  TDUnitX.RegisterTestFixture(TSysUtilsDateTimeToStrTests);

end.
