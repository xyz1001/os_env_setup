- 获取pacman软件列表
comm -12 <(cat ~/.bash_history ~/.zsh_history| grep "sudo pacman -S " | grep -v grep | awk -F'-S ' '{print $NF}' | tr ' ' '\n' | sed '/^\s*$/d' | sort | uniq) <(pacman -Qenq | sort)

- 获取yaourt软件列表
pacman -Qemq
