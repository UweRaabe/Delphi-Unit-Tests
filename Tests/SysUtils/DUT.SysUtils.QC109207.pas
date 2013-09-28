unit DUT.SysUtils.QC109207;

interface

uses
  {$if CompilerVersion < 23 }
    SysUtils,
  {$else}
    System.SysUtils, // Delphi XE2 (CompilerVersion 23) added scopes in front of unit names
  {$ifend}
  DUnitX.TestFramework;

type
  [TestFixture('QC109207', '0-based Strings')]
  TSysUtilsCaseTest_QC109207 = class
    [Test]
    procedure TestExtractFileExt_QC109207;
  end;

implementation

{ TSysUtilsCaseTest_QC109207 }

procedure TSysUtilsCaseTest_QC109207.TestExtractFileExt_QC109207;
begin
  // Due to 0-based strings, XE3 messed up this call. Fixed in XE4
  Assert.AreEqual('.png', ExtractFileExt('.png'), False, 'ExtractFileDir failed');
end;

initialization
  TDUnitX.RegisterTestFixture(TSysUtilsCaseTest_QC109207);
end.
