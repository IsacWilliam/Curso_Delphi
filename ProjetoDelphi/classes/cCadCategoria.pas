unit cCadCategoria;

interface

uses System.Classes, Vcl.Controls, Vcl.ExtCtrls, Vcl.Dialogs, // Lista de Units
     ZAbstractConnection, ZConnection, ZAbstractRODataset, ZAbstractDataset,
     ZDataset, System.SysUtils;
type
  TCategoria = class // Declaração do tipos da classe

  private // Variáveis Privadas, somente DENTRO da classe
    ConexaoDB : TZConnection;
    F_categoriaId : Integer;
    F_descricao : String;
    function getCodigo: Integer;
    function getDescricao: String;
    procedure setCodigo(const Value: Integer);
    procedure setDescricao(const Value: String);

  public // Variáveis Públicas, podem ser usadas FORA da Classe
    constructor Create (aConexao : TZConnection); // Construtor da Classe
    destructor Destroy; override;// Destrói a Classe, usar Override por causa de sobrescrever
    function Inserir : Boolean;
    function Atualizar: Boolean;
    function Apagar: Boolean;
    function Selecionar(id : Integer) : Boolean;
  published // Variáveis Públics utilizadas para propriedades da Classe...
              //... para fornecer informações em Runtime
    property codigo : Integer   read getCodigo    write setCodigo;
    property descricao : String read getDescricao write setDescricao;
  end;

implementation

{ TCategoria }
{$region 'CONSTRUTOR E DESTRUTOR'}
constructor TCategoria.Create(aConexao : TZConnection);
begin
  ConexaoDB := aConexao;
end;

destructor TCategoria.Destroy;
begin
  inherited;
end;
{$endRegion}

{$region 'FUNÇÕES CRUD'}
function TCategoria.Inserir: Boolean;
var qryInserir : TZQuery;
begin
  try
    Result := True;
    qryInserir := TZQuery.Create(nil);
    qryInserir.Connection := ConexaoDB;
    qryInserir.SQL.Clear;
    qryInserir.SQL.Add('insert into categorias (descricao) values (:descricao)');
    qryInserir.ParamByName('descricao').AsString := Self.F_descricao;
    try
      qryInserir.ExecSQL;
    Except
      Result := False;
    end;
  finally
    if Assigned(qryInserir) then
      FreeAndNil(qryInserir);
  end;
end;

function TCategoria.Atualizar: Boolean;
var qryAtualizar: TZQuery;
begin
  try
    Result := True;
    qryAtualizar := TZQuery.Create(nil);
    qryAtualizar.Connection := ConexaoDB;
    qryAtualizar.SQL.Clear;
    qryAtualizar.SQL.Add('UPDATE categorias '+
                         'SET    descricao   =:descricao '+
                         'WHERE  categoriaId =:categoriaId');
    qryAtualizar.ParamByName('categoriaId').AsInteger := Self.F_categoriaId;
    qryAtualizar.ParamByName('descricao').AsString    := Self.F_descricao;

    Try
      qryAtualizar.ExecSQL;
    Except
      Result := False;
    End;

  finally
    if Assigned(qryAtualizar) then
      FreeAndNil(qryAtualizar);
  end;
end;

function TCategoria.Apagar: Boolean;
var
  qryApagar: TZQuery;
begin
  Result := False; // Defina o resultado como falso por padrão

  if MessageDlg('Apagar o Registro: ' + #13#13 +
                'Código: ' + IntToStr(F_categoriaId) + #13 +
                'Descrição: ' + F_descricao, mtConfirmation,
                [mbYes, mbNo], 0) = mrNo then
  begin
    Abort; // Se o usuário escolher 'Não', aborte a operação
  end;

  qryApagar := TZQuery.Create(nil);
  try
    qryApagar.Connection := ConexaoDB;
    qryApagar.SQL.Clear;
    qryApagar.SQL.Add('DELETE FROM categorias ' +
                      'WHERE categoriaId = :categoriaId');
    qryApagar.ParamByName('categoriaId').AsInteger := F_categoriaId;

    try
      qryApagar.ExecSQL;
      Result := True; // Se não ocorrer exceção, definir o resultado como verdadeiro
    except
      Result := False;
    end;
  finally
    FreeAndNil(qryApagar);
  end;
end;

function TCategoria.Selecionar(id: Integer): Boolean;
var qrySelecionar : TZQuery;
begin
  try
    Result := True;
    qrySelecionar := TZQuery.Create(nil);
    qrySelecionar.Connection := ConexaoDB;
    qrySelecionar.SQL.Clear;
    qrySelecionar.SQL.Add('SELECT categoriaId, '+
                          '       descricao '  +
                          'FROM   categorias '   +
                          'WHERE  categoriaId =:categoriaId');
    qrySelecionar.ParamByName('categoriaId').AsInteger := id;
    try
      qrySelecionar.Open;

      Self.F_categoriaId := qrySelecionar.FieldByName('categoriaId').AsInteger;
      Self.F_descricao   := qrySelecionar.FieldByName('descricao').AsString;
    Except
      Result := False;
    end;
  finally
    if Assigned(qrySelecionar) then
      FreeAndNil(qrySelecionar);
  end;
end;
{$endRegion}

{$region 'GETTERS e SETTERS'}
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
{$endRegion}

end.
