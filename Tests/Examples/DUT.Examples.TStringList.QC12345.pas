unit DUT.Examples.TStringList.QC12345;

///  Example of how a Test demonstrating a QC bug might be done.
///  Note one bug per QC, that would make it easier to see.

interface

uses
  {$if CompilerVersion < 23 }
    StrUtils,
  {$else}
    System.Classes, // Delphi XE2 (CompilerVersion 23) added scopes in front of unit names
  {$ifend}
   DUnitX.TestFramework;

type
  [TestFixture('QC12345','Shows super duper bug')]
  TQC12345 = class
  public
    [Test]
    procedure ShowBug;
  end;


implementation

{ TQC12345 }

procedure TQC12345.ShowBug;
begin
  Assert.IsTrue(False,'See, true is defintely not False!!!');
end;

initialization
  TDUnitX.RegisterTestFixture(TQC12345);

end.
