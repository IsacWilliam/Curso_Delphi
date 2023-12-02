unit uCadCategoria;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, uTelaHeranca, Data.DB,
  ZAbstractRODataset, ZAbstractDataset, ZDataset, Vcl.DBCtrls, Vcl.Grids,
  Vcl.DBGrids, Vcl.StdCtrls, Vcl.Buttons, Vcl.Mask, Vcl.ExtCtrls, Vcl.ComCtrls;

type
  TfrmCadCategoria = class(TfrmTelaHeranca)
    edtCategoriaId: TLabeledEdit;
    edtDescricao: TLabeledEdit;
    qryListagemcategoriaId: TIntegerField;
    qryListagemdescricao: TWideStringField;
    procedure FormCreate(Sender: TObject);
    procedure btnGravarClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmCadCategoria: TfrmCadCategoria;

implementation

{$R *.dfm}

procedure TfrmCadCategoria.btnGravarClick(Sender: TObject);
begin
  if (edtDescricao.Text = EmptyStr) then
    begin
      ShowMessage('Campo obrigátorio!');
      edtDescricao.SetFocus;
      Abort;
    end;

  inherited;

end;

procedure TfrmCadCategoria.FormCreate(Sender: TObject);
begin
  inherited;
  IndiceAtual := 'descricao';
end;

end.
