inherited frmCadCliente: TfrmCadCliente
  Caption = 'Cadastro de Cliente'
  ClientHeight = 388
  ClientWidth = 720
  ExplicitWidth = 726
  ExplicitHeight = 417
  PixelsPerInch = 96
  TextHeight = 13
  inherited pgcPrincipal: TPageControl
    Width = 720
    Height = 360
    ActivePage = tabManutencao
    inherited tabListagem: TTabSheet
      inherited pnlListagemTopo: TPanel
        Width = 712
      end
      inherited grdListagem: TDBGrid
        Width = 712
        Height = 267
      end
    end
    inherited tabManutencao: TTabSheet
      ExplicitLeft = 4
      ExplicitTop = 24
      ExplicitWidth = 693
      ExplicitHeight = 332
      object Label1: TLabel
        Left = 341
        Top = 81
        Width = 19
        Height = 13
        Caption = 'CEP'
      end
      object Label2: TLabel
        Left = 341
        Top = 173
        Width = 42
        Height = 13
        Caption = 'Telefone'
      end
      object Label3: TLabel
        Left = 0
        Top = 275
        Width = 96
        Height = 13
        Caption = 'Data de Nascimento'
      end
      object edtClienteId: TLabeledEdit
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
        EditLabel.Width = 46
        EditLabel.Height = 13
        EditLabel.Caption = 'Descri'#231#227'o'
        MaxLength = 60
        TabOrder = 1
      end
      object edtCEP: TMaskEdit
        Left = 341
        Top = 96
        Width = 318
        Height = 21
        EditMask = '99.999-999;1;_'
        MaxLength = 10
        TabOrder = 2
        Text = '  .   -   '
      end
      object edtEndereco: TLabeledEdit
        Left = 0
        Top = 144
        Width = 318
        Height = 21
        EditLabel.Width = 45
        EditLabel.Height = 13
        EditLabel.Caption = 'Endere'#231'o'
        MaxLength = 60
        TabOrder = 3
      end
      object edtBairro: TLabeledEdit
        Left = 341
        Top = 144
        Width = 318
        Height = 21
        EditLabel.Width = 28
        EditLabel.Height = 13
        EditLabel.Caption = 'Bairro'
        MaxLength = 40
        TabOrder = 4
      end
      object edtCidade: TLabeledEdit
        Left = 0
        Top = 192
        Width = 318
        Height = 21
        EditLabel.Width = 33
        EditLabel.Height = 13
        EditLabel.Caption = 'Cidade'
        MaxLength = 50
        TabOrder = 5
      end
      object edtEmail: TLabeledEdit
        Left = 0
        Top = 240
        Width = 318
        Height = 21
        EditLabel.Width = 28
        EditLabel.Height = 13
        EditLabel.Caption = 'E-mail'
        MaxLength = 100
        TabOrder = 7
      end
      object edtTelefone: TMaskEdit
        Left = 341
        Top = 192
        Width = 318
        Height = 21
        EditMask = '(99)9.9999-9999;1;_'
        MaxLength = 15
        TabOrder = 6
        Text = '(  ) .    -    '
      end
      object edtDataNascimento: TDateEdit
        Left = 0
        Top = 294
        Width = 121
        Height = 21
        ClickKey = 114
        DialogTitle = 'Selecione a Data'
        NumGlyphs = 2
        CalendarStyle = csDialog
        TabOrder = 8
      end
    end
  end
  inherited pnlRodape: TPanel
    Top = 360
    Width = 720
    Height = 28
    ExplicitTop = 360
    ExplicitWidth = 720
    ExplicitHeight = 28
    inherited btnFechar: TBitBtn
      Left = 641
      Top = 2
      Height = 24
      Anchors = [akRight, akBottom]
      ExplicitLeft = 655
      ExplicitTop = 2
      ExplicitHeight = 24
    end
    inherited btnNavigator: TDBNavigator
      Hints.Strings = ()
    end
  end
  inherited qryListagem: TZQuery
    Left = 172
    Top = 37
  end
  inherited dtsListagem: TDataSource
    Left = 233
    Top = 38
  end
end
