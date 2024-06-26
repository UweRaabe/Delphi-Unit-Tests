unit DUT.SysUtils.QC108975;

interface

uses
  System.SysUtils,
  DUnitX.TestFramework;

type
  [TestFixture('QC108975', '0-based Strings')]
  TSysUtilsCaseTest_QC108975 = class
    [Test]
    procedure TestExtractFileDir_QC108975;
  end;

implementation

{ TSysUtilsCaseTest_QC108975 }

procedure TSysUtilsCaseTest_QC108975.TestExtractFileDir_QC108975;
begin
  // Due to 0-based strings, XE3 messed up this call. Fixed in XE4
  Assert.AreEqual('\', ExtractFileDir('\xxx'), False, 'ExtractFileDir failed');
end;

initialization
  TDUnitX.RegisterTestFixture(TSysUtilsCaseTest_QC108975);
end.
