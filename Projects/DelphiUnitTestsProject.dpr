program DelphiUnitTestsProject_XE7;

{$APPTYPE CONSOLE}

{$R *.res}

uses
  DelphiUnitTestsMain in '..\DelphiUnitTestsMain.pas',
  DUT.Classes.TList.Enumerator in '..\Tests\Classes\DUT.Classes.TList.Enumerator.pas',
  DUT.Compiler.MethodOlverloadResolutionError.QC118897 in '..\Tests\Compiler\DUT.Compiler.MethodOlverloadResolutionError.QC118897.pas',
  DUT.DateUtils.DateOf in '..\Tests\DateUtils\DUT.DateUtils.DateOf.pas',
  DUT.DateUtils.Encode in '..\Tests\DateUtils\DUT.DateUtils.Encode.pas',
  DUT.DateUtils.EndOf in '..\Tests\DateUtils\DUT.DateUtils.EndOf.pas',
  DUT.DateUtils.HourOf in '..\Tests\DateUtils\DUT.DateUtils.HourOf.pas',
  DUT.DateUtils.MiscFunctions in '..\Tests\DateUtils\DUT.DateUtils.MiscFunctions.pas',
  DUT.StrUtils in '..\Tests\StrUtils\DUT.StrUtils.pas',
  DUT.SysUtils in '..\Tests\SysUtils\DUT.SysUtils.pas',
  DUT.SysUtils.BoolStrTests in '..\Tests\SysUtils\DUT.SysUtils.BoolStrTests.pas',
  DUT.SysUtils.QC108975 in '..\Tests\SysUtils\DUT.SysUtils.QC108975.pas',
  DUT.SysUtils.QC109207 in '..\Tests\SysUtils\DUT.SysUtils.QC109207.pas',
  DUnitX.ContinuaCI in '..\DUnitX.ContinuaCI.pas';

begin
  Main();
end.
