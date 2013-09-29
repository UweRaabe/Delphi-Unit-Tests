unit DUnitX.ContinuaCI;

interface

uses
  DUnitX.TestFramework;

procedure AddContinuaCILogger(Runner: ITestRunner);

implementation

uses
  {$if CompilerVersion < 23 }
    SysUtils,
  {$else}
    System.SysUtils, // Delphi XE2 (CompilerVersion 23) added scopes in front of unit names
  {$ifend }
  DUnitX.Loggers.XML.NUnit;

procedure AddContinuaCILogger(Runner: ITestRunner);
var
  xmlFilePath: string;
  XMLLogger: ITestLogger;
begin
  //When running under the CI Server we want the results as Nunit xml
  xmlFilePath := ParamStr(1);
  if '' = xmlFilePath then
    Exit; {TODO -o##jwp -cQuestion : Ask VSoft: Should we be nice here, or raise an Exception?}

  ForceDirectories(ExcludeTrailingPathDelimiter(ExtractFilePath(xmlFilePath)));
  XMLLogger := TDUnitXXMLNUnitFileLogger.Create(xmlFilePath);
  runner.AddLogger(XMLLogger);
end;

end.
