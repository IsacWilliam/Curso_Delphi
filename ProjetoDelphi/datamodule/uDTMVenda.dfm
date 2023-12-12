object dtmVenda: TdtmVenda
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  OnDestroy = DataModuleDestroy
  Height = 142
  Width = 291
  object qryCliente: TZQuery
    Connection = dtmPrincipal.ConexaoDB
    Active = True
    SQL.Strings = (
      'select clienteId, nome from clientes;')
    Params = <>
    Left = 22
    Top = 8
    object qryClienteclienteId: TIntegerField
      DisplayLabel = 'C'#243'digo'
      FieldName = 'clienteId'
      ReadOnly = True
    end
    object qryClientenome: TWideStringField
      DisplayLabel = 'Nome'
      FieldName = 'nome'
      Size = 60
    end
  end
  object qryProdutos: TZQuery
    Connection = dtmPrincipal.ConexaoDB
    Active = True
    SQL.Strings = (
      'select produtoId, nome, valor, quantidade from produtos;')
    Params = <>
    Left = 99
    Top = 7
    object qryProdutosprodutoId: TIntegerField
      DisplayLabel = 'C'#243'digo'
      FieldName = 'produtoId'
      ReadOnly = True
    end
    object qryProdutosnome: TWideStringField
      DisplayLabel = 'Nome'
      FieldName = 'nome'
      Size = 60
    end
    object qryProdutosvalor: TFloatField
      DisplayLabel = 'Valor'
      FieldName = 'valor'
    end
    object qryProdutosquantidade: TFloatField
      DisplayLabel = 'Quantidade'
      FieldName = 'quantidade'
    end
  end
  object cdsItensVenda: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 188
    Top = 7
    object cdsItensVendaprodutoId: TIntegerField
      DisplayLabel = 'C'#243'digo'
      FieldName = 'produtoId'
    end
    object cdsItensVendaNomeProduto: TStringField
      DisplayLabel = 'Nome do Produto'
      FieldName = 'NomeProduto'
      Size = 60
    end
    object cdsItensVendaquantidade: TFloatField
      DisplayLabel = 'Quantidade'
      FieldName = 'quantidade'
    end
    object cdsItensVendavalorUnitario: TFloatField
      DisplayLabel = 'Valor Unit'#225'rio'
      FieldName = 'valorUnitario'
    end
    object cdsItensVendavalorTotalProduto: TFloatField
      DisplayLabel = 'Total do Produto'
      FieldName = 'valorTotalProduto'
    end
    object cdsItensVendavalorTotalVenda: TAggregateField
      FieldName = 'valorTotalVenda'
      DisplayName = ''
      Expression = 'SUM(ValorTotalProduto)'
    end
  end
  object dtsCliente: TDataSource
    DataSet = qryCliente
    Left = 22
    Top = 57
  end
  object dtsProdutos: TDataSource
    DataSet = qryProdutos
    Left = 98
    Top = 57
  end
  object dtsItensVendas: TDataSource
    DataSet = cdsItensVenda
    Left = 188
    Top = 57
  end
end
