object APalavra: TAPalavra
  Left = 0
  Top = 0
  Caption = 'Players'
  ClientHeight = 181
  ClientWidth = 505
  Color = clWhite
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnActivate = FormActivate
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 505
    Height = 181
    Align = alClient
    BevelOuter = bvNone
    TabOrder = 0
    object Label1: TLabel
      Left = 104
      Top = 48
      Width = 39
      Height = 13
      Caption = 'Player 1'
    end
    object Label2: TLabel
      Left = 368
      Top = 48
      Width = 39
      Height = 13
      Caption = 'Player 2'
    end
    object btnConfirm: TButton
      Left = 216
      Top = 144
      Width = 75
      Height = 25
      Caption = 'Confirmar'
      TabOrder = 0
      OnClick = btnConfirmClick
    end
    object Edit1: TEdit
      Left = 32
      Top = 64
      Width = 201
      Height = 21
      TabOrder = 1
    end
    object Edit2: TEdit
      Left = 288
      Top = 64
      Width = 201
      Height = 21
      TabOrder = 2
    end
  end
end
