unit uLogin;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Buttons;

type
  TfrmLogin = class(TForm)
    btnFechar: TBitBtn;
    btnAcessar: TBitBtn;
    Label1: TLabel;
    Label2: TLabel;
    edtUsuario: TEdit;
    edtSenha: TEdit;
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure FormShow(Sender: TObject);
    procedure btnFecharClick(Sender: TObject);
    procedure btnAcessarClick(Sender: TObject);
  private
    { Private declarations }
    bFechar: Boolean;
    procedure FecharAplicacao;
    procedure FecharFormulario;
  public
    { Public declarations }
  end;

var
  frmLogin: TfrmLogin;

implementation

uses cCadUsuario, uDTMConexao, uPrincipal;

{$R *.dfm}

procedure TfrmLogin.btnAcessarClick(Sender: TObject);
var oUsuario: TUsuario;
begin
  Try
    oUsuario:= TUsuario.Create(dtmPrincipal.ConexaoDB);
    if oUsuario.Logar(edtUsuario.Text, edtSenha.Text) then
      begin
        oUsuarioLogado.codigo := oUsuario.codigo;
        oUsuarioLogado.nome   := oUsuario.nome;
        oUsuarioLogado.senha  := oUsuario.senha;
        FecharFormulario;  //  Fecha o formulário de Login
      end
    else
      begin
        MessageDlg('Usuário Inválido', mtInformation, [mbOK], 0);
        edtUsuario.SetFocus;
      end;
  Finally
    if Assigned(oUsuario) then
      FreeAndNil(oUsuario);
  End;
end;

procedure TfrmLogin.FecharAplicacao;
begin
  bFechar := True;
  Application.Terminate;
end;

procedure TfrmLogin.FecharFormulario;
begin
  bFechar := True;
  Close;
end;

procedure TfrmLogin.btnFecharClick(Sender: TObject);
begin
  FecharAplicacao;  // Encerra a Aplicação
end;

procedure TfrmLogin.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  CanClose:= bFechar;
end;

procedure TfrmLogin.FormShow(Sender: TObject);
begin
  bFechar:= False;
end;

end.
