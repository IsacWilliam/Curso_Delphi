unit cCadCategoria;

interface

uses System.Classes, Vcl.Controls, Vcl.ExtCtrls, Vcl.Dialogs; // Lista de Units

type
  TCategoria = class // Declara��o do tipos da classe

  private // Vari�veis Privadas, somente DENTRO da classe
    F_categoriaId : Integer;
    F_descricao : String;
    function getCodigo: Integer;
    function getDescricao: String;
    procedure setCodigo(const Value: Integer);
    procedure setDescricao(const Value: String);

  public // Vari�veis P�blicas, podem ser usadas FORA da Classe
    constructor Create; // Construtor da Classe
    destructor Destroy; override;// Destr�i a Classe, usar Override por causa de sobrescrever

  published // Vari�veis P�blics utilizadas para propriedades da Classe...
              //... para fornecer informa��es em Runtime
    property codigo : Integer   read getCodigo    write setCodigo;
    property descricao : String read getDescricao write setDescricao;
  end;

implementation

{ TCategoria }

constructor TCategoria.Create;
begin
end;

destructor TCategoria.Destroy;
begin
  inherited;
end;

function TCategoria.getCodigo: Integer;
begin
  Result := Self.F_categoriaId;
end;

function TCategoria.getDescricao: String;
begin
  Result := Self.F_descricao;
end;

procedure TCategoria.setCodigo(const Value: Integer);
begin
  Self.F_categoriaId := Value;
end;

procedure TCategoria.setDescricao(const Value: String);
begin
  Self.F_descricao := Value;
end;

end.
