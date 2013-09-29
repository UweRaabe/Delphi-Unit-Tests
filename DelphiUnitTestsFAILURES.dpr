program DelphiUnitTestsFAILURES;


{$APPTYPE CONSOLE}

{$R *.res}

uses
  DUnitX.ContinuaCI,
  DelphiUnitTestsMain in 'DelphiUnitTestsMain.pas',
  DUT.Examples.TStringList.QC12345 in 'Tests\Examples\DUT.Examples.TStringList.QC12345.pas';

begin
  Main();
end.





