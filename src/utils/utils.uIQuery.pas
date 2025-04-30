unit utils.uIQuery;

interface

uses
  System.Generics.Collections;

type
  IQuery = interface
  ['{4CC8B0E7-DC88-4138-B407-7FFC625AF8A5}']
    function Insert: String;
    function Update: String;
    function Delete: String;
    procedure FieldParameter(var AValue: TDictionary<String, Variant>);
    function SelectWithWhere(AValue: Boolean): String;
  end;

implementation

end.
