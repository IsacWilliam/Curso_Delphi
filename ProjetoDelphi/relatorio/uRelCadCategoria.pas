unit uRelCadCategoria;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  uDTMConexao, Data.DB, ZAbstractRODataset, ZAbstractDataset, ZDataset,
  RLReport, RLFilters, RLPDFFilter, RLHTMLFilter, RLXLSFilter, RLXLSXFilter;

type
  TfrmRelCadCategoria = class(TForm)
    qryCategorias: TZQuery;
    dtsCategorias: TDataSource;
    qryCategoriascategoriaId: TIntegerField;
    qryCategoriasdescricao: TWideStringField;
    Relatorio: TRLReport;
    Cabecalho: TRLBand;
    RLLabel1: TRLLabel;
    RLDraw1: TRLDraw;
    RLPDFFilter1: TRLPDFFilter;
    Rodape: TRLBand;
    RLDraw2: TRLDraw;
    RLSystemInfo1: TRLSystemInfo;
    RLSystemInfo2: TRLSystemInfo;
    RLSystemInfo3: TRLSystemInfo;
    RLLabel2: TRLLabel;
    RLLabel3: TRLLabel;
    RLBand1: TRLBand;
    RLDBText1: TRLDBText;
    RLDBText2: TRLDBText;
    RLBand2: TRLBand;
    RLPanel1: TRLPanel;
    RLLabel4: TRLLabel;
    RLLabel5: TRLLabel;
    RLXLSXFilter1: TRLXLSXFilter;
    RLXLSFilter1: TRLXLSFilter;
    RLHTMLFilter1: TRLHTMLFilter;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmRelCadCategoria: TfrmRelCadCategoria;

implementation

{$R *.dfm}



procedure TfrmRelCadCategoria.FormCreate(Sender: TObject);
begin
  qryCategorias.Open;
end;

procedure TfrmRelCadCategoria.FormDestroy(Sender: TObject);
begin
  qryCategorias.Close;
end;

end.
