unit uProVenda;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  uTelaHeranca, Data.DB, ZAbstractRODataset, ZAbstractDataset, ZDataset,
  Vcl.DBCtrls, Vcl.Grids, Vcl.DBGrids, Vcl.StdCtrls, Vcl.Buttons, Vcl.Mask,
  Vcl.ExtCtrls, Vcl.ComCtrls, uDTMConexao, uDTMVenda, RxToolEdit, RxCurrEdit,
  uEnum, cProVenda;

type
  TfrmProVenda = class(TfrmTelaHeranca)
    qryListagemvendaId: TIntegerField;
    qryListagemclienteId: TIntegerField;
    qryListagemnome: TWideStringField;
    qryListagemdataVenda: TDateTimeField;
    qryListagemtotalVenda: TFloatField;
    edtVendaId: TLabeledEdit;
    lkpCliente: TDBLookupComboBox;
    Label4: TLabel;
    edtDataVenda: TDateEdit;
    Label3: TLabel;
    Panel1: TPanel;
    Panel2: TPanel;
    Panel3: TPanel;
    Panel4: TPanel;
    edtValorTotal: TCurrencyEdit;
    Label2: TLabel;
    dbGridItensVenda: TDBGrid;
    Label5: TLabel;
    edtValorUnitario: TCurrencyEdit;
    edtQuantidade: TCurrencyEdit;
    edtTotalProduto: TCurrencyEdit;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    Label1: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    DBLookupComboBox1: TDBLookupComboBox;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure dbGridItensVendaKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure btnAlterarClick(Sender: TObject);
    procedure btnNovoClick(Sender: TObject);
  private
    { Private declarations }
    dtmVenda : TdtmVenda;
    oVenda : TVenda;
    function Gravar(EstadoDoCadastro : TEstadoDoCadastro): Boolean; override;
    function Apagar : Boolean; override;
  public
    { Public declarations }
  end;

var
  frmProVenda: TfrmProVenda;

implementation

{$R *.dfm}
{$region 'Override'}
function TfrmProVenda.Apagar: Boolean;
begin
  Result := oVenda.Apagar(qryListagem.FieldByName('vendaId').AsInteger);
end;

function TfrmProVenda.Gravar(EstadoDoCadastro : TEstadoDoCadastro): Boolean;
begin
  if edtVendaId.Text <> EmptyStr then
    oVenda.VendaId := StrToInt(edtVendaId.Text)
  else
    oVenda.VendaId := 0;
    oVenda.ClienteId := lkpCliente.KeyValue;
    oVenda.DataVenda := edtDataVenda.Date;
    oVenda.TotalVenda := edtValorTotal.Value;

  if (EstadoDoCadastro = ecInserir) then
    Result := oVenda.Inserir
  else if (EstadoDoCadastro = ecAlterar) then
    Result := oVenda.Atualizar;
end;
{$endRegion}
procedure TfrmProVenda.btnAlterarClick(Sender: TObject);
begin
  if oVenda.Selecionar(qryListagem.FieldByName('vendaId').AsInteger) then
    begin
      edtVendaId.Text     := IntToStr(oVenda.VendaId);
      lkpCliente.KeyValue := oVenda.ClienteId;
      edtDataVenda.Date   := oVenda.DataVenda;
      edtValorTotal.Value := oVenda.TotalVenda;
    end
  else
    begin
      btnCancelar.Click;
      Abort;
    end;
  inherited;
end;

procedure TfrmProVenda.btnNovoClick(Sender: TObject);
begin
  inherited;
  edtDataVenda.Date := Date;
  lkpCliente.SetFocus;
end;

procedure TfrmProVenda.dbGridItensVendaKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  BloqueiaCTRL_DEL_DBGrid(Key, Shift);
end;

procedure TfrmProVenda.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
  if Assigned(dtmVenda) then
    FreeAndNil(dtmVenda);

  if Assigned(oVenda) then
    FreeAndNil(oVenda);
end;

procedure TfrmProVenda.FormCreate(Sender: TObject);
begin
  inherited;
  dtmVenda    := TdtmVenda.Create(Self);
  oVenda      := TVenda.Create(dtmPrincipal.ConexaoDB);
  IndiceAtual := 'clienteId';
end;

end.
