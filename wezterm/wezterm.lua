local wezterm = require 'wezterm'
local config = {}

-- 字体配置
config.font = wezterm.font('Maple Mono NF CN')
config.font_size = 16

-- 窗口内边距
config.window_padding = {
    left = 15,
    right = 15,
    top = 15,
    bottom = 15,
}

-- 标签栏
config.enable_tab_bar = true -- 是否启用标签栏
-- config.hide_tab_bar_if_only_one_tab = true

-- 使用 dms 的主题
config.color_scheme_dirs = { wezterm.config_dir .. '/colors' }
config.color_scheme = 'dank-theme'

-- 禁用退出时的确认提示
config.window_close_confirmation = "NeverPrompt"

-- 启用现代键盘协议
config.enable_kitty_keyboard = true

-- 启用滚动条
config.enable_scroll_bar = true

config.keys = {
    {
        key = 'Backspace',
        mods = 'CTRL',
        action = wezterm.action.SendKey {
            key = 'w',
            mods = 'CTRL',
        },
    },
}

return config
