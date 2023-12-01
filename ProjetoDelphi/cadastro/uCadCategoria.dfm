inherited frmCadCategoria: TfrmCadCategoria
  Caption = 'Cadastro de Categorias'
  ClientWidth = 892
  ExplicitWidth = 898
  PixelsPerInch = 96
  TextHeight = 13
  inherited pgcPrincipal: TPageControl
    Width = 892
    ExplicitWidth = 892
    inherited tabListagem: TTabSheet
      ExplicitWidth = 884
      inherited pnlListagemTopo: TPanel
        Width = 884
        ExplicitWidth = 884
      end
      inherited grdListagem: TDBGrid
        Width = 884
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
    inherited tabManutencao: TTabSheet
      ExplicitWidth = 884
    end
  end
  inherited pnlRodape: TPanel
    Width = 892
    inherited btnNavigator: TDBNavigator
      Hints.Strings = ()
    end
  end
end
