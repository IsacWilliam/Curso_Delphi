inherited frmCadUsuario: TfrmCadUsuario
  Caption = 'Cadastro de Usu'#225'rio'
  ClientHeight = 299
  ClientWidth = 715
  ExplicitWidth = 721
  ExplicitHeight = 328
  PixelsPerInch = 96
  TextHeight = 13
  inherited pgcPrincipal: TPageControl
    Width = 715
    Height = 264
    ActivePage = tabManutencao
    ExplicitWidth = 715
    ExplicitHeight = 264
    inherited tabListagem: TTabSheet
      ExplicitLeft = 4
      ExplicitTop = 24
      ExplicitWidth = 707
      ExplicitHeight = 236
      inherited pnlListagemTopo: TPanel
        Width = 707
        ExplicitWidth = 707
      end
      inherited grdListagem: TDBGrid
        Width = 707
        Height = 171
        Columns = <
          item
            Expanded = False
            FieldName = 'usuarioId'
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'Nome'
            Width = 592
            Visible = True
          end>
      end
    end
    inherited tabManutencao: TTabSheet
      ExplicitLeft = 4
      ExplicitTop = 24
      ExplicitWidth = 707
      ExplicitHeight = 236
      object edtUsuarioId: TLabeledEdit
        Tag = 1
        Left = 0
        Top = 26
        Width = 75
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
        Top = 76
        Width = 399
        Height = 21
        EditLabel.Width = 27
        EditLabel.Height = 13
        EditLabel.Caption = 'Nome'
        MaxLength = 50
        TabOrder = 1
      end
      object edtSenha: TLabeledEdit
        Tag = 2
        Left = 0
        Top = 127
        Width = 318
        Height = 21
        EditLabel.Width = 30
        EditLabel.Height = 13
        EditLabel.Caption = 'Senha'
        MaxLength = 40
        PasswordChar = '*'
        TabOrder = 2
      end
    end
  end
  inherited pnlRodape: TPanel
    Top = 264
    Width = 715
    ExplicitTop = 264
    ExplicitWidth = 715
    inherited btnFechar: TBitBtn
      Left = 636
      ExplicitLeft = 636
    end
    inherited btnNavigator: TDBNavigator
      Hints.Strings = ()
    end
  end
  inherited qryListagem: TZQuery
    SQL.Strings = (
      'select usuarioId, Nome, Senha from usuarios;')
    Left = 596
    Top = 29
    object qryListagemusuarioId: TIntegerField
      DisplayLabel = 'C'#243'digo'
      FieldName = 'usuarioId'
      ReadOnly = True
    end
    object qryListagemNome: TWideStringField
      FieldName = 'Nome'
      Required = True
      Size = 50
    end
    object qryListagemSenha: TWideStringField
      FieldName = 'Senha'
      Required = True
      Size = 40
    end
  end
  inherited dtsListagem: TDataSource
    Left = 657
    Top = 30
  end
end
