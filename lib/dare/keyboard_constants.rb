module Dare

  # These are the corresponding character keycodes for keyboard presses
  # e.g.
  # if button_down? Dare::KbDown
  #   player.crouch #or something
  # end
  #
  # for convenience, you can "include Dare::Kb" at the top
  # of your main app file (after require 'dare'), and then
  # refer to these constants directly
  # e.g.
  # if button_down? KbI
  #   open_inventory
  # end
  #

  Kb0 = 48
  Kb1 = 49
  Kb2 = 50
  Kb3 = 51
  Kb4 = 52
  Kb5 = 53
  Kb6 = 54
  Kb7 = 55
  Kb8 = 56
  Kb9 = 57
  KbA = 65
  KbB = 66
  KbC = 67
  KbD = 68
  KbE = 69
  KbF = 70
  KbG = 71
  KbH = 72
  KbI = 73
  KbJ = 74
  KbK = 75
  KbL = 76
  KbM = 77
  KbN = 78
  KbO = 79
  KbP = 80
  KbQ = 81
  KbR = 82
  KbS = 83
  KbT = 84
  KbU = 85
  KbV = 86
  KbW = 87
  KbX = 88
  KbY = 89
  KbZ = 90
  KbBackspace = 8
  KbDelete = 46
  KbDown = 40
  KbEnd = 35
  KbEnter = 13
  KbReturn = 13
  KbEscape = 27
  KbF1 = 112
  KbF2 = 113
  KbF3 = 114
  KbF4 = 115
  KbF5 = 116
  KbF6 = 117
  KbF7 = 118
  KbF8 = 119
  KbF9 = 120
  KbF10 = 121
  KbF11 = 122
  KbF12 = 123
  KbSpace = 32
  KbPageUp = 33
  KbPageDown = 34
  KbHome = 36
  KbLeft = 37
  KbUp = 38
  KbRight = 39
  KbInsert = 45
  KbShift = 16
  KbControl = 17
  KbAlt = 18
  KbCapsLock = 20
  KbNumpad0 = 96
  KbNumpad1 = 97
  KbNumpad2 = 98
  KbNumpad3 = 99
  KbNumpad4 = 100
  KbNumpad5 = 101
  KbNumpad6 = 102
  KbNumpad7 = 103
  KbNumpad8 = 104
  KbNumpad9 = 105
  KbNumpadMultiply = 106
  KbNumpadAdd = 107
  KbNumpadSubtract = 109
  KbNumpadDivide = 111
  KbTab = 9
  KbBacktick = 192
  KbTilde = 192
  KbGraveAccent = 192
  KbMinus = 189
  KbDash = 189
  KbEqual = 187
  KbBracketLeft = 219
  KbBracketRight = 221
  KbBackslash = 220
  KbSemicolon = 186
  KbApostrophe = 222
  KbComma = 188
  KbPeriod = 190
  KbSlash = 191

  module Kb
    Kb0 = 48
    Kb1 = 49
    Kb2 = 50
    Kb3 = 51
    Kb4 = 52
    Kb5 = 53
    Kb6 = 54
    Kb7 = 55
    Kb8 = 56
    Kb9 = 57
    KbA = 65
    KbB = 66
    KbC = 67
    KbD = 68
    KbE = 69
    KbF = 70
    KbG = 71
    KbH = 72
    KbI = 73
    KbJ = 74
    KbK = 75
    KbL = 76
    KbM = 77
    KbN = 78
    KbO = 79
    KbP = 80
    KbQ = 81
    KbR = 82
    KbS = 83
    KbT = 84
    KbU = 85
    KbV = 86
    KbW = 87
    KbX = 88
    KbY = 89
    KbZ = 90
    KbBackspace = 8
    KbDelete = 46
    KbDown = 40
    KbEnd = 35
    KbEnter = 13
    KbReturn = 13
    KbEscape = 27
    KbF1 = 112
    KbF2 = 113
    KbF3 = 114
    KbF4 = 115
    KbF5 = 116
    KbF6 = 117
    KbF7 = 118
    KbF8 = 119
    KbF9 = 120
    KbF10 = 121
    KbF11 = 122
    KbF12 = 123
    KbSpace = 32
    KbPageUp = 33
    KbPageDown = 34
    KbHome = 36
    KbLeft = 37
    KbUp = 38
    KbRight = 39
    KbInsert = 45
    KbShift = 16
    KbControl = 17
    KbAlt = 18
    KbCapsLock = 20
    KbNumpad0 = 96
    KbNumpad1 = 97
    KbNumpad2 = 98
    KbNumpad3 = 99
    KbNumpad4 = 100
    KbNumpad5 = 101
    KbNumpad6 = 102
    KbNumpad7 = 103
    KbNumpad8 = 104
    KbNumpad9 = 105
    KbNumpadMultiply = 106
    KbNumpadAdd = 107
    KbNumpadSubtract = 109
    KbNumpadDivide = 111
    KbTab = 9
    KbBacktick = 192
    KbTilde = 192
    KbGraveAccent = 192
    KbMinus = 189
    KbDash = 189
    KbEqual = 187
    KbBracketLeft = 219
    KbBracketRight = 221
    KbBackslash = 220
    KbSemicolon = 186
    KbApostrophe = 222
    KbComma = 188
    KbPeriod = 190
    KbSlash = 191
  end
end
