unit uPrincipal;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Menus, uDTMConexao;

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
    procedure mnuFecharClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Categoria1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmPrincipal: TfrmPrincipal;

implementation

{$R *.dfm}

uses uCadCategoria;

procedure TfrmPrincipal.Categoria1Click(Sender: TObject);
begin
  frmCadCategoria := TfrmCadCategoria.Create(Self);
  frmCadCategoria.ShowModal;
  frmCadCategoria.Release;
end;

procedure TfrmPrincipal.FormCreate(Sender: TObject);
begin
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
  dtmPrincipal := TdtmPrincipal.Create(Self);
  with dtmPrincipal.ConexaoDB do
    begin
      SQLHourGlass := True;
      Protocol := 'mssql';
      LibraryLocation := 'E:\Cursos\Curso_Delphi\ProjetoDelphi\ntwdblib.dll';
      HostName := '.\SERVERCURSO';
      Port := 1433;
      User := 'sa';
      Password := 'delphi@2023';
      Database := 'vendas';
      Connected := True;
    end;
end;

procedure TfrmPrincipal.mnuFecharClick(Sender: TObject);
begin
   // Close;
   Application.Terminate;
end;

end.
