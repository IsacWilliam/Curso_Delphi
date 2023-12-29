unit cAtualizacaoBancoDeDados;

interface

uses System.Classes, System.SysUtils, Vcl.Controls, Vcl.ExtCtrls, Vcl.Dialogs,
     Data.DB, ZConnection, ZDataset, ZAbstractConnection, ZAbstractRODataset,
     ZAbstractDataset;

{$region 'TYPES'}
Type
  TAtualizaBancoDados = class
  private
  public
    ConexaoDB: TZConnection;
    constructor Create(aConexao: TZConnection);
    procedure ExecutaDiretoBancoDeDados(aScript: String);
End;

Type
  TAtualizaBancoDadosMSSQL = class
  private
    ConexaoDB: TZConnection;
  public
    function AtualizarBancoDeDadosMSSQL: Boolean;
    constructor Create(aConexao: TZConnection);
End;
{$endRegion}

implementation

uses cAtualizacaoTabelaMSSQL;

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
function TAtualizaBancoDadosMSSQL.AtualizarBancoDeDadosMSSQL: Boolean;
var oAtualizarDB: TAtualizaBancoDados;
    oTabela: TAtualizacaoTabelaMSSQL;
begin
  Try
    // Classe Principal de Atualização
    oAtualizarDB:= TAtualizaBancoDados.Create(ConexaoDB);

    // Classe Filha(Herança) de Atualização
    oTabela:= TAtualizacaoTabelaMSSQL.Create(ConexaoDB);
  Finally
    if Assigned(oAtualizarDB) then
       FreeAndNil(oAtualizarDB);

    if Assigned(oTabela) then
       FreeAndNil(oTabela);
  End;
end;

constructor TAtualizaBancoDadosMSSQL.Create(aConexao: TZConnection);
begin
  ConexaoDB:= aConexao;
end;

end.
