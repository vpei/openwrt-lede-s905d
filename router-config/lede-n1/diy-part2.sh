#!/bin/bash
#========================================================================================================================
# https://github.com/ophub/amlogic-s9xxx-openwrt
# Description: Automatically Build OpenWrt for Amlogic S9xxx STB
# Function: Diy script (After Update feeds, Modify the default IP, hostname, theme, add/remove software packages, etc.)
# Source code repository: https://github.com/coolsnowwolf/lede / Branch: master
#========================================================================================================================

# ------------------------------- Main source started -------------------------------
#
# Modify default theme（FROM uci-theme-bootstrap CHANGE TO luci-theme-material）
# sed -i 's/luci-theme-bootstrap/luci-theme-material/g' ./feeds/luci/collections/luci/Makefile

# Modify some code adaptation
sed -i 's/LUCI_DEPENDS.*/LUCI_DEPENDS:=\@\(arm\|\|aarch64\)/g' package/lean/luci-app-cpufreq/Makefile

# Add autocore support for armvirt
# sed -i 's/TARGET_rockchip/TARGET_rockchip\|\|TARGET_armvirt/g' package/lean/autocore/Makefile

# Add to compile options (Add related dependencies according to the requirements of the third-party software package Makefile)
# sed -i "/DEFAULT_PACKAGES/ s/$/ pirania-app pirania ip6tables-mod-nat ipset shared-state-pirania uhttpd-mod-lua/" target/linux/armvirt/Makefile

# Set DISTRIB_REVISION
sed -i "s|DISTRIB_REVISION='.*'|DISTRIB_REVISION='R$(date +%Y.%m.%d)'|g" package/lean/default-settings/files/zzz-default-settings

# Modify default root's password（FROM 'password'[$1$V4UetPzk$CYXluq4wUazHjmCDBCqXF.] CHANGE TO 'your password'）
# sed -i 's/root::0:0:99999:7:::/root:$1$V4UetPzk$CYXluq4wUazHjmCDBCqXF.:0:0:99999:7:::/g' /etc/shadow
sed -i 's/root:$1$V4UetPzk$CYXluq4wUazHjmCDBCqXF.:0:0:99999:7:::/root:$1$.q1gt4pK$9FjAkAv7TvFUyZYwWK8Td0:18923:0:99999:7:::/g' package/lean/default-settings/files/zzz-default-settings

# Modify default IP（FROM 192.168.1.1 CHANGE TO 192.168.31.4）
# sed -i 's/192.168.1.1/192.168.31.4/g' package/base-files/files/bin/config_generate
# sed -i 's/192.168.1.1/192.168.50.5/g' package/base-files/files/bin/config_generate

# Replace the default software source
# sed -i 's#openwrt.proxy.ustclug.org#mirrors.bfsu.edu.cn\\/openwrt#' package/lean/default-settings/files/zzz-default-settings
#
# ------------------------------- Main source ends -------------------------------


# ------------------------------- Other started -------------------------------
#
#replace coremark.sh with the new one
#rm feeds/packages/utils/coremark/coremark.sh
#cp $GITHUB_WORKSPACE/general/coremark.sh feeds/packages/utils/coremark/

# samba4
# sed -i 's/PKG_VERSION:=.*/PKG_VERSION:=4.14.6/' feeds/packages/net/samba4/Makefile
# sed -i 's/PKG_HASH:=.*/PKG_HASH:=86760692dd74a04705c0f6d11b31965a477265a50e79eb15838184476146f4b0/' feeds/packages/net/samba4/Makefile

#ffmpeg
# sed -i 's/PKG_VERSION:=.*/PKG_VERSION:=4.4/' feeds/packages/multimedia/ffmpeg/Makefile
# sed -i 's/PKG_HASH:=.*/PKG_HASH:=06b10a183ce5371f915c6bb15b7b1fffbe046e8275099c96affc29e17645d909/' feeds/packages/multimedia/ffmpeg/Makefile

