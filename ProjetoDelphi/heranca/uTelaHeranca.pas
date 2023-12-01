unit uTelaHeranca;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  Vcl.ComCtrls, Vcl.ExtCtrls, Vcl.StdCtrls, Vcl.Buttons, Data.DB, Vcl.Grids,
  Vcl.DBGrids, Vcl.Mask, Vcl.DBCtrls, ZAbstractRODataset, ZAbstractDataset,
  ZDataset,uEnum, RxToolEdit, RxCurrEdit, ZConnection, uDTMConexao;

type
  TfrmTelaHeranca = class(TForm)
    pgcPrincipal: TPageControl;
    pnlRodape: TPanel;
    tabListagem: TTabSheet;
    tabManutencao: TTabSheet;
    pnlListagemTopo: TPanel;
    mskPesquisar: TMaskEdit;
    bntPesquisar: TBitBtn;
    grdListagem: TDBGrid;
    btnNovo: TBitBtn;
    btnAlterar: TBitBtn;
    btnCancelar: TBitBtn;
    btnGravar: TBitBtn;
    btnApagar: TBitBtn;
    btnFechar: TBitBtn;
    btnNavigator: TDBNavigator;
    qryListagem: TZQuery;
    dtsListagem: TDataSource;
    lblIndice: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure btnFecharClick(Sender: TObject);
    procedure btnNovoClick(Sender: TObject);
    procedure btnCancelarClick(Sender: TObject);
    procedure btnGravarClick(Sender: TObject);
    procedure btnApagarClick(Sender: TObject);
    procedure btnAlterarClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure grdListagemTitleClick(Column: TColumn);
    procedure mskPesquisarChange(Sender: TObject);
  private
    { Private declarations }
    EstadoDoCadastro : TEstadoDoCadastro;

    procedure ControlarBotoes(btnNovo, btnAlterar, btnCancelar,
              btnGravar, btnApagar: TBitBtn; Navegador: TDBNavigator;
              pgcPrincipal: TPageControl; Flag: Boolean);
    procedure ControlarIndiceTab(pgcPageControl: TPageControl; Indice: Integer);
    function RetornarCampoTraduzido(Campo: String): String;
    procedure ExibirLabelIndice(Campo: string; aLabel: TLabel);
  public
    { Public declarations }
    IndiceAtual : string;
    function Excluir : Boolean; virtual;
    function Gravar(EstadoDoCadastro : TEstadoDoCadastro) : Boolean; virtual;
  end;

var
  frmTelaHeranca : TfrmTelaHeranca;

implementation

{$R *.dfm}
                  //Procedimentos de Controle de Tela
{$region 'Funções e Procedures'}
procedure TfrmTelaHeranca.FormClose(Sender : TObject; var Action: TCloseAction);
begin
   qryListagem.Close;
end;

procedure TfrmTelaHeranca.FormCreate(Sender : TObject);
begin
   qryListagem.Connection := dtmPrincipal.ConexaoDB;
   dtsListagem.DataSet := qryListagem;
   grdListagem.DataSource := dtsListagem;
   grdListagem.Options := [dgTitles,dgIndicator,dgColumnResize,dgColLines,
                           dgRowLines,dgTabs,dgRowSelect,dgAlwaysShowSelection,
                           dgCancelOnExit,dgTitleClick,dgTitleHotTrack]
end;

procedure TfrmTelaHeranca.FormShow(Sender: TObject);
begin
   if (qryListagem.SQL.Text <> EmptyStr) then
      begin
         qryListagem.IndexFieldNames := IndiceAtual;
         ExibirLabelIndice(IndiceAtual, lblIndice);
         qryListagem.Open;
      end;
   ControlarBotoes(btnNovo, btnAlterar, btnCancelar, btnGravar, btnApagar,
                   btnNavigator, pgcPrincipal, true);
end;

procedure TfrmTelaHeranca.grdListagemTitleClick(Column : TColumn);
begin
   IndiceAtual := Column.FieldName;
   qryListagem.IndexFieldNames := IndiceAtual;
   ExibirLabelIndice(IndiceAtual, lblIndice);
end;

procedure TfrmTelaHeranca.mskPesquisarChange(Sender : TObject);
begin
   qryListagem.Locate(IndiceAtual, TMaskEdit(Sender).Text, [loPartialKey]);
   //ou
   //qryListagem.Locate(IndiceAtual, mskPesquisar.Text, [loPartialKey]);

