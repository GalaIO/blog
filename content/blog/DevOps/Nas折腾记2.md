---
author: 攻城狮Gala
categories:
    - DevOps
date: 2023-06-12T21:18:45+08:00
draft: false
image: /assets/jainath-ponnala-9wWX_jwDHeM-unsplash.jpg
keywords:
    - DevOps
    - DevOps
    - NAS
    - NUC12
    - linux
    - 趣玩
    - You
tags:
    - DevOps
    - NAS
    - NUC12
    - linux
    - 趣玩
    - You
title: Nas折腾记2
---

<!----- [DevOps](/tags/DevOps) [NAS](/tags/NAS) [NUC12](/tags/NUC12) [linux](/tags/linux)  [趣玩](/tags/趣玩) ----->

欢迎关注 **“攻城狮Gala”公/ 众 /号** ，每天一起学习，努力成为Web3全栈

这是另一台Nas，我把专用设备换成了通用设备，可组合性提高不少，同时性能提升巨大～

## 背景

终于又要折腾Nas了，上一次折腾还是上一次。。参考[NAS折腾记]({{< relref "blog/DevOps/NAS折腾记.md" >}})。这一次的主要原因是购买的云服务器性能不足，比如跑autoGpt？之前的Nas性能也一般，主要是型号太老，想继续升级太难。

正好在网上看到有人转卖自己的NUC11，我检索了下，NUC的mini主机系列非常适合做Nas，它设计出来会考虑用在工业制造领域，支持`7*24`小时运行，而且性能非常可观。

## 硬件

![Pasted image 20230613215248.png](/assets/Pasted%20image%2020230613215248.png)

### 主机