# btrfs-progs
# sed -i 's/PKG_VERSION:=.*/PKG_VERSION:=5.13.1/' feeds/packages/utils/btrfs-progs/Makefile
# sed -i 's/PKG_HASH:=.*/PKG_HASH:=3d7e5a01e68fbaf485c5f1da15c6b8a7d1455fb57b6e75a706f8e2bb37f4f399/' feeds/packages/utils/btrfs-progs/Makefile

# golang
# sed -i 's/GO_VERSION_PATCH:=.*/GO_VERSION_PATCH:=7/' feeds/packages/lang/golang/golang/Makefile
# sed -i 's/PKG_HASH:=.*/PKG_HASH:=1a9f2894d3d878729f7045072f30becebe243524cf2fce4e0a7b248b1e0654ac/' feeds/packages/lang/golang/golang/Makefile

# curl
# sed -i 's/PKG_VERSION:=.*/PKG_VERSION:=7.78.0/' feeds/packages/net/curl/Makefile
# sed -i 's/PKG_HASH:=.*/PKG_HASH:=be42766d5664a739c3974ee3dfbbcbe978a4ccb1fe628bb1d9b59ac79e445fb5/' feeds/packages/net/curl/Makefile
# rm -f feeds/packages/net/curl/Makefile
# wget -P feeds/packages/net/curl https://raw.githubusercontent.com/openwrt/packages/master/net/curl/Makefile

# fix speedtest-cli
# sed -i "s/PKG_VERSION:=.*/PKG_VERSION:=2.1.3/" feeds/packages/lang/python/python3-speedtest-cli/Makefile
# sed -i "s/PKG_RELEASE:=.*/PKG_RELEASE:=1/" feeds/packages/lang/python/python3-speedtest-cli/Makefile
# sed -i "s/PKG_HASH:=.*/PKG_HASH:=5e2773233cedb5fa3d8120eb7f97bcc4974b5221b254d33ff16e2f1d413d90f0/" feeds/packages/lang/python/python3-speedtest-cli/Makefile

# node 
# sed -i "s/PKG_VERSION:=v14.17.1/PKG_VERSION:=v14.17.4/" feeds/packages/lang/node/Makefile
# sed -i "s/PKG_HASH:=ddf1d2d56ddf35ecd98c5ea5ddcd690b245899f289559b4330c921255f5a247f/PKG_HASH:=ae7bf4e784f8c8027ffa1e3757f37d2bd5925d0c48988c4d7f07e4515853cf2c/" feeds/packages/lang/node/Makefile
# rm -f feeds/packages/lang/node/patches/v14.x/003-path.patch
# wget -P feeds/packages/lang/node/patches/v14.x https://raw.githubusercontent.com/openwrt/packages/master/lang/node/patches/003-path.patch

# docker
# sed -i 's/PKG_VERSION:=20.10.7/PKG_VERSION:=20.10.8/' feeds/packages/utils/docker/Makefile
# sed -i 's/PKG_HASH:=.*/PKG_HASH:=cde34bbefd70fa27b44dfa904c40db84b89abf237e5267dcd08603b459a89253/' feeds/packages/utils/docker/Makefile
# sed -i 's/PKG_GIT_SHORT_COMMIT:=f0df350/PKG_GIT_SHORT_COMMIT:=3967b7d/' feeds/packages/utils/docker/Makefile

# dockerd
# sed -i 's/PKG_VERSION:=20.10.7/PKG_VERSION:=20.10.8/' feeds/packages/utils/dockerd/Makefile
# sed -i 's/PKG_HASH:=.*/PKG_HASH:=2505d00032f5d40ead5ac779c2840303dcead04713c93ba974be4c19b3ab8d0a/' feeds/packages/utils/dockerd/Makefile
# sed -i 's/PKG_GIT_SHORT_COMMIT:=b0f5bc3/PKG_GIT_SHORT_COMMIT:=75249d8/' feeds/packages/utils/dockerd/Makefile

