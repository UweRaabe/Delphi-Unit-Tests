program DelphiUnitTestsProject;

{$APPTYPE CONSOLE}

{$R *.res}

uses
{$IFDEF VER220 }
  SysUtils,
{$ELSE}
  System.SysUtils,
{$ENDIF}
  DUnitX.TestFramework,
  DUnitX.Loggers.Console,
  DUnitX.Windows.Console,
  DUT.SysUtils in 'DUT.SysUtils.pas',
  DUT.StrUtils in 'DUT.StrUtils.pas',
  DUT.Classes in 'DUT.Classes.pas';

var
  Runner: ITestRunner;
  Logger: ITestLogger;
  Results: ITestResults;

begin
  try
    //Create the runner
    Runner := TDUnitX.CreateRunner;
    Runner.UseRTTI := True;
    //tell the runner how we will log things
    Logger := TDUnitXConsoleLogger.Create;
    runner.AddLogger(Logger);

    //Run tests
    Results := Runner.Execute;

    System.Writeln('Done.. press any key to quit.');
    ReadLn;
  except
    on E: Exception do
      Writeln(E.ClassName, ': ', E.Message);
  end;
end.
