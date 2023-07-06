---
author: 攻城狮Gala
categories:
    - DevOps
date: 2023-07-03T22:46:14+08:00
draft: false
image: /assets/Pasted%20image%2020230703224931.png
keywords:
    - DevOps
    - 趣玩
    - Cloudflare
tags:
    - 趣玩
    - Cloudflare
title: 使用CloudFlare Pages托管网站
---

<!----- [趣玩](/tags/趣玩) [Cloudflare](/tags/Cloudflare)  ----->

欢迎关注 **“攻城狮Gala”公/ 众 /号** ，每天一起学习，努力成为Web3全栈

如何白嫖省心的CloudFlare Pages服务？完美替代Github Pages，对大陆网络友好～

## 背景

之前自己重新开始写博客了，为了方便本地md笔记(参考[个人笔记新解-Obsidian]({{< relref "blog/Misc/个人笔记新解-Obsidian.md" >}}))可以publish到公网，重新选型博客系统，最后决定使用hugo，参考`Obsidian与Hugo的一拍即合`。

不过之前计划直接挂在服务器的nginx上，不过请求流量和访问稳定性都是问题，同时hugo是静态网站，可以直接放到Github Pages上，当然现在有新的选择了，就是ClouFlare Pages，相比Github的服务肯定大陆访问的稳定性更好～

## 简介

Cloudfalre Pages服务在2021年就可用了，参见[Cloudflare Pages is now Generally Available](https://blog.cloudflare.com/cloudflare-pages-ga/)。

可以通过链接你的github或者gitlab，当push到远端时，cf pages将自动构建部署。使用 Cloudflare Pages 开发的每个站点都部署到位于 100 多个国家/地区的 Cloudflare 数据中心网络。

同时还有如下特性：
1. **Built-in, free web analytics**，通过[Web Analytics](https://www.cloudflare.com/web-analytics/)，只需单击一下即可启用分析，并开始跟踪网站的进度和性能，包括有关流量和网络核心生命体征的指标。
2. **redirects file support**，通过将 `_redirects` 文件添加到项目的构建输出目录，您可以轻松地将用户重定向到正确的 URL。格式如`[source] [destination] [http code]`。
3. 其他特性：
1. **Protected previews with Cloudflare Access integration**，custom your access policy；
2. **Live previews with Cloudflare Tunnel**；
3. **Image compression**，**Device-based resizing**，**Gzip and Brotli**，**Device-based resizing**；
4. **A/B testing**，**Webhooks**；
5. Integrate with **Cloudflare Workers**；

## 部署

准备创建Clouflare Pages:

1. 登录 [Cloudflare dashboard](https://dash.cloudflare.com/)，选择你的账户.
2. 选择**Workers & Pages**，选择**Create application** > **Pages** > **Connect to Git**.

![Pasted image 20230703231008.png](/assets/Pasted%20image%2020230703231008.png)

> 推荐使用Git部署，虽然支持直接上传资产，但是链接git可以更好协同。

3. 链接Github，选择对应的仓库。

![Pasted image 20230703231158.png](/assets/Pasted%20image%2020230703231158.png)

![Pasted image 20230703231315.png](/assets/Pasted%20image%2020230703231315.png)

4. 选择仓库分支，并编辑构建命令，因为我的项目已经使用`github-pages-action`自动完成构建到分支`gh-pages`，所以跳过设置构建，其他框架构建参考[配置构建](https://developers.cloudflare.com/pages/platform/build-configuration)。

![Pasted image 20230703231820.png](/assets/Pasted%20image%2020230703231820.png)

5. 点击保存并部署，cf pages提供一个免费的二级域名访问测试。

![Pasted image 20230703232813.png](/assets/Pasted%20image%2020230703232813.png)

## 其他功能

### 查看pages程序

可以在`workers和pages`的概述中，浏览部署的程序和plan uasge情况，免费的每天有100000次请求，一般够用的。

![Pasted image 20230703233603.png](/assets/Pasted%20image%2020230703233603.png)

### 重定向域名

在pages的项目页，选择`自定义域`，点击`设置自定义域`，注意输入你已经转入cf的域名。

![Pasted image 20230703234328.png](/assets/Pasted%20image%2020230703234328.png)

输入域名后，cf会自动添加一个`CNAME`解析到对应域名，注意如果与原有域名冲突cf会提示。最后点击`激活域`完成激活。

![Pasted image 20230703234532.png](/assets/Pasted%20image%2020230703234532.png)

> 这里可以输入一级域名，也可以输入二级域名，比如`blog.xxx.com`。

### 启用Web Analysis

在项目的`设置`中，点击`启用Web analysis`，随后在[Cloudflare Web Analytics](https://www.cloudflare.com/web-analytics)查看网站流量。

![Pasted image 20230703233802.png](/assets/Pasted%20image%2020230703233802.png)

Web Analysis展示：

![Pasted image 20230703234032.png](/assets/Pasted%20image%2020230703234032.png)

## 最后

体验效果不错～欢迎大家按照步骤尝试～

![2022_03_wxsousuo.png](/assets/2022_03_wxsousuo.png)

