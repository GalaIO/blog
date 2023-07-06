---
author: 攻城狮Gala
categories:
    - Misc
date: 2022-03-21T20:50:29+08:00
draft: false
image: /assets/2022_03_20220321124411.png
keywords:
    - Misc
    - obsidian
    - 知识管理
    - 效率
    - 笔记同步
tags:
    - obsidian
    - 知识管理
    - 效率
    - 笔记同步
title: 个人笔记新解-Obsidian
---

<!----- [obsidian](/tags/obsidian) [知识管理](/tags/知识管理) [效率](/tags/效率) [笔记同步](/tags/笔记同步) ----->

欢迎关注 **“攻城狮Gala”公/ 众 /号** ，每天一起学习，努力成为Web3全栈

现有笔记太难用了，如何使用新的工具破局。自己之前一直在使用为知笔记，体验越来越糟糕。主要有几个原因：

1. 为知笔记的编辑器很难用，尤其是对md的支持很差；
2. 最近有备份需求，但是为知笔记新版本竟然去掉导出文件夹功能，对自己的笔记安全存在担心；
3. 一直在找可以写公众号的方式，至少一键复制到公众号，而为知笔记的使用体验太差了；
4. 搜索功能可以当做没有，好多次搜索文章没搜出来；
5. 没有笔记发现和关联功能，不好做笔记整理和知识积累；

经过一段时间调研决定使用新的笔记软件，具体是以`本地笔记+线上博客+自建服务`的形式完成笔记的记录同步和发表，重在折腾。

## 本地笔记-Obsidian

