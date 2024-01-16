inherited frmCadAcaoAcesso: TfrmCadAcaoAcesso
  Caption = 'Cadastro de A'#231#227'o de Acesso'
  ClientHeight = 330
  ClientWidth = 716
  ExplicitWidth = 722
  ExplicitHeight = 359
  PixelsPerInch = 96
  TextHeight = 13
  inherited pgcPrincipal: TPageControl
    Width = 716
    Height = 295
    ActivePage = tabManutencao
    inherited tabListagem: TTabSheet
      inherited pnlListagemTopo: TPanel
        Width = 708
      end
      inherited grdListagem: TDBGrid
        Width = 708
        Height = 202
        Columns = <
          item
            Expanded = False
            FieldName = 'acaoAcessoId'
            Width = 63
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'descricao'
            Width = 318
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'chave'
            Width = 291
            Visible = True
          end>
      end
    end
    inherited tabManutencao: TTabSheet
      ExplicitLeft = 4
      ExplicitTop = 24
      ExplicitWidth = 868
      ExplicitHeight = 468
      object edtAcaoAcessoId: TLabeledEdit
        Tag = 1
        Left = 0
        Top = 40
        Width = 156
        Height = 21
        EditLabel.Width = 33
        EditLabel.Height = 13
        EditLabel.Caption = 'C'#243'digo'
        MaxLength = 10
        NumbersOnly = True
        TabOrder = 0
      end
      object edtDescricao: TLabeledEdit
        Tag = 2
        Left = 0
        Top = 96
        Width = 708
        Height = 21
        EditLabel.Width = 46
        EditLabel.Height = 13
        EditLabel.Caption = 'Descri'#231#227'o'
        MaxLength = 100
        TabOrder = 1
      end
      object edtChave: TLabeledEdit
        Tag = 2
        Left = 0
        Top = 152
        Width = 625
        Height = 21
        EditLabel.Width = 31
        EditLabel.Height = 13
        EditLabel.Caption = 'Chave'
        MaxLength = 60
        TabOrder = 2
      end
    end
  end
  inherited pnlRodape: TPanel
    Top = 295
    Width = 716
    inherited btnFechar: TBitBtn
      Left = 637
    end
    inherited btnNavigator: TDBNavigator
      Hints.Strings = ()
    end
  end
  inherited qryListagem: TZQuery
    Active = True
    SQL.Strings = (
      'select acaoAcessoId, descricao, chave from acaoAcesso;')
    object qryListagemacaoAcessoId: TIntegerField
      DisplayLabel = 'C'#243'digo'
      FieldName = 'acaoAcessoId'
      ReadOnly = True
    end
    object qryListagemdescricao: TWideStringField
      DisplayLabel = 'Descri'#231#227'o'
      FieldName = 'descricao'
      Required = True
      Size = 100
    end
    object qryListagemchave: TWideStringField
      DisplayLabel = 'Chave'
      FieldName = 'chave'
      Required = True
      Size = 60
    end
  end
end
