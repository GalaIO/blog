---
author: 攻城狮Gala
categories:
    - DevOps
date: 2021-07-19T20:43:26+08:00
draft: false
image: /assets/alex-cheung-gQdPafWDSyk-unsplash.jpg
keywords:
    - DevOps
    - DevOps
    - NAS
    - linux
    - 趣玩
tags:
    - DevOps
    - NAS
    - linux
    - 趣玩
title: NAS折腾记
---

<!----- [DevOps](/tags/DevOps) [NAS](/tags/NAS) [linux](/tags/linux) [趣玩](/tags/趣玩) ----->

欢迎关注 **“攻城狮Gala”公/ 众 /号** ，每天一起学习，努力成为Web3全栈

一年多前矿难的时候，收了一台星际蜗牛，但是一直没时间玩，最近准备备份下数据和照片，同时尝试跑下以太坊客户端，而且以太坊客户端占用空间大，云服务器成本高，自己pc太麻烦，没法一直开机，所以NAS是个不错的选择。

在这样的背景下，决心整台NAS，平时远程下下电影、备份照片，同时还可以试试同步以太坊。

## 硬件升级

原硬件是矿渣星际蜗牛，但是堆料很一般所以准备升级下硬件：

### 硬盘

增加两个NAS专用的4T硬盘，希捷酷狼，有点贵说实话，680一块，也可以使用监控类型硬盘，同样支持`7*24`使用；

### 电源

新的更稳定的电源，用的海韵，会贵一点。

### 风扇

这个很关键，选好真的没啥噪声，新的静音风扇，但是机箱太小，而且直接贴着机箱导致噪音还是挺大的。所以又买了一个温控的调速器，体验相当棒，平时有一丢丢风可以保证散热，而且噪音非常小；

### 远程开关

目前远程开关的方案是，小米智能插座，可以远程开关机(前提是NAS的bios配置插电启动哈)，同时可以记录功耗；

### 系统盘

原系统盘16g，肯定不够，买了一个更大的固态硬盘240g；

### 设置固定内网ip

在路由器设置静态ip绑定，按照你的牌子在后台设置，这样可以保证每次NAS连入路由器的时候，使用固定ip，不用每次查询ip是否有变动；

最后组装效果还不错，就是硬盘偏贵。。。。NAS的功耗非常低，可以长期开着，实测520小时耗电8度，功率大概20瓦左右。当然确实不用的时候可以远程关掉。

## 安装系统

操作系统使用更通用的linux而不是nas操作系统，Ubuntu server 20.04。主要的考虑是够折腾，不会被某个系统限制，所有的方案使用开源项目。总体来说折腾NAS就是玩linux，还有很多人用CDN+NAS来做网站，体验还是不错的。

### 挂载硬盘

硬盘格式化ext4，设置按照硬盘UUID永久挂载，否则重启就需要重新挂载；

参考：https://blog.csdn.net/dk_mcu/article/details/53464699

## 必备软件

###  openssh

这个不用说了，必装软件，用于远程登录。

### frp

用于外网登录和管理的，目前把ssh端口、vnc端口，还有一些后台管理端口做了穿透。

https://doc.natfrp.com/#/launcher/remote

方案使用市面上的免费服务；

### docker

这个不用细说，必备呀，安装一些服务非常方便。

### nextclound

一个开源的网盘方案，有mac、安卓、iphone的客户端，可以创建用户随后按用户维度，备份文档、照片、文件等等。

直接docker部署非常方便；

```yaml
version: '2'

services:
db:
container_name: cloud_db
image: mysql
volumes:
- "./mysql:/var/lib/mysql"
restart: always
environment:
MYSQL_ROOT_PASSWORD: root
MYSQL_DATABASE: nextcloud

app:
container_name: cloud_app
depends_on:
- db
image: nextcloud
volumes:
- ./config:/var/www/html/config
- /data1/nextcloud:/var/www/html/data
- ./apps:/var/www/html/apps
links:
- db
ports:
- "2333:80"
restart: always

networks:
default:
external:
name: nextcloud
```

随后访问ip:2333初始化，记得选择mysql进行初始化哈~

### minidlna

开源的lnda协议实现，所有支持ldna的音响、电视都可以直接连NAS播放。非常方便，用于看电影、听歌等等。

参考：https://blog.csdn.net/winniezhang/article/details/85861526

### 下载工具

Aria2非常方便，用于下载http、bt等等。

http://aria2.github.io/

AriaNG是一个页面工具非常好用强烈推荐，我把AriaNG的html放在nginx路径就可以直接访问到；

同时需要启动Aria2的rpc模式，aria2c --enable-rpc --rpc-listen-all=true --rpc-allow-origin-all -c --dir="/data1/downloads"

不过服务重启后，下载任务会丢。。。无语了。

### 视频下载工具

强烈推荐youget，体验不错，有些可能被下架的资源可以用youget下载。

参考：https://github.com/soimort/you-get/wiki/%E4%B8%AD%E6%96%87%E8%AF%B4%E6%98%8E

### 文件传输工具

强烈推荐samb，可以直接在mac和win上传输数据非常方便，直接访问smb://ip即可。还可以通过手机备份数据到NAS，推荐使用FolderSyncPro，目前支持安卓。

参考：https://www.linuxidc.com/Linux/2018-11/155466.htm

### 安装桌面

最终还是安装桌面，并用vnc远程控制。比如下载百度云、网页下载等，用桌面控制体验更好。

安装桌面环境：

参考：https://itsfoss.com/install-gui-ubuntu-server/

安装x11vnc：

参考：https://blog.csdn.net/jiakai82/article/details/103386097

这个是直接共享桌面，所以没显示器会卡顿。

参考：https://blog.csdn.net/weixin_43640082/article/details/109029526

参考这个可以设置虚拟输出，这样可以直接使用x11了。

## 其他经验

### 设置服务自启动

这个对于一些手动安装的服务来说需要自行设置自启动。

参考：https://doc.natfrp.com/#/frpc/service/systemd

![2022_03_wxsousuo.png](/assets/2022_03_wxsousuo.png)

