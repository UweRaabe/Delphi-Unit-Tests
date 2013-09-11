unit DUT.DateUtils.IsValid;

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
  TDateUtilsIsValidTests = class
  public
    [Test]
    procedure TestIsValidDate;
    [Test]
    procedure TestIsValidDateDay;
    [Test]
    procedure TestIsValidDateDayWithIncorrectLeapYear;
    [Test]
    procedure TestIsValidDateDayWithLeapYear;
    [Test]
    procedure TestIsValidDateMonthWeek;
    [Test]
    procedure TestIsValidDateTime;
    [Test]
    procedure TestIsValidDateTimeWithIncorrectLeapYear;
    [Test]
    procedure TestIsValidDateTimeWithLeapYear;
    [Test]
    procedure TestIsValidDateWeek;
    [Test]
    procedure TestIsValidDateWeekWithIncorrectLeapWeek;
    [Test]
    procedure TestIsValidDateWeekWithLeapWeek;
    [Test]
    procedure TestIsValidTime;
    [Test]
    procedure TestIsValidTimeWith24Hours;
  end;

implementation

{ TDateUtilsIsValidTests }

procedure TDateUtilsIsValidTests.TestIsValidDate;
begin
  Assert.IsTrue(IsValidDate(9999, 12, 31), 'IsValidDate failed to return True');
end;

procedure TDateUtilsIsValidTests.TestIsValidDateDay;
begin
  Assert.IsTrue(IsValidDateDay(9999, 365),
    'IsValidDateDay failed to return True');
end;

procedure TDateUtilsIsValidTests.TestIsValidDateDayWithIncorrectLeapYear;
begin
  Assert.IsFalse(IsValidDateDay(100, 366),
    'IsValidDateDay failed to detect an incorrect leap year');
end;

procedure TDateUtilsIsValidTests.TestIsValidDateDayWithLeapYear;
begin
  Assert.IsTrue(IsValidDateDay(4, 366),
    'IsValidDateDay failed to detect a leap year');
end;

procedure TDateUtilsIsValidTests.TestIsValidDateMonthWeek;
begin
  Assert.IsTrue(IsValidDateMonthWeek(100, 12, 5, DaySunday),
    'IsValidDateMonthWeek failed to return True');
end;

procedure TDateUtilsIsValidTests.TestIsValidDateTime;
begin
  Assert.IsTrue(IsValidDateTime(9999, 12, 31, 23, 59, 59, 999),
    'IsValidDateTime failed to return True');
end;

procedure TDateUtilsIsValidTests.TestIsValidDateTimeWithIncorrectLeapYear;
begin
  Assert.IsFalse(IsValidDateTime(100, 2, 29, 0, 0, 0, 0),
    'IsValidDateTime failed to detect an incorrect leap year');
end;

procedure TDateUtilsIsValidTests.TestIsValidDateTimeWithLeapYear;
begin
  Assert.IsTrue(IsValidDateTime(4, 2, 29, 0, 0, 0, 0),
    'IsValidDateTime failed to detect a leap year');
end;

procedure TDateUtilsIsValidTests.TestIsValidDateWeek;
begin
  Assert.IsTrue(IsValidDateWeek(9999, 52, 1),
    'IsValidDateWeek failed to return True');
end;

procedure TDateUtilsIsValidTests.TestIsValidDateWeekWithIncorrectLeapWeek;
begin
  Assert.IsFalse(IsValidDateWeek(100, 53, 1),
    'IsValidDateWeek failed to detect an incorrect year with a leap week');
end;

procedure TDateUtilsIsValidTests.TestIsValidDateWeekWithLeapWeek;
begin
  Assert.IsTrue(IsValidDateWeek(2009, 53, 1),
    'IsValidDateWeek failed to detect a correct year with a leap week');
end;

procedure TDateUtilsIsValidTests.TestIsValidTime;
begin
  Assert.IsTrue(IsValidTime(23, 59, 59, 999),
    'IsValidTime failed to return True');
end;

procedure TDateUtilsIsValidTests.TestIsValidTimeWith24Hours;
begin
  Assert.IsTrue(IsValidTime(24, 0, 0, 0), 'IsValidTime failed to return True');
end;

initialization
  TDUnitX.RegisterTestFixture(TDateUtilsIsValidTests);

end.
