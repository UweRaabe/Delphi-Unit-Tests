unit DelphiUnitTestsMain;

{$define CI}

interface

procedure Main();

implementation

uses
  {$if CompilerVersion < 23 }
    SysUtils,
  {$else}
    System.SysUtils, // Delphi XE2 (CompilerVersion 23) added scopes in front of unit names
  {$ifend }
  {$IFDEF CI}
    DUnitX.ContinuaCI,
  {$ENDIF}
  DUnitX.MacOS.Console, // need this to register the ConsoleWriter when running on Mac OS X
  DUnitX.Windows.Console, // need this to register the ConsoleWriter when running on Windows
  DUnitX.TestFramework,
  DUnitX.Loggers.Console,
  DUnitX.Loggers.XML.NUnit;

type
  TMain = class
  strict protected
    procedure AddConsoleLogger(Runner: ITestRunner); virtual;
    procedure AddLoggers(Runner: ITestRunner); virtual;
  public
    procedure Run(); virtual;
  end;

procedure TMain.AddConsoleLogger(Runner: ITestRunner);
var
  Logger: ITestLogger;
begin
  //tell the runner how we will log things
  Logger := TDUnitXConsoleLogger.Create;
  runner.AddLogger(Logger);
end;

procedure TMain.Run();
var
  Runner: ITestRunner;
  Results: IRunResults;
begin
  try
    //Create the runner
    Runner := TDUnitX.CreateRunner;
    Runner.UseRTTI := True;

    AddLoggers(Runner);

    //Run tests
    Results := Runner.Execute;

    {$IFNDEF CI}
    //We don't want this when running on a CI server.
    System.Write('Done.. press the <Enter> key to quit.');
    System.Readln;
    {$ENDIF}
  except
    on E: Exception do
      System.Writeln(E.ClassName, ': ', E.Message);
  end;
end;

procedure TMain.AddLoggers(Runner: ITestRunner);
begin
  AddConsoleLogger(Runner);

  {$IFDEF CI}
    AddContinuaCILogger(Runner);
  {$ENDIF}
end;

procedure Main();
begin
  with TMain.Create() do
  try
    Run();
  finally
    Free();
  end;
end;

end.
