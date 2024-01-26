unit uUsuarioVsAcoes;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Data.DB,
  ZAbstractRODataset, ZAbstractDataset, ZDataset, Vcl.Grids, Vcl.DBGrids,
  Vcl.StdCtrls, Vcl.Buttons;

type
  TfrmUsuarioVsAcoes = class(TForm)
    Panel1: TPanel;
    Panel2: TPanel;
    Panel3: TPanel;
    Splitter1: TSplitter;
    grdUsuarios: TDBGrid;
    grdAcoes: TDBGrid;
    qryUsuario: TZQuery;
    qryAcoes: TZQuery;
    dtsUsuario: TDataSource;
    dtsAcoes: TDataSource;
    qryUsuariousuarioId: TIntegerField;
    qryUsuarionome: TWideStringField;
    btnFechar: TBitBtn;
    qryAcoesusuarioId: TIntegerField;
    qryAcoesacaoAcessoId: TIntegerField;
    qryAcoesdescricao: TWideStringField;
    qryAcoesativo: TBooleanField;
    procedure btnFecharClick(Sender: TObject);
    procedure qryUsuarioAfterScroll(DataSet: TDataSet);
    procedure FormShow(Sender: TObject);
    procedure grdAcoesDblClick(Sender: TObject);
  private
    { Private declarations }
    procedure SelecionarAcoesAcessoPorUsuario;
  public
    { Public declarations }
  end;

var
  frmUsuarioVsAcoes: TfrmUsuarioVsAcoes;

implementation

{$R *.dfm}

uses uDTMConexao, uPrincipal;

procedure TfrmUsuarioVsAcoes.btnFecharClick(Sender: TObject);
begin
  Close;
end;

procedure TfrmUsuarioVsAcoes.grdAcoesDblClick(Sender: TObject);
var Qry:TZQuery;
    bmRegistroAtual:TBookmark;
begin
  try
    bmRegistroAtual := QryAcoes.GetBookMark; //Marcar o Registro Selecionado
    Qry:=TZQuery.Create(nil);
    Qry.Connection:=DtmPrincipal.ConexaoDB;
    Qry.SQL.Clear;
    Qry.SQL.Add('UPDATE usuariosAcaoAcesso '+
                '   SET ativo=:ativo '+
                ' WHERE usuarioId=:usuarioId '+
                '   AND acaoAcessoId=:acaoAcessoId ');
    Qry.ParamByName('usuarioId').AsInteger    :=QryAcoes.FieldByName('usuarioId').AsInteger;
    Qry.ParamByName('acaoAcessoId').AsInteger :=QryAcoes.FieldByName('acaoAcessoId').AsInteger;
    Qry.ParamByName('ativo').AsBoolean        :=not QryAcoes.FieldByName('ativo').AsBoolean;
    Try

      DtmPrincipal.ConexaoDB.StartTransaction;
      Qry.ExecSQL;
      DtmPrincipal.ConexaoDB.Commit;
    Except
      DtmPrincipal.ConexaoDB.Rollback;
    End;

  finally
    SelecionarAcoesAcessoPorUsuario;
    QryAcoes.GotoBookMark(bmRegistroAtual);  //Faz o Retorno do Registro depois que a query foi fechada e aberta
    if Assigned(Qry) then
       FreeAndNil(Qry);
  end;
end;

procedure TfrmUsuarioVsAcoes.FormShow(Sender: TObject);
begin
  Try
    qryUsuario.DisableControls;
    qryUsuario.Open;
    SelecionarAcoesAcessoPorUsuario;
  Finally
    qryUsuario.EnableControls;
  End;
end;

procedure TfrmUsuarioVsAcoes.qryUsuarioAfterScroll(DataSet: TDataSet);
begin
  SelecionarAcoesAcessoPorUsuario;
end;

procedure TfrmUsuarioVsAcoes.SelecionarAcoesAcessoPorUsuario;
begin
  qryAcoes.Close;
  qryAcoes.ParamByName('usuarioId').AsInteger:= qryUsuario.FieldByName('usuarioId').AsInteger;
  qryAcoes.Open;
end;

end.
