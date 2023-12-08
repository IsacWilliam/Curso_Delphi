unit uDTMVenda;

interface

uses
  System.SysUtils, System.Classes, Data.DB, ZAbstractRODataset,
  ZAbstractDataset, ZDataset, Datasnap.DBClient;

type
  TdtmVenda = class(TDataModule)
    qryCliente: TZQuery;
    qryClienteclienteId: TIntegerField;
    qryClientenome: TWideStringField;
    qryProdutos: TZQuery;
    qryProdutosprodutoId: TIntegerField;
    qryProdutosnome: TWideStringField;
    qryProdutosvalor: TFloatField;
    qryProdutosquantidade: TFloatField;
    cdsItensVendas: TClientDataSet;
    dtsCliente: TDataSource;
    dtsProdutos: TDataSource;
    dtsItensVendas: TDataSource;
    cdsItensVendasprodutoId: TIntegerField;
    cdsItensVendasNomeProduto: TStringField;
    cdsItensVendasquantidade: TFloatField;
    cdsItensVendasvalorUnitario: TFloatField;
    cdsItensVendasvalorTotalProduto: TFloatField;
    cdsItensVendasvalorTotalVenda: TAggregateField;
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  dtmVenda: TdtmVenda;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

uses uDTMConexao;

{$R *.dfm}

procedure TdtmVenda.DataModuleCreate(Sender: TObject);
begin
  cdsItensVendas.CreateDataSet;

  qryCliente.Open;
  qryProdutos.Open;
end;

procedure TdtmVenda.DataModuleDestroy(Sender: TObject);
begin
cdsItensVendas.Close;

  qryCliente.Close;
  qryProdutos.Close;
end;

end.
