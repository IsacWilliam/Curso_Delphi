object frmTelaHeranca: TfrmTelaHeranca
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'INFORME AQUI O T'#205'TULO'
  ClientHeight = 521
  ClientWidth = 876
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object pgcPrincipal: TPageControl
    Left = 0
    Top = 0
    Width = 876
    Height = 480
    ActivePage = TabListagem
    Align = alClient
    TabOrder = 0
    ExplicitWidth = 737
    ExplicitHeight = 412
    object TabListagem: TTabSheet
      Caption = 'Listagem'
      ExplicitLeft = 8
      ExplicitTop = 22
      ExplicitWidth = 729
      ExplicitHeight = 384
      object pnlListagemTopo: TPanel
        Left = 0
        Top = 0
        Width = 868
        Height = 43
        Align = alTop
        TabOrder = 0
        object mskEdit: TMaskEdit
          Left = 0
          Top = 7
          Width = 369
          Height = 21
          TabOrder = 0
          Text = 'Digite aqui para pesquisar'
        end
        object bntPesquisar: TBitBtn
          Left = 375
          Top = 5
          Width = 90
          Height = 25
          Caption = '&PESQUISAR'
          TabOrder = 1
        end
      end
      object grdListagem: TDBGrid
        Left = 0
        Top = 43
        Width = 868
        Height = 409
        Align = alClient
        DataSource = dtsListagem
        TabOrder = 1
        TitleFont.Charset = DEFAULT_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -11
        TitleFont.Name = 'Tahoma'
        TitleFont.Style = []
      end
    end
    object tabManutencao: TTabSheet
      Caption = 'Manuten'#231#227'o'
      ImageIndex = 1
      ExplicitLeft = 8
      ExplicitTop = 22
      ExplicitWidth = 729
      ExplicitHeight = 384
    end
  end
  object pnlRodape: TPanel
    Left = 0
    Top = 480
    Width = 876
    Height = 41
    Align = alBottom
    TabOrder = 1
    ExplicitLeft = 64
    ExplicitTop = 344
    ExplicitWidth = 185
    object btnNovo: TBitBtn
      Left = 4
      Top = 6
      Width = 75
      Height = 25
      Caption = '&Novo'
      TabOrder = 0
    end
    object btnAlterar: TBitBtn
      Left = 85
      Top = 6
      Width = 75
      Height = 25
      Caption = '&Alterar'
      TabOrder = 1
    end
    object btnCancelar: TBitBtn
      Left = 166
      Top = 6
      Width = 75
      Height = 25
      Caption = '&Cancelar'
      TabOrder = 2
    end
    object btnGravar: TBitBtn
      Left = 247
      Top = 6
      Width = 75
      Height = 25
      Caption = '&Gravar'
      TabOrder = 3
    end
    object BitBtn5: TBitBtn
      Left = 328
      Top = 6
      Width = 75
      Height = 25
      Caption = 'Apaga&r'
      TabOrder = 4
    end
    object btnFechar: TBitBtn
      Left = 797
      Top = 6
      Width = 75
      Height = 25
      Caption = '&Fechar'
      TabOrder = 5
      OnClick = btnFecharClick
    end
    object DBNavigator1: TDBNavigator
      Left = 492
      Top = 6
      Width = 220
      Height = 25
      DataSource = dtsListagem
      VisibleButtons = [nbFirst, nbPrior, nbNext, nbLast]
      TabOrder = 6
    end
  end
  object qryListagem: TZQuery
    Connection = dtmPrincipal.ConexaoDB
    Params = <>
    Left = 548
    Top = 21
  end
  object dtsListagem: TDataSource
    DataSet = qryListagem
    Left = 617
    Top = 22
  end
end