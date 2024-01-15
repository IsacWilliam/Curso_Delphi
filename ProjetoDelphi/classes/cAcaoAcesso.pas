unit cAcaoAcesso;

interface

uses System.Classes, System.SysUtils, Vcl.Controls, Vcl.ExtCtrls, Vcl.Dialogs,
     ZConnection, ZDataset, ZAbstractConnection, ZAbstractRODataset,
     ZAbstractDataset, Vcl.Forms, Vcl.Buttons;

type
  TAcaoAcesso = class
    private
      ConexaoDB: TZConnection;
      F_acaoAcessoId: Integer;
      F_descricao: String;
      F_chave: String;
    public
      constructor Create(aConexao: TZConnection);
      destructor Destroy; override;
      function Inserir: Boolean;
      function Atualizar: Boolean;
      function Apagar: Boolean;
      function Selecionar(id: Integer): Boolean;
      function ChaveExiste(aChave: String): Boolean;
    published
      property codigo   : Integer   read F_acaoAcessoId   write F_acaoAcessoId;
      property descricao: String    read F_descricao      write F_descricao;
      property chave    : String    read F_chave          write F_chave;
  end;

implementation

{ TAcaoAcesso }

function TAcaoAcesso.Apagar: Boolean;
var qryApagar: TZQuery;
begin
  if MessageDlg('Apagar o registro: '+#13+#13+
               'Código: '+F_acaoAcessoId.ToString +#13+
               'Nome: '+F_descricao, mtConfirmation, [mbYes, mbNo], 0)=mrNo then
     Result:= False;
     Abort;

  try
    Result:= True;
    qryApagar:= TZQuery.Create(nil);
    qryApagar.Connection:= ConexaoDB;
    qryApagar.SQL.Clear;
    qryApagar.SQL.Add('delete from acaoAcesso '+
                      'where acaoAcessoId=:F_acaoAcessoId;');
    qryApagar.ParamByName('acaoAcessoId').AsInteger:= F_acaoAcessoId;

    Try
      ConexaoDB.StartTransaction;
      qryApagar.ExecSQL;
      ConexaoDB.Commit;
    Except
      ConexaoDB.Rollback;
      Result:= False;
    End;

  finally
    if Assigned(qryApagar) then
       FreeAndNil(qryApagar);
  end;
end;

function TAcaoAcesso.Atualizar: Boolean;
var qryAtualizar: TZQuery;
begin
  try
    Result:= True;
    qryAtualizar:= TZQuery.Create(nil);
    qryAtualizar.Connection:= ConexaoDB;
    qryAtualizar.SQL.Clear;
    qryAtualizar.SQL.Add('update acaoAcesso '+
                         'set descricao=:descicao '+
                         'chave=:chave where acaoAcessoId=acaoAcessoId;');
    qryAtualizar.ParamByName('acaoAcessoId').AsInteger:= Self.F_acaoAcessoId;
    qryAtualizar.ParamByName('descricao').AsString:= Self.F_descricao;
    qryAtualizar.ParamByName('chave').AsString:= Self.F_chave;

    Try
      ConexaoDB.StartTransaction;
      qryAtualizar.ExecSQL;
      ConexaoDB.Commit;
    Except
      ConexaoDB.Rollback;
      Result:= False;
    End;

  finally
    if Assigned(qryAtualizar) then
       FreeAndNil(qryAtualizar);
  end;
end;

function TAcaoAcesso.ChaveExiste(aChave: String): Boolean;
var qryChaveExiste: TZQuery;
begin
  try
    qryChaveExiste:= TZQuery.Create(nil);
    qryChaveExiste.Connection:= ConexaoDB;
    qryChaveExiste.SQL.Clear;
    qryChaveExiste.SQL.Add('update acaoAcesso '+
                         'set descricao=:descicao '+
                         'chave=:chave where acaoAcessoId=acaoAcessoId;');
    qryChaveExiste.ParamByName('chave').AsString:= Self.F_chave;

    Try
      qryChaveExiste.Open;

      if qryChaveExiste.FieldByName('Qtde').AsInteger > 0 then
         Result:= True
      else
         Result:= False;

    Except
      Result:= False;
    End;

  finally
    if Assigned(qryChaveExiste) then
       FreeAndNil(qryChaveExiste);
  end;
end;

constructor TAcaoAcesso.Create(aConexao: TZConnection);
begin
  ConexaoDB:= aConexao
end;

destructor TAcaoAcesso.Destroy;
begin
  inherited;
end;

function TAcaoAcesso.Inserir: Boolean;
var qryInserir: TZQuery;
begin
  try
    Result:= True;
    qryInserir:= TZQuery.Create(nil);
    qryInserir.Connection:= ConexaoDB;
    qryInserir.SQL.Clear;
    qryInserir.SQL.Add('insert into acaoAcesso(descricao, chave) '+
                       'values (:descicao, :chave);');
    qryInserir.ParamByName('descricao').AsString:= Self.F_descricao;
    qryInserir.ParamByName('chave').AsString:= Self.F_chave;

    Try
      ConexaoDB.StartTransaction;
      qryInserir.ExecSQL;
      ConexaoDB.Commit;
    Except
      ConexaoDB.Rollback;
      Result:= False;
    End;

  finally
    if Assigned(qryInserir) then
       FreeAndNil(qryInserir);
  end;
end;

function TAcaoAcesso.Selecionar(id: Integer): Boolean;
var qrySelecionar: TZQuery;
begin
  try
    Result:= True;
    qrySelecionar:= TZQuery.Create(nil);
    qrySelecionar.Connection:= ConexaoDB;
    qrySelecionar.SQL.Clear;
    qrySelecionar.SQL.Add('select acaoAcessoId, descricao, chave '+
                          'from acaoAcesso where acaoAcessoId=:acaoAcessoId;');
    qrySelecionar.ParamByName('acaoAcessoId').AsInteger:= id;

    Try
      qrySelecionar.Open;

      Self.F_acaoAcessoId:= qrySelecionar.FieldByName('acaoAcessoId').AsInteger;
      Self.F_descricao   := qrySelecionar.FieldByName('descricao').AsString;
      Self.F_chave       := qrySelecionar.FieldByName('chave').AsString;
    Except
      Result:= False;
    End;

  finally
    if Assigned(qrySelecionar) then
       FreeAndNil(qrySelecionar);
  end;
end;

end.
