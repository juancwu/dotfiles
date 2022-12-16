function fish_user_key_bindings
  # bind peco functionalities
  # search directories
  bind \cf peco_change_directory

  # search commandline history
  bind \cr peco_select_hisotry

  # prevent iterm close window with ctrl+d
  bind \cd delete-char
end