[Obsidian](https://obsidian.md/)笔记主要使用markdown格式，通过本地文件管理笔记，支持即时预览，同时支持知识管理。更重要的是Obsidian是一个免费的开源笔记，丰富的社区生态让Obsidian变得非常实用，有很多分享软件的使用方法，分享好用的插件。

### 笔记管理

记笔记是Obsidian最基本的功能，具体使用可以参考文章[玩转 Obsidian 01：打造知识循环利器](https://sspai.com/post/62414)。以markdown格式为主笔记也是好用的。

### ToDo任务

详见[参考](https://medium.com/geekculture/how-i-track-my-tasks-in-obsidian-47fd7ad80364)，使用Todo插件可以非常简单创建Todo，添加优先级，记录完成时间。

### 笔记同步

这个功能摸索是最痛苦的，因为喜欢折腾，所以收费的官方同步服务是不会使用的- -。

最开始选择的方案是WebDav，分为向mac+android同步。但是obsidian的三方插件的webdav太差劲了，根本没法用，手机采用foldersync需要设置https才能使用webdav([android升级后必须使用安全的协议](https://stackoverflow.com/questions/45940861/android-8-cleartext-http-traffic-not-permitted)、[I can not connect to a non-HTTPS WebDav server. Why?](https://www.tacit.dk/foldersync/faq/#i-can-not-connect-to-a-non-https-webdav-server-why))。

经过长期折腾后决定采用，S3作为存储服务，手机使用`foldersync`同步，mac使用三方插件`Remotely Save`。

>突然发现市面上针对S3的产品还挺多呀，生态丰富！！中间准备使用几个重量的方案，比如nextCloud等，而syncthing也不好用，设备不在一个子网下面，速度感人。幸好S3折腾成功了。

>但是用过一段时间S3也发现几个问题，首先是笔记的整理，比如重命名、移动位置，无法应用到S3上，导致笔记重复在多个位置。而且还存在一个编辑冲突的问题，如果多设备修改存在冲突怎么办？所以决定改为Git，也有三方插件支持。[Obsidia笔记如何同步？]({{< relref "blog/Misc/Obsidia笔记如何同步？.md" >}})

### 网页剪辑

网页剪辑的功能非常重要，主要是对文章可以下载进行存档，obsidian是纯粹的markdown的文本记录，所以最好剪辑成markdown的格式，推荐插件[markdown-clipper](https://chrome.google.com/webstore/detail/markdown-clipper/cjedbglnccaioiolemnfhjncicchinao)可以直接下载，非常适合obsidian。

### 表格

日常比较依赖表格做数据分类，obsidian对表格的支持不是很好，目前的实时预览是不支持表格的。所以能不使用表格就不用了，必要时可以拉起Typora来编辑表格。

## 本地笔记-[Joplin笔记](https://joplinapp.org/)

因为目前Obsidian的网页剪辑太难用了，所以使用Joplin来替代[网页剪辑](https://joplinapp.org/clipper/)和本地软件同步的功能，两个都可以用于主力笔记编辑。

不过obsidian有知识管理和即时预览功能，Joplin的生态工具更丰富。不过随后都辛苦解决了。目前主用obsidian。

## 线上博客

线上博客主要是分享文章，之前已经调研过一个博客，使用体验尚可，同时编辑器支持一键复制到公众号和知乎，还是很友好的。开源博客[pipe](https://github.com/88250/pipe)。搭建也比较简单，推荐使用docker搭建。

随后所有的博客都沉淀在pipe和公众号。本地笔记更多是非公开的工作日志内容。

## 自建服务-S3

[MinIO](https://docs.min.io/)是对象服务器，可以兼容aws s3 api，用来做同步中转的，随后再一次性同步回自己的Nas即可，线上S3同步参考[RClone](https://rclone.org/)。

```bash
wget https://dl.min.io/server/minio/release/linux-amd64/minio
chmod +x minio
MINIO_ROOT_USER=test MINIO_ROOT_PASSWORD=test ./minio server ./ --console-address ":9001"
```

会得到如下输出：

```bash
API: http://172.22.0.15:9000  http://127.0.0.1:9000

Console: http://172.22.0.15:9001 http://127.0.0.1:9001
```
这个是admin用户，可以直接作为key和secret访问。

### TLS配置

为了可以在android和mac同时使用，最好有域名，并且申请好TLS证书，否则无法使用，可以使用nginx代理。

>注意MinIO不支持http/2，千万别在代理配置的时候打开http/2，我折腾好久，差点折在这。。。

### foldersync配置

建立账户使用如下配置，注意自定义端点的`/`要保留。随后在同步设置时选择对应的bucket文件夹。

```bash
Access key ID: test
Secret access key: test
自定义端点：https://s3.xxxxx.com/
区域：随便选一个
```

### Remotely Save配置

配置结束，check一下如果成功，可以配置定期备份。

```bash
S3Endpoint：https://s3.xxxxx.com
S3Region: us
S3AccessKeyID: test
S3SecretAccessKey: test
S3BucketName: bj
```

## 自建服务-图床

图床对于笔记来说也很重要的，随后复制到线上或者转到公众号有一个图床可以方便复制笔记。研究图床使用，可以参考[这个](https://www.jianshu.com/p/4c30495f4325)，使用[picGo](https://github.com/wayjam/picgo-plugin-s3)来上传到图床，就是我的S3服务器了。

![2022_02_20220217152653.png](/assets/2022_02_20220217152653.png)

picGo默认不支持S3，需要从插件市场搜索下载，然后S3的配置需要注意，对于`MinIO`必须打开`PathStyleAccess`，而且为了随后可以访问，需要在自定义域名设置为`S3 Url + bucket`，比如`https://s3.test.com/images`，设置错误无法正常预览图片。

## Obsidian实践

Obsidian由于有丰富的开源生态，所以使用的体验还是很棒的。下面是一些使用经验分享给大家。

### 如何调试Obsidian

obsidian底层还是一个前端，当出现软件异常，可以直接打开调试看插件或者obsidian的报错即可，windows和linux使用`Ctrl-Shift-I` ，macOS是`cmd-opt-I`。

### 增加Banner

安装插件Banners即可，在[unsplash](https://unsplash.com/)搜你喜欢的图，然后输出命令`/banner`找到`add banner from clipboard`就快速添加到md头信息。同时`cmd+e`可以预览效果。

### 双向连接

有一篇不错的[文章](https://zhuanlan.zhihu.com/p/355344374)，介绍为什么使用MOC，以及有什么作用。用来管理笔记和积累知识体系很重要。

### 看板

obsidian有一个[三方插件](https://matthewmeye.rs/obsidian-kanban/)，非常简单创建看板用来管理进度或者任务。[Obsidian看板指北]({{< relref "blog/Misc/Obsidian看板指北.md" >}})

![2022_02_20220222125027.png](/assets/2022_02_20220222125027.png)

### 大纲

可以在核心插件中打开大纲的功能，在右侧栏显示笔记大纲，功能很好用。

### 笔记漫游

可以在核心插件中打开笔记漫游，随机查看历史笔记，是一个不错的笔记发现功能。

### 模板

可以在核心插件中打开模板功能，设置模板文件夹，我这里是新建`Templates`文件夹作为模板目录，随后通过左侧栏使用模板，快速创建格式固定的笔记，比如任务、学习笔记等等。更多设置[参考](https://publish.obsidian.md/help-zh/%E6%8F%92%E4%BB%B6/%E6%A8%A1%E6%9D%BF)

设置模板的几个变量，日期：`{{date}}`，时间`{{time}}`，标题`{{title}}`。[Obsidian模板指北]({{< relref "blog/Misc/Obsidian模板指北.md" >}})

### 其他玩法与插件

可以自行搜索，网上对于obsidian的用法还是很多的。比如[这篇](https://forum-zh.obsidian.md/t/topic/194)。

### 快捷键

梳理下自己使用的快捷键，这里面根据自己的习惯对快捷键进行了修改，大家可以做个参考。

| 快捷键            | 功能                       | 备注 |
| ----------------- | -------------------------- | ---- |
| `cmd+.`           | 插入代码块                 |      |
| `cmd+e`           | 预览和编辑模式切换         |      |
| `cmd+w`           | 关闭当前文件               |      |
| `cmd+q`           | 关闭当前程序               |      |
| `cmd+o`           | 选择历史浏览的文件         |      |
| `cmd+p`           | 打开命令面板               |      |
| `cmd+1`           | 使用默认程序打开当前文件   |      |
| `cmd+2`           | 插入模板                   |      |
| `cmd+3`           | 固定当前tab页              |      |
| `cmd+4`           | 使用笔记漫游               |      |
| `cmd+t`           | 新增编辑当前TODO任务       |      |
| `cmd+s`           | 保存当前文件               |      |
| `cmd+opt+i`       | 打开调试模式               |      |
| `cmd+l`           | 快速添加超链接             |      |
| `#`               | 快速添加标签               |      |
| `[[`              | 快速添加双链               |      |
| `>`               | 快速添加引用               |      |
| `-`               | 快速添加列表               |      |
| `cmd+,`           | 快速添加引用               |      |
| `cmd+;`           | 快速添加文字加粗 **123**   |      |
| `cmd+shift+f`     | 启动全局文件搜索           |      |
| `cmd+f`           | 本地文件搜索               |      |
| `cmd+'`           | 文本斜体 *123*             |      |
| `cmd+;` + `cmd+'` | 文本加粗斜体 ***123***     |      |
| `cmd+enter`       | 快速创建列表、checkbox切换 |      |
| `cmd+/`           | 文本高亮 ==123==           |      |
| `cmd+[`           | 快速插入双链               |      |
| `cmd+opt+->`      | 切到下一个笔记             |      |
| `cmd+opt+<-`      | 切到上一个笔记             |      |

## 总结

折腾还是很累的，不过很有成就感。新的笔记记录非常方便，除了表格没之前灵活以外，其他的功能都满足我的需求。而且笔记关联可以让我更好的拆分想法，进行管理。同时看板功能非常好用，可以用于日常任务管理。

![2022_03_wxsousuo.png](/assets/2022_03_wxsousuo.png)

