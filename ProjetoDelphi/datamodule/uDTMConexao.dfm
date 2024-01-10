object dtmPrincipal: TdtmPrincipal
  OldCreateOrder = False
  Height = 115
  Width = 164
  object ConexaoDB: TZConnection
    ControlsCodePage = cCP_UTF16
    AutoEncodeStrings = True
    Catalog = ''
    Properties.Strings = (
      'controls_cp=CP_UTF16'
      'AutoEncodeStrings=True')
    TransactIsolationLevel = tiReadCommitted
    HostName = '.\SERVERCURSO'
    Port = 0
    Database = 'dbVendaTeste'
    User = 'sa'
    Password = 'delphi@2023'
    Protocol = 'mssql'
    LibraryLocation = 'E:\Cursos\Curso_Delphi\ProjetoDelphi\ntwdblib.dll'
    Left = 24
    Top = 12
  end
end
