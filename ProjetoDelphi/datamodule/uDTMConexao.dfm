object dtmPrincipal: TdtmPrincipal
  OldCreateOrder = False
  Height = 150
  Width = 215
  object ConexaoDB: TZConnection
    ControlsCodePage = cCP_UTF16
    AutoEncodeStrings = True
    Catalog = ''
    Properties.Strings = (
      'controls_cp=CP_UTF16'
      'AutoEncodeStrings=True')
    Connected = True
    HostName = '.\SERVERCURSO'
    Port = 0
    Database = 'vendas'
    User = 'sa'
    Password = 'delphi@2023'
    Protocol = 'mssql'
    LibraryLocation = 'E:\Cursos\Curso_Delphi\ProjetoDelphi\ntwdblib.dll'
    Left = 80
    Top = 32
  end
end
