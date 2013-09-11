unit DUT.DateUtils.MilliSecondOf;

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
  TDateUtilsMilliSecondOfTests = class
  private
    Input: TDateTime;
  public
    [Test]
    procedure TestMilliSecondOf;
    [Test]
    procedure TestMilliSecondOfTheDay;
    [Test]
    procedure TestMilliSecondOfTheHour;
    [Test]
    procedure TestMilliSecondOfTheMinute;
    [Test]
    procedure TestMilliSecondOfTheMonth;
    [Test]
    procedure TestMilliSecondOfTheSecond;
    [Test]
    procedure TestMilliSecondOfTheWeek;
    [Test]
    procedure TestMilliSecondOfTheYear;
  end;

implementation

{ TDateUtilsMilliSecondOfTests }

procedure TDateUtilsMilliSecondOfTests.TestMilliSecondOf;
begin
  Input := EncodeDateTime(1933, 6, 23, 0, 23, 23, 23);
  Assert.AreEqual(MilliSecondOf(Input), 23, 0,
    'MilliSecondOf failed to return 23');
end;

procedure TDateUtilsMilliSecondOfTests.TestMilliSecondOfTheDay;
var
  _expected : LongWord;
begin
  Input := 0.5;
  _expected := 12 * 60 * 60 * 1000; // 12 hours in milliseconds
  Assert.AreEqual(MilliSecondOfTheDay(Input), _expected, 0,
    'MilliSecondOfTheDay failed to return 12:0:0.000 in milliseconds');
end;

procedure TDateUtilsMilliSecondOfTests.TestMilliSecondOfTheHour;
var
  _expected : LongWord;
begin
  Input := EncodeDateTime(1933, 6, 23, 0, 59, 59, 999);
  _expected := (59 * 60 * 1000) + (59 * 1000) + 999;
  Assert.AreEqual(MilliSecondOfTheHour(Input), _expected, 0,
    'MilliSecondOfTheHour failed to return 0:59:59.999 in milliseconds');
end;

procedure TDateUtilsMilliSecondOfTests.TestMilliSecondOfTheMinute;
var
  _expected: LongWord;
begin
  Input := EncodeDateTime(1933, 6, 23, 0, 59, 59, 999);
  _expected := (59 * 1000) + 999;
  Assert.AreEqual(MilliSecondOfTheMinute(Input), _expected, 0,
    'MilliSecondOfTheMinute failed to return the difference between 0:59:0.0 and 0:59:59.999 in milliseconds');
end;

procedure TDateUtilsMilliSecondOfTests.TestMilliSecondOfTheMonth;
var
  _expected: LongWord;
begin
  Input := EncodeDateTime(1933, 6, 23, 0, 59, 59, 999);
  _expected := (22 * 24 * 60 * 60 * 1000) + (59 * 60 * 1000) +
    (59 * 1000) + 999;
  Assert.AreEqual(MilliSecondOfTheMonth(Input), _expected, 0,
    'MilliSecondOfTheMonth failed to return the difference between 6-23-1933 0:0:0.00 and 6-23-1933 0:59:59.999 in milliseconds');
end;

procedure TDateUtilsMilliSecondOfTests.TestMilliSecondOfTheSecond;
var
  _expected: LongWord;
begin
  Input := EncodeDateTime(1933, 6, 23, 0, 59, 59, 999);
  _expected := 999;
  Assert.AreEqual(MilliSecondOfTheSecond(Input), _expected, 0,
    'MilliSecondOfTheSecond failed to return the milliseconds of 0:59:59.999');
end;

procedure TDateUtilsMilliSecondOfTests.TestMilliSecondOfTheWeek;
var
  _expected: LongWord;
begin
  // the number of milliseconds between a specified TDateTime value
  // and 12:00:00:00 A.M. of the first day of the week
  //
  Input := EncodeDateTime(1933, 5, 6, 0, 0, 0, 0);  // 12:0:0.000 on May 6 - 5 complete days
  _expected := (5 * 24 * 60 * 60 * 1000);
  Assert.AreEqual(MilliSecondOfTheWeek(Input), _expected, 0,
    'MilliSecondOfTheSecond failed to return 5 days in milliseconds');
end;

procedure TDateUtilsMilliSecondOfTests.TestMilliSecondOfTheYear;
var
  _expected: LongWord;
begin
  //  the number of milliseconds between a specified TDateTime value
  // and 12:00:00:00 A.M. of the first day of the year
  //
  Input := EncodeDateTime(1933, 1, 6, 0, 0, 0, 0);  // 12:0:0.000 on Jan 6 - 5 complete days
  _expected := (5 * 24 * 60 * 60 * 1000);
  Assert.AreEqual(MilliSecondOfTheYear(Input), _expected, 0,
    'MilliSecondOfTheYear failed to return 5 days in milliseconds');
end;

initialization
  TDUnitX.RegisterTestFixture(TDateUtilsMilliSecondOfTests);

end.
