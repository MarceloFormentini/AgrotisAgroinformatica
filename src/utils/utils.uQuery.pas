unit utils.uQuery;

interface

uses
  utils.uIQuery,
  System.Generics.Collections;

type
  TQuery = class(TInterfacedObject, IQuery)
  private
    FParent: TObject;

    function Fields: String;
    function Params: String;
    function Where: String;
    function NomeTabela: String;
    function FieldParamsUpdate: String;

    constructor Create(Parent: IInterface);

  public
    class function New(Parent: IInterface): IQuery;

    procedure FieldParameter(var AValue: TDictionary<String, Variant>);
    function SelectWithWhere(AValue: Boolean): string;
    function Insert: String;
    function Update: String;
    function Delete: String;

  end;

implementation

uses
  System.Rtti,
  utils.uRttiHelper,
  utils.uAtributos,
  System.SysUtils,
  System.TypInfo,
  System.DateUtils;

constructor TQuery.Create(Parent: IInterface);
begin
  FParent := TObject(Parent);
end;

procedure TQuery.FieldParameter(var AValue: TDictionary<String, Variant>);
var
  lContexto: TRttiContext;
  lTipo: TRttiType;
begin
  lContexto := TRttiContext.Create;
  try
    lTipo := lContexto.GetType(FParent.ClassInfo);

    for var I in lTipo.GetFields do
    begin
      if not I.Tem<Campo> then
        Break;

      case I.GetValue(FParent).TypeInfo.Kind of
        tkInteger, tkInt64: 
        begin
          if not (I.GetValue(FParent).AsInteger <= 0) then
            AValue.Add(I.GetAttribute<Campo>.Name,I.GetValue(FParent).AsInteger);
        end;
        tkFloat: 
        begin
          if I.GetValue(FParent).TypeInfo = TypeInfo(TDateTime) then
            AValue.Add(I.GetAttribute<Campo>.Name, StrToDateTime(I.GetValue(FParent).ToString));

          if I.GetValue(FParent).TypeInfo = TypeInfo(Currency) then
            AValue.Add(I.GetAttribute<Campo>.Name, I.GetValue(FParent).AsCurrency);
        end;
        tkLString,
        tkWString,
        tkUString,
        tkString: 
        begin
          if not I.GetValue(FParent).AsString.IsEmpty then
            AValue.Add(I.GetAttribute<Campo>.Name, I.GetValue(FParent).AsString);
        end;
        else
          AValue.Add(I.GetAttribute<Campo>.Name, I.GetValue(FParent).AsString);

      end;
    end;

  finally
    lContexto.Free;
  end;

end;

function TQuery.FieldParamsUpdate: String;
var
  lContexto: TRttiContext;
  lTipo: TRttiType;
begin
  Result := '';

  lContexto := TRttiContext.Create;
  try
    lTipo := lContexto.GetType(FParent.ClassInfo);

    for var I in lTipo.GetFields do
    begin
      if not I.Tem<Campo> then
        Break;

      case I.GetValue(FParent).TypeInfo.Kind of
        tkInteger, tkInt64:
        begin
          if not (I.GetValue(FParent).AsInteger <= 0) then
            Result := Result + I.GetAttribute<Campo>.Name + ' = :' + I.GetAttribute<Campo>.Name + ', ';
        end;
        tkFloat:
        begin
          if I.GetValue(FParent).TypeInfo = TypeInfo(TDateTime) then
              Result := Result + I.GetAttribute<Campo>.Name + ' = :' + I.GetAttribute<Campo>.Name + ', ';

          if I.GetValue(FParent).TypeInfo = TypeInfo(Currency) then
            Result := Result + I.GetAttribute<Campo>.Name + ' = :' + I.GetAttribute<Campo>.Name + ', ';
        end;
        tkLString,
        tkWString,
        tkUString,
        tkString:
        begin
          if not I.GetValue(FParent).AsString.IsEmpty then
            Result := Result + I.GetAttribute<Campo>.Name + ' = :' + I.GetAttribute<Campo>.Name + ', ';
        end;
        else
          Result := Result + I.GetAttribute<Campo>.Name + ' = :' + I.GetAttribute<Campo>.Name + ', ';
      end;
    end;
  finally
    Result := Copy(Result, 0, Length(Result) - 2) + ' ';
    lContexto.Free;
  end;
end;

function TQuery.Fields: String;
var
  lContexto: TRttiContext;
  lTipo: TRttiType;