end;

procedure TfrmTelaHeranca.ControlarBotoes(btnNovo, btnAlterar, btnCancelar,
          btnGravar, btnApagar: TBitBtn; Navegador: TDBNavigator;
          pgcPrincipal: TPageControl; Flag: Boolean);
begin
   pgcPrincipal.Pages[0].TabVisible := Flag;
   Navegador.Enabled                := Flag;
   btnNovo.Enabled                  := Flag;
   btnApagar.Enabled                := Flag;
   btnAlterar.Enabled               := Flag;
   btnCancelar.Enabled              := not (Flag);
   btnGravar.Enabled                := not (Flag);
end;

procedure TfrmTelaHeranca.ControlarIndiceTab(pgcPageControl : TPageControl;
          Indice : Integer);
begin
   if (pgcPageControl.Pages[Indice].TabVisible) then
      pgcPageControl.TabIndex := Indice;
end;

function TfrmTelaHeranca.RetornarCampoTraduzido(Campo : String) : String;
var i : Integer;
begin
  for i := 0 to qryListagem.Fields.Count - 1 do begin
     if LowerCase(qryListagem.Fields[i].FieldName) = LowerCase(Campo) then begin
        Result := qryListagem.Fields[i].DisplayLabel;
        Break;
     end;
  end;
end;

procedure TfrmTelaHeranca.ExibirLabelIndice(Campo : string; aLabel : TLabel);
begin
   aLabel.Caption:=RetornarCampoTraduzido(Campo);
end;

{$endregion}

                  // Métodos para sobrescrição
{$region 'Métodos Virtuais'}
function TfrmTelaHeranca.Excluir: Boolean;
begin
   ShowMessage('DELETADO');
   Result := True;
end;

function TfrmTelaHeranca.Gravar(EstadoDoCadastro : TEstadoDoCadastro) : Boolean;
begin
   if (EstadoDoCadastro = ecInserir) then
      ShowMessage('Inserido')
   else if (EstadoDoCadastro = ecAlterar) then
      ShowMessage('Alterado');
   Result := True;
end;
{$endregion}

                  //Procedimentos de Ações dos Botões
{$region 'Ações dos Botões'}
procedure TfrmTelaHeranca.btnNovoClick(Sender : TObject);
begin
   ControlarBotoes(btnNovo, btnAlterar, btnCancelar, btnGravar, btnApagar,
   btnNavigator, pgcPrincipal, false);
   EstadoDoCadastro := ecInserir;
end;

procedure TfrmTelaHeranca.btnAlterarClick(Sender : TObject);
begin
   ControlarBotoes(btnNovo, btnAlterar, btnCancelar, btnGravar, btnApagar,
   btnNavigator, pgcPrincipal, false);
   EstadoDoCadastro := ecAlterar;
end;

procedure TfrmTelaHeranca.btnApagarClick(Sender : TObject);
begin
   if Excluir then
      begin
        ControlarBotoes(btnNovo, btnAlterar, btnCancelar, btnGravar, btnApagar,
        btnNavigator, pgcPrincipal, true);
        ControlarIndiceTab(pgcPrincipal, 0);
        EstadoDoCadastro := ecNenhum;
      end;
end;

procedure TfrmTelaHeranca.btnCancelarClick(Sender : TObject);
begin
   ControlarBotoes(btnNovo, btnAlterar, btnCancelar, btnGravar, btnApagar,
   btnNavigator, pgcPrincipal, true);
   ControlarIndiceTab(pgcPrincipal, 0);
   EstadoDoCadastro := ecNenhum;
end;

procedure TfrmTelaHeranca.btnFecharClick(Sender: TObject);
begin
   Close;
end;

procedure TfrmTelaHeranca.btnGravarClick(Sender: TObject);
begin
  Try
     if Gravar(EstadoDoCadastro) then
        begin
           ControlarBotoes(btnNovo, btnAlterar, btnCancelar, btnGravar, btnApagar,
                           btnNavigator, pgcPrincipal, true);
           ControlarIndiceTab(pgcPrincipal, 0);
        end;
  Finally
    EstadoDoCadastro := ecNenhum;
  End;
end;
{$endregion}
end.
