unit DUT.Compiler.MethodOlverloadResolutionError.QC118897;

interface

uses
  {$if CompilerVersion < 23 }
    SysUtils,
    TypInfo,
  {$else}
    System.SysUtils, // Delphi XE2 (CompilerVersion 23) added scopes in front of unit names
    System.TypInfo,
  {$ifend}
  DUnitX.TestFramework
  ;

type
  IInterfaceDefinition = interface(IInterface)
    ['{98588095-29C8-4C19-9BDC-2697D51F8BCA}']
    procedure PlainOverloadMethod(const Description: string; const Item: Pointer); overload;
    procedure PlainOverloadMethod(const Description: string; const TypeTypeInfo: PTypeInfo); overload;
    procedure DefaultOverloadMethod(const Description: string; const Item: Pointer); overload;
    procedure DefaultOverloadMethod(const Description: string; const TypeTypeInfo: PTypeInfo; const Prefix: string = ''); overload;
  end;

  TClassDefinition = class(TInterfacedObject, IInterfaceDefinition)
    procedure PlainOverloadMethod(const Description: string; const Item: Pointer); overload;
    procedure PlainOverloadMethod(const Description: string; const TypeTypeInfo: PTypeInfo); overload;
    procedure DefaultOverloadMethod(const Description: string; const Item: Pointer); overload;
    procedure DefaultOverloadMethod(const Description: string; const TypeTypeInfo: PTypeInfo; const Prefix: string = ''); overload;
  end;

type
  TMethodOverloadResolutionBase = class
  strict protected
    Item: Pointer;
    TypeTypeInfo: PTypeInfo;
    Instance: TObject;
    procedure Setup(); virtual;
  end;

  [TestFixture]
  TMethodOverloadResolutionTests = class(TMethodOverloadResolutionBase)
  public
    [Setup]
    procedure Setup(); override;
    [Test]
    procedure TestPlainOverloadMethodAtPointer();
    [Test]
    procedure TestDefaultOverloadMethodAtPointer();
    [Test]
    procedure TestPlainOverloadMethodPointer();
    [Test]
    procedure TestDefaultOverloadMethodPointer();
    [Test]
    procedure TestPlainOverloadMethodPTypeInfo();
    [Test]
    procedure TestDefaultOverloadMethodPTypeInfo();
  end;

type
  [TestFixture]
  TClassMethodOverloadResolutionTests = class(TMethodOverloadResolutionBase)
  strict private
    ObjectInstance: TClassDefinition;
  public
    [Setup]
    procedure Setup; override;
    [TearDown]
    procedure TearDown();
    [Test]
    procedure TestPlainOverloadMethodAtPointer();
    [Test]
    procedure TestDefaultOverloadMethodAtPointer();
    [Test]
    procedure TestPlainOverloadMethodPointer();
    [Test]
    procedure TestDefaultOverloadMethodPointer();
    [Test]
    procedure TestPlainOverloadMethodPTypeInfo();
    [Test]
    procedure TestDefaultOverloadMethodPTypeInfo();
  end;

type
  [TestFixture]
  TInterfaceMethodOverloadResolutionTests = class(TMethodOverloadResolutionBase)
  strict private
    InterfaceReference: IInterfaceDefinition;
  public
    [Setup]
    procedure Setup; override;
    [TearDown]
    procedure TearDown();
    [Test]
    procedure TestPlainOverloadMethodAtPointer();
    [Test]
    procedure TestDefaultOverloadMethodAtPointer();
    [Test]
    procedure TestPlainOverloadMethodPointer();
    [Test]
    procedure TestDefaultOverloadMethodPointer();
    [Test]
    procedure TestPlainOverloadMethodPTypeInfo();
    [Test]
    procedure TestDefaultOverloadMethodPTypeInfo();
  end;

implementation

const
  SAtPointer = '@Pointer';
  SPointer = 'Pointer';
  SPTypeInfo = 'PTypeInfo';

