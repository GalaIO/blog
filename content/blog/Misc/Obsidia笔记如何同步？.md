---
author: 攻城狮Gala
categories:
    - Misc
date: 2022-03-31T21:03:38+08:00
draft: false
image: /assets/2022_03_20220330233357.png
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
title: Obsidia笔记如何同步？
---

<!----- [obsidian](/tags/obsidian) [知识管理](/tags/知识管理) [效率](/tags/效率) [笔记同步](/tags/笔记同步)  ----->

欢迎关注 **“攻城狮Gala”公/ 众 /号** ，每天一起学习，努力成为Web3全栈

>摘要：如果使用S3同步笔记太痛苦，不如尝试使用Git服务同步吧。

## 笔记同步

从云笔记迁移到开源笔记产品后，对于写笔记的体验和效率提升确实巨大。不过对于提供收费服务的产品来说，有一些服务时开源笔记无法提供。其中一点就是笔记同步。

笔记同步的需求主要在于，你可能会在多台设备阅读或者编辑笔记，这时候需要保持多设备之间的数据一致。

当前主流的几种同步方式，无非是S3、云存储、git等。我折腾的目的就是使用开源自建的服务，所以第一个尝试的就是S3。

## 使用S3

[S3](https://aws.amazon.com/cn/s3/) 来源于AWS的对象存储服务，后来作为一个标准协议，出现很多云服务商、开源软件的S2兼容协议API，所以你可以发现S3出现在各种有关存储的地方，应用已经比较广泛了。

### MinIO搭建

[MinIO](https://docs.min.io/)是一个开源对象服务器，使用Go实现，可以兼容AWS S3 Api，可以用来同步笔记内容，随后也可以再一次性同步回自己的Nas做北非，线上S3同步参考[RClone](https://rclone.org/)。

执行如下命令部署MinIO：

```bash
wget https://dl.min.io/server/minio/release/linux-amd64/minio
chmod +x minio
MINIO_ROOT_USER=test MINIO_ROOT_PASSWORD=test ./minio server ./ --console-address ":9001"
```

随后你会得到如下输出：

```bash
API: http://172.22.0.15:9000  http://127.0.0.1:9000

Console: http://172.22.0.15:9001 http://127.0.0.1:9001
```

这个是admin用户，可以直接作为key和secret访问。

### TLS配置

为了可以在android和mac同时使用，最好有域名，并且申请好TLS证书，否则无法使用([android升级后必须使用安全的协议](https://stackoverflow.com/questions/45940861/android-8-cleartext-http-traffic-not-permitted)、[I can not connect to a non-HTTPS WebDav server. Why?](https://www.tacit.dk/foldersync/faq/#i-can-not-connect-to-a-non-https-webdav-server-why))。你可以使用nginx代理https，转发到http端口。

>注意MinIO不支持http/2，千万别在代理配置的时候打开http/2，我折腾好久，差点折在这。。。

### 手机端同步

搭建好S3服务器后，需要对应的客户端搭配。在android手机端，推荐使用foldersync免费版。

打开软件，建立账户，并使用如下配置。

> 注意自定义端点的`/`要保留。随后在同步设置时选择对应的bucket文件夹。

```bash
Access key ID: test
Secret access key: test
自定义端点：https://s3.xxxxx.com/
区域：随便选一个
```

### Obsidian插件配置

除了使用S3客户端，同时可以在Obsidian安装`Remotely Save`插件，进行同步。

配置如下：

```bash
S3Endpoint：https://s3.xxxxx.com
S3Region: us
S3AccessKeyID: test
S3SecretAccessKey: test
S3BucketName: bj
```

配置完成后，check一下。如果显示成功，随后就可以配置定期备份。

### S3同步缺点

S3解决了文件在多设备同步问题，但是无法记录文件的重命名、移动等等，所以如果对笔记的文件夹修改，S3服务端无法感知，导致旧文件和新文件同时存在。

同样的如果在多设备对同一文件进行修改，出现冲突也是非常头疼。如果你存在这种场景S3并不是最优解。

## 使用Git

对于存在多设备修改进行同步的场景，Git服务同步更适合你，而不是S3服务。对于Git服务如何应用在Obsidian笔记同步，有一篇文章介绍[Obsidian的Git同步原理](https://medium.com/analytics-vidhya/how-i-put-my-mind-under-version-control-24caea37b8a5)。

简单理解就是，现在本地建立好仓库，每次更新笔记使用`git commit -m`变成一次提交，并上传`git push`。在其他设备需要修改时，先`git pull`拉取远程更新，如果出现冲突，进行修改并再次提交即可。

### 建立仓库

推荐使用Github或者其他私有Git服务来同步笔记，毕竟是隐私数据，需要做好保护。

需要注意的是忽略文件，避免提交不必要的数据，导致频繁冲突。我使用的`.gitignore`文件如下：

```bash
.obsidian/cache
.obsidian/workspace
.trash
.DS_Store
```

### 插件推荐

上节提到的文件，介绍Git同步的原理，需要不断上传和拉取。在Obsidian的插件市场，有一款可以代替你执行-[Obsidian的Git插件](https://github.com/denolehov/obsidian-git)。

该插件可以设置定时提交和拉取，同时指定提交信息、分支、同步模式等等，确实够用了。

![2022_03_20220327224705.png](/assets/2022_03_20220327224705.png)

### 使用体验

使用Git同步后，对文件夹修改、文件重命名、修改内容等再也不会担心会冲突，也不存在需要对本地和远程同时修改的情况。完美解决我的需求，赞！

![2022_03_wxsousuo.png](/assets/2022_03_wxsousuo.png)

