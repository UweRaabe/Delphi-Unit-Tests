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
  DUT.Classes.TList.Enumerator in 'Tests\Classes\DUT.Classes.TList.Enumerator.pas',
  DUT.DateUtils.DateOf in 'Tests\DateUtils\DUT.DateUtils.DateOf.pas',
  DUT.DateUtils.Encode in 'Tests\DateUtils\DUT.DateUtils.Encode.pas',
  DUT.StrUtils in 'Tests\StrUtils\DUT.StrUtils.pas',
  DUT.SysUtils in 'Tests\SysUtils\DUT.SysUtils.pas',
  DUT.DateUtils.MiscFunctions in 'Tests\DateUtils\DUT.DateUtils.MiscFunctions.pas',
  DUT.SysUtils.QC108975 in 'Tests\SysUtils\DUT.SysUtils.QC108975.pas',
  DUT.SysUtils.QC109207 in 'Tests\SysUtils\DUT.SysUtils.QC109207.pas',
  DUT.SysUtils.BoolStrTests in 'Tests\SysUtils\DUT.SysUtils.BoolStrTests.pas',
  DUT.DateUtils.EndOf in 'Tests\DateUtils\DUT.DateUtils.EndOf.pas';

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
