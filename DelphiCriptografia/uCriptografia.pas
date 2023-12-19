unit uCriptografia;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls;

type
  TfrmCriptografia = class(TForm)
    Button1: TButton;
    edtCriptografia: TEdit;
    edtDesCriptografia: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmCriptografia: TfrmCriptografia;

implementation

{$R *.dfm}

function Criptografar(const aEntrada: String): String;
var i, iQtdeEnt, iIntervalo: Integer;
    sSaida: String;
    sProximoCaracter: String;
begin
  iIntervalo:= 6;
  i         := 0;
  iQtdeEnt  := 0;
  if (aEntrada <>  EmptyStr) then
    begin
      iQtdeEnt := Length(aEntrada);
      for i := iQtdeEnt downto 1 do //Faça o Loop contrário
        begin
          sProximoCaracter := Copy(aEntrada, i, 1);
          sSaida := sSaida + (char(ord(sProximoCaracter[1]) + iIntervalo));
        end;
    end;
    Result := sSaida;
end;

function Descriptografar(const aEntrada: String): String;
var i, iQtdeEnt, iIntervalo: Integer;
    sSaida: String;
    sProximoCaracter: String;
begin
  iIntervalo:= 6;
  i         := 0;
  iQtdeEnt  := 0;
  if (aEntrada <>  EmptyStr) then
    begin
      iQtdeEnt := Length(aEntrada);
      for i := iQtdeEnt downto 1 do //Faça o Loop contrário
        begin
          sProximoCaracter := Copy(aEntrada, i, 1);
          sSaida := sSaida + (char(ord(sProximoCaracter[1]) - iIntervalo));
        end;
    end;
    Result := sSaida;
end;

procedure TfrmCriptografia.Button1Click(Sender: TObject);
begin
   edtCriptografia.Text    := edtCriptografia.Text;
   edtDesCriptografia.Text := Criptografar(edtCriptografia.Text);
end;
end.

