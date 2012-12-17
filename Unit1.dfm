object Form1: TForm1
  Left = 270
  Top = 115
  Width = 870
  Height = 640
  Caption = #1043#1077#1085#1077#1088#1072#1090#1086#1088' '#1089#1083#1091#1095#1072#1081#1085#1099#1093' '#1095#1080#1089#1077#1083
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  Menu = MainMenu1
  OldCreateOrder = False
  OnClose = FormClose
  OnCreate = FormCreate
  OnResize = FormResize
  PixelsPerInch = 96
  TextHeight = 13
  object Panel: TPanel
    Left = 0
    Top = 201
    Width = 862
    Height = 64
    Align = alTop
    Caption = #1047#1076#1077#1089#1100' '#1084#1086#1078#1077#1090' '#1073#1099#1090#1100' '#1074#1072#1096#1072' '#1088#1077#1082#1083#1072#1084#1072
    TabOrder = 2
    Visible = False
    object Gauge: TGauge
      Left = 760
      Top = 16
      Width = 33
      Height = 33
      BorderStyle = bsNone
      ForeColor = clGreen
      Kind = gkPie
      MaxValue = 100000
      Progress = 67
    end
    object ButtonCancel: TButton
      Left = 272
      Top = 23
      Width = 129
      Height = 25
      Caption = #1055#1088#1077#1088#1074#1072#1090#1100' '#1088#1072#1089#1095#1105#1090
      TabOrder = 0
      OnClick = ButtonCancelClick
    end
  end
  object grid: TStringGrid
    Left = 0
    Top = 265
    Width = 862
    Height = 321
    Align = alClient
    BiDiMode = bdLeftToRight
    DefaultRowHeight = 18
    FixedCols = 0
    RowCount = 2
    ParentBiDiMode = False
    TabOrder = 1
    OnClick = gridClick
  end
  object Chart: TChart
    Tag = 13
    Left = 0
    Top = 0
    Width = 862
    Height = 201
    BackWall.Brush.Color = clWhite
    BackWall.Brush.Style = bsClear
    Title.Text.Strings = (
      #1043#1080#1089#1090#1086#1075#1088#1072#1084#1084#1072' '#1095#1072#1089#1090#1086#1090)
    Legend.Visible = False
    View3D = False
    Align = alTop
    PopupMenu = PopupMenuChart
    TabOrder = 0
    object Button1: TButton
      Left = 40
      Top = 24
      Width = 75
      Height = 25
      Caption = 'Button1'
      TabOrder = 0
      OnClick = Button1Click
    end
    object Series1: TBarSeries
      Marks.ArrowLength = 20
      Marks.Visible = True
      SeriesColor = clRed
      MultiBar = mbStacked
      XValues.DateTime = False
      XValues.Name = 'X'
      XValues.Multiplier = 1.000000000000000000
      XValues.Order = loAscending
      YValues.DateTime = False
      YValues.Name = 'Bar'
      YValues.Multiplier = 1.000000000000000000
      YValues.Order = loNone
    end
  end
  object MainMenu1: TMainMenu
    Left = 40
    Top = 8
    object N1: TMenuItem
      Caption = #1060#1072#1081#1083
      object N3: TMenuItem
        Caption = #1053#1086#1074#1072#1103' '#1079#1072#1076#1072#1095#1072'...'
        OnClick = N3Click
      end
      object N5: TMenuItem
        Caption = #1054#1090#1082#1088#1099#1090#1100'...'
        OnClick = N5Click
      end
      object N4: TMenuItem
        Caption = #1057#1086#1093#1088#1072#1085#1080#1090#1100' '#1082#1072#1082'...'
        OnClick = N4Click
      end
      object N2: TMenuItem
        Caption = #1042#1099#1093#1086#1076
        OnClick = N2Click
      end
    end
    object N9: TMenuItem
      Caption = #1057#1087#1088#1072#1074#1082#1072
      object N10: TMenuItem
        Caption = #1055#1086#1084#1086#1097#1100
        OnClick = N10Click
      end
      object N11: TMenuItem
        Caption = #1054' '#1087#1088#1086#1075#1088#1072#1084#1084#1077'...'
        OnClick = N11Click
      end
    end
  end
  object XPManifest1: TXPManifest
    Left = 8
    Top = 8
  end
  object Timer1: TTimer
    Enabled = False
    Interval = 100
    OnTimer = Timer1Timer
    Left = 72
    Top = 8
  end
  object PopupMenuChart: TPopupMenu
    Left = 104
    Top = 8
    object N12: TMenuItem
      Caption = #1050#1086#1083#1080#1095#1077#1089#1090#1074#1086' '#1089#1090#1086#1083#1073#1094#1086#1074'...'
      OnClick = N12Click
    end
    object N13: TMenuItem
      Caption = '-'
    end
    object N2D1: TMenuItem
      Caption = '2D '#1074#1080#1076
      Checked = True
      OnClick = N2D1Click
    end
    object N3D1: TMenuItem
      Caption = '3D '#1074#1080#1076
      OnClick = N3D1Click
    end
    object N6: TMenuItem
      Caption = '-'
    end
    object N7: TMenuItem
      Caption = #1050#1086#1087#1080#1088#1086#1074#1072#1090#1100' '#1080#1079#1086#1073#1088#1072#1078#1077#1085#1080#1077
      OnClick = N7Click
    end
    object N8: TMenuItem
      Caption = #1050#1086#1087#1080#1088#1086#1074#1072#1090#1100' '#1088#1077#1079#1091#1083#1100#1090#1072#1090#1099
      OnClick = N8Click
    end
  end
end
