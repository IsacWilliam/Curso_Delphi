unit cAtualizacaoTabelaMSSQL;

interface

uses System.Classes, System.SysUtils, Vcl.Controls, Vcl.ExtCtrls, Vcl.Dialogs,
     Data.DB, ZConnection, ZDataset, ZAbstractConnection, ZAbstractRODataset,
     ZAbstractDataset, cAtualizacaoBancoDeDados, cCadUsuario;

Type
     TAtualizacaoTabelaMSSQL = class(TAtualizaBancoDados)

     private
        function TabelaExiste(aNomeTabela: String): Boolean;
        procedure Categoria;
        procedure Cliente;
        procedure Produto;
        procedure Vendas;
        procedure VendasItens;
        procedure Usuario;

     protected

     public
        constructor Create(aConexao: TZConnection);
        destructor Destroy; override;
     end;

implementation

{ TAtualizacaoTabelaMSSQL }

constructor TAtualizacaoTabelaMSSQL.Create(aConexao: TZConnection);
begin
  ConexaoDB:= aConexao;
  Categoria;
  Cliente;
  Produto;
  Vendas;
  VendasItens;
  Usuario;
end;

destructor TAtualizacaoTabelaMSSQL.Destroy;
begin

  inherited;
end;

function TAtualizacaoTabelaMSSQL.TabelaExiste(aNomeTabela: String): Boolean;
var qryTabelaExiste: TZQuery;
begin
  Try
    Result:= False;
    qryTabelaExiste:= TZQuery.Create(nil);
    qryTabelaExiste.Connection:= ConexaoDB;
    qryTabelaExiste.SQL.Clear;
    qryTabelaExiste.SQL.Add('SELECT OBJECT_ID (:NomeTabela) AS ID');
    qryTabelaExiste.ParamByName('NomeTabela').AsString:= aNomeTabela;
    qryTabelaExiste.Open;

    if qryTabelaExiste.FieldByName('ID').AsInteger > 0 then
       Result:= True;
  Finally
    qryTabelaExiste.Close;
    if Assigned(qryTabelaExiste) then
       FreeAndNil(qryTabelaExiste);
  End;
end;

procedure TAtualizacaoTabelaMSSQL.Categoria;
begin
  if not TabelaExiste('categorias') then
    begin
      ExecutaDiretoBancoDeDados(
        'create table categorias('+
        'categoriaId int identity(1,1) not null, '+
        'descricao varchar(30) null, '+
        'primary key (categoriaId));'
      );
    end;
end;

procedure TAtualizacaoTabelaMSSQL.Cliente;
begin
  if not TabelaExiste('clientes') then
    begin
      ExecutaDiretoBancoDeDados(
        'create table clientes('+
        'clienteId int identity(1,1) not null, '+
        'nome varchar(60) null, '+
        'endereco varchar(60) null, '+
        'cidade varchar(50) null, '+
        'bairro varchar(40) null, '+
        'estado varchar(2) null, '+
        'cep varchar(10) null, '+
        'telefone varchar(14) null, '+
        'email varchar(100) null, '+
        'dataNascimento datetime null, '+
        'primary key (clienteId));'
      );
    end;
end;

procedure TAtualizacaoTabelaMSSQL.Produto;
begin
  if not TabelaExiste('produtos') then
    begin
      ExecutaDiretoBancoDeDados(
        'create table produtos('+
        'produtoId int identity(1,1) not null, '+
        'nome varchar(60) null, '+
        'descricao varchar(255) null, '+
        'valor decimal(18,5) default 0.00000 null, '+
        'quantidade decimal(18,5) default 0.00000 null, '+
        'categoriaId int null, '+
        'primary key (produtoId), '+
        'constraint FK_ProdutosCategorias '+
        'foreign key (categoriaId) references categorias(categoriaId));'
      );
    end;
end;

procedure TAtualizacaoTabelaMSSQL.Vendas;
begin
  if not TabelaExiste('vendas') then
    begin
      ExecutaDiretoBancoDeDados(
        'create table vendas('+
        'vendaId int identity(1,1) not null, '+
        'clienteId int not null, '+
        'dataVenda datetime default getdate(), '+
        'totalVenda decimal(18,5) default 0.00000, '+
        'primary key (vendaId), '+
        'constraint FK_VendasClientes foreign key (clienteId) '+
        'references clientes(clienteId));'
      );
    end;
end;

procedure TAtualizacaoTabelaMSSQL.VendasItens;
begin
  if not TabelaExiste('vendasItens') then
    begin
      ExecutaDiretoBancoDeDados(
        'create table vendasItens('+
        'vendaId int not null, '+
        'produtoId int not null, '+
        'valorUnitario decimal(18,5) default 0.00000, '+
        'quantidade decimal(18,5) default 0.00000, '+
        'totalProduto decimal(18,5) default 0.00000, '+
        'primary key (vendaId, ProdutoId), '+
        'constraint FK_VendasItensProdutos foreign key (produtoId) '+
        'references produtos(produtoId));'
      );
    end;
end;

procedure TAtualizacaoTabelaMSSQL.Usuario;
var oUsuario:TUsuario;
begin
  if not TabelaExiste('usuarios') then
    begin
      ExecutaDiretoBancoDeDados(
        'create table usuarios('+
        'usuarioId int identity(1,1) not null, '+
        'nome varchar(50) not null, '+
        'senha varchar(40) not null, '+
        'primary key (usuarioId));'
      );
    end;

    Try
      oUsuario:= TUsuario.Create(ConexaoDB);
      oUsuario.nome:= 'ADM';
      oUsuario.senha:= 'adm';
      if not oUsuario.UsuarioExiste(oUsuario.nome) then
        oUsuario.Inserir;
    Finally
      if Assigned(oUsuario) then
        FreeAndNil(oUsuario);
    End;
end;
end.

