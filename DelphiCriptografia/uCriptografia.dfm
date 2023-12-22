object frmCriptografia: TfrmCriptografia
  Left = 0
  Top = 0
  Caption = 'Tela Criptografia'
  ClientHeight = 115
  ClientWidth = 286
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 24
    Top = 8
    Width = 78
    Height = 13
    Caption = 'Sem criptografia'
  end
  object Label2: TLabel
    Left = 24
    Top = 67
    Width = 67
    Height = 13
    Caption = 'Criptografado'
  end
  object Button1: TButton
    Left = 160
    Top = 55
    Width = 75
    Height = 25
    Caption = 'Executar'
    TabOrder = 0
    OnClick = Button1Click
  end
  object edtCriptografia: TEdit
    Left = 24
    Top = 27
    Width = 121
    Height = 21
    TabOrder = 1
  end
  object edtDesCriptografia: TEdit
    Left = 24
    Top = 86
    Width = 121
    Height = 21
    TabOrder = 2
  end
end
