---
author: 攻城狮Gala
categories:
    - Coding
date: 2022-03-31T21:00:22+08:00
draft: false
image: /assets/2022_03_20220330232734.png
keywords:
    - Coding
    - 笔记同步
    - 趣玩
    - Git
tags:
    - 笔记同步
    - 趣玩
    - Git
title: Git部署与使用
---

<!----- [笔记同步](/tags/笔记同步) [趣玩](/tags/趣玩) [Git](/tags/Git) ----->

欢迎关注 **“攻城狮Gala”公/ 众 /号** ，每天一起学习，努力成为Web3全栈

>摘要：当你有自己的服务器，同时期望私有化进行版本管理内容 or 代码，部署自己的Git服务器是一个绝佳选择。

## 背景

之前折腾笔记同步，虽然已经有S3可以在不同设备同步内容，但是对于不同设备同时修改或者出现编辑冲突时，使用S3变成噩梦，无法处理这种情况。

这时候Git作为版本化管理工具，可以完美解决这种问题。同时本着折腾的精神，决定在自己的云服务器部署Git服务，而不是使用Github的免费私有仓库。

> 选择自建服务还有两点：1.基于github的国内的访问速度；2.对私有数据的隐私保护；

## 服务端搭建

### Git服务器部署
在Git服务器选项方面，采用[gogs](https://gogs.io/)，gogs是使用Go开发的Git服务器，自带Web UI管理界面，非常赞。

部署的话自然是使用`docker`，部署方便之极，依赖docker和docker-compose，安装的自行找资料吧，比较简单。

下面是docker-compos.yaml配置，gogs容器需要挂载整个`/data`目录，来保存生成的数据。

```yaml
version: '2'

services:
db:
container_name: gogs_db
image: mysql
volumes:
- "./mysql/data:/var/lib/mysql"
- "./mysql/conf.d:/etc/mysql/conf.d"
command: mysqld --lower_case_table_names=1 --character-set-server=utf8mb4 --collation-server=utf8mb4_general_ci
restart: always
environment:
MYSQL_USER: gogs
MYSQL_PASSWORD: 123456
MYSQL_ROOT_PASSWORD: 123456
MYSQL_DATABASE: gogs

gogs:
container_name: gogs
depends_on:
- db
image: docker.io/gogs/gogs:latest
links:
- db
ports:
- "10022:22"
- "13000:3000"
volumes:
- ./gogs/:/data
restart: always

```

> 注意`mysql 8.0`后root用户登录密码采用加密验证了，所以建议新增一个专用的账户来登录mysql，而不是使用root登录。

在docker-compose.yaml的目录，执行如下命令启动服务：

```bash
docker-compose up -d
```

### 设置域名

强烈建议设置域名使用你的git服务，同时启用https。当前android等系统已经要求访问链接必须是https。

我的服务就设置了对应https访问，命名可以做个参考：

```bash
https://git.xxx.com -> localhost:13000
https://gitssh.xxx.com -> localhost:10022
```

### Git服务器初始化

启动后访问`http://127.0.0.1:13000`，启动后页面初始化，注意填写数据库主机时使用docker的container作为ip即可。

![2022_02_20220220104648.png](/assets/2022_02_20220220104648.png)

应用设置的时候，填写相应的域名。

![2022_02_20220220104848.png](/assets/2022_02_20220220104848.png)

点击最下面的立即安装，等待片刻。安装成功后可以登录，并创建你的仓库。

![2022_03_20220327214948.png](/assets/2022_03_20220327214948.png)

## 客户端

如何从Git服务拉取仓库，并同步本地更改呢？下面介绍几个操作系统的客户端。

### Win/Mac客户端

对于PC操作系统来说，git安装非常方便。访问[git官网](https://git-scm.com/downloads)就有安装教程。

### Android客户端

对于android来说，目前也有一些选择，我使用的是[MGit](https://github.com/maks/MGit)。体验还可以，如果是私有仓库会记住你的账户密码进行拉取。

## 总结

Git服务搭建好后，可以非常方便应对类似笔记这种，内容变化后各设备同步的场景。以后除了同步笔记外，还可以作为个人私有代码仓库使用。

![2022_03_wxsousuo.png](/assets/2022_03_wxsousuo.png)