# containerd
# sed -i 's/PKG_VERSION:=.*/PKG_VERSION:=1.4.9/' feeds/packages/utils/containerd/Makefile
# sed -i 's/PKG_HASH:=.*/PKG_HASH:=3bb9f54be022067847f5930d21ebbfe4e7a67f589d78930aa0ac713492c28bcc/' feeds/packages/utils/containerd/Makefile
# sed -i 's/PKG_SOURCE_VERSION:=.*/PKG_SOURCE_VERSION:=e25210fe30a0a703442421b0f60afac609f950a3/' feeds/packages/utils/containerd/Makefile

# runc
# sed -i 's/PKG_VERSION:=.*/PKG_VERSION:=1.0.1/' feeds/packages/utils/runc/Makefile
# sed -i 's/PKG_HASH:=.*/PKG_HASH:=b25e4273a895af3239bc5e495a007266356038adfb34c4b94b4fc39627a89ad9/' feeds/packages/utils/runc/Makefile
# sed -i 's/PKG_SOURCE_VERSION:=.*/PKG_SOURCE_VERSION:=4144b63817ebcc5b358fc2c8ef95f7cddd709aa7/' feeds/packages/utils/runc/Makefile

# bsdtar
sed -i 's/PKG_VERSION:=.*/PKG_VERSION:=3.5.2/' feeds/packages/libs/libarchive/Makefile
sed -i 's/PKG_HASH:=.*/PKG_HASH:=f0b19ff39c3c9a5898a219497ababbadab99d8178acc980155c7e1271089b5a0/' feeds/packages/libs/libarchive/Makefile



# mbedtls
# sed -i 's/PKG_VERSION:=.*/PKG_VERSION:=2.6.11/' package/libs/mbedtls/Makefile
# sed -i 's/PKG_RELEASE:=.*/PKG_RELEASE:=$(AUTORELEASE)/' package/libs/mbedtls/Makefile
# sed -i 's/PKG_HASH:=.*/PKG_HASH:=c18e7e9abf95e69e425260493720470021384a1728417042060a35d0b7b18b41/' package/libs/mbedtls/Makefile

# pcre
sed -i 's/PKG_VERSION:=.*/PKG_VERSION:=8.45/' package/libs/pcre/Makefile
sed -i 's/PKG_RELEASE:=.*/PKG_RELEASE:=$(AUTORELEASE)/' package/libs/pcre/Makefile
sed -i 's/PKG_HASH:=.*/PKG_HASH:=4dae6fdcd2bb0bb6c37b5f97c33c2be954da743985369cddac3546e3218bffb8/' package/libs/pcre/Makefile

# libpcap
#sed -i 's/PKG_VERSION:=.*/PKG_VERSION:=1.10.1/' package/libs/libpcap/Makefile
#sed -i 's/PKG_RELEASE:=.*/PKG_RELEASE:=$(AUTORELEASE)/' package/libs/libpcap/Makefile
#sed -i 's/PKG_HASH:=.*/PKG_HASH:=ed285f4accaf05344f90975757b3dbfe772ba41d1c401c2648b7fa45b711bdd4/' package/libs/libpcap/Makefile


# Qt5 -qtbase
# sed -i "s/PKG_BUGFIX:=.*/PKG_BUGFIX:=2/" package/lean/qtbase/Makefile
# sed -i "s/PKG_HASH:=.*/PKG_HASH:=909fad2591ee367993a75d7e2ea50ad4db332f05e1c38dd7a5a274e156a4e0f8/" package/lean/qtbase/Makefile
# mkdir package/lean/qtbase/patches
# wget -P package/lean/qtbase/patches/ https://raw.githubusercontent.com/breakings/OpenWrt/main/general/001-gcc11.patch

# Qt5 -qttools
# sed -i "s/PKG_BUGFIX:=.*/PKG_BUGFIX:=2/" package/lean/qttools/Makefile
# sed -i "s/PKG_HASH:=.*/PKG_HASH:=c189d0ce1ff7c739db9a3ace52ac3e24cb8fd6dbf234e49f075249b38f43c1cc/" package/lean/qttools/Makefile

