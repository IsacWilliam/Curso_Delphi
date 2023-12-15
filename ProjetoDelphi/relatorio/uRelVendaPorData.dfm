object frmRelProVendaPorData: TfrmRelProVendaPorData
  Left = 0
  Top = 0
  Caption = 'frmRelProVendaPorData'
  ClientHeight = 565
  ClientWidth = 857
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 13
  object Relatorio: TRLReport
    Left = 0
    Top = 0
    Width = 794
    Height = 1123
    DataSource = dtsVendas
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -13
    Font.Name = 'Arial'
    Font.Style = []
    object Cabecalho: TRLBand
      Left = 38
      Top = 38
      Width = 718
      Height = 59
      BandType = btHeader
      object RLLabel1: TRLLabel
        Left = 0
        Top = 23
        Width = 303
        Height = 24
        Caption = 'Listagem de Vendas por Data'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -21
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object RLDraw1: TRLDraw
        Left = 0
        Top = 55
        Width = 718
        Height = 4
        Align = faBottom
        DrawKind = dkLine
        Pen.Width = 2
      end
    end
    object Rodape: TRLBand
      Left = 38
      Top = 236
      Width = 718
      Height = 34
      BandType = btFooter
      object RLDraw2: TRLDraw
        Left = 0
        Top = 0
        Width = 718
        Height = 11
        Align = faTop
        DrawKind = dkLine
        Pen.Width = 2
      end
      object RLSystemInfo1: TRLSystemInfo
        Left = 0
        Top = 11
        Width = 60
        Height = 16
        Info = itFullDate
        Text = ''
      end
      object RLSystemInfo2: TRLSystemInfo
        Left = 635
        Top = 11
        Width = 31
        Height = 16
        Alignment = taRightJustify
        Info = itPageNumber
        Text = ''
      end
      object RLSystemInfo3: TRLSystemInfo
        Left = 684
        Top = 11
        Width = 29
        Height = 16
        Info = itLastPageNumber
        Text = ''
      end
      object RLLabel2: TRLLabel
        Left = 672
        Top = 11
        Width = 8
        Height = 16
        Alignment = taRightJustify
        Caption = '/'
      end
      object RLLabel3: TRLLabel
        Left = 600
        Top = 11
        Width = 44
        Height = 16
        Caption = 'P'#225'gina'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -13
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
    end
    object BandaDoGrupo: TRLGroup
      Left = 38
      Top = 97
      Width = 718
      Height = 96
      DataFields = 'dataVenda'
      object RLBand3: TRLBand
        Left = 0
        Top = 0
        Width = 718
        Height = 19
        BandType = btHeader
        Color = clInactiveCaption
        ParentColor = False
        Transparent = False
        object RLLabel8: TRLLabel
          Left = 0
          Top = 0
          Width = 37
          Height = 16
          Caption = 'Data:'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          Transparent = False
        end
        object RLDBText5: TRLDBText
          Left = 43
          Top = 0
          Width = 66
          Height = 16
          DataField = 'dataVenda'
          DataSource = dtsVendas
          Text = ''
        end
      end
      object RLBand1: TRLBand
        Left = 0
        Top = 44
        Width = 718
        Height = 16
        object RLDBText1: TRLDBText
          Left = 3
          Top = 0
          Width = 52
          Height = 16
          DataField = 'clienteId'
          DataSource = dtsVendas
          Text = ''
        end
        object RLDBText2: TRLDBText
          Left = 66
          Top = 0
          Width = 36
          Height = 16
          DataField = 'nome'
          DataSource = dtsVendas
          Text = ''
        end
        object RLDBText4: TRLDBText
          Left = 652
          Top = 0
          Width = 66
          Height = 16
          Alignment = taRightJustify
          DataField = 'totalVenda'
          DataSource = dtsVendas
          Text = ''
        end
      end
      object RLBand2: TRLBand
        Left = 0
        Top = 19
        Width = 718
        Height = 25
        BandType = btColumnHeader
        Color = clInfoBk
        ParentColor = False
        Transparent = False
        object RLLabel4: TRLLabel
          Left = 0
          Top = 3
          Width = 49
          Height = 16
          Caption = 'C'#243'digo'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          Transparent = False
        end
        object RLLabel5: TRLLabel
          Left = 66
          Top = 3
          Width = 110
          Height = 16
          Caption = 'Nome do Cliente'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          Transparent = False
        end
        object RLLabel7: TRLLabel
          Left = 615
          Top = 3
          Width = 103
          Height = 16
          Alignment = taRightJustify
          Caption = 'Valor da Venda'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          Transparent = False
        end
      end
      object RLBand4: TRLBand
        Left = 0
        Top = 60
        Width = 718
        Height = 34
        BandType = btSummary
        object RLDBResult1: TRLDBResult
          Left = 652
          Top = 8
          Width = 66
          Height = 16
          Alignment = taRightJustify
          DataField = 'totalVenda'
          DataSource = dtsVendas
          Info = riSum
          Text = ''
        end
        object RLDraw3: TRLDraw
          Left = 555
          Top = 0
          Width = 163
          Height = 11
          DrawKind = dkLine
        end
        object RLLabel10: TRLLabel
          Left = 555
          Top = 8
          Width = 97
          Height = 16
          Caption = 'Total por data:'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          Transparent = False
        end
      end
    end
    object RLBand5: TRLBand
      Left = 38
      Top = 193
      Width = 718
      Height = 43
      BandType = btSummary
      object RLDBResult2: TRLDBResult
        Left = 652
        Top = 16
        Width = 66
        Height = 16
        Alignment = taRightJustify
        DataField = 'totalVenda'
        DataSource = dtsVendas
        Info = riSum
        Text = ''
      end
      object RLDraw4: TRLDraw
        Left = 555
        Top = 8
        Width = 163
        Height = 11
        DrawKind = dkLine
      end
      object RLLabel6: TRLLabel
        Left = 573
        Top = 16
        Width = 79
        Height = 16
        Caption = 'Total Geral:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -13
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = False
      end
    end
  end
  object qryVendas: TZQuery
    Connection = dtmPrincipal.ConexaoDB
    SQL.Strings = (
      'select vendas.vendaId,'
      '       vendas.clienteId,'
      '       clientes.nome,'
      '       vendas.dataVenda,'
      '       vendas.totalVenda'
      
        '  from vendas inner join clientes on clientes.clienteId = vendas' +
        '.clienteId'
      ' where vendas.dataVenda between :DataInicio and :DataFim'
      ' order by vendas.dataVenda, vendas.clienteId;'
      ''
      '')
    Params = <
      item
        DataType = ftDate
        Name = 'DataInicio'
        ParamType = ptInput
        Value = '01/01/2000'
      end
      item
        DataType = ftDate
        Name = 'DataFim'
        ParamType = ptInput
        Value = '31/12/2023'
      end>
    Left = 56
    Top = 480
    ParamData = <
      item
        DataType = ftDate
        Name = 'DataInicio'
        ParamType = ptInput
        Value = '01/01/2000'
      end
      item
        DataType = ftDate
        Name = 'DataFim'
        ParamType = ptInput
        Value = '31/12/2023'
      end>
    object qryVendasvendaId: TIntegerField
      FieldName = 'vendaId'
      ReadOnly = True
    end
    object qryVendasclienteId: TIntegerField
      FieldName = 'clienteId'
      Required = True
    end
    object qryVendasnome: TWideStringField
      FieldName = 'nome'
      Size = 60
    end
    object qryVendasdataVenda: TDateTimeField
      FieldName = 'dataVenda'
      Required = True
    end
    object qryVendastotalVenda: TFloatField
      FieldName = 'totalVenda'
      Required = True
    end
  end
  object dtsVendas: TDataSource
    DataSet = qryVendas
    Left = 136
    Top = 480
  end
  object RLPDFFilter1: TRLPDFFilter
    DocumentInfo.Creator = 
      'FortesReport Community Edition v4.0.1.2 \251 Copyright '#169' 1999-20' +
      '21 Fortes Inform'#225'tica'
    DisplayName = 'Documento PDF'
    Left = 216
    Top = 480
  end
  object RLXLSXFilter1: TRLXLSXFilter
    DisplayName = 'Planilha Excel'
    Left = 296
    Top = 480
  end
  object RLXLSFilter1: TRLXLSFilter
    DisplayName = 'Planilha Excel 97-2013'
    Left = 360
    Top = 480
  end
  object RLHTMLFilter1: TRLHTMLFilter
    DocumentStyle = dsCSS2
    DisplayName = 'P'#225'gina da Web'
    Left = 440
    Top = 480
  end
end
