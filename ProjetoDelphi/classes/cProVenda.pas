unit cProVenda;

interface

uses System.Classes, Vcl.Controls, Vcl.ExtCtrls, Vcl.Dialogs,
     ZAbstractConnection, ZConnection, ZAbstractRODataset, ZAbstractDataset,
     ZDataset, System.SysUtils, System.UITypes, Data.DB, Datasnap.DBClient;

type
  TVenda= class
  private
    ConexaoDB : TZConnection;
    F_vendaId : Integer;
    F_clienteId : Integer;
    F_dataVenda : TDateTime;
    F_totalVenda : Double;
    function InserirItens(cds: TClientDataSet; IdVenda: Integer): Boolean;

  public
    constructor Create(aConexao : TZConnection);
    destructor Destroy; override;
    function Inserir(cds:TClientDataSet) : Boolean;
    function Atualizar : Boolean;
    function Apagar : Boolean;
    function Selecionar(id : Integer) : Boolean;

  published
    property VendaId   : Integer    read F_vendaId     write F_vendaId;
    property ClienteId : Integer    read F_clienteId   write F_clienteId;
    property DataVenda : TDateTime  read F_dataVenda   write F_dataVenda;
    property TotalVenda: Double     read F_totalVenda  write F_totalVenda;

  end;

implementation

{$region 'Construtor e Destrutor'}
constructor TVenda.Create(aConexao : TZConnection);
begin
  ConexaoDB := aConexao;
end;

destructor TVenda.Destroy;
begin
  inherited;
end;
{$endRegion}

{$region 'CRUD'}
function TVenda.Apagar : Boolean;
var qryApagar : TZQuery;
begin
  if MessageDlg('Apagar o Registro: '+#13+#13+
                'Venda Nro: '+IntToStr(VendaId), mtConfirmation, [mbYes, mbNo],0)=mrNo then
    begin
      Result := False;
      Abort;
    end;

  try
    Result := True;
    ConexaoDB.StartTransaction;
    qryApagar := TZQuery.Create(nil);
    qryApagar.Connection := ConexaoDB;
    qryApagar.SQL.Clear;
    qryApagar.SQL.Add('DELETE FROM vendasItens '+
                      'WHERE vendaId =:vendaId');
    qryApagar.ParamByName('vendaId').AsInteger := VendaId;

    Try
      qryApagar.ExecSQL;
      qryApagar.SQL.Clear;
      qryApagar.SQL.Add('DELETE FROM vendas '+
                        'WHERE vendaId =:vendaId');
      qryApagar.ParamByName('vendaId').AsInteger := VendaId;
      qryApagar.ExecSQL;
      ConexaoDB.Commit;

    Except
      ConexaoDB.RollBack;
      Result := False;
    End;

  finally
    if Assigned(qryApagar) then
      FreeAndNil(qryApagar);
  end;
end;

function TVenda.Atualizar : Boolean;
var qryAtualizar : TZQuery;
begin
  try
    Result := True;
    qryAtualizar := TZQuery.Create(nil);
    qryAtualizar.Connection := ConexaoDB;
    qryAtualizar.SQL.Clear;
    qryAtualizar.SQL.Add('UPDATE vendas '+
                         'SET clienteId = :clienteId, '+
                         'dataVenda = :dataVenda, '+
                         'totalVenda = :totalVenda '+
                         'WHERE vendaId = :vendaId');
    qryAtualizar.ParamByName('vendaId').AsInteger   := Self.F_vendaId;
    qryAtualizar.ParamByName('clienteId').AsInteger := Self.F_clienteId;
    qryAtualizar.ParamByName('dataVenda').AsDateTime:= Self.F_dataVenda;
    qryAtualizar.ParamByName('totalVenda').AsFloat  := Self.F_totalVenda;

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

function TVenda.Inserir(cds:TClientDataSet) : Boolean;
var qryInserir : TZQuery;
    IdVendaGerado : Integer;