# qBittorrent
# sed -i "s/PKG_VERSION:=.*/PKG_VERSION:=4.3.7/" package/lean/qBittorrent/Makefile
# sed -i "s/PKG_HASH:=.*/PKG_HASH:=d17c0bd852aaf8b75d61026ee213ad9147c37d8e3a14a3137b735732061bd1b1" package/lean/qBittorrent/Makefile

#sed -i '/Load Average/i\\t\t<tr><td width="33%"><%:Telegram %></td><td><a href="https://t.me/vpei"><%:电报交流群%></a></td></tr>' package/lean/autocore/files/arm/index.htm

# ARM64: Add CPU model name in proc cpuinfo
# wget -P target/linux/generic/pending-5.4 https://github.com/immortalwrt/immortalwrt/raw/master/target/linux/generic/hack-5.4/312-arm64-cpuinfo-Add-model-name-in-proc-cpuinfo-for-64bit-ta.patch

# autocore
sed -i 's/DEPENDS:=@(.*/DEPENDS:=@(TARGET_bcm27xx||TARGET_bcm53xx||TARGET_ipq40xx||TARGET_ipq806x||TARGET_ipq807x||TARGET_mvebu||TARGET_rockchip||TARGET_armvirt) \\/g' package/lean/autocore/Makefile
# Add cputemp.sh
# cp -rf $GITHUB_WORKSPACE/PATCH/new/script/cputemp.sh ./package/base-files/files/bin/cputemp.sh

# Add shadowsocks and shadowsocksR
# svn co https://github.com/openwrt/packages/trunk/net/shadowsocks-libev package/shadowsocks-libev
svn co https://github.com/xiaorouji/openwrt-passwall/trunk/shadowsocks-rust package/shadowsocks-rust
svn co https://github.com/xiaorouji/openwrt-passwall/trunk/shadowsocksr-libev package/shadowsocksr-libev

# Add Kenzok packages 
# git clone https://github.com/kenzok8/openwrt-packages.git package/kenzok
# git clone https://github.com/kenzok8/small.git package/small

# Add p7zip
# svn co https://github.com/hubutui/p7zip-lede/trunk package/p7zip

# coolsnowwolf default software package replaced with Lienol related software package
# rm -rf feeds/packages/utils/{containerd,libnetwork,runc,tini}
# svn co https://github.com/Lienol/openwrt-packages/trunk/utils/{containerd,libnetwork,runc,tini} feeds/packages/utils

# Add third-party software packages (The entire repository)
# git clone https://github.com/libremesh/lime-packages.git package/lime-packages

# Add third-party software packages (Specify the package)
# svn co https://github.com/libremesh/lime-packages/trunk/packages/{shared-state-pirania,pirania-app,pirania} package/lime-packages/packages

# 替换软件包
# rm include/feeds.mk
# wget -P include https://raw.githubusercontent.com/openwrt/openwrt/master/include/feeds.mk

# rm -rf feeds/packages/net/openssh
# svn co https://github.com/openwrt/packages/trunk/net/openssh package/openssh
# rm -rf package/lean/luci-app-cpufreq
# svn co https://github.com/breakings/OpenWrt/trunk/general/luci-app-cpufreq package/luci-app-cpufreq

# luci-app-socat
svn co https://github.com/Lienol/openwrt-package/trunk/luci-app-socat package/luci-app-socat

# rm -rf package/libs/elfutils
# svn co https://github.com/neheb/openwrt/branches/elf/package/libs/elfutils package/libs/elfutils

# rm -rf feeds/packages/utils/gnupg
# svn co https://github.com/breakings/OpenWrt/trunk/general/gnupg feeds/packages/utils/gnupg

# rm -rf feeds/packages/net/kcptun
# svn co https://github.com/xiaorouji/openwrt-passwall/trunk/kcptun package/kcptun

