unit cProVenda;

interface

uses System.Classes, Vcl.Controls, Vcl.ExtCtrls, Vcl.Dialogs,
     ZAbstractConnection, ZConnection, ZAbstractRODataset, ZAbstractDataset,
     ZDataset, System.SysUtils, Data.DB, Datasnap.DBClient, uEnum,
     cControleEstoque;

type
  TVenda= class
  private
    ConexaoDB : TZConnection;
    F_vendaId : Integer;
    F_clienteId : Integer;
    F_dataVenda : TDateTime;
    F_totalVenda : Double;
    function InserirItens(cds: TClientDataSet; IdVenda: Integer): Boolean;
    function ApagarItens(cds: TClientDataSet): Boolean;
    function InNot(cds: TClientDataSet): String;
    function EsteItemExiste(vendaId, produtoId: Integer): Boolean;
    function AtualizarItem(cds: TClientDataSet): Boolean;
    procedure RetornarEstoque(sCodigo: String; Acao: TAcaoExcluirEstoque);
    procedure BaixarEstoque(produtoId: Integer; Quantidade: Double);

  public
    constructor Create(aConexao : TZConnection);
    destructor Destroy; override;
    function Inserir(cds:TClientDataSet) : Integer;
    function Atualizar(cds:TClientDataSet) : Boolean;
    function Apagar : Boolean;
    function Selecionar(id : Integer; var cds:TClientDataSet) : Boolean;

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

function TVenda.Atualizar(cds:TClientDataSet) : Boolean;
var qryAtualizar : TZQuery;
begin
  try
    Result := True;
    ConexaoDB.StartTransaction;
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
      //Update Vendas
      qryAtualizar.ExecSQL;

      //Apagar itens no banco de dados que foram apagados na tela
      ApagarItens(cds);

      cds.First;
      while not cds.Eof do
        begin
          if EsteItemExiste(Self.F_vendaId, cds.FieldByName('produtoId').AsInteger) then
            begin
              //Update
              AtualizarItem(cds);
            end
          else
            begin
              //Insert
              InserirItens(cds, Self.F_vendaId);
            end;
          cds.Next;
        end;

    Except
      Result := False;
      ConexaoDB.Rollback;
    End;

    ConexaoDB.Commit;
  finally
    if Assigned(qryAtualizar) then
      FreeAndNil(qryAtualizar);
  end;
end;

function TVenda.AtualizarItem(cds:TClientDataSet): Boolean;
var qryAtualizarItem: TZQuery;
begin
  try
    Result:= True;
    RetornarEstoque(cds.FieldByName('produtoId').AsString, aeeAlterar);
    qryAtualizarItem:= TZQuery.Create(nil);
    qryAtualizarItem.Connection:= ConexaoDB;
    qryAtualizarItem.SQL.Clear;
    qryAtualizarItem.SQL.Add('UPDATE VendasItens SET ValorUnitario=:ValorUnitario, '+
    'Quantidade=:Quantidade, TotalProduto=:TotalProduto WHERE vendaId=:vendaId '+
    'AND produtoId=:produtoId');
    qryAtualizarItem.ParamByName('vendaId').AsInteger    := Self.F_vendaId;
    qryAtualizarItem.ParamByName('produtoId').AsInteger  := cds.FieldByName('produtoId').AsInteger;
    qryAtualizarItem.ParamByName('ValorUnitario').AsFloat:= cds.FieldByName('valorUnitario').AsFloat;
    qryAtualizarItem.ParamByName('Quantidade').AsFloat   := cds.FieldByName('quantidade').AsFloat;
    qryAtualizarItem.ParamByName('TotalProduto').AsFloat := cds.FieldByName('valorTotalProduto').AsFloat;

    Try
      qryAtualizarItem.ExecSQL;
      BaixarEstoque(cds.FieldByName('produtoId').AsInteger, cds.FieldByName('quantidade').AsFloat);
    Except
      Result := False;
    End;
  finally
    if Assigned(qryAtualizarItem) then
      FreeAndNil(qryAtualizarItem);
  end;
end;

function TVenda.EsteItemExiste(vendaId: Integer; produtoId: Integer): Boolean;
var qryEsteItemExiste: TZQuery;
begin
  try
    qryEsteItemExiste:= TZQuery.Create(nil);
    qryEsteItemExiste.Connection:= ConexaoDB;
    qryEsteItemExiste.SQL.Clear;
    qryEsteItemExiste.SQL.Add('SELECT Count(vendaId) AS Qtde FROM VendasItens '+
    'WHERE vendaId=:vendaId AND produtoId=:produtoId');
    qryEsteItemExiste.ParamByName('vendaId').AsInteger := vendaId;
    qryEsteItemExiste.ParamByName('produtoId').AsInteger := produtoId;
    Try
      qryEsteItemExiste.Open;

      if qryEsteItemExiste.FieldByName('Qtde').AsInteger > 0 then
        Result := True
      else
        Result := False;
    Except
      Result := False;
    End;
  finally
    if Assigned(qryEsteItemExiste) then
      FreeAndNil(qryEsteItemExiste);
  end;
end;

function TVenda.ApagarItens(cds:TClientDataSet): Boolean;
var qryApagaItens: TZQuery;
    sCodNoCds: String;
