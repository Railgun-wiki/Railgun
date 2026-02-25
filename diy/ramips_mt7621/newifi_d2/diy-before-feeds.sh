#!/bin/bash

# 修改：移除不需要的科学上网面板源码（我们将使用 ShellCrash）
# git clone --depth=1 https://github.com/fw876/helloworld package/helloworld
# git clone --depth=1 https://github.com/xiaorouji/openwrt-passwall package/passwall

# 修改：添加你指定的 Minieap 校园网核心与配套 LuCI 面板
git clone --depth=1 https://github.com/undefined443/openwrt-minieap-sysu package/minieap
git clone --depth=1 https://github.com/kongfl888/luci-app-minieap package/luci-app-minieap

# 修改：注释掉原作者修复 Python 的补丁文件（Ubuntu 22.04 原生完美支持编译 5.10 内核，无需此补丁，保留此行反而会因为找不到补丁文件而报错退出）
patch -p1 < ~/work/Railgun/Railgun/patches/00_python3.patch
