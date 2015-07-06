# Ubuntu工作环境搭建小记
作者 Jeff Chan(@chjhuang) | 发布于 2015-06-30

## 目录

<!-- MarkdownTOC depth=3 -->
- [系统安装](#system_install)
- [桌面环境](#desktop_environment)
    - [Input Method](#input_method)
    - [Google Chrome](#google_chrome)
    - [Terminator](#terminator)
    - [everpad](#everpad)
    - [VLC](#vlc)
    - [Stickynotes](#stickynotes)
- [开发环境](#develop_environment)
    - [Vim](#vim)
    - [Git](#git)
    - [Java](#java)
    - [Python & C family](#python_c)
    - [NodeJS](#nodejs)
    - [Latex](#latex)
- [终端命令工具](#terminal_tools)
    - [xclip](#xclip)

<!-- /MarkdownTOC -->

趁着夏季小学期课少，闲來无事终于决定要彻底将工作开发环境从Windows转到Linux下了。为了方便以后重装或者移植到新的PC，所以现在将这几天的折腾过程进行记录存档。

之前断断续续玩过一段时间的CentOS，也玩过一会Ubuntu。虽然个人比较喜欢CentOS蓝黑的清爽风格，但是其软件管理、依赖解决等没有Ubuntu的好(比如安装Chrome，依赖库解决比较费事)，所以为了省事(不想折腾)，最终选择了Ubuntu发行版。

<a name="system_install" />
## 系统安装

1. 电脑为*`Thinkpad T430`*，采用Windows和Ubuntu双系统硬盘安装。引导方式及硬盘分区表为*`UEFI+GPT`*，与*`BIOS+MBR`*不同的是，所有系统的引导程序都会放到一个隐藏的格式为FAT32的*`EFI`*引导分区(/dev/sda2)。所以若要配置多系统的引导，则需要修改该分区中的.efi文件。例如在Windows+CentOS中，就需要安装第三方引导程序refind到EFI分区，并通过修改refind.conf文件来引导多系统的加载。不过Ubuntu不用你费事，其grub引导程序能够帮你解决一切。

2. 接下来是*`U盘`*启动盘的制作。从6V下载最新*`Ubuntu 15.04`*镜像(1G大小)，用*`UltraISO`*->文件->打开...，然后启动->写入硬盘映射，刻录到U盘。(*注意*：如果用UltraISO->文件->打开Ubuntu镜像时只有EFI文件夹，可以先用系统自带的ISO打开方式加载镜像，然后UltraISO->文件->打开光盘->选择刚刚ISO挂载的盘符，接着写入硬盘映射)。

3. 选择U盘启动，安装方式选择第三项`自定义安装`，即手动进行分区和选择挂载点。我留给Ubuntu系统的磁盘空间大小大概有120G，具体分区情况为：

    * `/` &ensp; 30G(系统根目录挂载点)
    * `/var` &ensp; 10G(系统运行时要改变的数据)
    * `swap` &ensp; 4G(内存交换区)
    * `/home` &ensp; 剩下的所有空间

4. 系统初始配置

    * 设置root密码

    ```sh
    sudo passwd root
    ```

    * 设置开机启动等待时间

    ```sh
    sudo gedit /etc/default/grub   # 修改GRUB_TIMEOUT项
    sudo update-grub
    ```

    * 设置系统更新源([清华大学源][])

    ```sh
    sudo gedit /etc/apt/sources.list
    sudo apt-get update
    ```

    系统[sources.list][]文件已上传至Github，可以备份本地文件后，从github上拉取：

    ```sh
    mv /etc/apt/sources.list /etc/apt/sources.list.old
    curl https://raw.githubusercontent.com/chjhuang/blog/master/2015/06/sources.list \
        > /etc/apt/sources.list
    ```

    另外，关于sources.list中的*`vivid`*，这是Ubuntu 15.04的版本代号(codename)。所以如果是其他版本的Ubuntu，则要将文件中所有的`vivid`替换成对应的版本代号，下表列出了部分Ubuntu版本号和代号(和Eclipse等软件类似，也是按照首字母的字典顺序来进行命名的)的对应关系：

     版本号  |  代号  | 完整代号
    ---------|--------|---------
    8.04 LTS |hardy   |Hardy Heron
    9.10     |karmic  |Karmic Koala
    10.04 LTS|lucid   |Lucid Lynx
    10.10    |maverick|Maverick Meerkat
    11.04    |natty   |Natty Narwhal
    11.10    |oneiric |Oneiric Ocelot
    12.04 LTS|precise |Precise Pangolin
    12.10    |quantal |Quantal Quetzal
    13.04    |raring  |Raring Ringtail
    14.04 LTS|trusty  |Trusty Tahr
    14.10    |utopic  |Utopic Unicorn
    15.04    |vivid   |Vivid Vervet

    * 另外，为了方便操作Windows系统下的资源，可以在Ubuntu Home目录下建立对应资源的`软链接`：
        * Windows/Desktop -> Home/Desktop: 

        ```sh
        ln -s /media/jeff/Windows8_OS/Users/hwq/Desktop ~/Desktop/W_Desktop
        ```

        * Windows/Pictures -> Home/Pictures

        ```sh
        ln -s /media/jeff/Windows8_OS/Users/hwq/Pictures ~/Pictures/W_Pictures
        ```

        * Windows/Documents -> Home/Documents

        ```sh
        ln -s /media/jeff/Windows8_OS/Users/hwq/Documents ~/Documents/W_Documents
        ```

        * Windows下其他常用文件夹 -> Home中Documents或Desktop中

        这样，在终端输入`Desktop/W_Desktop`路径就可以操作Windows桌面了，省了一大段路径名。

[清华大学源]: http://mirrors.tuna.tsinghua.edu.cn/ "tsinghua"
[sources.list]: https://github.com/chjhuang/blog/blob/master/2015/06/sources.list "sources.list"


<a name="desktop_environment" />
## 桌面环境

<a name="input_method" />
### Input Method

输入法沿用Ubuntu自带ibus输入法框架，并在其上安装*`sunpinyin`*中文输入法：

```sh
sudo apt-get install ibus-sunpinyin
```

<a name="google_chrome" />
### Google Chrome

一直在用Google Chrome浏览器，所以为了同步，卸载掉了自带的Firefox浏览器。Ubuntu中Chrome浏览器的安装相对CentOS来说比较简单：

* 方法1-直接下载

```sh
# 下载对应系统Google Chrome最新deb安装包
wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
sudo dpkg -i google-chrome-stable_current_amd64.deb  # 安装deb软件包
sudo apt-get install -f  # 安装缺少依赖库，递归安装上一指令缺少的所有依赖库
sudo dpkg -i google-chrome-stable_current_amd64.deb  # 解决依赖库问题后再次安装
```

* 方法2-添加Google Chrome的PPA

```sh
wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub \
    | sudo apt-key add
sudo sh -c 'echo "deb http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google-chrome.list'
sudo apt-get update
sudo apt-get install google-chrome
```

附带提一下，关于CentOS系列Google Chrome的安装(~~好像是Google developers觉得CentOS的Linux构建系统太老而取消了支持~~)，国外某大神写了个`一键`安装脚本[install_chrome.sh][]，亲测有效。

[install_chrome.sh]: http://chrome.richardlloyd.org.uk/ "Google Installer"

<a name="terminator" />
### Terminator

Ubuntu自带的终端是gnome-terminal，但不支持分屏，复制粘贴支持也不爽，所以卸载掉了terminal，换用terminator。

* 安装

```sh
sudo apt-get install terminator
```

* 配置

    * 终端配色

    配色使用[Solarized][]系列，配置该系列对应terminator终端的配色方案[terminator-solarized][]操作如下：

    ```sh
    mkdir -p ~/.config/terminator
    curl https://raw.githubusercontent.com/ghuntley/terminator-solarized/master/config \
        > ~/.config/terminator/config
    ```

    * ls配色

    使用solarized配色后，你会发现用ls命令查看目录和文件时是一片灰色。这是因为默认情况下solarized各种bright方案基本都是灰色，而系统默认显示目录和文件时多用bright色，此时需要配置dircolors才能显示出彩色的文件和目录。

    [dircolors-solarized][]项目提供了适合于solarized的dircolors配色方案，只要选择合适的方案使用就可以了。我参照张洋[博客][]的做法，选择了适合这个配色的dircolors.ansi-dark：

    ```sh
    curl https://raw.githubusercontent.com/seebi/dircolors-solarized/master/dircolors.ansi-dark \
        > ~/.dircolors
    ```

    然后在*`~/.bashrc`*中作如下配置(Ubuntu好像默认有该配置)：

    ```bash
    # enable color support of ls and also add handy aliases
    if [ -x /usr/bin/dircolors ]; then
        test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
        alias ls='ls --color=auto'
        #alias dir='dir --color=auto'
        #alias vdir='vdir --color=auto'
        
        alias grep='grep --color=auto'
        alias fgrep='fgrep --color=auto'
        alias egrep='egrep --color=auto'
    fi
    ```

    * 其他配置

    对terminator诸如快捷键绑定等其他更多配置既可以在终端图形界面右键->preferences，也可以通过修改*`~/.config/terminator/config`*文件来进行设置。关于terminatro的详细配置选项可以参考[terminator manpage][]。

[Solarized]: http://ethanschoonover.com/solarized "Solarized"
[terminator-solarized]: https://github.com/ghuntley/terminator-solarized "terminator solarized"
[dircolors-solarized]: https://github.com/seebi/dircolors-solarized "dircolors solarized"
[博客]: http://blog.codinglabs.org/articles/getting-started-with-ubuntu.html中 "开始使用Ubuntu作为工作环境"
[terminator manpage]: http://manpages.ubuntu.com/manpages/vivid/man5/terminator_config.5.html "manpage"

<a name="everpad" />
### everpad

印象笔记现在没有Linux客户端，所以安装了一个第三方开源客户端[everpad][]：

* 安装

```sh
sudo add-apt-repository ppa:nvbn-rm/ppa
sudo apt-get update
sudo apt-get install everpad
```

* 配置

由于该客户端默认的授权链接是国际版Evernote，所以为了支持Evernote的中国版也就是印象笔记的授权，需要将其配置文件*`/usr/share/pyshared/everpad/const.py`*中的
```py
HOST = 'www.evernote.com' 修改为
HOST = 'app.yinxiang.com'
```

运行即可跳转到授权页面完成授权，然后就可以愉快地进行笔记同步了(~~不过界面有点丑~~)。

[everpad]: https://github.com/nvbn/everpad "everpad"

<a name="vlc" />
### VLC

又一个很喜欢的软件*`potPlayer`*没有Linux版客户端(~~摔~~)，系统自带的视频播放器又很难用，所以选择了一个据说很强大的播放软件(几乎通吃所有格式的音视频)：

```sh
sudo apt-get install vlc
```

<a name="stickynotes" />
### Stickynotes

不管是作日程安排，还是作碎片记忆，还是做各种Command、Shortcuts的(~~都Linux了，当然要追求纯键盘工作~~)Cheat Sheet，都离不开一个好的便利贴软件。对于这种小软件，我的要求是`简洁有效`，所以选择了[Stickynotes][]：

```sh
sudo add-apt-repository ppa:umang/indicator-stickynotes
sudo apt-get update
sudo apt-get install indicator-stickynotes
```

不过，这软件还是不完美，我只是想要一个可以触发便签`隐藏/显现`的快捷键。

[Stickynotes]: https://launchpad.net/indicator-stickynotes "indicator stickynotes"


<a name="develop_environment" />
## 开发环境

<a name="vim" />
### Vim

说好了要geek到纯键盘操作，那么Vim作为常用的高效文本(~~zhuang~~)编辑(~~bi~~)利器，自然值得好好配置一番。

* 安装

```sh
sudo apt-get install vim
```

* 配置

    Vim的配置主要是`插件安装`和`快捷键设置`。

    1. 为了更好地进行插件管理，首先安装插件管理工具[vim-plug][]: 

    ```sh
    # Install Vim plugin manager to ~/.vim
    curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
        https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    ```

    2. 然后编辑Vim的配置文件`~/.vimrc`，选择自己需要的插件，进行插件参数和启动快捷键等设置以及进行一些Vim的其他通用设置：

    ```vim
    " The simple usage example of vim-plug
    call plug#begin('~/.vim/plugged')
    
    " On-demand loading
    Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }
    
    " Using git URL
    Plug 'https://github.com/junegunn/vim-github-dashboard.git'
    
    " Unmanaged plugin (manually installed and updated)
    Plug '~/my-prototype-plugin'
    
    " Install other plugin ...
    
    call plug#end()

    " Plugin Settings and General Settings
    " ...
    ```

    为了方便，我已经将现在的[.vimrc][]上传到了Github。可以备份本地.vimrc后从github中直接拉取之前的配置文件：

    ```sh
    mv ~/.vimrc ~/.vimrc.old  # backup(it's depend)
    curl https://raw.githubusercontent.com/chjhuang/blog/master/2015/06/.vimrc \
        > ~/.vimrc
    ```

    3. 根据不同插件，检查并安装各自所需要的运行环境，如语法检查插件`synatic`需要`python-dev`环境，`vim-instant-markdown`需要`instant-markdown-d`的支持等。各插件说明和需要的前续操作在.vimrc处有说明。

    4. 安装好插件的编译环境(有些插件需要)和运行环境后，打开`vim`，执行命令`:PlugInstall`进行插件安装。

    5. 插件安装完成后，就可以愉快地Geek and Coding了。

    6. 为了实现`一键`配置，后续可能会写一个Vim自动配置脚本文件。

[vim-plug]: https://github.com/junegunn/vim-plug "Plugin Manager"
[.vimrc]: https://github.com/chjhuang/blog/blob/master/2015/06/.vimrc ".vimrc"

<a name="git" />
### Git

Git这么强大工具再加上Github这个全球最大~~同性交友~~网站，不仅可以做代码管理，还可以与各路大神神交、进行资料收集、做笔记、备份文件、写Blog等，值得认真泡泡。

* 安装

```sh
sudo apt-get install git
```

* [配置][]

    1. 检查系统是否已有可用*`SSH keys`*：

    ```sh
    ls -al ~/.ssh  # 列出现有SSH keys
    ```

    2. 如果有，直接跳到第三步，否则生成一个新的SSH keys：

    ```sh
    # Creates a new ssh key, using the provided email as a label
    ssh-keygen -t rsa -b 4096 -C "your_email@example.com" 
    ```

    选择默认密钥对保存路径(即弹出"Enter file in which to save the key(default path):"时，按*`Enter`*继续)，并选择一个好的安全的[passphrase][]。

    3. 将key加入ssh-agent：

    ```sh
    # start the ssh-agent in the background
    eval "$(ssh-agent -s)"
    ssh-add ~/.ssh/id_rsa  # Add your SSH key to the ssh-agent
    ```

    4. 将公钥发布到github：

    ```sh
    # Downloads and installs xclip.
    sudo apt-get install xclip
    # Copies the contents of the id_rsa.pub file to your clipboard>
    xclip -sel clip < ~/.ssh/id_rsa.pub
    ```

    然后将其粘贴到GitHub账户Settings->SSH key->Add SSH key。

    5. 验证连接

    ```sh
    ssh -T git@github.com  # Attempts to ssh to GitHub
    ```

    Type `yes`，如果看到"Hi username! You've successfully authenticated, but GitHub does not provide shell access."，则说明连接成功。

    6. 设置全局用户账户

    ```sh
    git config --global user.email "your_email@example.com"
    git config --global user.name "your name"
    git config --global push.default simple  # Git 2.0以上为simple, 2.0以下为matching
    ```

[配置]: https://help.github.com/articles/generating-ssh-keys/ "generating ssh keys"
[passphrase]: https://help.github.com/articles/working-with-ssh-key-passphrases/ "passphrase"

<a name="java" />
### Java

现在用的主要开发语言是Java，所以需要配置Java开发运行环境。

* JDK

    * 方法一(推荐)

        ```sh
        # 添加JDK deb源
        sudo add-apt-repository "deb http://archive.canonical.com/ vivid partner"
        sudo apt-get update
        sudo apt-get install sun-java8-jdk sun-java8-jre sun-java8-plugin
        java -version  # Check
        ```
    
    * 方法二

        1. 与Windows下类似，首先到[Oracle][]下载64位Linux下的JDK，然后解压

        ```sh
        mkdir /usr/java  # 本地安装一般安装在/usr/local目录下
        cd /usr/java
        sudo tar -xzvf ~/Downloads/jdk-8u45-linux-x64.tar.gz
        ```

        2. 接着进行环境变量配置：

        ```sh
        sudo vim /etc/profile
        ```

        在最后加入：

        ```bash
        # JDK Environment Variables
        export JAVA_HOME=/usr/java/jdk1.8.0_45
        export CLASSPATH=$CLASSPATH:.:$JAVA_HOME/lib:$JAVA_HOME/jre/lib
        export PATH=$PATH:$JAVA_HOME/bin 
        ```

        3. 重新加载系统环境变量：

        ```sh
        source /etc/profile
        ```

* IDE

    虽然说Vim很强大，但Java作为具有很多很优秀IDE，且工程结构比较复杂的面向对象语言，还是要配个IDE这种好鞍的。既然业界风向标Google在开发其`Android Studio`时都抛弃`Eclipse`，转投`IntelliJ`了，那么我当然也要尝试一下这个所谓的*"The Most Intelligent Java IDE"*了。[IntelliJ IDEA][]分为`Ultimate Edition`和`Community Edition`两个版本，穷到极致的我当然只能选择开源的社区版了，不过对于主要写Java项目的我来说足够了。其[安装][]很简单：

    1. [下载][]

    2. 解压

    ```sh
    cd /usr/java
    sudo tar -xzvf ~/Downloads/ideaIC-14.1.4.tar.gz
    ```

    3. 启动运行

    ```sh
    cd /usr/java/idea-IC-141.1532.4/bin  # 切换到bin目录
    sh idea.sh   # 启动运行
    ```

    4. 配置，并创建桌面快捷方式: `Configure | Create Desktop Entry`

    5. 原有Eclipse工程转换及更多其他操作信息可参照IntelliJ IDEA的[Help][]文档。

[Oracle]: http://www.oracle.com/technetwork/java/javase/downloads/jdk8-downloads-2133151.html "JDK"
[IntelliJ IDEA]: https://www.jetbrains.com/idea/ "IntelliJ IDEA"
[安装]: https://www.jetbrains.com/idea/help/basics-and-installation.html "Installation"
[下载]: https://www.jetbrains.com/idea/download/ "Download"
[Help]: https://www.jetbrains.com/idea/help/eclipse.html "Eclipse"

<a name="python_c" />
### Python & C family

Ubuntu系统自带`Python 2.7`、`Python 3.4`、`gcc 4.9`等编译运行环境。而且现在也没有用这些语言进行大项目开发，所以用Vim(具有语法检查并能够自补全)编辑，然后在终端编译运行就足够了。

<a name="nodejs" />
### NodeJS

NodeJs是Javascrpit的Server端运行版，Vim的某些插件用得到，其安装如下: 

```sh
sudo apt-get install npm  # 或者
sudo apt-get install nodejs
```

<a name="latex" />
### Latex

既然决定要`Geek`，那么就要Geek到底。抛弃`Word`，选择`Latex`；用`HTML5 + JS`代替`Power Point`；`Excel`？这是什么鬼。还是想用`Office`，没事，Ubuntu系统自带`LibreOffice`。

进入正题，为了可以支持中文文档的编辑，选择使用基于`Unicode`的`TeX`排版系统[XeTex][]。其是由Jonathan Kew开发并使用Unicode编码，因而支持多种语言并能够直接访问操作系统字体。XeTex环境配置如下：

* 准备工作(可选)
    
    由于XeTex能够直接使用操作系统字体，所以这一步是可选的。不过Linux中的中文字体多数不太适合用于排版文档，所以建议复制Windows中的字体或Adobe的字体。

    * 获取中文字体

        * 从Windows复制

        ```sh
        sudo mkdir /usr/share/fonts/win
        sudo cp /media/jeff/Windows8_OS/Windows/Fonts/{SIM,sim}* \
            /usr/share/fonts/win/
        sudo chmod 755 /usr/share/fonts/win/*
        ```

        * 安装`Microsoft`的公开免费字体

        ```sh
        sudo apt-get install xfonts-wqy ttf-wqy-microhei ttf-wqy-zenhei
        ```

        * 获取Adobe字体(？)

    * 更新系统字体缓存

    ```sh
    sudo fc-cache -f -s -v  # 更新系统字体缓存
    fc-list :lang=zh  # 查看系统现有中文字体
    ```

* 安装

```sh
# 安装xetex和xelatex，可以直接通过install xelatex
# 来实现，Ubuntu会自动安装xelatex依赖的xetex库。
# xelatex是xetex的命令，能够直接编译生成pdf
sudo apt-get install texlive-xelatex

# 安装中文支持CJK
sudo apt-get install latex-cjk-chinese

# 安装Latex的science包，以后编译遇到包找不到的情况，
# 都可以通过Google，找到对应的安装包名，进行后续安装
sudo apt-get install texlive-science
```

* 用法示例(使用xeCJK排版中文)

根据Latex语法，用Vim编辑`example.tex`文件(`UTF-8`):

```tex
\documentclass[11pt]{article}
% 使用xeCJK排版中文
\usepackage[BoldFont,SlantFont,CJKchecksingle]{xeCJK}
\setCJKmainfont[BoldFont=SimHei]{SimSun}  % 设置缺省中文字体
\setCJKmonofont{SimSun}
\parindent 2em   %段首缩进

\begin{document}
\section{举例}
\begin{verbatim}
标点。
\end{verbatim}

汉字Chinese数学$x=y$空格
\end{document}
```

完成之后，在终端输入：

```sh
xelatex example.tex
```

即可编译生成对应的`pdf`文件。

[XeTeX]: http://scripts.sil.org/xetex "XeTeX"


<a name="terminal_tools" />
## 终端命令工具

<a name="xclip" />
### xclip

xclip命令建立了终端和剪切板之间的通道，可以将终端输出或文件内容保存到剪切板，也可以将剪切板的内容输出到终端或文件。Ubuntu需要自己安装：

```sh
sudo apt-get install xclip
```

常用命令包括：

```sh
xclip filename  # 将指定文件输出到剪贴板
ls -al | xclip  # 将终端输出保存到剪贴板
xclip -o  # 剪切板内容输出到终端
xclip -o > filename  # 剪切板内容输出到文件
```

不过这里需要`注意`，在X11(Linux系列的GUI视窗系统)系统中有多个[clipboards][]，其中最主要的两个是：

* `PRIMARY` —— Normally copied to implicitly with mouse selection, and pasted with a middle mouse click.
* `CLIPBOARD` —— Normally used explicitly from applications, such as with C-c, C-x, and C-v.

xclip默认选择的是`X PRIMARY`，所以，如果想用`X CLIPBOARD`的话，需要用

```sh
xclip -selection c  # 输出到c
xclip -o -selection c # 从c输出
```

[clipboards]: http://www.debian-administration.org/article/565/Using_the_X_clipboard_from_the_command_line "xclip"


*(未完待续......)*