begin
  lContexto := TRttiContext.Create;
  try
    lTipo := lContexto.GetType(FParent.ClassInfo);

    for var I in lTipo.GetFields do
    begin
      if not I.Tem<Campo> then
        Break;

      case I.GetValue(FParent).TypeInfo.Kind of
        tkInteger, tkInt64:
        begin
          if not (I.GetValue(FParent).AsInteger <= 0) then
            Result := Result + I.GetAttribute<Campo>.Name + ', ';
        end;
        tkFloat:
        begin
          if I.GetValue(FParent).TypeInfo = TypeInfo(TDateTime) then
              Result := Result + I.GetAttribute<Campo>.Name + ', ';

          if I.GetValue(FParent).TypeInfo = TypeInfo(Currency) then
            Result := Result + I.GetAttribute<Campo>.Name + ', ';
        end;
        tkLString,
        tkWString,
        tkUString,
        tkString:
        begin
          if not I.GetValue(FParent).AsString.IsEmpty then
            Result := Result + I.GetAttribute<Campo>.Name + ', ';
        end;
        else
          Result := Result + I.GetAttribute<Campo>.Name + ', ';
      end;
    end;
  finally
    Result := Copy(Result, 0, Result.Length-2);
    lContexto.Free;
  end;
end;

class function TQuery.New(Parent: IInterface): IQuery;
begin
  Result := Self.Create(Parent);
end;

function TQuery.Params: String;
var
  ctxRtti: TRttiContext;
  typRtti: TRttiType;
  lField: TRttiField;
begin
  ctxRtti := TRttiContext.Create;
  try
    typRtti := ctxRtti.GetType(FParent.ClassInfo);
    for var I in typRtti.GetFields do
    begin
      if not I.Tem<Campo> then
        Break;

      case I.GetValue(FParent).TypeInfo.Kind of
        tkInteger, tkInt64: begin
          if not (I.GetValue(FParent).AsInteger <= 0) then
            Result  := Result + ':' + I.GetAttribute<Campo>.Name + ', ';
        end;
        tkFloat: begin
          if I.GetValue(FParent).TypeInfo = TypeInfo(TDateTime) then
              Result  := Result + ':' + I.GetAttribute<Campo>.Name + ', ';

          if I.GetValue(FParent).TypeInfo = TypeInfo(Currency) then
            Result  := Result + ':' + I.GetAttribute<Campo>.Name + ', ';
        end;
        tkLString,
        tkWString,
        tkUString,
        tkString: begin
          if not I.GetValue(FParent).AsString.IsEmpty then
            Result  := Result + ':' + I.GetAttribute<Campo>.Name + ', ';
        end;
        else
          Result  := Result + ':' + I.GetAttribute<Campo>.Name + ', ';
      end;
    end;
  finally
    Result := Copy(Result, 0, Length(Result) - 2) + ' ';
    ctxRtti.Free;
  end;
end;

function TQuery.SelectWithWhere(AValue: Boolean): string;
begin
  Result := 'SELECT * FROM ' + NomeTabela;

  if AValue then
    Result := Result + ' WHERE ' + Where;
end;

function TQuery.NomeTabela: String;
var
  vCtxRtti: TRttiContext;
  vTypRtti: TRttiType;
begin
  vCtxRtti := TRttiContext.Create;
  try
    vTypRtti := vCtxRtti.GetType(FParent.ClassInfo);

    if vTypRtti.Tem<Tabela> then
      Result := vTypRtti.GetAttribute<Tabela>.Name;

  finally
    vCtxRtti.Free;
  end;
end;

function TQuery.Insert: String;
begin
  Result := 'INSERT INTO ' + NomeTabela + ' (' + Fields + ') VALUES (' + Params + ');';
end;

function TQuery.Update: String;
begin
  Result := 'UPDATE ' + NomeTabela + ' SET ' + FieldParamsUpdate + '  WHERE ' + Where;
end;

function TQuery.Where: String;
var
  lCtxRtti: TRttiContext;
  lTipo: TRttiType;
begin
  Result := '';

  lCtxRtti := TRttiContext.Create;
  try
    lTipo := lCtxRtti.GetType(FParent.ClassInfo);

    for var I in lTipo.GetFields do
    begin
      if not I.Tem<PK> then
        Continue;

      Result := Result + I.GetAttribute<Campo>.Name + ' = :' + I.GetAttribute<Campo>.Name + ' AND ';
    end;
  finally
    Result := Copy(Result, 0, Length(Result) - 4) + ' ';
    lCtxRtti.Free;
  end;
end;

function TQuery.Delete: String;
begin
  Result := 'DELETE FROM ' + NomeTabela + ' WHERE ' + Where;
end;

end.
