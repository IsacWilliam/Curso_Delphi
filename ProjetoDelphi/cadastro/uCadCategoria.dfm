inherited frmCadCategoria: TfrmCadCategoria
  Caption = 'Cadastro de Categorias'
  ClientWidth = 905
  ExplicitWidth = 911
  PixelsPerInch = 96
  TextHeight = 13
  inherited pgcPrincipal: TPageControl
    Width = 905
    ExplicitWidth = 905
    inherited tabListagem: TTabSheet
      ExplicitWidth = 897
      inherited pnlListagemTopo: TPanel
        Width = 897
        ExplicitWidth = 897
        inherited bntPesquisar: TBitBtn
          Width = 90
          Height = 24
          ExplicitWidth = 90
          ExplicitHeight = 24
        end
      end
      inherited grdListagem: TDBGrid
        Width = 897
        Columns = <
          item
            Expanded = False
            FieldName = 'categoriaId'
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'descricao'
            Visible = True
          end>
      end
    end
  end
  inherited pnlRodape: TPanel
    Width = 905
    ExplicitWidth = 905
    DesignSize = (
      905
      41)
    inherited btnFechar: TBitBtn
      Left = 826
      ExplicitLeft = 826
    end
    inherited btnNavigator: TDBNavigator
      Hints.Strings = ()
    end
  end
  inherited qryListagem: TZQuery
    SQL.Strings = (
      'select * from categorias;')
    Left = 764
    object qryListagemcategoriaId: TIntegerField
      DisplayLabel = 'C'#243'digo'
      FieldName = 'categoriaId'
      ReadOnly = True
    end
    object qryListagemdescricao: TWideStringField
      DisplayLabel = 'Descri'#231#227'o'
      FieldName = 'descricao'
      Size = 30
    end
  end
end
