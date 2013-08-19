program DelphiUnitTestsProject;

{$APPTYPE CONSOLE}

{$R *.res}

uses
  {$if CompilerVersion < 23 }
  SysUtils,
  {$else}
  System.SysUtils,
  {$ifend }
  DUnitX.TestFramework,
  DUnitX.Loggers.Console,
  DUnitX.Loggers.XML.NUnit,
  DUnitX.Windows.Console,
  DUT.SysUtils in 'DUT.SysUtils.pas',
  DUT.StrUtils in 'DUT.StrUtils.pas',
  DUT.Classes.TList.Enumerator in 'DUT.Classes.TList.Enumerator.pas',
  DUT.DateUtils.Encode in 'DUT.DateUtils.Encode.pas',
  DUT.DateUtils.DateOf in 'DUT.DateUtils.DateOf.pas';

var
  Runner: ITestRunner;
  Logger: ITestLogger;
  Results: ITestResults;
  {$IFDEF CI}
  XMLLogger : ITestLogger;
  xmlFilePath : string;
  {$ENDIF}
begin
  try
    //Create the runner
    Runner := TDUnitX.CreateRunner;
    Runner.UseRTTI := True;
    //tell the runner how we will log things
    Logger := TDUnitXConsoleLogger.Create;
    runner.AddLogger(Logger);

    {$IFDEF CI}
    //When running under the CI Server we want the results as Nunit xml
      xmlFilePath := ParamStr(1);
      ForceDirectories(ExcludeTrailingPathDelimiter(ExtractFilePath(xmlFilePath)));
      XMLLogger := TDUnitXXMLNUnitFileLogger.Create(xmlFilePath);
      runner.AddLogger(XMLLogger);

    {$ENDIF}


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
end.
