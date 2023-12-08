unit uCadProduto;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, uTelaHeranca, Data.DB,
  ZAbstractRODataset, ZAbstractDataset, ZDataset, Vcl.DBCtrls, Vcl.Grids,
  Vcl.DBGrids, Vcl.StdCtrls, Vcl.Buttons, Vcl.Mask, Vcl.ExtCtrls, Vcl.ComCtrls,
  RxToolEdit, RxCurrEdit, cCadProduto, uEnum, uDTMConexao;

type
  TfrmCadProduto = class(TfrmTelaHeranca)
    qryListagemprodutoId: TIntegerField;
    qryListagemnome: TWideStringField;
    qryListagemdescricao: TWideStringField;
    qryListagemvalor: TFloatField;
    qryListagemquantidade: TFloatField;
    qryListagemcategoriaId: TIntegerField;
    qryListagemDescricaoCategoria: TWideStringField;
    edtProdutoId: TLabeledEdit;
    edtNome: TLabeledEdit;
    edtDescricao: TMemo;
    Label1: TLabel;
    edtValor: TCurrencyEdit;
    edtQuantidade: TCurrencyEdit;
    Label2: TLabel;
    Label3: TLabel;
    lkpCategoria: TDBLookupComboBox;
    qryCategoria: TZQuery;
    dtsCategoria: TDataSource;
    qryCategoriacategoriaId: TIntegerField;
    qryCategoriadescricao: TWideStringField;
    Label4: TLabel;
    procedure btnAlterarClick(Sender: TObject);
    procedure btnNovoClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
    oProduto : TProduto;
    function Apagar : Boolean; override;
    function Gravar(EstadoDoCadastro : TEstadoDoCadastro) : Boolean; override;
  public
    { Public declarations }
  end;

var
  frmCadProduto: TfrmCadProduto;

implementation

{$R *.dfm}

{$region 'OVERRIDE'}
function TfrmCadProduto.Apagar : Boolean;
begin
  if oProduto.Selecionar(qryListagem.FieldByName('produtoId').AsInteger) then
    begin
      Result := oProduto.Apagar;
    end;
end;

function TfrmCadProduto.Gravar(EstadoDoCadastro: TEstadoDoCadastro) : Boolean;
begin
  if edtProdutoId.Text <> EmptyStr then
     oProduto.codigo := StrToInt(edtProdutoId.Text)
  else
     oProduto.codigo      := 0;
     oProduto.nome        := edtNome.Text;
     oProduto.descricao   := edtDescricao.Text;
     oProduto.categoriaId := lkpCategoria.KeyValue;
     oProduto.valor       := edtValor.Value;
     oProduto.quantidade  := edtQuantidade.Value;

  if(EstadoDoCadastro = ecInserir) then
    Result := oProduto.Inserir
  else if (EstadoDoCadastro = ecAlterar) then
    Result := oProduto.Atualizar;
end;
{$endRegion}

procedure TfrmCadProduto.btnAlterarClick(Sender: TObject);
begin
  if oProduto.Selecionar(qryListagem.FieldByName('produtoId').AsInteger) then
    begin
      edtProdutoId.Text         := IntToStr(oProduto.codigo);
      edtNome.Text              := oProduto.nome;
      edtDescricao.Text         := oProduto.descricao;
      lkpCategoria.KeyValue     := oProduto.categoriaId;
      edtValor.Value            := oProduto.valor;
      edtQuantidade.Value       := oProduto.quantidade;
    end
  else
    begin
      btnCancelar.Click;
      Abort
    end;

  inherited;
end;

procedure TfrmCadProduto.btnNovoClick(Sender: TObject);
begin
  inherited;
  edtNome.SetFocus;
end;

procedure TfrmCadProduto.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
  qryCategoria.Close;
  if Assigned(oProduto) then
    FreeAndNil(oProduto);
end;

procedure TfrmCadProduto.FormCreate(Sender: TObject);
begin
  inherited;
  oProduto := TProduto.Create(dtmPrincipal.ConexaoDB);
  IndiceAtual := 'nome';
end;

procedure TfrmCadProduto.FormShow(Sender: TObject);
begin
  inherited;
  qryCategoria.Open;
end;

end.