# fix nginx-ssl-util error (do not use fallthrough attribute)
# rm feeds/packages/net/nginx-util/src/nginx-ssl-util.hpp
# wget -P feeds/packages/net/nginx-util/src https://raw.githubusercontent.com/openwrt/packages/master/net/nginx-util/src/nginx-ssl-util.hpp

# fdk-aac
# rm -rf feeds/packages/sound/fdk-aac
# svn co https://github.com/openwrt/packages/trunk/sound/fdk-aac feeds/packages/sound/fdk-aac

# lvm2
# rm -rf feeds/packages/utils/lvm2
# svn co https://github.com/openwrt/packages/trunk/utils/lvm2 feeds/packages/utils/lvm2

# tini
# rm -rf feeds/packages/utils/tini
# svn co https://github.com/openwrt/packages/trunk/utils/tini feeds/packages/utils/tini

# ntfs3
# rm -rf package/lean/ntfs3
# svn co https://github.com/breakings/OpenWrt/trunk/general/ntfs3 package/lean/ntfs3
# fix ntfs3 generating empty package
# sed -i 's/KCONFIG:=CONFIG_NLS_DEFAULT="utf8"/#KCONFIG:=CONFIG_NLS_DEFAULT="utf8"/'g package/lean/ntfs3/Makefile

# readd cpufreq for aarch64
sed -i 's/LUCI_DEPENDS.*/LUCI_DEPENDS:=\@\(arm\|\|aarch64\)/g' package/lean/luci-app-cpufreq/Makefile
sed -i 's/services/system/g'  package/lean/luci-app-cpufreq/luasrc/controller/cpufreq.lua

# naiveproxy
svn co https://github.com/xiaorouji/openwrt-passwall/trunk/naiveproxy package/naiveproxy
# fix NaïveProxy typo error
# sed -i 's/NaveProxy/NaïveProxy/g' package/naiveproxy/Makefile


# 添加额外软件包
# svn co https://github.com/immortalwrt/luci-app-unblockneteasemusic/trunk package/luci-app-unblockneteasemusic
svn co https://github.com/jerrykuku/lua-maxminddb/trunk package/lua-maxminddb
svn co https://github.com/jerrykuku/luci-app-vssr/trunk package/luci-app-vssr
svn co https://github.com/vernesong/OpenClash/trunk/luci-app-openclash package/luci-app-openclash
svn co https://github.com/project-lede/luci-app-godproxy/trunk package/luci-app-godproxy
# svn co https://github.com/openwrt/luci/trunk/modules/luci-mod-dashboard feeds/luci/modules/luci-mod-dashboard
# svn co https://github.com/openwrt/packages/trunk/libs/libfido2 package/libfido2
# svn co https://github.com/openwrt/packages/trunk/libs/libcbor package/libcbor


# aliyundrive webdav
svn co https://github.com/messense/aliyundrive-webdav/trunk/openwrt/aliyundrive-webdav package/aliyundrive-webdav
svn co https://github.com/messense/aliyundrive-webdav/trunk/openwrt/luci-app-aliyundrive-webdav package/luci-app-aliyundrive-webdav

# 添加京东自动签到 luci-app-jd-dailybonus
rm -rf package/lean/luci-app-jd-dailybonus
svn co https://github.com/jerrykuku/luci-app-jd-dailybonus/trunk package/luci-app-jd-dailybonus


# 编译 po2lmo (如果有po2lmo可跳过)
# pushd package/luci-app-openclash/tools/po2lmo
# make && sudo make install popd
svn co https://github.com/xiaorouji/openwrt-passwall/trunk/brook package/brook
svn co https://github.com/xiaorouji/openwrt-passwall/trunk/chinadns-ng package/chinadns-ng
svn co https://github.com/xiaorouji/openwrt-passwall/trunk/tcping package/tcping
svn co https://github.com/xiaorouji/openwrt-passwall/trunk/trojan-go package/trojan-go
svn co https://github.com/xiaorouji/openwrt-passwall/trunk/trojan-plus package/trojan-plus

