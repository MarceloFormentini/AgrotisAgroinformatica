unit model.conexao.uIQuery;

interface

uses
  Data.DB,
  System.Generics.Collections;

type
  IQuery = interface
  ['{0C1131B7-7799-4EBD-9CDF-E11CB7CB76D0}']
    procedure Query(const Statement: String; const Params: Array of Variant); overload;
    procedure Query(const Statement: String; const Params: TDictionary<String, Variant>); overload;
    function OneAll(const Statement: Variant; const Params: Array of Variant): TDataSet; overload;
    function OneAll(const Statement: String; const Params: TDictionary<String, Variant>): TDataSet; overload;
  end;

implementation

end.
