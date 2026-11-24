# Dotfiles 维护规则

## 系统软件和用户环境

- `ansible.yml` 管理 Fedora 的 RPM、软件源、系统级 Flatpak 和宿主机设置，包括 Nix daemon、登录 shell 和 Kanata 的设备权限。Flatpak 模块依赖的集合在 `requirements.yml` 中声明。
- 常用软件优先用 DNF 安装，包括 Git、Fish、Starship、mise、VS Code 和 Ghostty。Home Manager 用于用户配置和服务。当前由 Nix 安装的应用和字体是 Kanata 和 Maple Mono NF CN。
- Kanata 的用户服务在 `home-manager/home.nix` 中定义。服务读取仓库中的 `kanata/kanata.kbd`，修改键位文件后运行 `rebuild` 会重新加载服务定义并触发重启。

## 可写应用配置

- 以 `~/dotfiles` 中的文件为准。在 `home-manager/home.nix` 里，使用 `xdg.configFile` 和 `config.lib.file.mkOutOfStoreSymlink` 部署应用配置。链接目标用指向工作区的绝对路径字符串，例如 `"${config.home.homeDirectory}/dotfiles/git/config"`。
- 应用保存设置时应写回仓库里的同一个文件。普通的 `source = ../文件` 会把内容放进只读的 Nix store。用链接部署应用配置时，应避免同时启用会在同一路径生成文件的 Home Manager 选项。
- Git 的全局配置是 `git/config`，部署到 `~/.config/git/config`。用 `git config --global` 修改全局设置，用 `git config --local` 修改单个项目的设置。Git 凭证、访问令牌和私钥留在本地凭证存储。
- 修改应用配置内容后，用 `git diff` 查看改动。新增文件先加入 Git 索引。修改 Home Manager 的文件映射、软件包清单或服务定义后，使用 Fish 的 `rebuild` 应用配置。应用需要重读配置时，重载或重启该应用。
- 迁移现有文件时先比较实际内容和仓库内容。有差异时先合并要保留的改动，再切换成链接。
