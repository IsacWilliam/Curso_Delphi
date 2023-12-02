unit cCadCategoria;

interface

uses System.Classes, Vcl.Controls, Vcl.ExtCtrls, Vcl.Dialogs; // Lista de Units

type
  TCategoria = class // Declara��o do tipos da classe
  private // Vari�veis Privadas, somente DENTRO da classe

  public // Vari�veis P�blicas, podem ser usadas FORA da Classe
    constructor Create; // Construtor da Classe
    destructor Destroy; override;// Destr�i a Classe, usar Override por causa de sobrescrever

  published // Vari�veis P�blics utilizadas para propriedades da Classe...
              //... para fornecer informa��es em Runtime
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
