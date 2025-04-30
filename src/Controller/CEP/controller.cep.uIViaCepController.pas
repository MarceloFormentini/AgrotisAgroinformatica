unit controller.cep.uIViaCepController;

interface

uses
  model.cep.uIViaCEP;

type
  IViaCepController = interface
    function ConsultarPorCEP(const ACep: string): IViaCep;
  end;

implementation

end.
