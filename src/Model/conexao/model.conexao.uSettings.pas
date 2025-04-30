unit model.conexao.uSettings;

interface

uses
  model.conexao.uISettings,
  System.IniFiles,
  System.SysUtils;

type
  TSettings = class(TInterfacedObject, ISettings)
  const
    SECTION = 'CONFIG';
    CAMINHO = 'CAMINHO';
    PORTA = 'PORTA';
    SERVIDOR = 'SERVIDOR';
    USUARIO = 'USUARIO';
    SENHA = 'SENHA';
    DRIVERNAME = 'DRIVERNAME';

  private
    FArquivo: TIniFile;
    FProtocolo: String;
    FServidor: String;
    FPorta: Integer;
    FUsuario: String;
    FSenha: String;
    FCaminho: String;
    FDriveName: String;

    constructor Create(AFileName: String);
    destructor Destroy; override;

  public
    class function New(AFileName: String): ISettings;

    function GetProtocolo: String;

    function SetServidor(const AValue: String): ISettings;
    function GetServidor: String;

    function SetPorta(const AValue: Integer): ISettings;
    function GetPorta: String;

    function SetUsuario(const AValue: String): ISettings;
    function GetUsuario: String;

    function SetSenha(const AValue: String): ISettings;
    function GetSenha: String;

    function SetCaminho(const AValue: String): ISettings;
    function GetCaminho: String;

    function SetDriverName(const AValue: String): ISettings;
    function GetDriverName: String;

  end;

implementation

constructor TSettings.Create(AFileName: String);
begin
  FArquivo := TIniFile.Create(AFileName);
end;

destructor TSettings.Destroy;
begin
  FArquivo.Free;
  inherited;
end;

class function TSettings.New(AFileName: String): ISettings;
begin
  Result := Self.Create(AFileName);
end;

function TSettings.GetCaminho: String;
begin
  Result := FArquivo.ReadString(SECTION, CAMINHO, '');
end;

function TSettings.GetDriverName: String;
begin
  Result := FArquivo.ReadString(SECTION, DRIVERNAME, '');
end;

function TSettings.GetPorta: String;
begin
  Result := FArquivo.ReadString(SECTION, PORTA, '');
end;

function TSettings.GetProtocolo: String;
begin
  Result := 'LOCAL';
  if not (FArquivo.ReadString(SECTION, SERVIDOR, '').Equals('LOCALHOST') or
    FArquivo.ReadString(SECTION, SERVIDOR, '').Equals('127.0.0.1')) then
      Result := 'TCP';
end;

function TSettings.GetSenha: String;
begin
  Result := FArquivo.ReadString(SECTION, SENHA, '');
end;

function TSettings.GetServidor: String;
begin
  Result := FArquivo.ReadString(SECTION, SERVIDOR, '');
end;

function TSettings.GetUsuario: String;
begin
  Result := FArquivo.ReadString(SECTION, USUARIO, '');
end;

function TSettings.SetCaminho(const AValue: String): ISettings;
begin
  Result := Self;
  FArquivo.WriteString(SECTION, CAMINHO, AValue);
end;

function TSettings.SetDriverName(const AValue: String): ISettings;
begin
  Result := Self;
  FArquivo.WriteString(SECTION, DRIVERNAME, AValue);
end;

function TSettings.SetPorta(const AValue: Integer): ISettings;
begin
  Result := Self;
  FArquivo.WriteInteger(SECTION, PORTA, AValue);
end;

function TSettings.SetSenha(const AValue: String): ISettings;
begin
  Result := Self;
  FArquivo.WriteString(SECTION, SENHA, AValue);
end;

function TSettings.SetServidor(const AValue: String): ISettings;
begin
  Result := Self;
  FArquivo.WriteString(SECTION, SERVIDOR, AValue);
end;

function TSettings.SetUsuario(const AValue: String): ISettings;
begin
  Result := Self;
  FArquivo.WriteString(SECTION, USUARIO, AValue);
end;

end.
