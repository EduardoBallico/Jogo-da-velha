object Form1: TForm1
  Left = 0
  Top = 0
  Anchors = [akLeft, akTop, akRight, akBottom]
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'Jogo da Velha'
  ClientHeight = 456
  ClientWidth = 464
  Color = clDefault
  Font.Charset = ANSI_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Arial'
  Font.Style = [fsBold]
  OldCreateOrder = False
  Position = poDesktopCenter
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 14
  object StringGrid1: TStringGrid
    Left = 0
    Top = 0
    Width = 464
    Height = 456
    Align = alClient
    ColCount = 3
    DefaultColWidth = 150
    DefaultRowHeight = 150
    FixedColor = clWhite
    FixedCols = 0
    RowCount = 3
    FixedRows = 0
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -133
    Font.Name = 'Times New Roman'
    Font.Style = []
    ParentFont = False
    TabOrder = 0
    OnSelectCell = StringGrid1SelectCell
  end
end
