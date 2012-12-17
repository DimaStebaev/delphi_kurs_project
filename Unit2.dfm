object Form2: TForm2
  Left = 457
  Top = 283
  BorderStyle = bsDialog
  Caption = #1053#1086#1074#1099#1081' '#1088#1072#1089#1095#1105#1090
  ClientHeight = 281
  ClientWidth = 297
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  PixelsPerInch = 96
  TextHeight = 13
  object GroupBox1: TGroupBox
    Left = 8
    Top = 8
    Width = 281
    Height = 97
    Caption = #1055#1072#1088#1072#1084#1077#1090#1088#1099' '#1089#1083#1091#1095#1072#1081#1085#1086#1081' '#1074#1077#1083#1080#1095#1080#1085#1099
    TabOrder = 0
    object Label1: TLabel
      Left = 115
      Top = 28
      Width = 76
      Height = 13
      Caption = #1052#1072#1090'. '#1086#1078#1080#1076#1072#1085#1080#1077
    end
    object Label2: TLabel
      Left = 10
      Top = 60
      Width = 181
      Height = 13
      Caption = #1057#1088#1077#1076#1085#1077#1082#1074#1072#1076#1088#1072#1090#1080#1095#1077#1089#1082#1086#1077' '#1086#1090#1082#1083#1086#1085#1077#1085#1080#1077
    end
    object EditM: TEdit
      Left = 200
      Top = 24
      Width = 65
      Height = 21
      TabOrder = 0
      Text = '0'
      OnChange = EditMChange
    end
    object EditS: TEdit
      Left = 200
      Top = 56
      Width = 65
      Height = 21
      TabOrder = 1
      Text = '1'
      OnChange = EditMChange
    end
  end
  object ButtonGenerate: TButton
    Left = 8
    Top = 248
    Width = 281
    Height = 25
    Caption = #1057#1075#1077#1085#1077#1088#1080#1088#1086#1074#1072#1090#1100
    TabOrder = 1
    OnClick = ButtonGenerateClick
  end
  object GroupBox2: TGroupBox
    Left = 8
    Top = 112
    Width = 281
    Height = 129
    Caption = #1055#1072#1088#1072#1084#1077#1090#1088#1099' '#1075#1077#1085#1077#1088#1072#1090#1086#1088#1072
    TabOrder = 2
    object Label3: TLabel
      Left = 108
      Top = 100
      Width = 82
      Height = 13
      Caption = #1054#1073#1098#1105#1084' '#1074#1099#1073#1086#1088#1082#1080
    end
    object EditAmount: TEdit
      Left = 200
      Top = 96
      Width = 65
      Height = 21
      TabOrder = 0
      Text = '10000'
      OnChange = EditAmountChange
    end
    object CheckBoxInv: TCheckBox
      Left = 24
      Top = 24
      Width = 241
      Height = 17
      Caption = #1052#1077#1090#1086#1076' '#1086#1073#1088#1072#1090#1085#1086#1081' '#1092#1091#1085#1082#1094#1080#1080
      Checked = True
      State = cbChecked
      TabOrder = 1
    end
    object CheckBoxNeimon: TCheckBox
      Left = 24
      Top = 48
      Width = 241
      Height = 17
      Caption = #1052#1077#1090#1086#1076' '#1053#1077#1081#1084#1072#1085#1072
      Checked = True
      State = cbChecked
      TabOrder = 2
    end
    object CheckBoxProcess: TCheckBox
      Left = 24
      Top = 72
      Width = 241
      Height = 17
      Caption = #1052#1077#1090#1086#1076' '#1084#1086#1076#1077#1083#1080#1088#1086#1074#1072#1085#1080#1103' '#1087#1088#1086#1094#1077#1089#1089#1072
      Checked = True
      State = cbChecked
      TabOrder = 3
    end
  end
  object XPManifest1: TXPManifest
    Left = 8
    Top = 248
  end
end
