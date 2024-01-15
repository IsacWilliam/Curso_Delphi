unit cAtualizacaoCampoMSSQL;

interface

uses System.Classes, System.SysUtils, Vcl.Controls, Vcl.ExtCtrls, Vcl.Dialogs,
     ZConnection, ZDataset, ZAbstractConnection, ZAbstractRODataset,
     ZAbstractDataset, cAtualizacaoBancoDeDados;

type
    TAtualizacaoCampoMSSQL = class(TAtualizaBancoDados)

    private
      function CampoExisteNaTabela(aNomeTabela, aCampo: String): Boolean;
      procedure Versao1;
    protected

    public
      constructor Create(aConexao: TZConnection);
      destructor Destroy; override;
  end;

implementation

{ TAtualizacaoCampoMSSQL }

function TAtualizacaoCampoMSSQL.CampoExisteNaTabela(aNomeTabela,
  aCampo: String): Boolean;
var qryCampoExisteNaTabela: TZQuery;
begin
  Try
    Result:= False;
    qryCampoExisteNaTabela:=TZQuery.Create(nil);
    qryCampoExisteNaTabela.Connection:= ConexaoDB;
    qryCampoExisteNaTabela.SQL.Clear;
    qryCampoExisteNaTabela.SQL.Add('SELECT COUNT(COLUMN_NAME) AS Qtde ');
    qryCampoExisteNaTabela.SQL.Add('FROM INFORMATION_SCHEMA.COLUMNS ');
    qryCampoExisteNaTabela.SQL.Add('WHERE TABLE_NAME =:Tabela ');
    qryCampoExisteNaTabela.SQL.Add('AND COLUMN_NAME =:Campo');
    qryCampoExisteNaTabela.ParamByName('Tabela').AsString:= aNomeTabela;
    qryCampoExisteNaTabela.ParamByName('Campo').AsString := aCampo;
    qryCampoExisteNaTabela.Open;

    if qryCampoExisteNaTabela.FieldByName('Qtde').AsInteger > 0 then
      Result:= True;
  Finally
    qryCampoExisteNaTabela.Close;
    if Assigned(qryCampoExisteNaTabela) then
      FreeAndNil(qryCampoExisteNaTabela);
  End;
end;

constructor TAtualizacaoCampoMSSQL.Create(aConexao: TZConnection);
begin
  ConexaoDB:= aConexao;
  Versao1;
end;

destructor TAtualizacaoCampoMSSQL.Destroy;
begin

  inherited;
end;

procedure TAtualizacaoCampoMSSQL.Versao1;
begin
  if not CampoExisteNaTabela('Categorias', 'teste') then
    begin
      ExecutaDiretoBancoDeDados('ALTER TABLE Categorias ADD teste VARCHAR(30) NULL');
    end;

  if CampoExisteNaTabela('Categorias', 'teste') then
    begin
      ExecutaDiretoBancoDeDados('ALTER TABLE Categorias DROP COLUMN teste');
    end;
end;

end.
