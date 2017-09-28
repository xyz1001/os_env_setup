# zsh

## 插件
- `antigen`: `zsh`的插件管理器。
 - `curl -L git.io/antigen > antigen.zsh`
 - `.zshrc`中添加`source antigen.zsh`
- `oh-my-zsh`
 - `antigen use oh-my-zsh`
 - `oh-my-zsh`自带插件
   - `git`
   - `sudo`
   - `pip`
   - `autojump`
   - `command-not-found`    #输入时不存在的命令标红
   - `web-search`    #通过命令打开浏览器搜索
   - `vi-mdoe`    #vi模式
   修改`oh-my-zsh`插件目录下`plugins/vi-mode/vi-mode.plugin.zsh`，将`bindkey -M vicmd 'v' edit-command-line`修改为`bindkey -M vicmd '!' edit-command-line`
- `zsh-autosuggestions`    #自动提示
 - `antigen bundle zsh-users/zsh-autosuggestions`
- `zsh-completions`    #自动不全
 - `antigen bundle zsh-users/zsh-completions src`
- `zsh-syntax-highlighting`    #语法高亮
 - `antigen bundle zsh-users/zsh-syntax-highlighting`

具体参考`dotfiles`
