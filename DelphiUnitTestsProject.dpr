program DelphiUnitTestsProject;

{$APPTYPE CONSOLE}

{$R *.res}

uses
  {$if CompilerVersion < 23 }
    SysUtils,
  {$else}
    System.SysUtils, // Delphi XE2 (CompilerVersion 23) added scopes in front of unit names
  {$ifend}
  DUnitX.TestFramework,
  DUnitX.Loggers.Console,
  DUnitX.Windows.Console,
  DUT.SysUtils in 'DUT.SysUtils.pas',
  DUT.StrUtils in 'DUT.StrUtils.pas',
  DUT.Classes in 'DUT.Classes.pas',
  DUT.DateUtils in 'DUT.DateUtils.pas';

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

    System.Write('Done.. press the <Enter> key to quit.');
    System.Readln;
  except
    on E: Exception do
      System.Writeln(E.ClassName, ': ', E.Message);
  end;
end.
