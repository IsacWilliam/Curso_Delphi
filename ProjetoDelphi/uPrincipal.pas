unit uPrincipal;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Menus,
  Enter, ShellApi, Vcl.ExtCtrls, Vcl.StdCtrls, Vcl.ComCtrls, VclTee.TeeGDIPlus,
  Data.DB, VCLTee.Series, VCLTee.TeEngine, VCLTee.TeeProcs, VCLTee.Chart,
  VCLTee.DBChart, ZDbcIntfs, RLReport, ZAbstractRODataset, ZAbstractDataset,
  ZDataset, uFrmAtualizaDB, cUsuarioLogado, cAtualizacaoBancoDeDados,
  cAcaoAcesso, uUsuarioVsAcoes;

type
  TfrmPrincipal = class(TForm)
    mainPrincipal: TMainMenu;
    Cadastro1: TMenuItem;
    Cliente1: TMenuItem;
    N1: TMenuItem;
    Categoria1: TMenuItem;
    Produto1: TMenuItem;
    N2: TMenuItem;
    mnuFechar: TMenuItem;
    Movimentao1: TMenuItem;
    Venda1: TMenuItem;
    Relatrios1: TMenuItem;
    Cliente2: TMenuItem;
    N3: TMenuItem;
    Produto2: TMenuItem;
    N4: TMenuItem;
    VendasporData1: TMenuItem;
    Categoria2: TMenuItem;
    FichadeClientes1: TMenuItem;
    ProdutoporCategoria1: TMenuItem;
    Usurio1: TMenuItem;
    N5: TMenuItem;
    AlterarSenha1: TMenuItem;
    stbPrincipal: TStatusBar;
    AoAcesso1: TMenuItem;
    N6: TMenuItem;
    UsuriosVSAes1: TMenuItem;
    N7: TMenuItem;
    procedure mnuFecharClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Categoria1Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure Cliente1Click(Sender: TObject);
    procedure Produto1Click(Sender: TObject);
    procedure Venda1Click(Sender: TObject);
    procedure Categoria2Click(Sender: TObject);
    procedure Cliente2Click(Sender: TObject);
    procedure FichadeClientes1Click(Sender: TObject);
    procedure Produto2Click(Sender: TObject);
    procedure ProdutoporCategoria1Click(Sender: TObject);
    procedure VendasporData1Click(Sender: TObject);
    procedure Usurio1Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure AlterarSenha1Click(Sender: TObject);
    procedure AoAcesso1Click(Sender: TObject);
    procedure UsuriosVSAes1Click(Sender: TObject);
  private
    { Private declarations }
    TeclaEnter: TMREnter;
    procedure AtualizaBancoDados(aForm: TfrmAtualizaDB);
    procedure CriarForm(aNomeForm: TFormClass);
    procedure CriarRelatorio(aNomeForm: TFormClass);
  public
    { Public declarations }
  end;

var
  frmPrincipal: TfrmPrincipal;
  oUsuarioLogado: TUsuarioLogado;

implementation

{$R *.dfm}

uses uCadCategoria, uDTMConexao, uCadCliente, uCadProduto, uProVenda,
  uRelCadCategoria, uRelCadCliente, uRelCadClienteFicha, uRelCadProduto,
  uRelCadProdutoComGrupoCategoria, uSelecionarData, uRelVendaPorData,
  uCadUsuario, uLogin, uAlterarSenha, cArquivoIni, uCadAcaoAcesso;

procedure TfrmPrincipal.Categoria1Click(Sender: TObject);
begin
  CriarForm(TfrmCadCategoria);
end;

procedure TfrmPrincipal.Categoria2Click(Sender: TObject);
begin
  CriarRelatorio(TfrmRelCadCategoria);
end;

procedure TfrmPrincipal.Cliente1Click(Sender: TObject);
begin
  CriarForm(TfrmCadCliente);
end;

procedure TfrmPrincipal.Cliente2Click(Sender: TObject);
begin
  CriarRelatorio(TfrmRelCadCliente);
end;

procedure TfrmPrincipal.FichadeClientes1Click(Sender: TObject);
begin
  CriarRelatorio(TfrmRelCadClienteFicha);
end;

procedure TfrmPrincipal.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  FreeAndNil(TeclaEnter);
  FreeAndNil(dtmPrincipal);
  if Assigned(oUsuarioLogado) then
    FreeAndNil(oUsuarioLogado);
end;

