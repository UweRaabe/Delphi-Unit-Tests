program DelphiUnitTestsFAILURES;


{$APPTYPE CONSOLE}

{$R *.res}

uses
  DUnitX.ContinuaCI in '..\DUnitX.ContinuaCI.pas',
  DUT.Examples.TStringList.QC12345 in '..\Tests\Examples\DUT.Examples.TStringList.QC12345.pas',
  DelphiUnitTestsMain in '..\DelphiUnitTestsMain.pas';

begin
  Main();
end.





