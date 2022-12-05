local Color, colors, Group, groups, styles = require('colorbuddy').setup()

vim.g.colors_name = "pearfs"

-- base colours, global colours
Color.new("red", "#ff3860")
Color.new("reddark", "#ff1443")
Color.new("redlight", "#ff5c7c")
Color.new("blue", "#498afb")
Color.new("bluedark", "#2674fa")
Color.new("bluelight", "#6ca0fc")
Color.new("orange", "#fa8142")
Color.new("orangedark", "#f96a1f")
Color.new("orangelight", "#fb9865")
Color.new("green", "#09c372")
Color.new("greendark", "#07a15e")
Color.new("greenlight", "#0BE586")
Color.new("purple", "#9166cc")
Color.new("purpldark", "#7d4bc3")
Color.new("purplelight", "#a481d5")
Color.new("pink", "#ff4088")
Color.new("pinkdark", "#ff1c72")
Color.new("pinklight", "#ff649e")
Color.new("yellow", "#ffd803")
Color.new("gray0", "#f8f8f8")
Color.new("gray1", "#dbe1e8")
Color.new("gray2", "#b2becd")
Color.new("gray3", "#6c7983")
Color.new("gray4", "#454e56")
Color.new("gray5", "#2a2e35")
Color.new("gray6", "#12181b")

Group.new("Normal", colors.gray2, colors.gray6, styles.none)
Group.new("Comment", colors.gray4, colors.NONE, styles.NONE)
Group.new("Constant", colors.blue, colors.NONE, styles.NONE)
-- variable, function names...
Group.new("Identifier", colors.orangelight, colors.NONE, styles.NONE)
-- any statement, such as if else while etc
Group.new("Statement", colors.redlight, colors.NONE, styles.NONE)
-- things such as '#include'
Group.new("PreProc", colors.gray3, colors.NONE, styles.NONE)
-- type color
Group.new("Type", colors.purple, colors.NONE, styles.NONE)
-- special characters such as escape characters '\n'
Group.new("Special", colors.orange, colors.NONE, styles.NONE)
Group.new("Underlined", colors.bluelight, colors.none, styles.none)
Group.new("Error", colors.red, colors.none, styles.none)
Group.new("TODO", colors.yellow, colors.none, styles.none)
Group.new("String", colors.green, colors.none, styles.none)
Group.new("Number", colors.gray2, colors.none, styles.none)
Group.new("Ignore", colors.none, colors.none, styles.none)
Group.new("Function", colors.purple, colors.none, styles.none)
Group.new("SpecialKey", colors.gray2, colors.gray6, styles.none)
Group.new("NonText", colors.gray2, colors.none, styles.none)
Group.new("Visual", colors.gray2, colors.gray4, styles.none)
Group.new("Directory", colors.blue, colors.none, styles.none)
Group.new("ErrorMsg", colors.red, colors.none, styles.none)
Group.new("IncSearch", colors.gray6, colors.yellow, styles.none)
Group.new("Search", colors.gray6, colors.yellow, styles.none)

Group.new("MoreMsg", colors.blue, colors.none, styles.none)
Group.new("ModeMsg", colors.bluedark, colors.none, styles.none)
Group.new("LineNr", colors.gray3, colors.none, styles.none)