type
  EOverloadResolutionError = class(Exception)
    constructor Create(const Description: string; const Method: string);
  end;

procedure Check(const Description: string; const Method: string; const Expected: string);
var
  OverloadResolutionError: EOverloadResolutionError;
begin
  if 0 = Pos(Expected, Description) then
  begin
    OverloadResolutionError := EOverloadResolutionError.Create(Description, Method);
    raise OverloadResolutionError;
  end;
end;

procedure GlobalPlainOverloadMethod(const Description: string; const Item: Pointer); overload;
const
  Method = 'procedure GlobalPlainOverloadMethod(const Description: string; const Item: Pointer);';
begin
  Check(Description, Method, SPointer);
end;

procedure GlobalPlainOverloadMethod(const Description: string; const TypeTypeInfo: PTypeInfo); overload;
const
  Method = 'procedure GlobalPlainOverloadMethod(const Description: string; const TypeTypeInfo: PTypeInfo);';
begin
  Check(Description, Method, SPTypeInfo);
end;

procedure GlobalDefaultOverloadMethod(const Description: string; const Item: Pointer); overload;
const
  Method = 'procedure GlobalDefaultOverloadMethod(const Description: string; const Item: Pointer);';
begin
  Check(Description, Method, SPointer);
end;

procedure GlobalDefaultOverloadMethod(const Description: string; const TypeTypeInfo: PTypeInfo; const Prefix: string = ''); overload;
const
  Method = 'procedure GlobalDefaultOverloadMethod(const Description: string; const TypeTypeInfo: PTypeInfo; const Prefix: string = '''');';
begin
  Check(Description, Method, SPTypeInfo);
end;

procedure TClassDefinition.PlainOverloadMethod(const Description: string; const Item: Pointer);
begin
  GlobalPlainOverloadMethod(Description, Item);
end;

procedure TClassDefinition.PlainOverloadMethod(const Description: string; const TypeTypeInfo: PTypeInfo);
begin
  GlobalPlainOverloadMethod(Description, TypeTypeInfo);
end;

procedure TClassDefinition.DefaultOverloadMethod(const Description: string; const Item: Pointer);
begin
  GlobalDefaultOverloadMethod(Description, Item);
end;

procedure TClassDefinition.DefaultOverloadMethod(const Description: string; const TypeTypeInfo: PTypeInfo; const Prefix: string = '');
begin
  GlobalDefaultOverloadMethod(Description, TypeTypeInfo, Prefix);
end;

{ EOverloadResolutionError }

constructor EOverloadResolutionError.Create(const Description, Method: string);
begin
  inherited CreateFmt('Overload resolution error: "%s" parameter called "%s"', [Description, Method]);
end;

{ TMethodOverloadResolutionBase }

procedure TMethodOverloadResolutionBase.Setup();
begin
  Item := nil;
  TypeTypeInfo := nil;
  Instance := nil;
end;

{ TMethodOverloadResolutionTests }

procedure TMethodOverloadResolutionTests.Setup();
begin
  inherited Setup();
end;

procedure TMethodOverloadResolutionTests.TestPlainOverloadMethodAtPointer();
begin
  GlobalPlainOverloadMethod(SAtPointer, @Instance); // error: calls the PTypeInfo overload
end;

procedure TMethodOverloadResolutionTests.TestDefaultOverloadMethodAtPointer();
begin
  GlobalDefaultOverloadMethod(SAtPointer, @Instance); // error: calls the PTypeInfo overload
end;

procedure TMethodOverloadResolutionTests.TestPlainOverloadMethodPointer();
begin
  GlobalPlainOverloadMethod(SPointer, Item);
end;

procedure TMethodOverloadResolutionTests.TestDefaultOverloadMethodPointer();
begin
  GlobalDefaultOverloadMethod(SPointer, Item);
end;

procedure TMethodOverloadResolutionTests.TestPlainOverloadMethodPTypeInfo();
begin
  GlobalPlainOverloadMethod(SPTypeInfo, TypeTypeInfo);
end;

procedure TMethodOverloadResolutionTests.TestDefaultOverloadMethodPTypeInfo();
begin
  GlobalDefaultOverloadMethod(SPTypeInfo, TypeTypeInfo);
end;

{ TClassMethodOverloadResolutionTests }

procedure TClassMethodOverloadResolutionTests.Setup;
begin
  inherited Setup();
  ObjectInstance := TClassDefinition.Create();
end;

procedure TClassMethodOverloadResolutionTests.TearDown();
begin
  ObjectInstance.Free();
  ObjectInstance := nil;
end;

procedure TClassMethodOverloadResolutionTests.TestPlainOverloadMethodAtPointer();
begin
  ObjectInstance.PlainOverloadMethod(SAtPointer, @Instance); // error: calls the PTypeInfo overload
end;

procedure TClassMethodOverloadResolutionTests.TestDefaultOverloadMethodAtPointer();
begin
  ObjectInstance.DefaultOverloadMethod(SAtPointer, @Instance); // error: calls the PTypeInfo overload
end;

procedure TClassMethodOverloadResolutionTests.TestPlainOverloadMethodPointer();
begin
  ObjectInstance.PlainOverloadMethod(SPointer, Item);
end;

procedure TClassMethodOverloadResolutionTests.TestDefaultOverloadMethodPointer();
begin
  ObjectInstance.DefaultOverloadMethod(SPointer, Item);
end;

procedure TClassMethodOverloadResolutionTests.TestPlainOverloadMethodPTypeInfo();
begin
  ObjectInstance.PlainOverloadMethod(SPTypeInfo, TypeTypeInfo);
end;

procedure TClassMethodOverloadResolutionTests.TestDefaultOverloadMethodPTypeInfo();
begin
  ObjectInstance.DefaultOverloadMethod(SPTypeInfo, TypeTypeInfo);
end;

{ TInterfaceMethodOverloadResolutionTests }

procedure TInterfaceMethodOverloadResolutionTests.Setup;
var
  Logger: TClassDefinition;
begin
  inherited Setup();
  Logger := TClassDefinition.Create();
  InterfaceReference := Logger;
end;

procedure TInterfaceMethodOverloadResolutionTests.TearDown();
begin
  InterfaceReference := nil;
end;

procedure TInterfaceMethodOverloadResolutionTests.TestPlainOverloadMethodAtPointer();
begin
  InterfaceReference.PlainOverloadMethod(SAtPointer, @Instance); // error: calls the PTypeInfo overload
end;

procedure TInterfaceMethodOverloadResolutionTests.TestDefaultOverloadMethodAtPointer();
begin
  InterfaceReference.DefaultOverloadMethod(SAtPointer, @Instance); // error: calls the PTypeInfo overload
end;

procedure TInterfaceMethodOverloadResolutionTests.TestPlainOverloadMethodPointer();
begin
  InterfaceReference.PlainOverloadMethod(SPointer, Item);
end;

procedure TInterfaceMethodOverloadResolutionTests.TestDefaultOverloadMethodPointer();
begin
  InterfaceReference.DefaultOverloadMethod(SPointer, Item);
end;

procedure TInterfaceMethodOverloadResolutionTests.TestPlainOverloadMethodPTypeInfo();
begin
  InterfaceReference.PlainOverloadMethod(SPTypeInfo, TypeTypeInfo);
end;

procedure TInterfaceMethodOverloadResolutionTests.TestDefaultOverloadMethodPTypeInfo();
begin
  InterfaceReference.DefaultOverloadMethod(SPTypeInfo, TypeTypeInfo);
end;

initialization
  TDUnitX.RegisterTestFixture(TMethodOverloadResolutionTests);
  TDUnitX.RegisterTestFixture(TClassMethodOverloadResolutionTests);
  TDUnitX.RegisterTestFixture(TInterfaceMethodOverloadResolutionTests);
end.

