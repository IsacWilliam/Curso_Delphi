unit cCadUsuario;

interface

uses System.Classes, Vcl.Controls, Vcl.ExtCtrls, Vcl.Dialogs, ZConnection,
     ZAbstractConnection, ZAbstractRODataset, ZAbstractDataset, ZDataset,
     System.SysUtils, uFuncaoCriptografia;

type
  TUsuario = class
  private
    ConexaoDB: TZConnection;
    F_usuarioId: Integer;
    F_nome: String;
    F_senha: String;
    function getSenha: string;
    procedure setSenha(const Value: String);
  public
    constructor Create(aConexao: TZConnection);
    destructor Destroy; override;
    function Inserir: Boolean;
    function Atualizar: Boolean;
    function Apagar: Boolean;
    function Selecionar(id: Integer): Boolean;
    function Logar(aUsuario, aSenha: String): Boolean;
  published
    property codigo: Integer read F_usuarioId write F_usuarioId;
    property nome  : String  read F_nome      write F_nome;
    property senha : String  read getSenha    write setSenha;
  end;

implementation

{$region 'Construtor e Destrutor'}
constructor TUsuario.Create(aConexao: TZConnection);
begin
  ConexaoDB:= aConexao;
end;

destructor TUsuario.Destroy;
begin
  inherited;
end;
{$endRegion}

{$region 'CRUD'}
function TUsuario.Apagar : Boolean;
var qryApagar : TZQuery;
begin
  if MessageDlg('Apagar o Registro: '+#13+#13+
                'Código: '+IntToStr(F_usuarioId)+#13+
                'Nome: '+F_nome, mtConfirmation, [mbYes, mbNo],0)=mrNo then
    begin
      Result := False;
      Abort;
    end;

  try
    Result := True;
    qryApagar := TZQuery.Create(nil);
    qryApagar.Connection := ConexaoDB;
    qryApagar.SQL.Clear;
    qryApagar.SQL.Add('DELETE FROM usuarios '+
                      'WHERE usuarioId =:usuarioId');
    qryApagar.ParamByName('usuarioId').AsInteger := F_usuarioId;
    Try
      qryApagar.ExecSQL;
    Except
      Result := False;
    End;

  finally
    if Assigned(qryApagar) then
      FreeAndNil(qryApagar);
  end;
end;

function TUsuario.Atualizar : Boolean;
var qryAtualizar : TZQuery;
begin
  try
    Result := True;
    qryAtualizar := TZQuery.Create(nil);
    qryAtualizar.Connection := ConexaoDB;
    qryAtualizar.SQL.Clear;
    qryAtualizar.SQL.Add('UPDATE usuarios SET nome =:nome, '+
                         '                   senha =:senha '+
                         ' WHERE usuarioId =:usuarioId');
    qryAtualizar.ParamByName('usuarioId').AsInteger:= Self.F_usuarioId;
    qryAtualizar.ParamByName('nome').AsString      := Self.F_nome;
    qryAtualizar.ParamByName('senha').AsString     := Self.F_senha;

    Try
      qryAtualizar.ExecSQL;
    Except
      Result := False;
    End;

  finally
    if Assigned(qryAtualizar) then
      FreeAndNil(qryAtualizar);
  end;
end;

function TUsuario.Inserir : Boolean;
var qryInserir : TZQuery;
begin
  try
    Result := True;
    qryInserir := TZQuery.Create(nil);
    qryInserir.Connection := ConexaoDB;
    qryInserir.SQL.Clear;
    qryInserir.SQL.Add('INSERT INTO usuarios (nome , senha) '+
                       'VALUES (:nome , :senha)');
    qryInserir.ParamByName('nome').AsString         := Self.F_nome;
    qryInserir.ParamByName('senha').AsString    := Self.F_senha;

    Try
      qryInserir.ExecSQL;
    Except
      Result := False;
    End;

  finally
    if Assigned(qryInserir) then
      FreeAndNil(qryInserir);
  end;
end;

function TUsuario.Selecionar(id: Integer): Boolean;
var qrySelecionar : TZQuery;
begin
  try
    Result := True;
    qrySelecionar := TZQuery.Create(nil);
    qrySelecionar.Connection := ConexaoDB;
    qrySelecionar.SQL.Clear;
    qrySelecionar.SQL.Add('SELECT usuarioId, nome, senha '+
                          '  FROM usuarios WHERE usuarioId =:usuarioId');
    qrySelecionar.ParamByName('usuarioId').AsInteger   := id;
    Try
      qrySelecionar.Open;

      Self.F_usuarioId   := qrySelecionar.FieldByName('usuarioId').AsInteger;
      Self.F_nome        := qrySelecionar.FieldByName('nome').AsString;
      Self.F_senha       := qrySelecionar.FieldByName('senha').AsString;

    Except
      Result := False
    End;

  finally
    if Assigned(qrySelecionar) then
      FreeAndNil(qrySelecionar);
  end;
end;
{$endRegion}

{$region 'GET e SET'}
function TUsuario.getSenha: String;
begin
  Result:= Descriptografar(Self.F_senha);
end;

procedure TUsuario.setSenha(const Value: string);
begin
  Self.F_senha:= Criptografar(Value);
end;
{$endRegion}

{$region 'LOGIN'}
function TUsuario.Logar(aUsuario: String; aSenha:String): Boolean;
var qryLogar: TZQuery;
begin
  try
    qryLogar:= TZQuery.Create(nil);
    qryLogar.Connection:= ConexaoDB;
    qryLogar.SQL.Clear;
    qryLogar.SQL.Add('SELECT COUNT (usuarioId) AS Qtde FROM usuarios '+
                     ' WHERE nome=:nome AND senha=:Senha');
    qryLogar.ParamByName('nome').AsString:= aUsuario;
    qryLogar.ParamByName('senha').AsString:= Criptografar(aSenha);
    Try
      qryLogar.Open;
      if qryLogar.FieldByName('Qtde').AsInteger > 0 then
        Result:= True
      else Result:= False;
    Except
      Result:= False;
    end;

  finally
    if Assigned(qryLogar) then
      FreeAndNil(qryLogar);
  end;
end;
{$endRegion}
end.
