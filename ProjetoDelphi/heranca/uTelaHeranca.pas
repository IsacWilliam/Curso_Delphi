unit uTelaHeranca;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  Vcl.ComCtrls, Vcl.ExtCtrls, Vcl.StdCtrls, Vcl.Buttons, Data.DB, Vcl.Grids,
  Vcl.DBGrids, Vcl.Mask, Vcl.DBCtrls, ZAbstractRODataset, ZAbstractDataset,
  ZDataset,uEnum, RxToolEdit, RxCurrEdit, ZConnection;

type
  TfrmTelaHeranca = class(TForm)
    pgcPrincipal: TPageControl;
    pnlRodape: TPanel;
    tabListagem: TTabSheet;
    tabManutencao: TTabSheet;
    pnlListagemTopo: TPanel;
    mskEdit: TMaskEdit;
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
  private
    { Private declarations }
    EstadoDoCadastro : TEstadoDoCadastro;

    procedure ControlarBotoes(btnNovo, btnAlterar, btnCancelar,
              btnGravar, btnApagar: TBitBtn; Navegador: TDBNavigator;
              pgcPrincipal: TPageControl; Flag: Boolean);
    procedure ControlarIndiceTab(pgcPageControl: TPageControl; Indice: Integer);
  public
    { Public declarations }
  end;

var
  frmTelaHeranca: TfrmTelaHeranca;

implementation

{$R *.dfm}

uses uDTMConexao;

//Procedimentos de Controle de Tela
procedure TfrmTelaHeranca.FormClose(Sender: TObject; var Action: TCloseAction);
begin
   qryListagem.Close;
end;

procedure TfrmTelaHeranca.FormCreate(Sender: TObject);
begin
   qryListagem.Connection := dtmPrincipal.ConexaoDB;
   dtsListagem.DataSet := qryListagem;
   grdListagem.DataSource := dtsListagem;
end;

procedure TfrmTelaHeranca.FormShow(Sender: TObject);
begin
   if (qryListagem.SQL.Text <> EmptyStr) then
      begin
        qryListagem.Open;
      end;
end;

procedure TfrmTelaHeranca.grdListagemTitleClick(Column: TColumn);
begin
   ShowMessage(Column.FieldName);
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

procedure TfrmTelaHeranca.ControlarIndiceTab(pgcPageControl: TPageControl;
          Indice: Integer);
begin
   if (pgcPageControl.Pages[Indice].TabVisible) then
      pgcPageControl.TabIndex := Indice;
end;

//Procedimentos de Ações dos Botões
procedure TfrmTelaHeranca.btnNovoClick(Sender: TObject);
begin
   ControlarBotoes(btnNovo, btnAlterar, btnCancelar, btnGravar, btnApagar,
   btnNavigator, pgcPrincipal, false);
   EstadoDoCadastro := ecInserir;
end;

procedure TfrmTelaHeranca.btnAlterarClick(Sender: TObject);
begin
   ControlarBotoes(btnNovo, btnAlterar, btnCancelar, btnGravar, btnApagar,
   btnNavigator, pgcPrincipal, false);
   EstadoDoCadastro := ecAlterar;
end;

procedure TfrmTelaHeranca.btnApagarClick(Sender: TObject);
begin
   ControlarBotoes(btnNovo, btnAlterar, btnCancelar, btnGravar, btnApagar,
   btnNavigator, pgcPrincipal, true);
   ControlarIndiceTab(pgcPrincipal, 0);
   EstadoDoCadastro := ecNenhum;
end;

procedure TfrmTelaHeranca.btnCancelarClick(Sender: TObject);
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
    ControlarBotoes(btnNovo, btnAlterar, btnCancelar, btnGravar, btnApagar,
                    btnNavigator, pgcPrincipal, true);
    ControlarIndiceTab(pgcPrincipal, 0);

    if (EstadoDoCadastro = ecInserir) then
      ShowMessage('Inserido!')
    else if (EstadoDoCadastro = ecAlterar) then
      ShowMessage('Alterado!')
    else
      ShowMessage('Nada aconteceu aqui...');
  Finally
    EstadoDoCadastro := ecNenhum;
  End;
end;

end.
