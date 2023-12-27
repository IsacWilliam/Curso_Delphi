unit cControleEstoque;

interface

uses System.Classes, Vcl.Controls, Vcl.ExtCtrls, Vcl.Dialogs,
     ZAbstractConnection, ZConnection, ZAbstractRODataset, ZAbstractDataset,
     ZDataset, System.SysUtils, Data.DB, Datasnap.DBClient;

type
  TControleEstoque = class
  private
    ConexaoDB : TZConnection;
    F_ProdutoId : Integer;
    F_Quantidade : Double;
  public
    constructor Create(aConexao : TZConnection);
    destructor Destroy; override;
    function BaixarEstoque: Boolean;
    function RetornarEstoque: Boolean;
  published
    property ProdutoId : Integer    read F_ProdutoId    write F_ProdutoId;
    property Quantidade: Double     read F_Quantidade   write F_Quantidade;

  end;

implementation
{$region 'Construtor e Destrutor'}
constructor TControleEstoque.Create(aConexao : TZConnection);
begin
  ConexaoDB := aConexao;
end;

destructor TControleEstoque.Destroy;
begin
  inherited;
end;
{$endRegion}

function TControleEstoque.BaixarEstoque: Boolean;
var qryBaixarEstoque: TZQuery;
begin
  try
    Result := True;
    qryBaixarEstoque:= TZQuery.Create(nil);
    qryBaixarEstoque.Connection:= ConexaoDB;
    qryBaixarEstoque.SQL.Clear;
    qryBaixarEstoque.SQL.Add('UPDATE produtos '+
                             'SET quantidade = quantidade - :qtdeBaixa '+
                             'WHERE produtoId=:produtoId');
    qryBaixarEstoque.ParamByName('produtoId').AsInteger := ProdutoId;
    qryBaixarEstoque.ParamByName('qtdeBaixa').AsFloat := F_Quantidade;
    try
      ConexaoDB.StartTransaction;
      qryBaixarEstoque.ExecSQL;
      ConexaoDB.Commit;
    except
      ConexaoDB.Rollback;
      Result := False;
    end;

  finally
    if Assigned(qryBaixarEstoque) then
      FreeAndNil(qryBaixarEstoque);
  end;
end;

function TControleEstoque.RetornarEstoque: Boolean;
var qryRetornarEstoque: TZQuery;
begin
  try
    Result := True;
    qryRetornarEstoque:= TZQuery.Create(nil);
    qryRetornarEstoque.Connection:= ConexaoDB;
    qryRetornarEstoque.SQL.Clear;
    qryRetornarEstoque.SQL.Add('UPDATE produtos '+
                               'SET quantidade = quantidade + :qtdeRetorno '+
                               'WHERE produtoId=:produtoId');
    qryRetornarEstoque.ParamByName('produtoId').AsInteger := ProdutoId;
    qryRetornarEstoque.ParamByName('qtdeRetorno').AsFloat := Quantidade;
    try
      ConexaoDB.StartTransaction;
      qryRetornarEstoque.ExecSQL;
      ConexaoDB.Commit;
    except
      ConexaoDB.Rollback;
      Result := False;
    end;

  finally
    if Assigned(qryRetornarEstoque) then
      FreeAndNil(qryRetornarEstoque);
  end;
end;
end.
