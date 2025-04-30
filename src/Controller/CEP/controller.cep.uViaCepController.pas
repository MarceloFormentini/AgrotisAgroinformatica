unit controller.cep.uViaCepController;

interface

uses
  controller.cep.uIViaCepController,

  System.Net.HttpClient,
  System.JSON,
  System.SysUtils, model.cep.uIViaCEP;

type
  TViaCepController = class(TInterfacedObject, IViaCepController)
  public
    class function New: IViaCepController;
    function ConsultarPorCEP(const ACep: string): IViaCep;
  end;

implementation

uses
  model.cep.uViaCEP;

function TViaCepController.ConsultarPorCEP(const ACep: string): IViaCep;
var
  HttpClient: THttpClient;
  Response: IHTTPResponse;
  JsonObj: TJSONObject;
begin
  HttpClient := THttpClient.Create;
  Result := TViaCep.Create;
  try
    Response := HttpClient.Get('https://viacep.com.br/ws/' + ACep + '/json/');
    JsonObj := TJSONObject.ParseJSONValue(Response.ContentAsString) as TJSONObject;
    try
      if JsonObj <> nil then
      begin
      Result
          .SetCep(JsonObj.GetValue<string>('cep'))
          .SetLogradouro(JsonObj.GetValue<string>('logradouro'))
          .SetComplemento(JsonObj.GetValue<string>('complemento'))
          .SetBairro(JsonObj.GetValue<string>('bairro'))
          .SetCidade(JsonObj.GetValue<string>('localidade'))
          .SetUF(JsonObj.GetValue<string>('uf'))
          .SetCodigoIBGE(JsonObj.GetValue<string>('ibge'));
      end;
    finally
      JsonObj.Free;
    end;
  finally
    HttpClient.Free;
  end;
end;

class function TViaCepController.New: IViaCepController;
begin
  Result := Self.Create;
end;

end.
