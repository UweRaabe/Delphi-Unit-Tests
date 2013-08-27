unit DUT.DateUtils.MiscFunctions;

interface

uses
      DUnitX.TestFramework
    ;


type
  [TestFixture]
  TDateUtilsMiscFunctionTests = class
  private
    Input: TDateTime;
    Expected: TDateTime;
    Actual: TDateTime;
  public
    [Test]
    procedure TestIsInLeapYearWithNormalDate;
    [Test]
    procedure TestIsPMWithNormalDate;
  end;

implementation

uses
  {$if CompilerVersion < 23 }
    DateUtils,
    SysUtils;
  {$else}
    System.DateUtils, // Delphi XE2 (CompilerVersion 23) added scopes in front of unit names
    System.SysUtils;
  {$ifend}


{ TDateUtilsMiscFunctionTests }

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


initialization
  TDUnitX.RegisterTestFixture(TDateUtilsMiscFunctionTests);

end.
