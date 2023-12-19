unit uFuncaoCriptografia;

interface

uses Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
     System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs;

function Criptografar(const aEntrada: String): String;
function Descriptografar(const aEntrada: String): String;

implementation

function Criptografar(const aEntrada: String): String;
var i, iQtdeEnt, iIntervalo: Integer;
    sSaida, sProximoCaracter: String;
begin
  iIntervalo:= 6;
  i         := 0;
  iQtdeEnt  := 0;
  if (aEntrada <>  EmptyStr) then
    begin
      iQtdeEnt := Length(aEntrada);
      ShowMessage(IntToStr(iQtdeEnt));
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
    sSaida, sProximoCaracter: String;
begin
  iIntervalo:= 6;
  i         := 0;
  iQtdeEnt  := 0;
  if (aEntrada <>  EmptyStr) then
    begin
      iQtdeEnt := Length(aEntrada);
      ShowMessage(IntToStr(iQtdeEnt));
      for i := iQtdeEnt downto 1 do //Faça o Loop contrário
        begin
          sProximoCaracter := Copy(aEntrada, i, 1);
          sSaida := sSaida + (char(ord(sProximoCaracter[1]) - iIntervalo));
        end;
    end;
    Result := sSaida;
end;

end.
