inherited frmCadProduto: TfrmCadProduto
  Caption = 'Cadastro de Produto'
  ClientHeight = 425
  ClientWidth = 772
  ExplicitWidth = 778
  ExplicitHeight = 454
  PixelsPerInch = 96
  TextHeight = 13
  inherited pgcPrincipal: TPageControl
    Width = 772
    Height = 390
    ActivePage = tabManutencao
    inherited tabListagem: TTabSheet
      inherited pnlListagemTopo: TPanel
        Width = 764
      end
      inherited grdListagem: TDBGrid
        Width = 764
        Height = 297
        Columns = <
          item
            Expanded = False
            FieldName = 'produtoId'
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'nome'
            Width = 106
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'valor'
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'quantidade'
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'DescricaoCategoria'
            Visible = True
          end>
      end
    end
    inherited tabManutencao: TTabSheet
      ExplicitLeft = 4
      ExplicitTop = 24
      ExplicitWidth = 741
      ExplicitHeight = 468
      object Label1: TLabel
        Left = 0
        Top = 128
        Width = 46
        Height = 13
        Caption = 'Descri'#231#227'o'
      end
      object Label2: TLabel
        Left = 0
        Top = 301
        Width = 24
        Height = 13
        Caption = 'Valor'
      end
      object Label3: TLabel
        Left = 162
        Top = 301
        Width = 56
        Height = 13
        Caption = 'Quantidade'
      end
      object edtProdutoId: TLabeledEdit
        Tag = 1
        Left = 0
        Top = 40
        Width = 121
        Height = 21
        EditLabel.Width = 33
        EditLabel.Height = 13
        EditLabel.Caption = 'C'#243'digo'
        MaxLength = 10
        NumbersOnly = True
        TabOrder = 0
      end
      object edtNome: TLabeledEdit
        Tag = 2
        Left = 0
        Top = 96
        Width = 318
        Height = 21
        EditLabel.Width = 27
        EditLabel.Height = 13
        EditLabel.Caption = 'Nome'
        MaxLength = 60
        TabOrder = 1
      end
      object edtDescricao: TMemo
        Left = 0
        Top = 147
        Width = 756
        Height = 148
        Lines.Strings = (
          'edtDescricao')
        MaxLength = 255
        TabOrder = 2
      end
      object edtValor: TCurrencyEdit
        Left = 0
        Top = 320
        Width = 156
        Height = 21
        TabOrder = 3
      end
      object edtQuantidade: TCurrencyEdit
        Left = 162
        Top = 320
        Width = 156
        Height = 21
        DisplayFormat = ',0.00;-,0.00'
        TabOrder = 4
      end
      object lkpCategoria: TDBLookupComboBox
        Left = 336
        Top = 96
        Width = 420
        Height = 21
        KeyField = 'categoriaId'
        ListField = 'descricao'
        ListSource = dtsCategoria
        TabOrder = 5
      end
    end
  end
  inherited pnlRodape: TPanel
    Top = 390
    Width = 772
    inherited btnFechar: TBitBtn
      Left = 685
      Top = 2
      ExplicitLeft = 798
      ExplicitTop = 2
    end
    inherited btnNavigator: TDBNavigator
      Hints.Strings = ()
    end
  end
  inherited qryListagem: TZQuery
    SQL.Strings = (
      
        'select p.produtoId, p.nome, p.descricao, p.valor, p.quantidade, ' +
        'p.categoriaId, '
      'c.descricao As DescricaoCategoria '
      'from produtos as p '
      'left join categorias as c on c.categoriaId = p.categoriaId;')
    Left = 484
    Top = 29
    object qryListagemprodutoId: TIntegerField
      DisplayLabel = 'C'#243'digo'
      FieldName = 'produtoId'
      ReadOnly = True
    end
    object qryListagemnome: TWideStringField
      DisplayLabel = 'Nome'
      FieldName = 'nome'
      Size = 60
    end
    object qryListagemdescricao: TWideStringField
      DisplayLabel = 'Descri'#231#227'o'
      FieldName = 'descricao'
      Size = 255
    end
    object qryListagemvalor: TFloatField
      DisplayLabel = 'Valor'
      FieldName = 'valor'
    end
    object qryListagemquantidade: TFloatField
      DisplayLabel = 'Quantidade'
      FieldName = 'quantidade'
    end
    object qryListagemcategoriaId: TIntegerField
      DisplayLabel = 'C'#243'd. Categoria'
      FieldName = 'categoriaId'
    end
    object qryListagemDescricaoCategoria: TWideStringField
      DisplayLabel = 'Descri'#231#227'o da Categoria'
      FieldName = 'DescricaoCategoria'
      Size = 30
    end
  end
  inherited dtsListagem: TDataSource
    Left = 569
    Top = 30
  end
  object qryCategoria: TZQuery
    Connection = dtmPrincipal.ConexaoDB
    SQL.Strings = (
      'select * from categorias;')
    Params = <>
    Left = 476
    Top = 128
    object qryCategoriacategoriaId: TIntegerField
      DisplayLabel = 'C'#243'digo'
      FieldName = 'categoriaId'
      ReadOnly = True
    end
    object qryCategoriadescricao: TWideStringField
      DisplayLabel = 'Descri'#231#227'o'
      FieldName = 'descricao'
      Size = 30
    end
  end
  object dtsCategoria: TDataSource
    DataSet = qryCategoria
    Left = 572
    Top = 128
  end
end
