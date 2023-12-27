unit cCadCliente;

interface

uses System.Classes, Vcl.Controls, Vcl.ExtCtrls, Vcl.Dialogs, // Lista de Units
     ZAbstractConnection, ZConnection, ZAbstractRODataset, ZAbstractDataset,
     ZDataset, System.SysUtils;

type
  TCliente = class
  private
    ConexaoDB: TZConnection;
    F_clienteId: Integer;
    F_nome: String;
	  F_endereco: String;
	  F_cidade: String;
	  F_bairro: String;
	  F_estado: String;
	  F_cep: String;
	  F_telefone: String;
	  F_email: String;
	  F_dataNascimento: TDateTime;

  public
    constructor Create(aConexao: TZConnection);
    destructor Destroy; override;
    function Inserir: Boolean;
    function Atualizar: Boolean;
    function Apagar: Boolean;
    function Selecionar(id: Integer): Boolean;
  published
    property codigo        : Integer   read F_clienteId      write F_clienteId;
    property nome          : String    read F_nome           write F_nome;
    property endereco      : String    read F_endereco       write F_endereco;
    property cidade        : String    read F_cidade         write F_cidade;
    property bairro        : String    read F_bairro         write F_bairro;
    property estado        : String    read F_estado         write F_estado;
    property cep           : String    read F_cep            write F_cep;
    property telefone      : String    read F_telefone       write F_telefone;
    property email         : String    read F_email          write F_email;
    property dataNascimento: TDateTIme read F_dataNascimento write F_dataNascimento;
  end;
implementation

{$region 'Construtor e Destrutor'}
constructor TCliente.Create(aConexao: TZConnection);
begin
  ConexaoDB := aConexao;
end;

destructor TCliente.Destroy;
begin
  inherited;
end;
{$endRegion}

{$region 'CRUD'}
function TCliente.Apagar: Boolean;
var qryApagar: TZQuery;
begin
  if MessageDlg('Apagar o registro: '+#13+#13+
                'Código: '+IntToStr(F_clienteId)+#13+
                'Descrição: '+F_nome, mtConfirmation, [mbYes, mbNo], 0) = mrNo then
    begin
      Result := False;
      Abort;
    end;

    try
      Result := True;
      qryApagar := TZQuery.Create(nil);
      qryApagar.Connection := ConexaoDB;
      qryApagar.SQL.Clear;
      qryApagar.SQL.Add('DELETE FROM clientes '+
                        'WHERE clienteId =:clienteId');
      qryApagar.ParamByName('clienteId').AsInteger := F_clienteId;
      try
        ConexaoDB.StartTransaction;
        qryApagar.ExecSQL;
        ConexaoDB.Commit;
      except
        ConexaoDB.Rollback;
        Result := False;
      end;

    finally
      if Assigned(qryApagar) then
        FreeAndNil(qryApagar);
    end;
end;

function TCliente.Atualizar: Boolean;
var qryAtualizar: TZQuery;
begin
    try
      Result := True;
      qryAtualizar := TZQuery.Create(nil);
      qryAtualizar.Connection := ConexaoDB;
      qryAtualizar.SQL.Clear;
      qryAtualizar.SQL.Add('UPDATE clientes '+
                           'SET nome        =:nome, '+
                           'endereco        =:endereco, '+
                           'cidade          =:cidade, '+
                           'bairro          =:bairro, '+
                           'estado          =:estado, '+
                           'cep             =:cep, '+
                           'telefone        =:telefone, '+
                           'email           =:email, '+
                           'dataNascimento  =:dataNascimento '+
                           'WHERE clienteId =:clienteId');
      qryAtualizar.ParamByName('clienteId').AsInteger      := Self.F_clienteId;
      qryAtualizar.ParamByName('nome').AsString            := Self.F_nome;
      qryAtualizar.ParamByName('endereco').AsString        := Self.F_endereco;
      qryAtualizar.ParamByName('cidade').AsString          := Self.F_cidade;
      qryAtualizar.ParamByName('bairro').AsString          := Self.F_bairro;
      qryAtualizar.ParamByName('estado').AsString          := Self.F_bairro;
      qryAtualizar.ParamByName('cep').AsString             := Self.F_cep;
      qryAtualizar.ParamByName('telefone').AsString        := Self.F_telefone;
      qryAtualizar.ParamByName('email').AsString           := Self.F_email;
      qryAtualizar.ParamByName('dataNascimento').AsDateTime:= Self.F_dataNascimento;
    try
      ConexaoDB.StartTransaction;
      qryAtualizar.ExecSQL;
      ConexaoDB.Commit;
    except
      ConexaoDB.Rollback;
      Result := False;
    end;

    finally
      if Assigned(qryAtualizar) then
        FreeAndNil(qryAtualizar);
    end;
