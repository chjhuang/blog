# Ubuntu实战
Published on 2015-07-08 | System, Ubuntu

这里，主要是记录在Ubuntu系统实践过程中遇到的问题以及最终的解决方案。

## 1\. 系统*`Suspend/Resume`*时自动执行用户自定义脚本

有时，我们需要在系统启动/关机、挂起/唤醒时执行一些用户自定义的操作。例如，启动特定程序、作特定配置等。这里，是因为`Ubuntu 15.04`挂起再唤醒时，无法恢复到挂起前的亮度，所以我需要手动在挂起时保存屏幕亮度，唤醒时恢复亮度。

该方法适用于`Ubuntu 15.04`,而之前的版本会再後面说明：

*  编辑用户自动义脚本: 

    ```sh
    #!/bin/sh

    # name this file as *.sh, eg. my_brt.sh

    # two arguments will be passed in when executed by
    # systemd-suspend.service(a system service that is pulled in by
    # suspend.target and is responsible for the actual system suspend).
    # The first argument will be "pre"(suspend) or "post"(resume), the
    # second either "suspend", "hibernate", or "hybrid-sleep" depending
    # on the chosen action.
    # run "man systemd-sleep" on terminal for more details

    case $1$2 in
        pre/*)
            # executed on suspend
            # uncomment following line if nothing need to be executed
            #exit 0
            # write you command here
            ;;
        post/*)
            # executed on resume
            # write you command here
            # eg. echo 8 > /sys/class/backlight/acpi-video0/brightness
            ;;
    esac

    ```

*  为自定义脚本添加可执行权限

    ```
    sudo chmod +x scriptname.sh
    ```

*  将所有需要执行的自定义脚本放到目录*`/lib/systemd/system-sleep`*下，根据*`systemd-sleep`*的`help`信息，我们可以知道：

    >  Immediately before entering system suspend and/or hibernation systemd-suspend.service (and the other mentioned units, respectively) will run all executables in '/lib/systemd/system-sleep/' and pass two arguments to them. And all executables in this directory are executed in parallel, and execution of the action is not continued until all executables have finished.

至于`vivid`之前的版本，可按如下操作：

*  编辑用户自定义脚本

    ```sh
    #!/bin/bash

    case "$1" in
        suspend|suspend_hybrid|hibernate)
            # executed on suspend
            ;;
        resume|thaw)
            # executed on resume
            ;;
    esac
    ```

*  为自定义脚本添加可执行权限
*  将所有需要执行的自定义脚本放到*`/etc/pm/sleep.d`*目录下。另外为了让所有用户自定义脚本在系统脚本之后执行，脚本命名最好带前缀`99`等。

同样的，如果需要在*`init/shut down`*时执行用户自定义脚本，则可以将用户脚本放到*`/lib/systemd/system-shutdown`*目录下。

更多详细信息参见[askubuntu.com][]和[wiki.archlinux.org][]。

另外，启动/关机/挂起/唤醒等的日志信息可查阅：*`/var/log/syslog`*或*`/var/log/messages`*，从而我们可以通过在自定义脚本中输出(echo)信息来进行调试。

[askubuntu.com]: http://askubuntu.com/questions/620494/ubuntu-15-04-suspend-doesnt-run-pm-suspend "askubuntu.com"
[wiki.archlinux.org]: https://wiki.archlinux.org/index.php/Power_management#Hooks_in_.2Fusr.2Flib.2Fsystemd.2Fsystem-sleep "wiki.archlinux.org"
