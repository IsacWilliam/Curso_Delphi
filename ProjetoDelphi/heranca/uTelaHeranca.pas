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
    procedure grdListagemDblClick(Sender: TObject);
  private
    { Private declarations }
    EstadoDoCadastro : TEstadoDoCadastro;

    procedure ControlarBotoes(btnNovo, btnAlterar, btnCancelar,
              btnGravar, btnApagar: TBitBtn; Navegador: TDBNavigator;
              pgcPrincipal: TPageControl; Flag: Boolean);
    procedure ControlarIndiceTab(pgcPageControl: TPageControl; Indice: Integer);
    function RetornarCampoTraduzido(Campo: String): String;
    procedure ExibirLabelIndice(Campo: string; aLabel: TLabel);
    function ExisteCampoObrigatorio: Boolean;
    procedure DesabilitarEditPK;
    procedure LimparEdits;
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
{$region 'NOTAS'}
{
  TAG: 1 - Chave Prim�ria - PK
  TAG: 2 - Campos Obrigat�rios
}
{$endregion}

{$region 'Fun��es e Procedures'}
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
   ControlarIndiceTab(pgcPrincipal, 0);
   DesabilitarEditPK;
   ControlarBotoes(btnNovo, btnAlterar, btnCancelar, btnGravar, btnApagar,
                   btnNavigator, pgcPrincipal, true);
end;

procedure TfrmTelaHeranca.grdListagemDblClick(Sender: TObject);
begin
  btnAlterar.Click;
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

function TfrmTelaHeranca.ExisteCampoObrigatorio : Boolean;
var i : Integer;
begin
  Result := False;
  for i := 0 to ComponentCount - 1 do
    begin
      if (Components[i] is TLabeledEdit) then
        begin
          if (TLabeledEdit(Components[i]).Tag = 2) and
             (TLabeledEdit(Components[i]).Text = EmptyStr) then
            begin
              MessageDlg(TLabeledEdit(Components[i]).EditLabel.Caption +
                          ' � um campo obrigat�rio', mtInformation, [mbOK], 0);
              TLabeledEdit(Components[i]).SetFocus;
              Result := True;
              Break;
            end;

        end;
    end;

end;

procedure TfrmTelaHeranca.DesabilitarEditPK;
var i : Integer;
begin
  for i := 0 to ComponentCount - 1 do
    begin
      if (Components[i] is TLabeledEdit) then
        begin
          if (TLabeledEdit(Components[i]).Tag = 1) then
            begin
              TLabeledEdit(Components[i]).Enabled := False;
              Break
            end;
        end;
    end;
end;

procedure TfrmTelaHeranca.LimparEdits;
var i : Integer;
begin
  for i := 0 to ComponentCount - 1 do
    begin
      if (Components[i] is TLabeledEdit) then
        //TLabeledEdit(Components[i]).Text := EmptyStr
        TLabeledEdit(Components[i]).Text := ''
        else if (Components[i] is TEdit) then
          //TEdit(Components[i]).Text := EmptyStr
          TEdit(Components[i]).Text := ''
    end;

end;
{$endregion}

{$region 'M�todos Virtuais - Sobrescrever'}
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

{$region 'A��es dos Bot�es'}
procedure TfrmTelaHeranca.btnNovoClick(Sender : TObject);
begin
   ControlarBotoes(btnNovo, btnAlterar, btnCancelar, btnGravar, btnApagar,
   btnNavigator, pgcPrincipal, false);
   EstadoDoCadastro := ecInserir;
   LimparEdits
end;

procedure TfrmTelaHeranca.btnAlterarClick(Sender : TObject);
begin
   ControlarBotoes(btnNovo, btnAlterar, btnCancelar, btnGravar, btnApagar,
   btnNavigator, pgcPrincipal, false);
   EstadoDoCadastro := ecAlterar;
end;

procedure TfrmTelaHeranca.btnApagarClick(Sender : TObject);
begin
   Try
     if (Excluir) then
        begin
          ControlarBotoes(btnNovo, btnAlterar, btnCancelar, btnGravar, btnApagar,
                          btnNavigator, pgcPrincipal, true);
          ControlarIndiceTab(pgcPrincipal, 0);
          LimparEdits
        end
     else
        begin
          MessageDlg('Erro na exclus�o', mtError, [mbOK], 0);
        end;
   Finally
     EstadoDoCadastro := ecNenhum;
   End;
end;

procedure TfrmTelaHeranca.btnCancelarClick(Sender : TObject);
begin
   ControlarBotoes(btnNovo, btnAlterar, btnCancelar, btnGravar, btnApagar,
   btnNavigator, pgcPrincipal, true);
   ControlarIndiceTab(pgcPrincipal, 0);
   EstadoDoCadastro := ecNenhum;
   LimparEdits
end;

procedure TfrmTelaHeranca.btnFecharClick(Sender: TObject);
begin
   Close;
end;

procedure TfrmTelaHeranca.btnGravarClick(Sender: TObject);
begin
  if (ExisteCampoObrigatorio) then
    Abort;

  Try
    if Gravar(EstadoDoCadastro) then
      begin
         ControlarBotoes(btnNovo, btnAlterar, btnCancelar, btnGravar, btnApagar,
                         btnNavigator, pgcPrincipal, true);
         ControlarIndiceTab(pgcPrincipal, 0);
         EstadoDoCadastro := ecNenhum;
         LimparEdits;
      end
    else
      begin
        MessageDlg('Erro na grava��o', mtError, [mbOK], 0);
      end;
  Finally
  End;
end;
{$endregion}
end.
