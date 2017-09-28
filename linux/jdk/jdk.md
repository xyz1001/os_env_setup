# Oracle-JDK

## DEB包安装(Deepin)
`sudo apt install oracle-java8`

## 二进制包安装
### 下载
[jdk下载](http://www.oracle.com/technetwork/java/javase/downloads/index.html)
### 安装
- `tar xvf ${FILENAME}.tar.gz -C /usr/local` #解压 
更新链接
- `sudo update-alternatives --install /usr/bin/java java /usr/local/${FILENAME}/bin/java 100`
- `sudo update-alternatives --install /usr/bin/javac javac /usr/local/${FILENAME}/bin/javac 100`
