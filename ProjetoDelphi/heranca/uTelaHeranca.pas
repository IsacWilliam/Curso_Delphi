unit uTelaHeranca;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.ComCtrls,
  Vcl.StdCtrls, Vcl.Buttons, Vcl.Mask, Data.DB, Vcl.DBCtrls, Vcl.Grids,
  Vcl.DBGrids, ZAbstractRODataset, ZAbstractDataset, ZDataset, uDtmConexao;

type
  TfrmTelaHeranca = class(TForm)
    pgcPrincipal: TPageControl;
    pnlRodape: TPanel;
    TabListagem: TTabSheet;
    tabManutencao: TTabSheet;
    pnlListagemTopo: TPanel;
    mskEdit: TMaskEdit;
    bntPesquisar: TBitBtn;
    grdListagem: TDBGrid;
    btnNovo: TBitBtn;
    btnAlterar: TBitBtn;
    btnCancelar: TBitBtn;
    btnGravar: TBitBtn;
    BitBtn5: TBitBtn;
    btnFechar: TBitBtn;
    DBNavigator1: TDBNavigator;
    qryListagem: TZQuery;
    dtsListagem: TDataSource;
    procedure FormCreate(Sender: TObject);
    procedure btnFecharClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmTelaHeranca: TfrmTelaHeranca;

implementation

{$R *.dfm}

procedure TfrmTelaHeranca.btnFecharClick(Sender: TObject);
begin
  Close;
end;

procedure TfrmTelaHeranca.FormCreate(Sender: TObject);
begin
   qryListagem.Connection := dtmPrincipal.ConexaoDB;
   dtsListagem.DataSet := qryListagem;
   grdListagem.DataSource := dtsListagem;
end;

end.
