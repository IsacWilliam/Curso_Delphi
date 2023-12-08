unit cCadProduto;

interface

uses System.Classes, Vcl.Controls, Vcl.ExtCtrls, Vcl.Dialogs,
     ZAbstractConnection, ZConnection, ZAbstractRODataset, ZAbstractDataset,
     ZDataset, System.SysUtils;

type
  TProduto = class
  private
    ConexaoDB : TZConnection;
    F_produtoId : Integer;
    F_nome : String;
    F_descricao : String;
    F_valor : Double;
    F_quantidade : Double;
    F_categoriaId : Integer;

  public
    constructor Create(aConexao : TZConnection);
    destructor Destroy; override;
    function Inserir : Boolean;
    function Atualizar : Boolean;
    function Apagar : Boolean;
    function Selecionar(id : Integer) : Boolean;

  published
    property codigo      : Integer   read F_produtoId     write F_produtoId;
    property nome        : String    read F_nome          write F_nome;
    property descricao   : String    read F_descricao     write F_descricao;
    property valor       : Double    read F_valor         write F_valor;
    property quantidade  : Double    read F_quantidade    write F_quantidade;
    property categoriaId : Integer   read F_categoriaId   write F_categoriaId;
  end;

implementation

{$region 'Construtor e Destrutor'}
constructor TProduto.Create(aConexao : TZConnection);
begin
  ConexaoDB := aConexao;
end;

destructor TProduto.Destroy;
begin
  inherited;
end;
{$endRegion}

{$region 'CRUD'}
function TProduto.Apagar : Boolean;
var qryApagar : TZQuery;
begin
  if MessageDlg('Apagar o Registro: '+#13+#13+
                'Código: '+IntToStr(F_produtoId)+#13+
                'Descrição: '+F_nome, mtConfirmation, [mbYes, mbNo],0)=mrNo then
    begin
      Result := False;
      Abort;
    end;

  try
    Result := True;
    qryApagar := TZQuery.Create(nil);
    qryApagar.Connection := ConexaoDB;
    qryApagar.SQL.Clear;
    qryApagar.SQL.Add('DELETE FROM produtos '+
                      'WHERE produtoId =:produtoId');
    qryApagar.ParamByName('produtoId').AsInteger := F_produtoId;
    Try
      qryApagar.ExecSQL;
    Except
      Result := False;
    End;

  finally
    if Assigned(qryApagar) then
      FreeAndNil(qryApagar);
  end;
end;

function TProduto.Atualizar : Boolean;
var qryAtualizar : TZQuery;
begin
  try
    Result := True;
    qryAtualizar := TZQuery.Create(nil);
    qryAtualizar.Connection := ConexaoDB;
    qryAtualizar.SQL.Clear;
    qryAtualizar.SQL.Add('UPDATE produtos SET nome =:nome, '+
                         'descricao =:descricao, valor =:valor, '+
                         'quantidade =:quantidade, categoriaId =:categoriaId '+
                         'WHERE produtoId =:produtoId');
    qryAtualizar.ParamByName('produtoId').AsInteger   := Self.F_produtoId;
    qryAtualizar.ParamByName('nome').AsString         := Self.F_nome;
    qryAtualizar.ParamByName('descricao').AsString    := Self.F_descricao;
    qryAtualizar.ParamByName('valor').AsFloat         := Self.F_valor;
    qryAtualizar.ParamByName('quantidade').AsFloat    := Self.F_quantidade;
    qryAtualizar.ParamByName('categoriaId').AsInteger := Self.F_categoriaId;

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

function TProduto.Inserir : Boolean;
var qryInserir : TZQuery;
begin
  try
    Result := True;
    qryInserir := TZQuery.Create(nil);
    qryInserir.Connection := ConexaoDB;
    qryInserir.SQL.Clear;
    qryInserir.SQL.Add('INSERT INTO produtos (nome , descricao , valor, '+
                       'quantidade , categoriaId) VALUES (:nome , :descricao , '+
                       ':valor, :quantidade , :categoriaId)');
    qryInserir.ParamByName('nome').AsString         := Self.F_nome;
    qryInserir.ParamByName('descricao').AsString    := Self.F_descricao;
    qryInserir.ParamByName('valor').AsFloat         := Self.F_valor;
    qryInserir.ParamByName('quantidade').AsFloat    := Self.F_quantidade;
    qryInserir.ParamByName('categoriaId').AsInteger := Self.F_categoriaId;

    Try
      qryInserir.ExecSQL;
    Except
      Result := False;
    End;

  finally
    if Assigned(qryInserir) then
      FreeAndNil(qryInserir);
  end;
end;

function TProduto.Selecionar(id: Integer): Boolean;
var qrySelecionar : TZQuery;
begin
  try
    Result := True;
    qrySelecionar := TZQuery.Create(nil);
    qrySelecionar.Connection := ConexaoDB;
    qrySelecionar.SQL.Clear;
    qrySelecionar.SQL.Add('SELECT produtoId, nome, descricao, valor, '+
                          'quantidade, categoriaId FROM produtos '+
                          'WHERE produtoId =:produtoId');
    qrySelecionar.ParamByName('produtoId').AsInteger   := id;
    Try
      qrySelecionar.Open;

      Self.F_produtoId   := qrySelecionar.FieldByName('produtoId').AsInteger;
      Self.F_nome        := qrySelecionar.FieldByName('nome').AsString;
      Self.F_descricao   := qrySelecionar.FieldByName('descricao').AsString;
      Self.F_valor       := qrySelecionar.FieldByName('valor').AsFloat;
      Self.F_quantidade  := qrySelecionar.FieldByName('quantidade').AsFloat;
      Self.F_categoriaId := qrySelecionar.FieldByName('categoriaId').AsInteger;

    Except
      Result := False
    End;

  finally
    if Assigned(qrySelecionar) then
      FreeAndNil(qrySelecionar);
  end;
end;

{$endRegion}
end.
