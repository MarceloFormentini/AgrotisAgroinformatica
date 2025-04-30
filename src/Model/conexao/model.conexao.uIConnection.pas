unit model.conexao.uIConnection;

interface

uses
  Data.DB;

type

  IConnection = interface
    function Connection : TCustomConnection;
  end;

implementation

end.