end;

function TCliente.Inserir: Boolean;
var qryInserir: TZQuery;
begin
    try
      Result := True;
      qryInserir := TZQuery.Create(nil);
      qryInserir.Connection := ConexaoDB;
      qryInserir.SQL.Clear;
      qryInserir.SQL.Add('INSERT INTO clientes (nome, endereco, cidade, bairro, '+
                         'estado, cep, telefone, email, dataNascimento) '+
                         'VALUES (:nome, :endereco, :cidade, :bairro, :estado, '+
                         ':cep, :telefone, :email, :dataNascimento)');
      qryInserir.ParamByName('nome').AsString            := Self.F_nome;
      qryInserir.ParamByName('endereco').AsString        := Self.F_endereco;
      qryInserir.ParamByName('cidade').AsString          := Self.F_cidade;
      qryInserir.ParamByName('bairro').AsString          := Self.F_bairro;
      qryInserir.ParamByName('estado').AsString          := Self.F_bairro;
      qryInserir.ParamByName('cep').AsString             := Self.F_cep;
      qryInserir.ParamByName('telefone').AsString        := Self.F_telefone;
      qryInserir.ParamByName('email').AsString           := Self.F_email;
      qryInserir.ParamByName('dataNascimento').AsDateTime:= Self.F_dataNascimento;
      try
        ConexaoDB.StartTransaction;
        qryInserir.ExecSQL;
        ConexaoDB.Commit;
      except
        ConexaoDB.Rollback;
        Result := False;
      end;

    finally
      if Assigned(qryInserir) then
        FreeAndNil(qryInserir);
    end;
end;

function TCliente.Selecionar(id: Integer): Boolean;
var qrySelecionar: TZQuery;
begin
    try
      Result := True;
      qrySelecionar := TZQuery.Create(nil);
      qrySelecionar.Connection := ConexaoDB;
      qrySelecionar.SQL.Clear;
      qrySelecionar.SQL.Add('SELECT * FROM clientes WHERE clienteId=:clienteId');
      qrySelecionar.ParamByName('clienteId').AsInteger := id;

      Try
        qrySelecionar.Open;

        Self.F_clienteId     := qrySelecionar.FieldByName('clienteId').AsInteger;
        Self.F_nome          := qrySelecionar.FieldByName('nome').AsString;
        Self.F_endereco      := qrySelecionar.FieldByName('endereco').AsString;
        Self.F_cidade        := qrySelecionar.FieldByName('cidade').AsString;
        Self.F_bairro        := qrySelecionar.FieldByName('bairro').AsString;
        Self.F_bairro        := qrySelecionar.FieldByName('estado').AsString;
        Self.F_cep           := qrySelecionar.FieldByName('cep').AsString;
        Self.F_telefone      := qrySelecionar.FieldByName('telefone').AsString;
        Self.F_email         := qrySelecionar.FieldByName('email').AsString;
        Self.F_dataNascimento:= qrySelecionar.FieldByName('dataNascimento').AsDateTime;

      Except
        Result := False;
      End;

    finally
      if Assigned(qrySelecionar) then
        FreeAndNil(qrySelecionar);
    end;
end;
{$endRegion}
end.
