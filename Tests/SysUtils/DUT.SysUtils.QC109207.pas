unit DUT.SysUtils.QC109207;

interface

uses
  System.SysUtils,
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
