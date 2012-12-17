object Form3: TForm3
  Left = 570
  Top = 319
  BorderStyle = bsNone
  Caption = 'Form3'
  ClientHeight = 197
  ClientWidth = 165
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnHide = FormHide
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 165
    Height = 197
    Align = alClient
    Caption = 'Panel1'
    ParentColor = True
    TabOrder = 0
    object Gauge1: TGauge
      Left = 1
      Top = 1
      Width = 163
      Height = 163
      BorderStyle = bsNone
      ForeColor = clGreen
      Kind = gkPie
      MaxValue = 20
      Progress = 20
      ShowText = False
    end
    object Label1: TLabel
      Left = 13
      Top = 165
      Width = 140
      Height = 24
      Caption = #1048#1085#1080#1094#1080#1072#1083#1080#1079#1072#1094#1080#1103
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -19
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
  end
  object Timer1: TTimer
    Enabled = False
    Interval = 25
    OnTimer = Timer1Timer
    Left = 64
    Top = 64
  end
end
