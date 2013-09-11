unit DUT.DateUtils.HourOf;

interface

uses
  {$if CompilerVersion < 23 }
    DateUtils,
  {$else}
    System.DateUtils, // Delphi XE2 (CompilerVersion 23) added scopes in front of unit names
  {$ifend}
   DUnitX.TestFramework;

type
  [TestFixture]
  TDateUtilsHourOfTests = class
  private
    Expected: Word;
    Actual: Word;
  public
    [Test]
    procedure TestHourOfTheDay;
    [Test]
    procedure TestHourOfTheMonth;
    [Test]
    procedure TestHourOfTheWeek;
    [Test]
    procedure TestHourOfTheYear;
    [Test]
    procedure TestHourOf;
  end;

implementation

{ TDateUtilsEndOfTheWeekTests }

procedure TDateUtilsHourOfTests.TestHourOfTheDay;
begin
  Expected := 6;
  // the hour of the day represented by a specified TDateTime value
  // .25 of any day is the 6th hour
  Actual := HourOfTheDay(0.25);
  Assert.IsTrue(Expected = Actual, 'HourOfTheDay failed to return 6');
end;

procedure TDateUtilsHourOfTests.TestHourOfTheMonth;
begin
  Expected := 24;
  // the number of *complete* hours between a specified TDateTime value
  // and 12:00 AM on the first day of the month that includes
  // the specified TDateTime
  Actual := HourOfTheMonth(EncodeDateTime(1900, 1, 2, 0, 59, 59, 999));
  Assert.IsTrue(Expected = Actual, 'HourOfTheMonth failed to return 24');
end;

procedure TDateUtilsHourOfTests.TestHourOfTheWeek;
begin
  Expected := 24;
  // the number of *complete* hours between a specified TDateTime value
  // and 12:00 AM on Monday of the week that includes the specified TDateTime
  Actual := HourOfTheWeek(EncodeDateTime(1900, 1, 2, 0, 59, 59, 999));
  Assert.IsTrue(Expected = Actual, 'HourOfTheWeek failed to return 24');
end;

procedure TDateUtilsHourOfTests.TestHourOfTheYear;
begin
  Expected := 24;
  // the number of *complete* hours between a specified TDateTime value
  // and 12:00 AM on January 1 of the year that includes the specified TDateTime
  Actual := HourOfTheYear(EncodeDateTime(1900, 1, 2, 0, 59, 59, 999));
  Assert.IsTrue(Expected = Actual, 'HourOfThe failed to return 24');
end;

procedure TDateUtilsHourOfTests.TestHourOf;
begin
  Expected := 12;
  // the hour of the day represented by a specified TDateTime
  Actual := HourOf(0.5);
  Assert.IsTrue(Expected = Actual, 'HourOf failed to return 12');
end;

initialization
  TDUnitX.RegisterTestFixture(TDateUtilsHourOfTests);

end.
