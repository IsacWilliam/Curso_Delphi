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
    btnApagarItem: TBitBtn;
    Label1: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    lkpProduto: TDBLookupComboBox;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure dbGridItensVendaKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure btnAlterarClick(Sender: TObject);
    procedure btnNovoClick(Sender: TObject);
    procedure btnAdicionarItem(Sender: TObject);
    procedure lkpProdutoExit(Sender: TObject);
    procedure edtQuantidadeExit(Sender: TObject);
    procedure edtQuantidadeEnter(Sender: TObject);
    procedure btnCancelarClick(Sender: TObject);
    procedure btnGravarClick(Sender: TObject);
  private
    { Private declarations }
    dtmVenda : TdtmVenda;
    oVenda : TVenda;
    function Gravar(EstadoDoCadastro : TEstadoDoCadastro): Boolean; override;
    function Apagar : Boolean; override;
    function TotalizarProduto(valorUnitario, Quantidade: Double): Double;
    procedure LimparComponenteItem;
    procedure LimparCds;
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
  if oVenda.Selecionar(qryListagem.FieldByName('vendaId').AsInteger) then
    begin
      Result := oVenda.Apagar;
    end;
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
procedure TfrmProVenda.lkpProdutoExit(Sender: TObject);
begin
  inherited;
  edtValorUnitario.Value := dtmVenda.qryProdutos.FieldByName('valor').AsFloat;
  edtQuantidade.Value := 1;
  edtTotalProduto.Value := TotalizarProduto(edtValorUnitario.Value, edtQuantidade.Value);
end;

{$endRegion}
procedure TfrmProVenda.btnAdicionarItem(Sender: TObject);
begin
  inherited;
  if lkpProduto.KeyValue = Null then
    begin
      MessageDlg('Produto é um campo obrigatório!', mtInformation, [mbOK], 0);
      lkpProduto.SetFocus;
      Abort;
    end;

    if edtValorUnitario.Value <= 0 then
      begin
        MessageDlg('Valor Unitário não pode ser Zero!', mtInformation, [mbOK], 0);
        edtValorUnitario.SetFocus;
        Abort;
      end;

    if edtQuantidade.Value <= 0 then
      begin
        MessageDlg('Quantidade não pode ser Zero!', mtInformation, [mbOK], 0);
        edtQuantidade.SetFocus;
        Abort;
      end;

    if dtmVenda.cdsItensVendas.Locate('produtoId', lkpProduto.KeyValue, []) then
    begin
      MessageDlg('Este Produto já foi selecionado!', mtInformation, [mbOK], 0);
      lkpProduto.SetFocus;
      Abort;
    end;

    edtTotalProduto.Value := TotalizarProduto(edtValorUnitario.Value, edtQuantidade.Value);

    dtmVenda.cdsItensVendas.Append;
    dtmVenda.cdsItensVendas.FieldByName('produtoId').AsString := lkpProduto.KeyValue;
    dtmVenda.cdsItensVendas.FieldByName('nomeProduto').AsString := dtmVenda.qryProdutos.FieldByName('nome').AsString;
    dtmVenda.cdsItensVendas.FieldByName('quantidade').AsFloat := edtQuantidade.Value;
    dtmVenda.cdsItensVendas.FieldByName('valorUnitario').AsFloat := edtValorUnitario.Value;
    dtmVenda.cdsItensVendas.FieldByName('valorTotalProduto').AsFloat := edtTotalProduto.Value;
    dtmVenda.cdsItensVendas.Post;
    LimparComponenteItem;

    lkpProduto.SetFocus;

end;

procedure TfrmProVenda.LimparComponenteItem;
begin
  lkpProduto.KeyValue   := null;
  edtQuantidade.Value   := 0;
  edtValorUnitario.Value:= 0;
  edtTotalProduto.Value := 0;
end;

function TfrmProVenda.TotalizarProduto(valorUnitario, Quantidade: Double): Double;
begin
  Result:= valorUnitario * Quantidade;
end;

procedure TfrmProVenda.LimparCds;
begin
  while not dtmVenda.cdsItensVendas.Eof do
    dtmVenda.cdsItensVendas.Delete;
end;

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

procedure TfrmProVenda.btnCancelarClick(Sender: TObject);
begin
  inherited;
  LimparCds;
end;

procedure TfrmProVenda.btnGravarClick(Sender: TObject);
begin
  inherited;
  LimparCds;
end;

procedure TfrmProVenda.btnNovoClick(Sender: TObject);
begin
  inherited;
  edtDataVenda.Date := Date;
  lkpCliente.SetFocus;
  LimparCds;
end;

procedure TfrmProVenda.dbGridItensVendaKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  BloqueiaCTRL_DEL_DBGrid(Key, Shift);
end;

procedure TfrmProVenda.edtQuantidadeEnter(Sender: TObject);
begin
  inherited;
  edtTotalProduto.Value := TotalizarProduto(edtValorUnitario.Value, edtQuantidade.Value);
end;

procedure TfrmProVenda.edtQuantidadeExit(Sender: TObject);
begin
  inherited;
  edtTotalProduto.Value := TotalizarProduto(edtValorUnitario.Value, edtQuantidade.Value);
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
