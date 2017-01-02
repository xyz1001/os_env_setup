# Vim安装
## 二进制安装

直接通过命令安装，简单方便，但灵活性差
### Debian系 (Debian/Ubuntu/Deepin)

- `sudo apt install vim`

### RedHat系 (RedHat/CentOS/Fedora)

- `sudo yum install vim`

## 编译安装

通过下载源码进行编译安装，可灵活地选择开启Vim的特性支持，如支持Python，Lua，部分Vim插件需要这些特性支持

1. 下载所需版本的Vim源码 ([地址](ftp://ftp.vim.org/pub/vim/unix))，这里以Vim8.0为例

- `wget ftp://ftp.vim.org/pub/vim/unix/vim-8.0.069.tar.bz2`
- `tar xvf vim-8.0.069.tar.bz2`
- `cd vim-8.0.069.tar.bz2`

2. 编译
- `./configure --prefix=`安装目录` --with-features=huge`
- `make`

其中configure选项可以指定开启那些特性支持，特性列表如下
> --enable-acl                                                  -- Don't check for ACL support.                                                                
> --enable-athena-check                                         -- If auto-select GUI, check for Athena default=yes                                            
> --enable-carbon-check                                         -- If auto-select GUI, check for Carbon default=yes                                            
> --enable-channel                                              -- Disable process communication support.                                                      
> --enable-cscope                                               -- Include cscope interface.                                                                   
> --enable-darwin                                               -- Disable Darwin (Mac OS X) support.                                                          
> --enable-desktop-database-update  --enable-icon-cache-update  -- update disabled                                                                             
> --enable-fail-if-missing                                      -- Fail if dependencies on additional features                                                 
> --enable-fontset                                              -- Include X fontset output support.                                                           
> --enable-gnome-check                                          -- If GTK GUI, check for GNOME default=no                                                      
> --enable-gpm                                                  -- Don't use gpm (Linux mouse daemon).                                                         
> --enable-gtk2-check                                           -- If auto-select GUI, check for GTK+ 2 default=yes                                            
> --enable-gtk3-check                                           -- If auto-select GUI, check for GTK+ 3 default=yes                                            
> --enable-gtktest                                              -- Do not try to compile and run a test GTK program                                            
> --enable-gui                                                  -- X11 GUI default=auto OPTS=auto/no/gtk2/gnome2/gtk3/motif/athena/neXtaw/photon/carbon        
> --enable-hangulinput                                          -- Include Hangul input support.                                                               
> --enable-largefile                                            -- omit support for large files                                                                
> --enable-luainterp                                            -- Include Lua interpreter.  default=no OPTS=no/yes/dynamic                                    
> --enable-motif-check                                          -- If auto-select GUI, check for Motif default=yes                                             
> --enable-multibyte                                            -- Include multibyte editing support.                                                          
> --enable-mzschemeinterp                                       -- Include MzScheme interpreter.                                                               
> --enable-netbeans                                             -- Disable NetBeans integration support.                                                       
> --enable-nextaw-check                                         -- If auto-select GUI, check for neXtaw default=yes                                            
> --enable-nls                                                  -- Don't support NLS (gettext()).                                                              
> --enable-option-checking                                      -- ignore unrecognized --enable/--with options                                                 
> --enable-perlinterp                                           -- Include Perl interpreter.  default=no OPTS=no/yes/dynamic                                   
> --enable-python3interp                                        -- Include Python3 interpreter. default=no OPTS=no/yes/dynamic                                 
> --enable-pythoninterp                                         -- Include Python interpreter. default=no OPTS=no/yes/dynamic                                  
> --enable-rubyinterp                                           -- Include Ruby interpreter.  default=no OPTS=no/yes/dynamic                                   
> --enable-selinux                                              -- Do not check for SELinux support.                                                           
> --enable-smack                                                -- Do not check for Smack support.                                                             
> --enable-sysmouse                                             -- Don't use sysmouse (mouse in *BSD console).                                                 
> --enable-tclinterp                                            -- Include Tcl interpreter. default=no OPTS=no/yes/dynamic                                     
> --enable-workshop                                             -- Include Sun Visual Workshop support.                                                        
> --enable-xim                                                  -- Include XIM input support.                                                                  
> --enable-xsmp                                                 -- Disable XSMP session management                                                             
> --enable-xsmp-interact                                        -- Disable XSMP interaction                                                                    
> --exec-prefix                                                 -- install architecture-dependent files in EPREFIX                                             
> --enable-acl                                                  -- Don't check for ACL support.                                                                
> --enable-athena-check                                         -- If auto-select GUI, check for Athena default=yes                                            
> --enable-carbon-check                                         -- If auto-select GUI, check for Carbon default=yes                                            
> --enable-channel                                              -- Disable process communication support.                                                      
> --enable-cscope                                               -- Include cscope interface.                                                                   
> --enable-darwin                                               -- Disable Darwin (Mac OS X) support.                                                          
> --enable-desktop-database-update  --enable-icon-cache-update  -- update disabled                                                                             
> --enable-fail-if-missing                                      -- Fail if dependencies on additional features                                                 
> --enable-fontset                                              -- Include X fontset output support.                                                           
> --enable-gnome-check                                          -- If GTK GUI, check for GNOME default=no                                                      
> --enable-gpm                                                  -- Don't use gpm (Linux mouse daemon).                                                         
> --enable-gtk2-check                                           -- If auto-select GUI, check for GTK+ 2 default=yes                                            
> --enable-gtk3-check                                           -- If auto-select GUI, check for GTK+ 3 default=yes                                            
> --enable-gtktest                                              -- Do not try to compile and run a test GTK program                                            
> --enable-gui                                                  -- X11 GUI default=auto OPTS=auto/no/gtk2/gnome2/gtk3/motif/athena/neXtaw/photon/carbon        
> --enable-hangulinput                                          -- Include Hangul input support.                                                               
> --enable-largefile                                            -- omit support for large files                                                                
> --enable-luainterp                                            -- Include Lua interpreter.  default=no OPTS=no/yes/dynamic                                    
> --enable-motif-check                                          -- If auto-select GUI, check for Motif default=yes                                             
> --enable-multibyte                                            -- Include multibyte editing support.                                                          
> --enable-mzschemeinterp                                       -- Include MzScheme interpreter.                                                               
> --enable-netbeans                                             -- Disable NetBeans integration support.                                                       
> --enable-nextaw-check                                         -- If auto-select GUI, check for neXtaw default=yes                                            
> --enable-nls                                                  -- Don't support NLS (gettext()).                                                              
> --enable-option-checking                                      -- ignore unrecognized --enable/--with options                                                 
> --enable-perlinterp                                           -- Include Perl interpreter.  default=no OPTS=no/yes/dynamic                                   
> --enable-python3interp                                        -- Include Python3 interpreter. default=no OPTS=no/yes/dynamic                                 
> --enable-pythoninterp                                         -- Include Python interpreter. default=no OPTS=no/yes/dynamic                                  
> --enable-rubyinterp                                           -- Include Ruby interpreter.  default=no OPTS=no/yes/dynamic                                   
> --enable-selinux                                              -- Do not check for SELinux support.                                                           
> --enable-smack                                                -- Do not check for Smack support.                                                             
> --enable-sysmouse                                             -- Don't use sysmouse (mouse in *BSD console).                                                 
> --enable-tclinterp                                            -- Include Tcl interpreter. default=no OPTS=no/yes/dynamic                                     
> --enable-workshop                                             -- Include Sun Visual Workshop support.                                                        
> --enable-xim                                                  -- Include XIM input support.                                                                  
> --enable-xsmp                                                 -- Disable XSMP session management                                                             
> --enable-xsmp-interact                                        -- Disable XSMP interaction                                                                    
> --exec-prefix                                                 -- install architecture-dependent files in EPREFIX                                             
某些插件会要求部分特性支持，如neocomplete需要开启lua等

3. 安装
- `sudo make install`


## 备注
- 开启部分语言特性支持需要有该语言开发环境，需要安装`libxxxy.y-dev`包，其中xxx为编程语言名，y.y为版本号，如开启python3支持需要安装`libpython3.x-dev`，如果环境不满足，configure并不会报错。
