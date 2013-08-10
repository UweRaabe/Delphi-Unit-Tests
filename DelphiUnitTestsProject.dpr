program DelphiUnitTestsProject;

{$APPTYPE CONSOLE}

{$R *.res}

uses
  System.SysUtils,
  DUnitX.TestFramework,
  DUnitX.Loggers.Console,
  DUnitX.Windows.Console,
  DUT.SysUtils in 'DUT.SysUtils.pas',
  DUT.StrUtils in 'DUT.StrUtils.pas';

var
  Runner: ITestRunner;
  Logger: ITestLogger;
  Results: ITestResults;

begin
  try
    try
    //Create the runner
    Runner := TDUnitX.CreateRunner;
    Runner.UseRTTI := True;
    finally

    end;
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
