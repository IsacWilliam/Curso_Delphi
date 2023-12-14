unit uRelCadClienteFicha;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  uDTMConexao, Data.DB, ZAbstractRODataset, ZAbstractDataset, ZDataset,
  RLReport, RLFilters, RLPDFFilter, RLHTMLFilter, RLXLSFilter, RLXLSXFilter,
  Vcl.Imaging.pngimage;

type
  TfrmRelCadClienteFicha = class(TForm)
    qryCliente: TZQuery;
    dtsCliente: TDataSource;
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
    RLXLSXFilter1: TRLXLSXFilter;
    RLXLSFilter1: TRLXLSFilter;
    RLHTMLFilter1: TRLHTMLFilter;
    RLDBText3: TRLDBText;
    RLDBText4: TRLDBText;
    qryClienteclienteId: TIntegerField;
    qryClienteNome: TWideStringField;
    qryClientecep: TWideStringField;
    qryClienteendereco: TWideStringField;
    qryClientebairro: TWideStringField;
    qryClientecidade: TWideStringField;
    qryClienteestado: TWideStringField;
    qryClienteemail: TWideStringField;
    qryClientetelefone: TWideStringField;
    qryClientedataNascimento: TDateTimeField;
    RLLabel4: TRLLabel;
    RLLabel7: TRLLabel;
    RLLabel6: TRLLabel;
    RLLabel5: TRLLabel;
    RLDBText5: TRLDBText;
    RLLabel8: TRLLabel;
    RLLabel9: TRLLabel;
    RLDBText6: TRLDBText;
    RLLabel10: TRLLabel;
    RLDBText7: TRLDBText;
    RLLabel11: TRLLabel;
    RLDBText8: TRLDBText;
    RLLabel12: TRLLabel;
    RLDBText9: TRLDBText;
    RLLabel13: TRLLabel;
    RLDBText10: TRLDBText;
    RLDraw3: TRLDraw;
    RLImage1: TRLImage;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmRelCadClienteFicha: TfrmRelCadClienteFicha;

implementation

{$R *.dfm}



procedure TfrmRelCadClienteFicha.FormCreate(Sender: TObject);
begin
  qryCliente.Open;
end;

procedure TfrmRelCadClienteFicha.FormDestroy(Sender: TObject);
begin
  qryCliente.Close;
end;

end.
