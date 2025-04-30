object FPesquisa: TFPesquisa
  Left = 0
  Top = 0
  BorderStyle = bsNone
  ClientHeight = 338
  ClientWidth = 682
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poDesktopCenter
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object PanelTop: TPanel
    Left = 0
    Top = 0
    Width = 682
    Height = 65
    Align = alTop
    TabOrder = 0
    object Label1: TLabel
      Left = 8
      Top = 35
      Width = 61
      Height = 13
      Caption = 'Pesquisa por'
    end
    object lblPesquisa: TLabel
      Left = 1
      Top = 1
      Width = 680
      Height = 21
      Align = alTop
      Alignment = taCenter
      Caption = 'Pesquisa'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'Segoe UI'
      Font.Style = [fsBold]
      ParentFont = False
      ExplicitWidth = 67
    end
    object btnPesquisar: TButton
      Left = 535
      Top = 30
      Width = 120
      Height = 25
      Caption = 'Pesquisar'
      TabOrder = 0
      OnClick = btnPesquisarClick
    end
    object EditPesquisa: TEdit
      Left = 167
      Top = 32
      Width = 362
      Height = 21
      CharCase = ecUpperCase
      TabOrder = 1
    end
    object cbxOpcao: TComboBox
      Left = 75
      Top = 32
      Width = 86
      Height = 21
      ItemIndex = 0
      TabOrder = 2
      Text = 'C'#243'digo'
      Items.Strings = (
        'C'#243'digo'
        'Nome')
    end
  end
  object PanelGrid: TPanel
    Left = 0
    Top = 65
    Width = 682
    Height = 233
    Align = alClient
    TabOrder = 1
    object GridPesquisa: TDBGrid
      Left = 1
      Top = 1
      Width = 680
      Height = 231
      Align = alClient
      DataSource = DataSourcePesquisa
      Options = [dgTitles, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
      TabOrder = 0
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -11
      TitleFont.Name = 'Tahoma'
      TitleFont.Style = []
      OnDblClick = GridPesquisaDblClick
    end
  end
  object PanelBottom: TPanel
    Left = 0
    Top = 298
    Width = 682
    Height = 40
    Align = alBottom
    TabOrder = 2
    object btnSelecionar: TButton
      Left = 75
      Top = 6
      Width = 120
      Height = 25
      Caption = 'Selecionar'
      TabOrder = 0
      OnClick = btnSelecionarClick
    end
    object btnFechar: TButton
      Left = 535
      Top = 6
      Width = 120
      Height = 25
      Caption = 'Fechar'
      TabOrder = 1
      OnClick = btnFecharClick
    end
  end
  object DataSourcePesquisa: TDataSource
    Left = 328
    Top = 152
  end
end