begin
  try
    Result := True;
    ConexaoDB.StartTransaction;
    qryInserir := TZQuery.Create(nil);
    qryInserir.Connection := ConexaoDB;
    qryInserir.SQL.Clear;
    qryInserir.SQL.Add('INSERT INTO vendas (clienteId, dataVenda, totalVenda) '+
                       'VALUES (:clienteId, :dataVenda, :totalVenda)');
    qryInserir.ParamByName('clienteId').AsInteger  := Self.F_clienteId;
    qryInserir.ParamByName('dataVenda').AsDateTime := Self.F_dataVenda;
    qryInserir.ParamByName('totalVenda').AsFloat   := Self.F_totalVenda;

    Try
      qryInserir.ExecSQL;
      // Recupera o ID gerado no Insert
      qryInserir.SQL.Clear;
      qryInserir.SQL.Add('SELECT SCOPE_IDENTITY() AS ID');
      qryInserir.Open;

      // ID da tabela Master(Venda)
      IdVendaGerado := qryInserir.FieldByName('ID').AsInteger;

      {$region 'GRAVAR NA TABELA VENDASITENS'}
      cds.First;
      while not cds.Eof do
        begin
          InserirItens(cds, IdVendaGerado);
          cds.Next;
        end;
      {$endRegion}

      ConexaoDB.Commit;
    Except
      ConexaoDB.Rollback;
      Result := False;
    End;

  finally
    if Assigned(qryInserir) then
      FreeAndNil(qryInserir);
  end;
end;

function TVenda.Selecionar(id: Integer): Boolean;
var qrySelecionar : TZQuery;
begin
  try
    Result := True;
    qrySelecionar := TZQuery.Create(nil);
    qrySelecionar.Connection := ConexaoDB;
    qrySelecionar.SQL.Clear;
    qrySelecionar.SQL.Add('SELECT vendaId, clienteId, dataVenda, totalVenda '+
                          'FROM vendas '+
                          'WHERE vendaId = :vendaId');
    qrySelecionar.ParamByName('vendaId').AsInteger   := id;
    Try
      qrySelecionar.Open;

      Self.F_vendaId    := qrySelecionar.FieldByName('vendaId').AsInteger;
      Self.F_clienteId  := qrySelecionar.FieldByName('clienteId').AsInteger;
      Self.F_dataVenda  := qrySelecionar.FieldByName('dataVenda').AsDateTime;
      Self.F_totalVenda := qrySelecionar.FieldByName('totalVenda').AsFloat;

    Except
      Result := False
    End;

  finally
    if Assigned(qrySelecionar) then
      FreeAndNil(qrySelecionar);
  end;
end;

function TVenda.InserirItens(cds: TClientDataSet; IdVenda: Integer): Boolean;
var qryInserirItens: TZQuery;
begin
  try
    Result := True;
    qryInserirItens := TZQuery.Create(nil);
    qryInserirItens.Connection := ConexaoDB;
    qryInserirItens.SQL.Clear;
    qryInserirItens.SQL.Add('INSERT INTO VendasItens '+
                            '(VendaID, ProdutoID, ValorUnitario, Quantidade, TotalProduto) '+
                            'VALUES '+
                            '(:VendaID, :ProdutoID, :ValorUnitario, :Quantidade, :TotalProduto)');
    qryInserirItens.ParamByName('VendaID').AsInteger := IdVenda;
    qryInserirItens.ParamByName('ProdutoID').AsInteger := cds.FieldByName('produtoId').AsInteger;
    qryInserirItens.ParamByName('ValorUnitario').AsFloat := cds.FieldByName('valorUnitario').AsFloat;
    qryInserirItens.ParamByName('Quantidade').AsFloat := cds.FieldByName('quantidade').AsFloat;
    qryInserirItens.ParamByName('TotalProduto').AsFloat := cds.FieldByName('valorTotalProduto').AsFloat;
    try
      qryInserirItens.ExecSQL;
    Except
      Result := False;
    end;

  finally
    if Assigned(qryInserirItens) then
      FreeAndNil(qryInserirItens);
  end;

end;
{$endRegion}
end.
