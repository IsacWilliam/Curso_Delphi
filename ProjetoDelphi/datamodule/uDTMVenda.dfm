object dtmVenda: TdtmVenda
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  OnDestroy = DataModuleDestroy
  Height = 142
  Width = 291
  object qryCliente: TZQuery
    Connection = dtmPrincipal.ConexaoDB
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
  object cdsItensVendas: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 188
    Top = 7
    object cdsItensVendasprodutoId: TIntegerField
      FieldName = 'produtoId'
    end
    object cdsItensVendasNomeProduto: TStringField
      FieldName = 'NomeProduto'
      Size = 60
    end
    object cdsItensVendasquantidade: TFloatField
      FieldName = 'quantidade'
    end
    object cdsItensVendasvalorUnitario: TFloatField
      FieldName = 'valorUnitario'
    end
    object cdsItensVendasvalorTotalProduto: TFloatField
      FieldName = 'valorTotalProduto'
    end
    object cdsItensVendasvalorTotalVenda: TAggregateField
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
    DataSet = cdsItensVendas
    Left = 188
    Top = 57
  end
end
