unit cAtualizacaoBancoDeDados;

interface

uses System.Classes, System.SysUtils, Vcl.Controls, Vcl.ExtCtrls, Vcl.Dialogs,
     Data.DB, ZConnection, ZDataset, ZAbstractConnection, ZAbstractRODataset,
     ZAbstractDataset;

{$region 'TYPES'}
Type
  TAtualizaBancoDados = class
  private
    ConexaoDB: TZConnection;
  public
    constructor Create(aConexao: TZConnection);
    procedure ExecutaDiretoBancoDeDados(aScript: String);
End;

Type
  TAtualizaBancoDadosMSSQL = class
  private
    ConexaoDB: TZConnection;
  public
    function AtualizaBancoDadosMSSQL: Boolean;
    constructor Create(aConexao: TZConnection);
End;
{$endRegion}

implementation

{ TAtualizaBancoDados }
constructor TAtualizaBancoDados.Create(aConexao: TZConnection);
begin
  ConexaoDB:= aConexao;
end;

procedure TAtualizaBancoDados.ExecutaDiretoBancoDeDados(aScript: String);
var qryExecutaDiretoBancoDeDados: TZQuery;
begin
  Try
    qryExecutaDiretoBancoDeDados:= TZQuery.Create(nil);
    qryExecutaDiretoBancoDeDados.Connection:= ConexaoDB;
    qryExecutaDiretoBancoDeDados.SQL.Clear;
    qryExecutaDiretoBancoDeDados.SQL.Add(aScript);
    Try
      ConexaoDB.StartTransaction;
      qryExecutaDiretoBancoDeDados.ExecSQL;
      ConexaoDB.Commit;
    Except
      ConexaoDB.Rollback;
    End;
  Finally
    qryExecutaDiretoBancoDeDados.Close;
    if Assigned(qryExecutaDiretoBancoDeDados) then
       FreeAndNil(qryExecutaDiretoBancoDeDados);
  End;
end;

{ TAtualizaBancoDadosMSSQL }
function TAtualizaBancoDadosMSSQL.AtualizaBancoDadosMSSQL: Boolean;
var oAtualizarDB: TAtualizaBancoDados;
begin
  Try
    // Classe Principal de Atualização
    oAtualizarDB:= TAtualizaBancoDados.Create(ConexaoDB);
  Finally
    if Assigned(oAtualizarDB) then
       FreeAndNil(oAtualizarDB);
  End;
end;

constructor TAtualizaBancoDadosMSSQL.Create(aConexao: TZConnection);
begin
  ConexaoDB:= aConexao;
end;

end.
