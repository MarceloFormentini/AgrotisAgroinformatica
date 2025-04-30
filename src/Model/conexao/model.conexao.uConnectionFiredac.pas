unit model.conexao.uConnectionFiredac;

interface

uses
  model.conexao.uIConnection,
  model.conexao.uISettings,
  System.SysUtils,
  System.IniFiles,
  FireDAC.Comp.Client,
  FireDAC.Phys.FB,
  FireDAC.Stan.Def,
  FireDAC.DApt,
  FireDAC.VCLUI.Wait,
  FireDAC.Stan.Async,
  Data.DB;

type
  TConnectionFiredac = class(TInterfacedObject, IConnection)
  private
    FConnection: TFDConnection;
    FSettings: ISettings;

    constructor Create;
    destructor Destroy; override;

  public
    class function New: IConnection;
    function Connection: TCustomConnection;
  end;

implementation

uses
  model.conexao.uSettings;

function TConnectionFiredac.Connection: TCustomConnection;
begin
  Result := FConnection;
end;

constructor TConnectionFiredac.Create;
begin
  FConnection:= TFDConnection.Create(nil);
  FSettings := TSettings.New(ExtractFilePath(ParamStr(0)) + 'conf.ini');
  try
    FConnection.Params.Clear;
    FConnection.Params.DriverID := FSettings.GetDriverName;
    FConnection.Params.Database := FSettings.GetCaminho;
    FConnection.Params.UserName := FSettings.GetUsuario;
    FConnection.Params.Password := FSettings.GetSenha;
  except
    raise Exception.Create('Error ao tentar conectar com a base de dados');
  end;
end;

destructor TConnectionFiredac.Destroy;
begin
  FConnection.Free;
  inherited;
end;

class function TConnectionFiredac.New: IConnection;
begin
  Result := Self.Create;
end;

end.