begin
  try
    Result := True;
    //Pega os códigos que estão no ClientDataSet para selecionar o IN NOT no BD
    sCodNoCds:= InNot(cds);

    //Retorna ao Estoque
    RetornarEstoque(sCodNoCds, aeeApagar);

    qryApagaItens := TZQuery.Create(nil);
    qryApagaItens.Connection := ConexaoDB;
    qryApagaItens.SQL.Clear;
    qryApagaItens.SQL.Add('DELETE FROM VendasItens WHERE VendaId=:VendaId '+
                          'AND produtoId NOT IN ('+sCodNoCds+')');
    qryApagaItens.ParamByName('vendaId').AsInteger := Self.F_vendaId;
    Try
      qryApagaItens.ExecSQL;
    Except
      Result := False;
    End;
  finally
    if Assigned(qryApagaItens) then
      FreeAndNil(qryApagaItens);
  end;
end;

function TVenda.InNot(cds:TClientDataSet): String;
var sInNot : String;
begin
  sInNot := EmptyStr;
  cds.First;
  while not cds.Eof do
    begin
      if sInNot = EmptyStr then
        sInNot := cds.FieldByName('produtoId').AsString
      else
        sInNot := sInNot + ', '+cds.FieldByName('produtoId').AsString;
        cds.Next;
    end;
  Result := sInNot;
end;

function TVenda.Inserir(cds:TClientDataSet) : Integer;
var qryInserir : TZQuery;
    IdVendaGerado : Integer;
begin
  try
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
      Result := IdVendaGerado;
    Except
      ConexaoDB.Rollback;
      Result := -1;
    End;

  finally
    if Assigned(qryInserir) then
      FreeAndNil(qryInserir);
  end;
end;

function TVenda.Selecionar(id: Integer; var cds:TClientDataSet): Boolean;
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

      {$region 'SELECIONAR NA TABELA VENDASITENS'}
      //Apaga o CLientDataSet caso esteja com algum registro
      cds.First;
      while not cds.Eof do
        begin
          cds.Delete;
        end;

      //Seleciona os Itens do Banco de Dados com a propriedade F_VendaId
      qrySelecionar.Close;
      qrySelecionar.SQL.Clear;
      qrySelecionar.SQL.Add('SELECT VendasItens.ProdutoID, Produtos.Nome, '+
      'VendasItens.ValorUnitario, VendasItens.Quantidade, VendasItens.TotalProduto '+
      'FROM VendasItens INNER JOIN produtos ON Produtos.produtoId = VendasItens.produtoId '+
                                          'WHERE VendasItens.VendaID=:VendaID');
      qrySelecionar.ParamByName('VendaID').AsInteger := Self.F_vendaId;
      qrySelecionar.Open;

      //Lê da Query e coloca no ClientDataSet
      qrySelecionar.First;
      while not qrySelecionar.Eof do
        begin
          cds.Append;
          cds.FieldByName('produtoId').AsInteger := qrySelecionar.FieldByName('ProdutoID').AsInteger;
          cds.FieldByName('nomeProduto').AsString := qrySelecionar.FieldByName('Nome').AsString;
          cds.FieldByName('valorUnitario').AsFloat := qrySelecionar.FieldByName('ValorUnitario').AsFloat;
          cds.FieldByName('quantidade').AsFloat := qrySelecionar.FieldByName('Quantidade').AsFloat;
          cds.FieldByName('valorTotalProduto').AsFloat := qrySelecionar.FieldByName('TotalProduto').AsFloat;
          cds.Post;
          qrySelecionar.Next;
        end;
        cds.First;
      {$endRegion}

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
      BaixarEstoque(cds.FieldByName('produtoId').AsInteger, cds.FieldByName('quantidade').AsFloat);
    Except
      Result := False;
    end;

  finally
    if Assigned(qryInserirItens) then
      FreeAndNil(qryInserirItens);
  end;
end;
{$endRegion}

{$region 'CONTROLE DE ESTOQUE'}
// Utilizado pelo UPDATE e DELETE do Item
procedure TVenda.RetornarEstoque(sCodigo: String; Acao:TAcaoExcluirEstoque);
var qryRetornarEstoque: TZQuery;
    oControleEstoque: TControleEstoque;
begin
    qryRetornarEstoque := TZQuery.Create(nil);
    qryRetornarEstoque.Connection := ConexaoDB;
    qryRetornarEstoque.SQL.Clear;
    qryRetornarEstoque.SQL.Add('SELECT produtoId, quantidade FROM VendasItens '+
                               'WHERE VendaId=:VendaId ');
    if Acao = aeeApagar then
      qryRetornarEstoque.SQL.Add('AND produtoId NOT IN ('+sCodigo+') ')
    else
      qryRetornarEstoque.SQL.Add('AND produtoId = ('+sCodigo+') ');

    qryRetornarEstoque.ParamByName('vendaId').AsInteger := Self.F_vendaId;

    Try
      oControleEstoque := TControleEstoque.Create(ConexaoDB);
      qryRetornarEstoque.Open;
      qryRetornarEstoque.First;
      while not qryRetornarEstoque.Eof do
        begin
          oControleEstoque.ProdutoId := qryRetornarEstoque.FieldByName('produtoId').AsInteger;
          oControleEstoque.Quantidade:= qryRetornarEstoque.FieldByName('quantidade').AsFloat;
          oControleEstoque.RetornarEstoque;
          qryRetornarEstoque.Next;
        end;
    Finally
      if Assigned(oControleEstoque) then
        FreeAndNil(oControleEstoque);
    End;
end;

//Utilizado pelo INSERT
procedure TVenda.BaixarEstoque(produtoId: Integer; Quantidade:Double);
var oControleEstoque: TControleEstoque;
begin
  Try
    oControleEstoque:= TControleEstoque.Create(ConexaoDB);
    oControleEstoque.ProdutoId := produtoId;
    oControleEstoque.Quantidade:= Quantidade;
    oControleEstoque.BaixarEstoque;
  Finally
    if Assigned(oControleEstoque) then
      FreeAndNil(oControleEstoque);
  End;
end;
{$endRegion}

end.
