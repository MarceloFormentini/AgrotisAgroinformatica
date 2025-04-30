unit model.conexao.uISettings;

interface

type
  ISettings = interface
  ['{FF1E61FC-1A72-438C-A025-335444447F99}']
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

end.
