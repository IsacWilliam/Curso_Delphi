unit uSelecionarData;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  Vcl.StdCtrls, Vcl.Mask, RxToolEdit, Vcl.Buttons, System.DateUtils;

type
  TfrmSelecionarData = class(TForm)
    Label3: TLabel;
    edtDataInicio: TDateEdit;
    Label1: TLabel;
    edtDataFinal: TDateEdit;
    BitBtn1: TBitBtn;
    procedure BitBtn1Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmSelecionarData: TfrmSelecionarData;

implementation

{$R *.dfm}

procedure TfrmSelecionarData.BitBtn1Click(Sender: TObject);
begin
  if (edtDataFinal.Date) < (edtDataInicio.Date) then
    begin
      MessageDlg('Data Final n�o pode ser maior que a Data de In�cio', mtInformation, [mbOK], 0);
      edtDataFinal.SetFocus;
      Abort;
    end;

  if (edtDataFinal.Date = 0) or (edtDataInicio.Date = 0) then
    begin
      MessageDlg('Data de In�cio e Data Final s�o campos obrigat�rios', mtInformation, [mbOK], 0);
      edtDataInicio.SetFocus;
      Abort;
    end;
  Close;
end;
procedure TfrmSelecionarData.FormShow(Sender: TObject);
begin
  edtDataInicio.Date := StartOfTheMonth(Date);
  edtDataFinal.Date  := EndOfTheMonth(Date);
end;

end.