# 添加luci-app-filebrowser
svn co https://github.com/Lienol/openwrt-package/trunk/luci-app-filebrowser package/luci-app-filebrowser

# svn co https://github.com/project-openwrt/openwrt/trunk/package/lienol/luci-app-fileassistant package/luci-app-fileassistant

# 添加passwall
svn co https://github.com/xiaorouji/openwrt-passwall/trunk/luci-app-passwall package/luci-app-passwall


# 添加xray-core xray-plugin
svn co https://github.com/xiaorouji/openwrt-passwall/trunk/xray-core package/xray-core
svn co https://github.com/xiaorouji/openwrt-passwall/trunk/xray-plugin package/xray-plugin
# sed -i 's/PKG_HASH:=.*/PKG_HASH:=4a178a2bacffcc2fd374c57e47b71eb0cb5667bfe747690a16501092c0618707/' package/xray-plugin/Makefile

svn co https://github.com/xiaorouji/openwrt-passwall/trunk/ssocks package/ssocks
svn co https://github.com/xiaorouji/openwrt-passwall/trunk/dns2socks package/dns2socks
svn co https://github.com/xiaorouji/openwrt-passwall/trunk/ipt2socks package/ipt2socks
svn co https://github.com/xiaorouji/openwrt-passwall/trunk/microsocks package/microsocks 
svn co https://github.com/xiaorouji/openwrt-passwall/trunk/pdnsd-alt package/pdnsd-alt
# svn co https://github.com/fw876/helloworld/trunk/tcping package/tcping
svn co https://github.com/xiaorouji/openwrt-passwall/trunk/v2ray-core package/v2ray-core
svn co https://github.com/xiaorouji/openwrt-passwall/trunk/v2ray-plugin package/v2ray-plugin
svn co https://github.com/xiaorouji/openwrt-passwall/trunk/simple-obfs package/simple-obfs
svn co https://github.com/xiaorouji/openwrt-passwall/trunk/trojan package/trojan
svn co https://github.com/xiaorouji/openwrt-passwall/trunk/hysteria package/hysteria

# svn co https://github.com/kenzok8/openwrt-packages/trunk/luci-app-gost package/luci-app-gost
# svn co https://github.com/kenzok8/openwrt-packages/trunk/gost package/gost
# svn co https://github.com/kenzok8/openwrt-packages/trunk/luci-app-eqos package/luci-app-eqos

# 微信推送serverchan
svn co https://github.com/tty228/luci-app-serverchan/trunk package/luci-app-serverchan

# 添加luci-app-ssr-plus
svn co https://github.com/fw876/helloworld/trunk/luci-app-ssr-plus package/luci-app-ssr-plus
svn co https://github.com/semigodking/redsocks/trunk package/redsocks2

# 添加luci-app-ssr-plus
svn co https://github.com/rufengsuixing/luci-app-adguardhome/trunk package/luci-app-adguardhome

# 添加smartdns
# rm -rf feeds/packages/net/smartdns
# svn co https://github.com/project-openwrt/openwrt/trunk/package/ntlf9t/smartdns package/smartdns
svn co https://github.com/kenzok8/openwrt-packages/branches/main/luci-app-smartdns package/luci-app-smartdns
sed -i 's/PKG_VERSION:=.*/PKG_VERSION:=1.2021.34/' feeds/packages/net/smartdns/Makefile
sed -i 's/PKG_SOURCE_VERSION:=.*/PKG_SOURCE_VERSION:=756029f5e9879075c042030bd3aa3db06d700270/' feeds/packages/net/smartdns/Makefile
sed -i 's/PKG_MIRROR_HASH:=.*/PKG_MIRROR_HASH:=c2979d956127946861977781beb3323ad9a614ae55014bc99ad39beb7a27d481/' feeds/packages/net/smartdns/Makefile

