# YCM
## 安装步骤
1. 在`.vimrc`中添加并在vim中执行`:PlugInstall`
```
Plug 'Valloric/YouCompleteMe'                       " 语义补全，跳转
Plug 'rdnetto/YCM-Generator', { 'branch': 'stable'} " 需要先安装clang++
```
2. [下载](http://releases.llvm.org/download.html)clang
`~/.vim/plugged/YouCompleteMe/third_party/ycmd/clang_archives`
3. 进入`~/.vim/plugged/YouCompleteMe`，执行`./install.py --clang-completer`
4. 安装`clang++`，确保`clang++`命令可执行
5. 在项目目录存在构建工具的情况下，在vim中执行`:YcmGenerateConfig`
