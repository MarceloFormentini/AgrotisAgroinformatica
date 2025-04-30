unit model.cep.uViaCEP;

interface

uses
  model.cep.uIViaCEP;

type
  TViaCEP = class(TInterfacedObject, IViaCEP)
  private
    FCep: string;
    FLogradouro: string;
    FComplemento: string;
    FBairro: string;
    FCidade: string;
    FUF: string;
    FCodigoIBGE: string;

  public
    class function New: IViaCEP;

    function GetCep: string;
    function GetLogradouro: string;
    function GetComplemento: string;
    function GetBairro: string;
    function GetCidade: string;
    function GetUF: string;
    function GetCodigoIBGE: string;

    function SetCep(const AValue: string): IViaCEP;
    function SetLogradouro(const AValue: string): IViaCEP;
    function SetComplemento(const AValue: string): IViaCEP;
    function SetBairro(const AValue: string): IViaCEP;
    function SetCidade(const AValue: string): IViaCEP;
    function SetUF(const AValue: string): IViaCEP;
    function SetCodigoIBGE(const AValue: string): IViaCEP;
  end;

implementation

function TViaCEP.GetBairro: string;
begin
  Result := FBairro;
end;

function TViaCEP.GetCep: string;
begin
  Result := FCep;
end;

function TViaCEP.GetCodigoIBGE: string;
begin
  Result := FCodigoIBGE;
end;

function TViaCEP.GetComplemento: string;
begin
  Result := FComplemento;
end;

function TViaCEP.GetCidade: string;
begin
  Result := FCidade;
end;

function TViaCEP.GetLogradouro: string;
begin
  Result := FLogradouro;
end;

function TViaCEP.GetUF: string;
begin
  Result := FUF;
end;

class function TViaCEP.New: IViaCEP;
begin
  Result := Self.Create;
end;

function TViaCEP.SetBairro(const AValue: string): IViaCEP;
begin
  Result := Self;
  FBairro := AValue;
end;

function TViaCEP.SetCep(const AValue: string): IViaCEP;
begin
  Result := Self;
  FCEP := AValue;
end;

function TViaCEP.SetCodigoIBGE(const AValue: string): IViaCEP;
begin
  Result := Self;
  FCodigoIBGE := AValue;
end;

function TViaCEP.SetComplemento(const AValue: string): IViaCEP;
begin
  Result := Self;
  FComplemento := AValue;
end;

function TViaCEP.SetCidade(const AValue: string): IViaCEP;
begin
  Result := Self;
  FCidade := AValue;
end;

function TViaCEP.SetLogradouro(const AValue: string): IViaCEP;
begin
  Result := Self;
  FLogradouro := AValue;
end;

function TViaCEP.SetUF(const AValue: string): IViaCEP;
begin
  Result := Self;
  FUF := AValue;
end;

end.
