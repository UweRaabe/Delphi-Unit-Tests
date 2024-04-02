program DelphiUnitTests;

{$IFNDEF TESTINSIGHT}
{$APPTYPE CONSOLE}
{$ENDIF}
{$STRONGLINKTYPES ON}
uses
  System.SysUtils,
  {$IFDEF TESTINSIGHT}
  TestInsight.DUnitX,
  {$ELSE}
  DUnitX.Loggers.Console,
  DUnitX.Loggers.XML.NUnit,
  {$ENDIF }
  DUnitX.TestFramework,
  DUT.Classes.TList.Enumerator in 'Tests\Classes\DUT.Classes.TList.Enumerator.pas',
  DUT.Compiler.MethodOlverloadResolutionError.QC118897 in 'Tests\Compiler\DUT.Compiler.MethodOlverloadResolutionError.QC118897.pas',
  DUT.DateUtils.DateOf in 'Tests\DateUtils\DUT.DateUtils.DateOf.pas',
  DUT.DateUtils.Encode in 'Tests\DateUtils\DUT.DateUtils.Encode.pas',
  DUT.DateUtils.EndOf in 'Tests\DateUtils\DUT.DateUtils.EndOf.pas',
  DUT.DateUtils.HourOf in 'Tests\DateUtils\DUT.DateUtils.HourOf.pas',
  DUT.DateUtils.MiscFunctions in 'Tests\DateUtils\DUT.DateUtils.MiscFunctions.pas',
  DUT.StrUtils in 'Tests\StrUtils\DUT.StrUtils.pas',
  DUT.SysUtils in 'Tests\SysUtils\DUT.SysUtils.pas',
  DUT.SysUtils.BoolStrTests in 'Tests\SysUtils\DUT.SysUtils.BoolStrTests.pas',
  DUT.SysUtils.QC108975 in 'Tests\SysUtils\DUT.SysUtils.QC108975.pas',
  DUT.SysUtils.QC109207 in 'Tests\SysUtils\DUT.SysUtils.QC109207.pas';

{ keep comment here to protect the following conditional from being removed by the IDE when adding a unit }
{$IFNDEF TESTINSIGHT}
var
  runner: ITestRunner;
  results: IRunResults;
  logger: ITestLogger;
  nunitLogger : ITestLogger;
{$ENDIF}
begin
{$IFDEF TESTINSIGHT}
  TestInsight.DUnitX.RunRegisteredTests;
{$ELSE}
  try
    //Check command line options, will exit if invalid
    TDUnitX.CheckCommandLine;
    //Create the test runner
    runner := TDUnitX.CreateRunner;
    //Tell the runner to use RTTI to find Fixtures
    runner.UseRTTI := True;
    //When true, Assertions must be made during tests;
    runner.FailsOnNoAsserts := False;

    //tell the runner how we will log things
    //Log to the console window if desired
    if TDUnitX.Options.ConsoleMode <> TDunitXConsoleMode.Off then
    begin
      logger := TDUnitXConsoleLogger.Create(TDUnitX.Options.ConsoleMode = TDunitXConsoleMode.Quiet);
      runner.AddLogger(logger);
    end;
    //Generate an NUnit compatible XML File
    nunitLogger := TDUnitXXMLNUnitFileLogger.Create(TDUnitX.Options.XMLOutputFile);
    runner.AddLogger(nunitLogger);

    //Run tests
    results := runner.Execute;
    if not results.AllPassed then
      System.ExitCode := EXIT_ERRORS;

    {$IFNDEF CI}
    //We don't want this happening when running under CI.
    if TDUnitX.Options.ExitBehavior = TDUnitXExitBehavior.Pause then
    begin
      System.Write('Done.. press <Enter> key to quit.');
      System.Readln;
    end;
    {$ENDIF}
  except
    on E: Exception do
      System.Writeln(E.ClassName, ': ', E.Message);
  end;
{$ENDIF}
end.
