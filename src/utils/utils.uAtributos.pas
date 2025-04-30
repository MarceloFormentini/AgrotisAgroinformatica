unit utils.uAtributos;

interface

uses
  System.Rtti;

type
  Campo = class(TCustomAttribute)
    private
      FName: String;

    public
      constructor Create(AName: String);
      property Name: String read FName;
  end;

  Tabela = class(TCustomAttribute)
    private
      FName: String;

    public
      constructor Create(AName: String);
      property Name: String read FName;
  end;

  PK = class(TCustomAttribute)
  end;

  FK = class(TCustomAttribute)
  end;

implementation

{ Campo }

constructor Campo.Create(AName: String);
begin
  FName := AName;
end;

{ Tabela }

constructor Tabela.Create(AName: String);
begin
  FName := AName;

end;

end.
