unit cUsuarioLogado;

interface

uses System.Classes;

type
  TUsuarioLogado = class
  private
    F_usuarioId: Integer;
    F_nome     : String;
    F_senha    : String;
  public

  published
    property codigo: Integer read F_usuarioId write F_usuarioId;
    property nome  : String  read F_nome      write F_nome;
    property senha : String  read F_senha     write F_Senha;
  end;

implementation

end.