procedure TfrmPrincipal.FormCreate(Sender: TObject);
begin
  //Configuração do arquivo INI
  if not FileExists(TArquivoIni.ArquivoIni) then
  begin
    TArquivoIni.AtualizarIni('SERVER', 'TipoDataBase', 'MSSQL');
    TArquivoIni.AtualizarIni('SERVER', 'HostName', '.\');
    TArquivoIni.AtualizarIni('SERVER', 'Port', '1433');
    TArquivoIni.AtualizarIni('SERVER', 'User', 'sa');
    TArquivoIni.AtualizarIni('SERVER', 'Password', 'delphi@2023');
    TArquivoIni.AtualizarIni('SERVER', 'Database', 'vendas');
    MessageDlg('Arquivo ' + TArquivoIni.ArquivoIni + #13 + 'Criado com sucesso.'
               + ' Configure o arquivo antes de inicializar a aplicação',
               mtInformation, [mbOK], 0);
    Application.Terminate;
  end
  else
  begin
    frmAtualizaDB := TfrmAtualizaDB.Create(Self);
    frmAtualizaDB.Show;
    frmAtualizaDB.Refresh;
  {
    dtmPrincipal := TdtmPrincipal.Create(Self);
    dtmPrincipal.ConexaoDB.SQLHourGlass := True;
    dtmPrincipal.ConexaoDB.Protocol := 'mssql';
    dtmPrincipal.ConexaoDB.LibraryLocation := 'E:\Cursos\Curso_Delphi\ProjetoDelphi\ntwdblib.dll';
    dtmPrincipal.ConexaoDB.HostName := '.\SERVERCURSO';
    dtmPrincipal.ConexaoDB.Port := 1433;
    dtmPrincipal.ConexaoDB.User := 'sa';
    dtmPrincipal.ConexaoDB.Password := 'delphi@2023';
    dtmPrincipal.ConexaoDB.Database := 'vendas';
    dtmPrincipal.ConexaoDB.Connected := True;
  }
  // Este bloco substitui o anterior
    dtmPrincipal := TdtmPrincipal.Create(Self);
    with dtmPrincipal.ConexaoDB do
      begin
        Connected := False;
        SQLHourGlass := False;
        if TArquivoIni.LerIni('SERVER', 'TipoDataBase') = 'MSSQL' then
          Protocol := 'mssql'; //Protocolo DB
        LibraryLocation := 'E:\Cursos\Curso_Delphi\ProjetoDelphi\ntwdblib.dll';
        HostName := TArquivoIni.LerIni('SERVER', 'HostName'); //Instância do DB
        Port := StrToInt(TArquivoIni.LerIni('SERVER', 'Port'));  //Porta DB
        User := TArquivoIni.LerIni('SERVER', 'User');  //Usuário DB
        Password := TArquivoIni.LerIni('SERVER', 'Password');  //Senha DB
        Database := TArquivoIni.LerIni('SERVER', 'DataBase');  //Nome DB
        AutoCommit := True;
        TransactIsolationLevel:= tiReadCommitted;
        Connected := True;
      end;

    AtualizaBancoDados(frmAtualizaDB);
    TAcaoAcesso.CriarAcoes(TfrmCadCategoria, dtmPrincipal.ConexaoDB);
    TAcaoAcesso.CriarAcoes(TfrmCadCliente, dtmPrincipal.ConexaoDB);
    TAcaoAcesso.CriarAcoes(TfrmCadProduto, dtmPrincipal.ConexaoDB);
    TAcaoAcesso.CriarAcoes(TfrmCadUsuario, dtmPrincipal.ConexaoDB);
    TAcaoAcesso.CriarAcoes(TfrmCadAcaoAcesso, dtmPrincipal.ConexaoDB);
    TAcaoAcesso.CriarAcoes(TfrmAlterarSenha, dtmPrincipal.ConexaoDB);
    TAcaoAcesso.CriarAcoes(TfrmProVenda, dtmPrincipal.ConexaoDB);
    TAcaoAcesso.CriarAcoes(TfrmRelProVendaPorData, dtmPrincipal.ConexaoDB);
    TAcaoAcesso.CriarAcoes(TfrmRelCadClienteFicha, dtmPrincipal.ConexaoDB);
    TAcaoAcesso.CriarAcoes(TfrmRelCadCliente, dtmPrincipal.ConexaoDB);
    TAcaoAcesso.CriarAcoes(TfrmRelCadProdutoComGrupoCategoria, dtmPrincipal.ConexaoDB);
    TAcaoAcesso.CriarAcoes(TfrmRelCadProduto, dtmPrincipal.ConexaoDB);
    TAcaoAcesso.CriarAcoes(TfrmRelCadCategoria, dtmPrincipal.ConexaoDB);
    frmAtualizaDB.Free;
    TeclaEnter:= TMREnter.Create(Self);
    TeclaEnter.FocusEnabled := True;
    TeclaEnter.FocusColor := clInfoBk;
  end;
end;

procedure TfrmPrincipal.FormShow(Sender: TObject);
begin
  try
    oUsuarioLogado:= TUsuarioLogado.Create;
    frmLogin:= TfrmLogin.Create(Self);
    frmLogin.ShowModal;
  finally
    frmLogin.Release;
    stbPrincipal.Panels[0].Text:='USUÁRIO: '+oUsuarioLogado.nome;
  end;
end;

procedure TfrmPrincipal.mnuFecharClick(Sender: TObject);
begin
   // Close;
   Application.Terminate;
end;

procedure TfrmPrincipal.Produto1Click(Sender: TObject);
begin
  CriarForm(TfrmCadProduto);
end;

procedure TfrmPrincipal.Produto2Click(Sender: TObject);
begin
  CriarRelatorio(TfrmRelCadProduto);
end;

procedure TfrmPrincipal.ProdutoporCategoria1Click(Sender: TObject);
begin
  CriarRelatorio(TfrmRelCadProdutoComGrupoCategoria);

end;

procedure TfrmPrincipal.Usurio1Click(Sender: TObject);
begin
  CriarForm(TfrmCadUsuario);
end;

procedure TfrmPrincipal.UsuriosVSAes1Click(Sender: TObject);
begin
  CriarForm(TfrmUsuarioVsAcoes);
end;

procedure TfrmPrincipal.Venda1Click(Sender: TObject);
begin
  CriarForm(TfrmProVenda);
end;

procedure TfrmPrincipal.VendasporData1Click(Sender: TObject);
begin
  try
    frmSelecionarData:= TfrmSelecionarData.Create(Self);
    frmSelecionarData.ShowModal;

    frmRelProVendaPorData := TfrmRelProVendaPorData.Create(Self);
    frmRelProVendaPorData.qryVendas.Close;
    frmRelProVendaPorData.qryVendas.ParamByName('DataInicio').AsDate:= frmSelecionarData.edtDataInicio.Date;
    frmRelProVendaPorData.qryVendas.ParamByName('DataFim').AsDate:= frmSelecionarData.edtDataFinal.Date;
    frmRelProVendaPorData.qryVendas.Open;
    frmRelProVendaPorData.Relatorio.PreviewModal;

  finally
    frmSelecionarData.Release;
    frmRelProVendaPorData.Release;
  end;
end;

procedure TfrmPrincipal.AlterarSenha1Click(Sender: TObject);
begin
  CriarForm(TfrmAlterarSenha);
end;

procedure TfrmPrincipal.AoAcesso1Click(Sender: TObject);
begin
  CriarForm(TfrmCadAcaoAcesso);
end;

procedure TfrmPrincipal.AtualizaBancoDados(aForm : TfrmAtualizaDB);
var oAtualizarMSSQL: TAtualizaBancoDadosMSSQL;
begin
  aForm.Refresh;

  try
    oAtualizarMSSQL:= TAtualizaBancoDadosMSSQL.Create(dtmPrincipal.ConexaoDB);
    oAtualizarMSSQL.AtualizarBancoDeDadosMSSQL;
  finally
    if Assigned(oAtualizarMSSQL) then
       FreeAndNil(oAtualizarMSSQL);
  end;
end;

procedure TfrmPrincipal.CriarForm(aNomeForm: TFormClass);
var form: TForm;
begin
  try
    form:= aNomeForm.Create(Application);
    form.ShowModal;
  finally
    if Assigned(form) then
       form.Release;
  end;
end;

procedure TfrmPrincipal.CriarRelatorio(aNomeForm: TFormClass);
var form: TForm;
    aRelatorio: TRLReport;
    i: Integer;
begin
  try
    form:= aNomeForm.Create(Application);
    for i := 0 to form.ComponentCount - 1 do
      begin
        if form.Components[i] is TRLReport then
          begin
            TRLReport(form.Components[i]).PreviewModal;
            Break
          end;
      end;
  finally
    if Assigned(form) then
       form.Release;
  end;
end;

{
  aForm.chkConexao.Checked := True;
  aForm.Refresh;
  Sleep(100);

  dtmPrincipal.qryScriptCategorias.ExecSQL;
  aForm.chkCategoria.Checked := True;
  aForm.Refresh;
  Sleep(100);

  dtmPrincipal.qryScriptProdutos.ExecSQL;
  aForm.chkProduto.Checked := True;
  aForm.Refresh;
  Sleep(100);

  dtmPrincipal.qryScriptClientes.ExecSQL;
  aForm.chkCliente.Checked := True;
  aForm.Refresh;
  Sleep(100);

  dtmPrincipal.qryScriptVendas.ExecSQL;
  aForm.chkVendas.Checked := True;
  aForm.Refresh;
  Sleep(100);

  dtmPrincipal.qryScriptItensVendas.ExecSQL;
  aForm.chkItensVenda.Checked := True;
  aForm.Refresh;
  Sleep(100);

  dtmPrincipal.qryScriptUsuarios.ExecSQL;
  aForm.chkUsuarios.Checked := True;
  aForm.Refresh;
  Sleep(500);
}



end.
