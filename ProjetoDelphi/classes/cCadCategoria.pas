unit cCadCategoria;

interface

uses System.Classes, Vcl.Controls, Vcl.ExtCtrls, Vcl.Dialogs; // Lista de Units

type
  TCategoria = class // Declaração do tipos da classe
  private // Variáveis Privadas, somente DENTRO da classe

  public // Variáveis Públicas, podem ser usadas FORA da Classe
    constructor Create; // Construtor da Classe
    destructor Destroy; override;// Destrói a Classe, usar Override por causa de sobrescrever

  published // Variáveis Públics utilizadas para propriedades da Classe...
              //... para fornecer informações em Runtime
  end;

implementation

{ TCategoria }

constructor TCategoria.Create;
begin
  ShowMessage('Elemento criado');
end;

destructor TCategoria.Destroy;
begin
  ShowMessage('Elemento eliminado');
  inherited;
end;

end.
