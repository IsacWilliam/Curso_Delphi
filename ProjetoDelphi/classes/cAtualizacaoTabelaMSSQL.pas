unit cAtualizacaoTabelaMSSQL;

interface

uses System.Classes, System.SysUtils, Vcl.Controls, Vcl.ExtCtrls, Vcl.Dialogs,
     Data.DB, ZConnection, ZDataset, ZAbstractConnection, ZAbstractRODataset,
     ZAbstractDataset, cAtualizacaoBancoDeDados;

Type
     TAtualizacaoTabelaMSSQL = class(TAtualizaBancoDados)

     private
       function TabelaExiste(aNomeTabela: String): Boolean;
    procedure Categoria;

     protected

     public
       constructor Create(aConexao: TZConnection);
       destructor Destroy; override;
     end;

implementation

{ TAtualizacaoTabelaMSSQL }

constructor TAtualizacaoTabelaMSSQL.Create(aConexao: TZConnection);
begin
  ConexaoDB:= aConexao;
  Categoria;
end;

destructor TAtualizacaoTabelaMSSQL.Destroy;
begin

  inherited;
end;

function TAtualizacaoTabelaMSSQL.TabelaExiste(aNomeTabela: String): Boolean;
var qryTabelaExiste: TZQuery;
begin
  Try
    Result:= False;
    qryTabelaExiste:= TZQuery.Create(nil);
    qryTabelaExiste.Connection:= ConexaoDB;
    qryTabelaExiste.SQL.Clear;
    qryTabelaExiste.SQL.Add('SELECT OBJECT_ID (:NomeTabela) AS ID');
    qryTabelaExiste.ParamByName('NomeTabela').AsString:= aNomeTabela;
    qryTabelaExiste.Open;

    if qryTabelaExiste.FieldByName('ID').AsInteger > 0 then
       Result:= True;
  Finally
    qryTabelaExiste.Close;
    if Assigned(qryTabelaExiste) then
       FreeAndNil(qryTabelaExiste);
  End;
end;

procedure TAtualizacaoTabelaMSSQL.Categoria;
begin
  if not TabelaExiste('categorias') then
    begin
      ExecutaDiretoBancoDeDados(
        'create table categorias('+
          'categoriaId int identity(1,1) not null, '+
          'descricao varchar(30) null, '+
          'primary key (categoriaId));'
      );
    end;
end;

end.
