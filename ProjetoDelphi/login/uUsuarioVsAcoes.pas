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
    DBGrid1: TDBGrid;
    DBGrid2: TDBGrid;
    qryUsuario: TZQuery;
    qryAcoes: TZQuery;
    dtsUsuario: TDataSource;
    dtsAcoes: TDataSource;
    qryUsuariousuarioId: TIntegerField;
    qryUsuarionome: TWideStringField;
    qryAcoesusuarioId: TIntegerField;
    qryAcoesacaoAcessoId: TIntegerField;
    qryAcoesdescricao: TWideStringField;
    qryAcoesativo: TBooleanField;
    btnFechar: TBitBtn;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmUsuarioVsAcoes: TfrmUsuarioVsAcoes;

implementation

{$R *.dfm}

uses uDTMConexao, uPrincipal;

end.
