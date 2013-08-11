unit DUT.Classes;

interface

uses
     DUnitX.TestFramework
   , Classes
   ;

type
  [TestFixture]
  TClassesListEnumeratorTests = class
  private
    FListEnumerator : TListEnumerator;
    FList : TList;
    Expected, Actual: string;
  public
    [Setup]
    procedure CreateListAndEnumerator;
    [Teardown]
    procedure DestroyListAndEnumerator;

    [Test]
    procedure TestListEnumerator_Create_NILListParameterAccepted;
    [Test]
    procedure TestListEnumerator_GetCurrent_ExceptionAsNeedToCallMoveNext;
    [Test]
    procedure TestListEnumerator_GetCurrent_GetsCurrent;
    [Test]
    procedure TestListEnumerator_MoveNext_IncrementsCurrent;
    [Test]
    procedure TestListEnumerator_MoveNext_ReturnsTrueOnMoving;
    [Test]
    procedure TestListEnumerator_MoveNext_ReturnsFalseOnReachingEndOfList;
    [Test]
    procedure TestListEnumerator_MoveNext_DoesNotPassEndOfList;
    [Test]
    procedure TestListEnumerator_MoveNext_ChangeTheListToASmallerSizeMakingTheIndexOutOfBounds;
    [Test]
    procedure TestListEnumerator_MoveNext_ChangeTheListToASmallerSizeThenCallMoveNext;
  end;

implementation

uses
     SysUtils;

{ TClassesListEnumeratorTests }

procedure TClassesListEnumeratorTests.CreateListAndEnumerator;
begin
  inherited;

  FList := TList.Create;
  FListEnumerator := TListEnumerator.Create(FList);
end;

procedure TClassesListEnumeratorTests.DestroyListAndEnumerator;
begin
  FListEnumerator.Free;
  // it is the tests` responsibility to free objects added to the list
  FList.Free;

  inherited;
end;

procedure TClassesListEnumeratorTests.TestListEnumerator_Create_NILListParameterAccepted;
var
  enumerator : TListEnumerator;

begin
  enumerator := TListEnumerator.Create(NIL);
  Assert.Pass( 'TListEnumerator is allowed a NIL TList parameter' );
  enumerator.Free;
end;

procedure TClassesListEnumeratorTests.TestListEnumerator_GetCurrent_ExceptionAsNeedToCallMoveNext;
begin
  try
    FListEnumerator.GetCurrent;
  except
    on E: Exception do
      if E.Message = 'List index out of bounds (-1)' then
        Assert.Pass( 'Calling GetCurrent before calling MoveNext causes an Access Violation' )
      else
        Assert.Fail;
  end;
end;

procedure TClassesListEnumeratorTests.TestListEnumerator_GetCurrent_GetsCurrent;
var
  item1 : TObject;
  item2 : TObject;

begin
  item1 := TObject.Create;
  item2 := TObject.Create;
  try
    FList.Add( item1 );
    FList.Add( item2 ); // just to make sure it doesnt return the wrong item

    FListEnumerator.MoveNext;
    Assert.AreSame( TObject( FListEnumerator.GetCurrent ), item1, 'The item returned in GetCurrent is not the one expected' );
  finally
    item1.Free;
    item2.Free;
  end;
end;

procedure TClassesListEnumeratorTests.TestListEnumerator_MoveNext_IncrementsCurrent;
var
  item1 : TObject;
  item2 : TObject;

begin
  item1 := TObject.Create;
  item2 := TObject.Create;
  try
    FList.Add( item1 );
    FList.Add( item2 );

    FListEnumerator.MoveNext;
    Assert.AreSame( TObject( FListEnumerator.GetCurrent ), item1, 'The item returned in GetCurrent is not the one expected' );
    FListEnumerator.MoveNext;
    Assert.AreSame( TObject( FListEnumerator.GetCurrent ), item2, 'The item returned in GetCurrent is not the one expected' );
  finally
    item1.Free;
    item2.Free;
  end;
end;

procedure TClassesListEnumeratorTests.TestListEnumerator_MoveNext_ReturnsTrueOnMoving;
var
  item1 : TObject;

begin
  item1 := TObject.Create;
  try
    FList.Add( item1 );

    Assert.IsTrue( FListEnumerator.MoveNext );
  finally
    item1.Free;
  end;
end;

procedure TClassesListEnumeratorTests.TestListEnumerator_MoveNext_ReturnsFalseOnReachingEndOfList;
var
  item1 : TObject;

begin
  item1 := TObject.Create;
  try
    FList.Add( item1 );

    FListEnumerator.MoveNext; // now at end
    Assert.IsFalse( FListEnumerator.MoveNext );
  finally
    item1.Free;
  end;
end;

procedure TClassesListEnumeratorTests.TestListEnumerator_MoveNext_DoesNotPassEndOfList;
var
  item1 : TObject;
  item2 : TObject;

begin
  item1 := TObject.Create;
  item2 := TObject.Create;
  try
    FList.Add( item1 );
    FList.Add( item2 );

    FListEnumerator.MoveNext;
    FListEnumerator.MoveNext; // after this one it should not increment past end of list
    FListEnumerator.MoveNext;
    FListEnumerator.MoveNext;
    FListEnumerator.MoveNext;
    Assert.AreSame( TObject( FListEnumerator.GetCurrent ), item2, 'The item returned in GetCurrent is not the one expected' );
  finally
    item1.Free;
    item2.Free;
  end;
end;

procedure TClassesListEnumeratorTests.TestListEnumerator_MoveNext_ChangeTheListToASmallerSizeMakingTheIndexOutOfBounds;
var
  item1 : TObject;
  item2 : TObject;

begin
  item1 := TObject.Create;
  item2 := TObject.Create;
  try
    FList.Add( item1 );
    FList.Add( item2 );

    FListEnumerator.MoveNext;
    FListEnumerator.MoveNext;
    Assert.AreSame( TObject( FListEnumerator.GetCurrent ), item2, 'The item returned in GetCurrent is not the one expected' );

    // now change the list, by removing the second item
    FList.Remove( item2 );
    try
      FListEnumerator.GetCurrent;
    except
      on E: Exception do
        if E.Message = 'List index out of bounds (1)' then
          Assert.Pass( 'Calling GetCurrent before calling MoveNext causes an Access Violation if the TList has become smaller than the current index' )
        else
          Assert.Fail;
    end;
  finally
    item1.Free;
    item2.Free;
  end;
end;

procedure TClassesListEnumeratorTests.TestListEnumerator_MoveNext_ChangeTheListToASmallerSizeThenCallMoveNext;
var
  item1 : TObject;
  item2 : TObject;

begin
  item1 := TObject.Create;
  item2 := TObject.Create;
  try
    FList.Add( item1 );
    FList.Add( item2 );

    FListEnumerator.MoveNext;
    FListEnumerator.MoveNext;
    Assert.AreSame( TObject( FListEnumerator.GetCurrent ), item2, 'The item returned in GetCurrent is not the one expected' );

    // now change the list, by removing the second item
    FList.Remove( item2 );
    FListEnumerator.MoveNext;
    try
      FListEnumerator.GetCurrent;
    except
      on E: Exception do
        if E.Message = 'List index out of bounds (1)' then
          Assert.Pass( 'Calling GetCurrent after calling MoveNext causes an Access Violation if the TList has become smaller than the current index' )
        else
          Assert.Fail;
    end;
  finally
    item1.Free;
    item2.Free;
  end;
end;


initialization
  TDUnitX.RegisterTestFixture(TClassesListEnumeratorTests);

end.
