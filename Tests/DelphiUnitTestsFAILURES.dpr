program DelphiUnitTestsFAILURES;

{$APPTYPE CONSOLE}

{$R *.res}

uses
  System.SysUtils,
  DUT.SysUtils.QC108975 in 'SysUtils\DUT.SysUtils.QC108975.pas',
  DUT.SysUtils.QC109207 in 'SysUtils\DUT.SysUtils.QC109207.pas';

begin
  try
    { TODO -oUser -cConsole Main : Insert code here }
  except
    on E: Exception do
      Writeln(E.ClassName, ': ', E.Message);
  end;
end.