# 修改bypass的makefile
# git clone https://github.com/garypang13/luci-app-bypass package/luci-app-bypass
# find package/*/ feeds/*/ -maxdepth 2 -path "*luci-app-bypass/Makefile" | xargs -i sed -i 's/shadowsocksr-libev-ssr-redir/shadowsocksr-libev-alt/g' {}
# find package/*/ feeds/*/ -maxdepth 2 -path "*luci-app-bypass/Makefile" | xargs -i sed -i 's/shadowsocksr-libev-ssr-server/shadowsocksr-libev-server/g' {}
# find package/luci-app-bypass/*/ -maxdepth 8 -path "*" | xargs -i sed -i 's/smartdns-le/smartdns/g' {}

# 添加ddnsto
# svn co https://github.com/linkease/ddnsto-openwrt/trunk/ddnsto package/ddnsto
# svn co https://github.com/linkease/ddnsto-openwrt/trunk/luci-app-ddnsto package/luci-app-ddnsto

# 添加udp2raw
# git clone https://github.com/sensec/openwrt-udp2raw package/openwrt-udp2raw
# git clone https://github.com/sensec/luci-app-udp2raw package/luci-app-udp2raw
# sed -i "s/PKG_SOURCE_VERSION:=.*/PKG_SOURCE_VERSION:=f2f90a9a150be94d50af555b53657a2a4309f287/" package/openwrt-udp2raw/Makefile
# sed -i "s/PKG_VERSION:=.*/PKG_VERSION:=20200920\.0/" package/openwrt-udp2raw/Makefile

# themes
svn co https://github.com/rosywrt/luci-theme-rosy/trunk/luci-theme-rosy package/luci-theme-rosy
# git clone https://github.com/rosywrt/luci-theme-purple.git package/luci-theme-purple
# git clone https://github.com/Leo-Jo-My/luci-theme-opentomcat.git package/luci-theme-opentomcat
svn co https://github.com/Leo-Jo-My/luci-theme-opentomcat/trunk package/luci-theme-opentomcat
# svn co https://github.com/Leo-Jo-My/luci-theme-opentomato/trunk package/luci-theme-opentomato
# svn co https://github.com/sirpdboy/luci-theme-opentopd/trunk package/luci-theme-opentopd
# git clone https://github.com/kevin-morgan/luci-theme-argon-dark.git package/luci-theme-argon-dark
# svn co https://github.com/kevin-morgan/luci-theme-argon-dark/trunk package/luci-theme-argon-dark
# svn co https://github.com/openwrt/luci/trunk/themes/luci-theme-openwrt-2020 package/luci-theme-openwrt-2020

# Add 晶晨宝盒 luci-app-amlogic
svn co https://github.com/ophub/luci-app-amlogic/trunk/depends/luci-lib-fs package/luci-lib-fs
svn co https://github.com/ophub/luci-app-amlogic/trunk/depends/meson_btld package/meson_btld
svn co https://github.com/ophub/luci-app-amlogic/trunk/luci-app-amlogic package/luci-app-amlogic
sed -i "s|https.*/amlogic-s9xxx-openwrt|https://github.com/breakings/OpenWrt|g" package/luci-app-amlogic/root/etc/config/amlogic
sed -i "s|http.*/library|https://github.com/breakings/OpenWrt/opt/kernel|g" package/luci-app-amlogic/root/etc/config/amlogic
sed -i "s|s9xxx_lede|ARMv8|g" package/luci-app-amlogic/root/etc/config/amlogic
# sed -i "s|.img.gz|..OPENWRT_SUFFIX|g" package/luci-app-amlogic/root/etc/config/amlogic

#删除docker无脑初始化教程
# sed -i '31,39d' package/lean/luci-app-docker/po/zh-cn/docker.po
# rm -rf lean/luci-app-docker/root/www

# Apply patch
# git apply ../router-config/patches/{0001*,0002*}.patch --directory=feeds/luci
#
# ------------------------------- Other ends -------------------------------