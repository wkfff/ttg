inherited CrossManyToManyEditorForm: TCrossManyToManyEditorForm
  Left = 405
  Top = 348
  Width = 656
  Height = 287
  Icon.Data = {
    0000010002002020100000000000E80200002600000010101000000000002801
    00000E0300002800000020000000400000000100040000000000800200000000
    0000000000000000000000000000000000000000800000800000008080008000
    00008000800080800000C0C0C000808080000000FF0000FF000000FFFF00FF00
    0000FF00FF00FFFF0000FFFFFF00088888888888000000000000000000000000
    00000008000000000000000000000FFFFFFFFF08000000000000000000000FFF
    FFFFFF08000000000000000000000FFFFFFFFF08000000000000000000000777
    77777708000000000000000000000FFFFFFFFF08888880000000000000000FFF
    FFFFFF00000080000000000000000FFFFFFFFF08000080000000000000000000
    0000000800008000000000000000077777777708000080000000000000000777
    7777770000008000088888888888000000000000000080880000000000080000
    00000000000080000FFFFFFFFF08000000000000000000880FFFFFFFFF080000
    00000000000000000FFFFFFFFF08000000000000000000880777777777080000
    00000000000080000FFFFFFFFF08000000000000000000880FFFFFFFFF080888
    88888888000080000FFFFFFFFF08000000000008000080000000000000080FFF
    FFFFFF08000080000777777777080FFFFFFFFF08000080000777777777000FFF
    FFFFFF0800008000000000000000077777777708000080000000000000000FFF
    FFFFFF08888080000000000000000FFFFFFFFF00000000000000000000000FFF
    FFFFFF0800000000000000000000000000000008000000000000000000000777
    7777770800000000000000000000077777777708000000000000000000000000
    0000000000000000000000000000800FFFFF000FFFFF000FFFFF000FFFFF000F
    FFFF000FFFFF00007FFF00007FFF000E7FFF000E7FFF000E7FFF001E7800001E
    4000FFFE0000FFFE0000FFFF8000FFFFC000FFFF0000FFFE0000800E0000000E
    7000000E7000000E7001000E7001000E7FFF00007FFF0000FFFF000FFFFF000F
    FFFF000FFFFF000FFFFF001FFFFF280000001000000020000000010004000000
    0000C00000000000000000000000000000000000000000000000000080000080
    000000808000800000008000800080800000C0C0C000808080000000FF0000FF
    000000FFFF00FF000000FF00FF00FFFF0000FFFFFF0000000888888800000008
    00000008000000000FFFFF080000000807777708880000080FFFFF0008000008
    00000008080000080FFFFF080800000800000000080008088888088808880000
    0008000000080FFFFF080FFFFF0807777708077777080FFFFF080FFFFF080000
    0008000000080FFFFF080FFFFF000000000000000000F80F0000E00F0000C00F
    0000C0030000C0030000C0030000C0030000C013000080800000000000000000
    00000000000000000000000000000001000001010000}
  OldCreateOrder = True
  OnCloseQuery = FormCloseQuery
  PixelsPerInch = 96
  TextHeight = 13
  inherited tb97Show: TToolBar
    Width = 648
    TabOrder = 3
    Visible = False
    object btn97Ok: TToolButton
      Left = 23
      Top = 0
      Hint = 'Aceptar|Aceptar'
      ImageIndex = 1
      ParentShowHint = False
      ShowHint = True
      OnClick = btn97OkClick
    end
    object btn97Cancel: TToolButton
      Left = 46
      Top = 0
      Hint = 'Cancelar|Cancelar'
      ImageIndex = 2
      ParentShowHint = False
      ShowHint = True
      OnClick = btn97CancelClick
    end
  end
  inherited pnlStatus: TPanel
    Top = 241
    Width = 648
    TabOrder = 2
  end
  inherited Panel1: TPanel
    Width = 648
    Height = 216
  end
  object DrawGrid: TRxDrawGrid [3]
    Left = 0
    Top = 25
    Width = 648
    Height = 216
    Align = alClient
    ColCount = 2
    DefaultColWidth = 80
    RowCount = 2
    ParentShowHint = False
    ShowHint = True
    TabOrder = 0
    OnDrawCell = DrawGridDrawCell
    OnSelectCell = DrawGridSelectCell
    IniStorage = FormStorage
    RowHeights = (
      18
      18)
  end
  inherited FormStorage: TFormStorage
    Left = 120
  end
  inherited ImageList: TImageList
    Bitmap = {
      494C010103000400040010001000FFFFFFFFFF10FFFFFFFFFFFFFFFF424D3600
      0000000000003600000028000000400000001000000001002000000000000010
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000008000000080000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      FF00000080000000800080808000000000000000000000000000000000000000
      00000000FF008080800000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000800000000080000000800000800000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      FF00000080000000800000008000808080000000000000000000000000000000
      FF00000080000000800080808000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000008000
      0000008000000080000000800000008000008000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      FF000000800000008000000080000000800080808000000000000000FF000000
      8000000080000000800000008000808080000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF000000
      0000000000000000000000000000000000000000000000000000800000000080
      0000008000000080000000800000008000000080000080000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000FF000000800000008000000080000000800080808000000080000000
      8000000080000000800000008000808080000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF000000000080808000C0C0C000C0C0C0008080
      8000808080000000000000000000000000000000000080000000008000000080
      00000080000000FF000000800000008000000080000000800000800000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000FF0000008000000080000000800000008000000080000000
      8000000080000000800080808000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000FFFFFF00FFFF
      FF00FFFFFF00FFFFFF000000000080808000C0C0C000C0C0C000FFFF00008080
      8000000000000000000000000000000000000000000000800000008000000080
      000000FF00000000000000FF0000008000000080000000800000800000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000FF00000080000000800000008000000080000000
      8000000080008080800000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000FFFFFF00FFFF
      FF00FFFFFF00FFFFFF0000000000C0C0C000C0C0C000C0C0C000C0C0C0008080
      8000000000000000000000000000000000000000000000FF00000080000000FF
      000000000000000000000000000000FF00000080000000800000008000008000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000080000000800000008000000080000000
      8000808080000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000FFFFFF00FFFF
      FF00FFFFFF00FFFFFF0000000000C0C0C000FFFF0000C0C0C000C0C0C0008080
      800000000000000000000000000000000000000000000000000000FF00000000
      00000000000000000000000000000000000000FF000000800000008000000080
      0000800000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000FF000000800000008000000080000000
      8000808080000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000FFFFFF00FFFF
      FF00FFFFFF00FFFFFF000000000080808000FFFF0000FFFF0000C0C0C0008080
      8000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000FF0000008000000080
      0000008000008000000000000000000000000000000000000000000000000000
      000000000000000000000000FF00000080000000800000008000000080000000
      8000808080000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF000000000080808000C0C0C000C0C0C0008080
      8000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000FF00000080
      0000008000000080000080000000000000000000000000000000000000000000
      0000000000000000FF0000008000000080000000800080808000000080000000
      8000000080008080800000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000000000000000FF
      0000008000000080000000800000800000000000000000000000000000000000
      00000000FF0000008000000080000000800080808000000000000000FF000000
      8000000080000000800080808000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000FF00000080000000800000008000000000000000000000000000000000
      00000000FF000000800000008000808080000000000000000000000000000000
      FF00000080000000800000008000808080000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF0000000000C0C0C000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000FF000000800000008000000000000000000000000000000000
      0000000000000000FF0000008000000000000000000000000000000000000000
      00000000FF000000800000008000000080000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000FF0000008000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000FF00000080000000FF000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000FF00000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000424D3E000000000000003E000000
      2800000040000000100000000100010000000000800000000000000000000000
      000000000000000000000000FFFFFF00FFFFF9FFE1F30000FFFFF0FFE0E10000
      8009E07FE04000008001C03FF00000008007801FF80100008007841FFC030000
      80078E0FFE0700008007DF07FE0700008007FF83FC070000800FFFC1F8030000
      800FFFE0F0410000800FFFF0F0E00000801FFFF8F9F00000803FFFFCFFF80000
      C07FFFFEFFFF0000FFFFFFFFFFFF000000000000000000000000000000000000
      000000000000}
  end
end
