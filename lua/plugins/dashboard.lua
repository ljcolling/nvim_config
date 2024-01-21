return {
  "glepnir/dashboard-nvim",
  commit = "e517188dab55493fb9034b4d4f1a508ccacfcd45",
  lazy = false,
  config = function()
    local db = require('dashboard')


    db.custom_header = {
      '',
      '',
      '██     ██ ██████  ██ ████████ ███████      ██████  ██████  ██████  ███████ ',
      '██     ██ ██   ██ ██    ██    ██          ██      ██    ██ ██   ██ ██      ',
      '██  █  ██ ██████  ██    ██    █████       ██      ██    ██ ██   ██ █████   ',
      '██ ███ ██ ██   ██ ██    ██    ██          ██      ██    ██ ██   ██ ██      ',
      ' ███ ███  ██   ██ ██    ██    ███████      ██████  ██████  ██████  ███████ ',
      '                                                                           ',
      '                                                                           ',
      '',
      '',
    }

    db.custom_footer = { "Hello Lincoln..." }

    db.custom_center = {
      { icon = " ", desc = " Recently Used Files          ", action = "Telescope oldfiles" },
      { icon = " ", desc = " Find File                    ", action = "Telescope find_files" },
      { icon = " ", desc = " Load Last Session            ", action = "SessionLoad" },
      { icon = " ", desc = " Find Word                    ", action = "Telescope live_grep" },
      { icon = " ", desc = " Neovim Config                ", action = "e ~/.config/nvim/init.lua" },
      { icon = " ", desc = " ZSH config                   ", action = "e ~/.zshrc" },
      --[[ { icon = "󰄛 ", desc = " Kitty config                 ", action = "e ~/.config/kitty/kitty.conf" }, ]]
      { icon = " ", desc = " Wezterm config               ", action = "e ~/.config/wezterm/wezterm.lua" },
      { icon = " ", desc = " Starship config              ", action = "e ~/.config/starship.toml" },
      { icon = " ", desc = " Other config files           ", action = ":next ~/.config/alacritty/alacritty.yml ~/.tmux/.tmux.conf ~/.config/skhd/skhdrc ~/.config/yabai/yabairc ~/.config/spacebar/spacebarrc ~/.config/sketchybar/sketchybarrc" },
      { icon = " ", desc = " Radian History               ", action = "e ~/.radian_history" }
    }
  end
}
