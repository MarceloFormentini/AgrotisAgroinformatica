unit model.validacao.uValidadorCampos;

interface

uses
  model.validacao.uIValidadorCampos,
  Vcl.Forms, Vcl.StdCtrls;

type
  TEditTabItem = record
    Edit: TEdit;
    TabOrder: Integer;
  end;

  TValidadorCampos = class(TInterfacedObject, IValidadorCampos)
    private
      FForm: TForm;

      constructor Create(AForm: TForm);
      destructor Destroy; override;
    public
      class function New(AForm: TForm): IValidadorCampos;

      function ValidarCampos: Boolean;
end;

implementation


uses
  System.SysUtils, Vcl.Dialogs, System.Classes, System.Generics.Collections,
  System.Generics.Defaults;

constructor TValidadorCampos.Create(AForm: TForm);
begin
  FForm := AForm;
end;

destructor TValidadorCampos.Destroy;
begin

  inherited;
end;

class function TValidadorCampos.New(AForm: TForm): IValidadorCampos;
begin
  Result := Self.Create(AForm);
end;

function TValidadorCampos.ValidarCampos: Boolean;
var
  I: Integer;
  EditList: TList<TEditTabItem>;
  Edit: TEdit;
  Item: TEditTabItem;
begin
  Result := True;

  if not Assigned(FForm) then
    raise Exception.Create('Formulário não atribuído.');

  EditList := TList<TEditTabItem>.Create;
  try
    // Coletar os edits obrigatórios
    for I := 0 to FForm.ComponentCount - 1 do
    begin
      if (FForm.Components[I] is TEdit) then
      begin
        Edit := TEdit(FForm.Components[I]);
        if Edit.Tag = 1 then
        begin
          Item.Edit := Edit;
          Item.TabOrder := Edit.TabOrder;
          EditList.Add(Item);
        end;
      end;
    end;

    // Ordenar por TabOrder
    EditList.Sort(
      TComparer<TEditTabItem>.Construct(
        function(const Left, Right: TEditTabItem): Integer
        begin
          Result := Left.TabOrder - Right.TabOrder;
        end
      )
    );

    // Validar na ordem
    for Item in EditList do
    begin
      if Trim(Item.Edit.Text) = '' then
      begin
        ShowMessage(Format('O campo "%s" é obrigatório.', [Item.Edit.Hint]));
        Item.Edit.SetFocus;
        Result := False;
        Exit;
      end;
    end;
  finally
    EditList.Free;
  end;
end;

end.
