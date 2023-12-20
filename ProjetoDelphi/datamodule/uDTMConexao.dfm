object dtmPrincipal: TdtmPrincipal
  OldCreateOrder = False
  Height = 116
  Width = 610
  object ConexaoDB: TZConnection
    ControlsCodePage = cCP_UTF16
    AutoEncodeStrings = True
    Catalog = ''
    Properties.Strings = (
      'controls_cp=CP_UTF16'
      'AutoEncodeStrings=True')
    Connected = True
    HostName = '.\SERVERCURSO'
    Port = 0
    Database = 'vendas'
    User = 'sa'
    Password = 'delphi@2023'
    Protocol = 'mssql'
    LibraryLocation = 'E:\Cursos\Curso_Delphi\ProjetoDelphi\ntwdblib.dll'
    Left = 24
    Top = 12
  end
  object qryScriptCategorias: TZQuery
    Connection = ConexaoDB
    SQL.Strings = (
      'if OBJECT_ID ('#39'categorias'#39') is null'
      'begin'
      '  create table categorias('
      '    categoriaId int identity(1,1) not null,'
      '    descricao varchar(30) null,'
      '    primary key (categoriaId)'
      '  )'
      'end')
    Params = <>
    Left = 187
    Top = 12
  end
  object qryScriptClientes: TZQuery
    Connection = ConexaoDB
    SQL.Strings = (
      'if OBJECT_ID ('#39'clientes'#39') is null'
      'begin'
      '  create table clientes('
      '    clienteId int identity(1,1) not null,'
      '    nome varchar(60) null,'
      '    endereco varchar(60) null,'
      '    cidade varchar(50) null,'
      '    bairro varchar(40) null,'
      '    estado varchar(2) null,'
      '    cep varchar(10) null,'
      '    telefone varchar(14) null,'
      '    email varchar(100) null,'
      '    dataNascimento datetime null,'
      '    primary key (clienteId)'
      '  )'
      'end')
    Params = <>
    Left = 286
    Top = 12
  end
  object qryScriptProdutos: TZQuery
    Connection = ConexaoDB
    SQL.Strings = (
      'if OBJECT_ID ('#39'produtos'#39') is null'
      'begin'
      '  create table produtos('
      '    produtoId int identity(1,1) not null,'
      '    nome varchar(60) null,'
      '    descricao varchar(255) null,'
      '    valor decimal(18,5) default 0.00000 null,'
      '    quantidade decimal(18,5) default 0.00000 null,'
      '    categoriaId int null,'
      '    primary key (produtoId),'
      '    constraint FK_ProdutosCategorias'
      
        '      foreign key (categoriaId) references categorias(categoriaI' +
        'd)'
      '  )'
      'end')
    Params = <>
    Left = 385
    Top = 12
  end
  object qryScriptVendas: TZQuery
    Connection = ConexaoDB
    SQL.Strings = (
      'if OBJECT_ID('#39'vendas'#39') is null'
      'begin'
      'create table vendas('
      '  vendaId int identity(1,1) not null,'
      '  clienteId int not null,'
      '  dataVenda datetime default getdate(),'
      '  totalVenda decimal(18,5) default 0.00000,'
      '  primary key (vendaId),'
      '  constraint FK_VendasClientes foreign key (clienteId)'
      '    references clientes(clienteId)'
      ')'
      'end')
    Params = <>
    Left = 188
    Top = 68
  end
  object qryScriptItensVendas: TZQuery
    Connection = ConexaoDB
    SQL.Strings = (
      'if OBJECT_ID('#39'vendasItens'#39') is null'
      'begin'
      'create table vendasItens('
      '  vendaId int not null,'
      '  produtoId int not null,'
      '  valorUnitario decimal(18,5) default 0.00000,'
      '  quantidade decimal(18,5) default 0.00000,'
      '  totalProduto decimal(18,5) default 0.00000,'
      '  primary key (vendaId, ProdutoId),'
      '  constraint FK_VendasItensProdutos foreign key (produtoId)'
      '    references produtos(produtoId)'
      ')'
      'end')
    Params = <>
    Left = 288
    Top = 66
  end
  object qryScriptUsuarios: TZQuery
    Connection = ConexaoDB
    SQL.Strings = (
      'if OBJECT_ID ('#39'usuarios'#39') is null'
      'begin'
      '  create table usuarios('
      '    usuarioId int identity(1,1) not null,'
      '    nome varchar(50) not null,'
      '    senha varchar(40) not null,'
      '    primary key (usuarioId)'
      '  );'
      'end;'
      '')
    Params = <>
    Left = 384
    Top = 64
  end
end
