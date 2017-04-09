source $HOME/.zsh/antigen.zsh

antigen use oh-my-zsh

antigen theme robbyrussell
#antigen theme Honukai
#antigen theme agnoster
#antigen theme jreese
#antigen theme arrow

antigen bundle git
antigen bundle sudo
antigen bundle pip
antigen bundle autojump
antigen bundle command-not-found
antigen bundle web-search
antigen bundle vi-mode

antigen bundle zsh-users/zsh-autosuggestions
antigen bundle zsh-users/zsh-completions src
antigen bundle zsh-users/zsh-syntax-highlighting

antigen apply

source $HOME/.zsh/config.zsh
source $HOME/.zsh/alais.zsh
