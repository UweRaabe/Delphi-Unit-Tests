unit DUT.SysUtils;

interface

uses
     DUnitX.TestFramework
{$IFDEF VER220 }
   , SysUtils
{$ELSE}
   , System.SysUtils
{$ENDIF}
   ;

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

type
  [TestFixture]
  TSysUtilsTimeToStrTests = class
  public
    [Test]
    procedure TestTimeToStr;
end;

type
  [TestFixture]
  TSysUtilsEncodeTimeTests = class
  public
    [Test]
    procedure TestEncodeTime;
    [Test]
    procedure TestEncodeTimeOutOfRangeHour;
    [Test]
    procedure TestEncodeTimeOutOfRangeMin;
    [Test]
    procedure TestEncodeTimeOutOfRangeSec;
    [Test]
    procedure TestEncodeTimeOutOfRangeMSec;
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
    procedure TestEncodeDate;
    [Test]
    procedure TestEncodeDateOutOfRangeYear;
    [Test]
    procedure TestEncodeDateOutOfRangeMonth;
    [Test]
    procedure TestEncodeDateOutOfRangeDay;
    [Test]
    procedure TestEncodeDateDetectCorrectLeapYear;
    [Test]
    procedure TestEncodeDateDetectIncorrectLeapYear;
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
  _time := EncodeTime(0,0,0,999); // 999 should be ignored by EncodeTime
  _format_settings.TimeSeparator := ':';
  _format_settings.LongTimeFormat := 'h:m:s';
  Assert.AreEqual('0:0:0', TimeToStr(_time,_format_settings), 'EncodeTime failed to encode 0:0:0');
end;

procedure TSysUtilsEncodeTimeTests.TestEncodeTimeOutOfRangeHour;
begin
  try
    EncodeTime(24,0,0,0);
    Assert.Fail('EncodeTime failed to throw EConvertError exception for Hour = 24');
  except
    on EConvertError do
      Assert.Pass('EncodeTime correctly threw an EConvertError exception for Hour = 24');
  end;
end;

procedure TSysUtilsEncodeTimeTests.TestEncodeTimeOutOfRangeMin;
begin
  try
    EncodeTime(0,60,0,0);
    Assert.Fail('EncodeTime failed to throw EConvertError exception for Min = 60');
  except
    on EConvertError do
      Assert.Pass('EncodeTime correctly threw an EConvertError exception for Min = 60');
  end;
end;

procedure TSysUtilsEncodeTimeTests.TestEncodeTimeOutOfRangeSec;
begin
  try
    EncodeTime(0,0,60,0);
    Assert.Fail('EncodeTime failed to throw EConvertError exception for Sec = 60');
  except
    on EConvertError do
      Assert.Pass('EncodeTime correctly threw an EConvertError exception for Sec = 60');
  end;
end;

procedure TSysUtilsEncodeTimeTests.TestEncodeTimeOutOfRangeMSec;
begin
  try
    EncodeTime(0,0,0,1000);
    Assert.Fail('EncodeTime failed to throw EConvertError exception for MSec = 1000');
  except
    on EConvertError do
      Assert.Pass('EncodeTime correctly threw an EConvertError exception for MSec = 100');
  end;
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
begin
  try
    EncodeDate(0,1,1);
    Assert.Fail('EncodeDate failed to throw EConvertError exception for Year = 0');
  except
    on EConvertError do
      Assert.Pass('EncodeDate correctly threw an EConvertError exception for Year = 0');
  end;
end;

procedure TSysUtilsEncodeDateTests.TestEncodeDateOutOfRangeMonth;
begin
  try
    EncodeDate(1,0,1);
    Assert.Fail('EncodeDate failed to throw EConvertError exception for Month = 0');
  except
    on EConvertError do
      Assert.Pass('EncodeDate correctly threw an EConvertError exception for Month = 0');
  end;
end;

procedure TSysUtilsEncodeDateTests.TestEncodeDateOutOfRangeDay;
begin
  try
    EncodeDate(1,1,0);
    Assert.Fail('EncodeDate failed to throw EConvertError exception for Day = 0');
  except
    on EConvertError do
      Assert.Pass('EncodeDate correctly threw an EConvertError exception for Day = 0');
  end;
end;

procedure TSysUtilsEncodeDateTests.TestEncodeDateDetectCorrectLeapYear;
begin
  try
    EncodeDate(4,2,29);  // Year 4 is the first leap year
    Assert.Pass('EncodeDate correctly allowed for Day = 29 for a leap year');
  except
    on EConvertError do
      Assert.Fail('EncodeDate incorrectly threw an EConvertError exception for Day = 29 for a leap year');
  end;
end;

procedure TSysUtilsEncodeDateTests.TestEncodeDateDetectIncorrectLeapYear;
begin
  try
    EncodeDate(100,2,29);  // 100 is the first year divisible by 4 which is not a leap year
    Assert.Fail('EncodeDate failed to throw EConvertError exception for Day = 29 for a non leap year');
  except
    on EConvertError do
      Assert.Pass('EncodeDate correctly threw an EConvertError exception for Day = 29 for a non leap year');
  end;
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

end.