#!/bin/bash

# Clone a sub-directory of a git repository. Probably replaces "svn co" which is being deprecated by GitHub.
# Usage: git_sparse_clone $repo_url $repo_branch $local_temp_url $sub_directory $target_location
function git_sparse_clone() {
    git clone --filter=blob:none --no-checkout --depth=1 -b $2 $1 $3 && cd $3
    git sparse-checkout init --cone
    git sparse-checkout set $4
    git checkout
    mv $4 ../$5
    cd ../ && rm -rf $3
}

# Clean up dependencies (保留：清理不需要的官方 Feed 源冲突，保持环境纯净)
find feeds -name Makefile -exec dirname {} \; | grep -wE 'gn|chinadns-ng|dns2socks|dns2tcp|hysteria|ipt2socks|microsocks|naiveproxy|redsocks2|shadowsocks-rust|shadowsocksr-libev|simple-obfs|sing-box|ssocks|tcping|trojan|v2ray-core|v2ray-geodata|v2ray-plugin|v2raya|xray-core|xray-plugin|lua-neturl|luci-app-ssr-plus|kuci-app-mosdns|mosdns' | xargs rm -rf

# Modify Default IP (保留：默认管理 IP 为 192.168.2.1)
sed -i 's/192.168.1.1/192.168.2.1/g' package/base-files/files/bin/config_generate

# Modify default hostname (保留：默认主机名为 Railgun)
sed -i 's/ImmortalWrt/Railgun/g' package/base-files/files/bin/config_generate

# 修改：移除不需要的 mosdns 和 v2ray 路由数据（ShellCrash 内置了完美的 DNS 分流）
# git clone --depth=1 https://github.com/sbwml/luci-app-mosdns package/mosdns
# git clone --depth=1 https://github.com/sbwml/v2ray-geodata package/v2ray-geodata

# 修改：移除为了编译 Xray 而升级底层 Go 语言版本的操作（不编译 Xray 能为你节约大量编译时间）
# rm -rf feeds/packages/lang/golang
# git_sparse_clone https://github.com/openwrt/packages master packages-upstream lang/golang feeds/packages/lang/golang