经过对比决定购买[NUC12WSHi5](https://www.intel.cn/content/www/cn/zh/products/sku/121626/intel-nuc-12-pro-kit-nuc12wshi5/ordering.html)，12核16线程，配置丰富，短时间内足够用。
- 内存：金士顿 (Kingston) 32GB DDR4 3200 笔记本内存条；
- 硬盘：西部数据（Western Digital）2TB SSD固态硬盘 M.2接口（NVMe协议），注意插好，避免主机无法识别；

![Pasted image 20230614221613.png](/assets/Pasted%20image%2020230614221613.png)

#### Bios设置

主要设置：
1. 关闭WiFi和蓝牙功能，不用避免耗电；
2. 设置开机自启动，设置`After Power Failure`为`Last State`，也就是说断电后再上电如果断电前开机就直接开机，否则依然关机，也可以设置`Power On`始终保持上电开机；

#### 系统

无脑ubuntu，有人可能会问怎么不用群晖，因为我主要当服务器使用，顺便搭建一些Nas软件提供存储服务。安装最新版本[Ubuntu Server 23.04](https://ubuntu.com/download/server)。

一些参考资料：
- [Ubuntu.Server.CLI.pro.tips.19.04.22.pdf](/assets/Ubuntu.Server.CLI.pro.tips.19.04.22.pdf)
- [ubuntu-server-guide-2023-06-11.pdf](/assets/ubuntu-server-guide-2023-06-11.pdf)

#### 扩展vg存储

默认安装情况下，LVM只会占用足够的空间，可以使用`lvextend`占用所有空间。

```bash
# 查看磁盘空间使用情况
$ df -h
# 扩展所有vg
$ sudo lvextend -l +100%FREE /dev/ubuntu-vg/ubuntu-lv
$ sudo resize2fs /dev/ubuntu-vg/ubuntu-lv
```

#### 安装2.5寸硬盘

如何安装2.5寸硬盘，参考如下，更多[指南参考](https://manuals.plus/zh-CN/intel/nuc-12-pro-kit-manual)。

![Pasted image 20230625195309.png](/assets/Pasted%20image%2020230625195309.png)

### 路由器

#### 设置无线AP

家里的网络有点复杂，首先有一个电信入户的光猫，在客厅有一个无线路由器，在卧室还有一个无线路由器，现在的一个问题是每个无线路由器都会开一个子网相互设备无法访问，虽然都可以访问公网。现在需要把所有无线路由器修改为无线AP，这样就可以共享光猫一个网段。

假设被共享网段的路由器是猪路由器，对于一般的无线路由器，需要3个步骤成为无线AP：
1. 关闭路由器DHCP功能；
2. 在路由器LAN口设置，设置主路由器同网段任意未使用ip；
3. 连接路由器的LAN口道主路由器的LAN口，也就是当交换机使用了；

![Pasted image 20230613215344.png](/assets/Pasted%20image%2020230613215344.png)

> Note：小米或者红米路由器有一个有线中级设置，切换后直接变成无线AP。

参考资料：
- [多台路由器如何串联（级联）？](https://smb.tp-link.com.cn/service/detail_article_89.html)
- [如何设置路由器当无线交换机使用](https://resource.tp-link.com.cn/pc/docCenter/showDoc?source=search&id=1655112585159408)
- [小米路由器-有线中继设置](https://www.mi.com/service/miwifi/miwifi2/Repeater)

#### 绑定IP地址

为了避免设备频繁更换IP，可以在路由器侧绑定IP地址分配，同时无需手动更改本机IP。一般DHCP设置页面都可以修改。

![Pasted image 20230613214956.png](/assets/Pasted%20image%2020230613214956.png)

### 硬盘柜

NUC上的固态始终容量有限无法存储所有数据，之前的NAS还有两个硬盘，经过搜索发现硬盘柜可以解决我的需求，加上一般内网访问磁盘速度在60MB/s左右基本满足需求，那么使用硬盘柜的方案也合理，不用整传输那么快～

硬盘柜选择的 奥睿科(ORICO)硬盘柜多盘位3.5英寸USB3.0 这款，有以下原因：
- 有风扇，因为硬盘的温度需要控制一下才能更稳定传输，如果没风扇硬盘会超级烫；
- 支持10分钟无操作休眠；
- 易安装，支持2.5寸/3.5寸；

![Pasted image 20230614221151.png](/assets/Pasted%20image%2020230614221151.png)

#### 挂载新盘

```bash
# 查看所有硬盘：
lsblk -a
# 查看磁盘空间使用情况
df -h
# 查看未挂载磁盘
sudo fdisk -l
# 创建目录
mkdir /data
# 挂载
sudo mount /dev/sda /data
# 查看设备uuid
sudo blkid
# 设置开机自动挂载
sudo vim /etc/fstab
# 按照格式填入挂载盘的uuid和挂载目录, 设置不会失败，超时9s，避免硬盘不再无法开机
UUID="a22fe25c-304f-4989-9ca6-f2fcdb9342ef" /data ext4 defaults,nofail,x-systemd.device-timeout=9 0 1
```

## 服务端软件

### Git

一般server自带Git，也可以使用如下命令安装：

```bash
sudo apt install git
```

Git本地配置`～/.gitconfig`参考如下：

```ini
[https]
proxy = http://127.0.0.1:7890/
postBuffer = 1048576000
lowSpeedLimit = 0
lowSpeedTime = 999999
[http]
proxy = http://127.0.0.1:7890/
postBuffer = 1048576000
lowSpeedLimit = 0
lowSpeedTime = 999999
```

### wget

wget命令一般是系统自带，这里介绍一下使用代理服务器的方式。

首先修改wget环境变量：

```bash
vim ~/.wgetrc
```

增加如下配置：

```bash
[You](/tags/You) can set the default proxies for Wget to use for http, https, and ftp.
# They will override the value in the environment.
https_proxy = http://127.0.0.1:7890/
http_proxy = http://127.0.0.1:7890/
ftp_proxy = http://127.0.0.1:7890/

# If you do not want to use proxy at all, set this to off.
# If you want to use proxy at all, set this to on.
use_proxy = off
```

随后通过如下方式使用wget：

```bash
# 不使用代理，默认不使用
wget https://github.com/aria2/aria2/releases/download/release-1.36.0/aria2-1.36.0.tar.gz
# 使用代理
wget -Y on https://github.com/aria2/aria2/releases/download/release-1.36.0/aria2-1.36.0.tar.gz
```

### Nginx

虽然NAS是本地服务器，但是不可避免会代理一些静态资源，或者转发一些http服务，所以Nginx也是NAS必备。

安装非常简单：

```bash
sudo apt install nginx
```

安装完开始监听80端口，也可以进入配置项修改端口，增加代理资源等等。

### aria2

[aria2](http://aria2.github.io/)是一个非常强大的下载工具，支持多种下载协议，常见的HTTP/HTTPS，BT，FTP等等。

#### 安装

```bash
sudo apt install -y aria2
# 卸载
sudo apt purge --autoremove -y aria2
```

#### 配置

aria2有很多复杂的配置项，默认情况下，体验不是很好，比如重启任务丢失，BT下载慢等等。可以参考[aria2.conf](https://github.com/P3TERX/aria2.conf)这个项目，是一个好的配置参考来源。

当然可以根据实际情况调整，修改后的配置如下：

```ini
## 文件保存设置 ##
# 下载目录。可使用绝对路径或相对路径, 默认: 当前启动位置
dir=/data1/downloads

# 磁盘缓存, 0 为禁用缓存，默认:16M
# 磁盘缓存的作用是把下载的数据块临时存储在内存中，然后集中写入硬盘，以减少磁盘 I/O ，提升读写性能，延长硬盘寿命。
# 建议在有足够的内存空闲情况下适当增加，但不要超过剩余可用内存空间大小。
# 此项值仅决定上限，实际对内存的占用取决于网速(带宽)和设备性能等其它因素。
disk-cache=64M

# 文件预分配方式, 可选：none, prealloc, trunc, falloc, 默认:prealloc
# 预分配对于机械硬盘可有效降低磁盘碎片、提升磁盘读写性能、延长磁盘寿命。
# 机械硬盘使用 ext4（具有扩展支持），btrfs，xfs 或 NTFS（仅 MinGW 编译版本）等文件系统建议设置为 falloc
# 若无法下载，提示 fallocate failed.cause：Operation not supported 则说明不支持，请设置为 none
# prealloc 分配速度慢, trunc 无实际作用，不推荐使用。
# 固态硬盘不需要预分配，只建议设置为 none ，否则可能会导致双倍文件大小的数据写入，从而影响寿命。
# file-allocation=none

# 文件预分配大小限制。小于此选项值大小的文件不预分配空间，单位 K 或 M，默认：5M
no-file-allocation-limit=64M

# 断点续传
continue=true

# 始终尝试断点续传，无法断点续传则终止下载，默认：true
always-resume=false

# 不支持断点续传的 URI 数值，当 always-resume=false 时生效。
# 达到这个数值从将头开始下载，值为 0 时所有 URI 不支持断点续传时才从头开始下载。
max-resume-failure-tries=0

# 获取服务器文件时间，默认:false
remote-time=true

## 进度保存设置 ##

# 从会话文件中读取下载任务
input-file=/home/ubuntu/.aria2/aria2.session

# 会话文件保存路径
# Aria2 退出时或指定的时间间隔会保存`错误/未完成`的下载任务到会话文件
save-session=/home/ubuntu/.aria2/aria2.session

# 任务状态改变后保存会话的间隔时间（秒）, 0 为仅在进程正常退出时保存, 默认:0
# 为了及时保存任务状态、防止任务丢失，此项值只建议设置为 1
save-session-interval=1

# 自动保存任务进度到控制文件(*.aria2)的间隔时间（秒），0 为仅在进程正常退出时保存，默认：60
# 此项值也会间接影响从内存中把缓存的数据写入磁盘的频率
# 想降低磁盘 IOPS (每秒读写次数)则提高间隔时间
# 想在意外非正常退出时尽量保存更多的下载进度则降低间隔时间
# 非正常退出：进程崩溃、系统崩溃、SIGKILL 信号、设备断电等
auto-save-interval=20

# 强制保存，即使任务已完成也保存信息到会话文件, 默认:false
# 开启后会在任务完成后保留 .aria2 文件，文件被移除且任务存在的情况下重启后会重新下载。
# 关闭后已完成的任务列表会在重启后清空。
force-save=false

## 下载连接设置 ##

# 文件未找到重试次数，默认:0 (禁用)
# 重试时同时会记录重试次数，所以也需要设置 max-tries 这个选项
max-file-not-found=10

# 最大尝试次数，0 表示无限，默认:5
max-tries=0

# 重试等待时间（秒）, 默认:0 (禁用)
retry-wait=10

# 连接超时时间（秒）。默认：60
connect-timeout=10

# 超时时间（秒）。默认：60
timeout=10

# 最大同时下载任务数, 运行时可修改, 默认:5
max-concurrent-downloads=20

# 单服务器最大连接线程数, 任务添加时可指定, 默认:1
# 最大值为 16 (增强版无限制), 且受限于单任务最大连接线程数(split)所设定的值。
max-connection-per-server=16

# 单任务最大连接线程数, 任务添加时可指定, 默认:5
split=64

# 文件最小分段大小, 添加时可指定, 取值范围 1M-1024M (增强版最小值为 1K), 默认:20M
# 比如此项值为 10M, 当文件为 20MB 会分成两段并使用两个来源下载, 文件为 15MB 则只使用一个来源下载。
# 理论上值越小使用下载分段就越多，所能获得的实际线程数就越大，下载速度就越快，但受限于所下载文件服务器的策略。
min-split-size=4M

# HTTP/FTP 下载分片大小，所有分割都必须是此项值的倍数，最小值为 1M (增强版为 1K)，默认：1M
piece-length=1M

# 允许分片大小变化。默认：false
# false：当分片大小与控制文件中的不同时将会中止下载
# true：丢失部分下载进度继续下载
allow-piece-length-change=true

# 最低下载速度限制。当下载速度低于或等于此选项的值时关闭连接（增强版本为重连），此选项与 BT 下载无关。单位 K 或 M ，默认：0 (无限制)
lowest-speed-limit=0

# 全局最大下载速度限制, 运行时可修改, 默认：0 (无限制)
max-overall-download-limit=0

# 单任务下载速度限制, 默认：0 (无限制)
max-download-limit=0

# 禁用 IPv6, 默认:false
disable-ipv6=true

# GZip 支持，默认:false
http-accept-gzip=true

# URI 复用，默认: true
reuse-uri=false

# 禁用 netrc 支持，默认:false
no-netrc=true

# 允许覆盖，当相关控制文件(.aria2)不存在时从头开始重新下载。默认:false
allow-overwrite=false

# 文件自动重命名，此选项仅在 HTTP(S)/FTP 下载中有效。新文件名在名称之后扩展名之前加上一个点和一个数字（1..9999）。默认:true
auto-file-renaming=true

# 使用 UTF-8 处理 Content-Disposition ，默认:false
content-disposition-default-utf8=true

# 最低 TLS 版本，可选：TLSv1.1、TLSv1.2、TLSv1.3 默认:TLSv1.2
#min-tls-version=TLSv1.2

## BT/PT 下载设置 ##

# BT 监听端口(TCP), 默认:6881-6999
# 直通外网的设备，比如 VPS ，务必配置防火墙和安全组策略允许此端口入站
# 内网环境的设备，比如 NAS ，除了防火墙设置，还需在路由器设置外网端口转发到此端口
listen-port=51413

# DHT 网络与 UDP tracker 监听端口(UDP), 默认:6881-6999
# 因协议不同，可以与 BT 监听端口使用相同的端口，方便配置防火墙和端口转发策略。
dht-listen-port=51413

# 启用 IPv4 DHT 功能, PT 下载(私有种子)会自动禁用, 默认:true
enable-dht=true

# 启用 IPv6 DHT 功能, PT 下载(私有种子)会自动禁用，默认:false
# 在没有 IPv6 支持的环境开启可能会导致 DHT 功能异常
enable-dht6=false

# 指定 BT 和 DHT 网络中的 IP 地址
# 使用场景：在家庭宽带没有公网 IP 的情况下可以把 BT 和 DHT 监听端口转发至具有公网 IP 的服务器，在此填写服务器的 IP ，可以提升 BT 下载速率。
#bt-external-ip=

# IPv4 DHT 文件路径，默认：$HOME/.aria2/dht.dat
dht-file-path=/home/ubuntu/.aria2/dht.dat

# IPv6 DHT 文件路径，默认：$HOME/.aria2/dht6.dat
dht-file-path6=/home/ubuntu/.aria2/dht6.dat

# IPv4 DHT 网络引导节点
dht-entry-point=dht.transmissionbt.com:6881

# IPv6 DHT 网络引导节点
dht-entry-point6=dht.transmissionbt.com:6881

# 本地节点发现, PT 下载(私有种子)会自动禁用 默认:false
bt-enable-lpd=true

# 指定用于本地节点发现的接口，可能的值：接口，IP地址
# 如果未指定此选项，则选择默认接口。
#bt-lpd-interface=

# 启用节点交换, PT 下载(私有种子)会自动禁用, 默认:true
enable-peer-exchange=true

# BT 下载最大连接数（单任务），运行时可修改。0 为不限制，默认:55
# 理想情况下连接数越多下载越快，但在实际情况是只有少部分连接到的做种者上传速度快，其余的上传慢或者不上传。
# 如果不限制，当下载非常热门的种子或任务数非常多时可能会因连接数过多导致进程崩溃或网络阻塞。
# 进程崩溃：如果设备 CPU 性能一般，连接数过多导致 CPU 占用过高，因资源不足 Aria2 进程会强制被终结。
# 网络阻塞：在内网环境下，即使下载没有占满带宽也会导致其它设备无法正常上网。因远古低性能路由器的转发性能瓶颈导致。
bt-max-peers=128

# BT 下载期望速度值（单任务），运行时可修改。单位 K 或 M 。默认:50K
# BT 下载速度低于此选项值时会临时提高连接数来获得更快的下载速度，不过前提是有更多的做种者可供连接。
# 实测临时提高连接数没有上限，但不会像不做限制一样无限增加，会根据算法进行合理的动态调节。
bt-request-peer-speed-limit=10M

# 全局最大上传速度限制, 运行时可修改, 默认:0 (无限制)
# 设置过低可能影响 BT 下载速度
max-overall-upload-limit=2M

# 单任务上传速度限制, 默认:0 (无限制)
max-upload-limit=0

# 最小分享率。当种子的分享率达到此选项设置的值时停止做种, 0 为一直做种, 默认:1.0
# 强烈建议您将此选项设置为大于等于 1.0
seed-ratio=1.0

# 最小做种时间（分钟）。设置为 0 时将在 BT 任务下载完成后停止做种。
seed-time=0

# 做种前检查文件哈希, 默认:true
bt-hash-check-seed=true

# 继续之前的BT任务时, 无需再次校验, 默认:false
bt-seed-unverified=false

# BT tracker 服务器连接超时时间（秒）。默认：60
# 建立连接后，此选项无效，将使用 bt-tracker-timeout 选项的值
bt-tracker-connect-timeout=10

# BT tracker 服务器超时时间（秒）。默认：60
bt-tracker-timeout=10

# BT 服务器连接间隔时间（秒）。默认：0 (自动)
#bt-tracker-interval=0

# BT 下载优先下载文件开头或结尾
bt-prioritize-piece=head=32M,tail=32M

# 保存通过 WebUI(RPC) 上传的种子文件(.torrent)，默认:true
# 所有涉及种子文件保存的选项都建议开启，不保存种子文件有任务丢失的风险。
# 通过 RPC 自定义临时下载目录可能不会保存种子文件。
rpc-save-upload-metadata=true

# 下载种子文件(.torrent)自动开始下载, 默认:true，可选：false|mem
# true：保存种子文件
# false：仅下载种子文件
# mem：将种子保存在内存中
follow-torrent=true

# 种子文件下载完后暂停任务，默认：false
# 在开启 follow-torrent 选项后下载种子文件或磁力会自动开始下载任务进行下载，而同时开启当此选项后会建立相关任务并暂停。
pause-metadata=false

# 保存磁力链接元数据为种子文件(.torrent), 默认:false
bt-save-metadata=true

# 加载已保存的元数据文件(.torrent)，默认:false
bt-load-saved-metadata=true

# 删除 BT 下载任务中未选择文件，默认:false
bt-remove-unselected-file=true

# BT强制加密, 默认: false
# 启用后将拒绝旧的 BT 握手协议并仅使用混淆握手及加密。可以解决部分运营商对 BT 下载的封锁，且有一定的防版权投诉与迅雷吸血效果。
# 此选项相当于后面两个选项(bt-require-crypto=true, bt-min-crypto-level=arc4)的快捷开启方式，但不会修改这两个选项的值。
bt-force-encryption=true

# BT加密需求，默认：false
# 启用后拒绝与旧的 BitTorrent 握手协议(\19BitTorrent protocol)建立连接，始终使用混淆处理握手。
#bt-require-crypto=true

# BT最低加密等级，可选：plain（明文），arc4（加密），默认：plain
#bt-min-crypto-level=arc4

# 分离仅做种任务，默认：false
# 从正在下载的任务中排除已经下载完成且正在做种的任务，并开始等待列表中的下一个任务。
bt-detach-seed-only=true

## 客户端伪装 ##

# 自定义 User Agent
user-agent=Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/93.0.4577.63 Safari/537.36 Edg/93.0.961.47

# BT 客户端伪装
# PT 下载需要保持 user-agent 和 peer-agent 两个参数一致
# 部分 PT 站对 Aria2 有特殊封禁机制，客户端伪装不一定有效，且有封禁账号的风险。
#user-agent=Deluge 1.3.15
peer-agent=Deluge 1.3.15
peer-id-prefix=-DE13F0-

## 执行额外命令 ##

# 下载停止后执行的命令
# 从 正在下载 到 删除、错误、完成 时触发。暂停被标记为未开始下载，故与此项无关。
#on-download-stop=/home/ubuntu/.aria2/delete.sh

# 下载完成后执行的命令
# 此项未定义则执行 下载停止后执行的命令 (on-download-stop)
#on-download-complete=/home/ubuntu/.aria2/clean.sh

# 下载错误后执行的命令
# 此项未定义则执行 下载停止后执行的命令 (on-download-stop)
#on-download-error=

# 下载暂停后执行的命令
#on-download-pause=

# 下载开始后执行的命令
#on-download-start=

# BT 下载完成后执行的命令
#on-bt-download-complete=

## RPC 设置 ##

# 启用 JSON-RPC/XML-RPC 服务器, 默认:false
enable-rpc=true

# 接受所有远程请求, 默认:false
rpc-allow-origin-all=true

# 允许外部访问, 默认:false
rpc-listen-all=true

# RPC 监听端口, 默认:6800
rpc-listen-port=6800

# RPC 密钥
rpc-secret=P3TERX

# RPC 最大请求大小
rpc-max-request-size=10M

# RPC 服务 SSL/TLS 加密, 默认：false
# 启用加密后必须使用 https 或者 wss 协议连接
# 不推荐开启，建议使用 web server 反向代理，比如 Nginx、Caddy ，灵活性更强。
#rpc-secure=false

# 在 RPC 服务中启用 SSL/TLS 加密时的证书文件(.pem/.crt)
#rpc-certificate=/home/ubuntu/.aria2/xxx.pem

# 在 RPC 服务中启用 SSL/TLS 加密时的私钥文件(.key)
#rpc-private-key=/home/ubuntu/.aria2/xxx.key

# 事件轮询方式, 可选：epoll, kqueue, port, poll, select, 不同系统默认值不同
#event-poll=select

## 高级选项 ##

# 启用异步 DNS 功能。默认：true
#async-dns=true

# 指定异步 DNS 服务器列表，未指定则从 /etc/resolv.conf 中读取。
#async-dns-server=119.29.29.29,223.5.5.5,8.8.8.8,1.1.1.1

# 指定单个网络接口，可能的值：接口，IP地址，主机名
# 如果接口具有多个 IP 地址，则建议指定 IP 地址。
# 已知指定网络接口会影响依赖本地 RPC 的连接的功能场景，即通过 localhost 和 127.0.0.1 无法与 Aria2 服务端进行讯通。
#interface=

# 指定多个网络接口，多个值之间使用逗号(,)分隔。
# 使用 interface 选项时会忽略此项。
#multiple-interface=

## 日志设置 ##

# 日志文件保存路径，忽略或设置为空为不保存，默认：不保存
#log=

# 日志级别，可选 debug, info, notice, warn, error 。默认：debug
#log-level=warn

# 控制台日志级别，可选 debug, info, notice, warn, error ，默认：notice
console-log-level=notice

# 安静模式，禁止在控制台输出日志，默认：false
quiet=false

# 下载进度摘要输出间隔时间（秒），0 为禁止输出。默认：60
summary-interval=0

## BitTorrent trackers ##
# bt-tracker=
```

将其保存在`$HOME/.aria2/aria2.conf`即可。另外需要将[aria2.conf](https://github.com/P3TERX/aria2.conf)的`dht.dat`和`dht6.dat`保存到`$HOME/.aria2/`。

```bash
wget -Y on https://github.com/P3TERX/aria2.conf/raw/master/dht.dat
wget -Y on https://github.com/P3TERX/aria2.conf/raw/master/dht6.dat
touch aria2.session
```

增加systemd配置`aria2.service`。

```ini
[Unit]
Description=aria2 - The ultra fast download utility
After=network.target nss-lookup.target

[Service]
User=ubuntu
NoNewPrivileges=true
ExecStart=aria2c --conf-path= /home/ubuntu/.aria2/aria2.conf
Restart=on-failure
RestartSec=10s
LimitNOFILE=infinity

[Install]
WantedBy=multi-user.target
```

启动服务：

```bash
sudo cp aria2.service /etc/systemd/system
sudo systemctl enable aria2.service
sudo systemctl start aria2.service
sudo systemctl status aria2.service
```

#### WebUI

强烈推荐使用WebUI来管理aria2的任务，因为很多任务下载耗时，多任务管理也更有优势。[AriaNg](https://github.com/mayswind/AriaNg)是一个洁面简洁的管理面板，安装也很简单：

```bash
# 下载资源
wget -Y on https://github.com/mayswind/AriaNg/releases/download/1.3.6/AriaNg-1.3.6-AllInOne.zip
unzip AriaNg-1.3.6-AllInOne.zip
# 直接复制到nginx的默认静态资源页面即可
sudo mkdir /var/www/html/AriaNg
sudo cp index.html /var/www/html/AriaNg/
```

好的，现在直接访问NAS服务即可，比如`http://192.168.31.3/AriaNg`。

![Pasted image 20230614214332.png](/assets/Pasted%20image%2020230614214332.png)

##### 未认证/Unauthorized

这是因为你没有输入正确aria2的RPC密码，该密码通过配置项`rpc-secret`修改。AriaNg可以在`AriaNg设置->RPC`处修改，如图：

![Pasted image 20230614215046.png](/assets/Pasted%20image%2020230614215046.png)

### frp

- [frp安装文档](https://gofrp.org/docs/setup/)
- [frp](https://github.com/fatedier/frp)

内网穿透
1. 设置tcp范围穿透，范围6000～7000，[参考](https://github.com/fatedier/frp#range-ports-mapping)；随后自建服务都尽量使用6000～7000
2. 设置`nas.galacoding.fun`, `*.nas.galacoding.fun` 全部转发到本机80端口，本机nginx根据hostname转发的各个服务，[参考](https://github.com/fatedier/frp/issues/2641)；这样所有挂在ngnix的web服务都直接可以使用穿透；
3. 穿透smb服务；

随后可以研究下frpc的xtcp模式，支持点对点内网穿透，挺好玩的。

### Samba

NAS上Samba必备，用于Mac，window访问你的服务器文件系统，共建资料，备份数据等。

```bash
# 安装samba服务器
sudo apt-get install samba samba-common
# 创建一个用于分享的samba目录
sudo mkdir /home/ubuntu/share
# donot forgot to add user to samba's database
sudo smbpasswd -a ubuntu
# 配置samba的配置文件, 确保共享的文件夹该用户有权限即可
sudo vim /etc/samba/smb.conf
# 重启samba服务器
sudo service smbd restart
```

配置：

```ini
[data1]
comment = share folder
browseable = yes
path = /data1
create mask = 0777
directory mask = 0777
valid users = ghome
force user = ghome
force group = ghome
public = yes
available = yes
writable = yes

[data2]
comment = share folder
browseable = yes
path = /data2
create mask = 0777
directory mask = 0777
valid users = ghome
force user = ghome
force group = ghome
public = yes
available = yes
writable = yes
```

一些资料：
- `如何正确使用Samba`
- https://github.com/samba-team/samba
- https://wiki.samba.org/index.php/FAQ
- https://wiki.samba.org/index.php/User_Documentation
- https://www.linuxidc.com/Linux/2018-11/155466.htm

