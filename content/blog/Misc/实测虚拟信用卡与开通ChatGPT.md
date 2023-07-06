---
author: 攻城狮Gala
categories:
    - Misc
date: 2023-06-10T18:56:56+08:00
draft: false
image: /assets/cardmapr-nl-s8F8yglbpjo-unsplash.jpg
keywords:
    - Misc
    - ChatGPT
    - Web3
    - 趣玩
tags:
    - ChatGPT
    - Web3
    - 趣玩
title: 实测虚拟信用卡与开通ChatGPT
---

<!----- [ChatGPT](/tags/ChatGPT) [Web3](/tags/Web3) [趣玩](/tags/趣玩) ----->

欢迎关注 **“攻城狮Gala”公/ 众 /号** ，每天一起学习，努力成为Web3全栈

## 背景

办理虚拟信用卡的目的主要是开通ChatGPT，因为OpenAI的限制在中国是无法直接访问ChatGPT，同时也无法继续使用OpenAI的API。

OpenAI的API才是大杀器，可以让你实现自己ChatGPT或者搭建AutoGPT。最开始的时候申请了一个试用期，大概额度是18$，目前已经到期，所以亟需开通付费，倒是chatGPT Plus不着急开通。

## 虚拟信用卡

虚拟信用卡其实就是没有实体卡而已，一般就是办理Visa或者Mastercard，经过检索，找到几个不错的虚拟信用卡供应商。202306月份OneKey Card新增美国Viasa卡，推荐使用OneKey Card。

### LimaoPay

这个[LimaoPay](https://www.limaopay.com/register/#/register?codes=DpMXg5cW)是在B站上看到的，体验了下是一个简易的供应商，需要**实名注册和人脸验证**。好在提供的信用卡好段丰富，选择一个美国号段信用开卡即可。

比较坑的是手续费，每次充值都会有手续费，人民币转美元还有一次手续费收取，开卡也有费用。充值250元人民币，兑换33.33元美元。美元兑换汇率`7.1988`，是在`2023-06-09`。在线充值手续费4%。

值得一提是，充值目前只支持微信支付，对国内比较友好。

#### 开卡

可以开`559666`卡段的美国虚拟卡，注意是预付制信用卡，亲测可以使用ChatGPT，卡费有`1.5$`，首次充值最少`20$`。

![Pasted image 20230610150239.png](/assets/Pasted%20image%2020230610150239.png)

开卡过程很简单，值得说明是选填信息的开卡国家可以不用填。

#### 风险提示

该供应商比较小众，切勿大额充值，如果平台运营稳定，可以使用很久，如果出现问题也需要迁移到其他虚拟信用卡平台，所以切勿大额充值。

### OneKey Card

之前在网上搜到[OneKey Card](https://card.onekey.so/?i=J0NTH2)可以支持ChatGPT订阅，但是现在官网显示已经不可以了，实测也是被拒。注册需要**实名制+人脸认证**。

OneKey Card比较有特点的是只能使用虚拟货币充值，信用卡只有香港卡段。

#### 开卡

有两个香港卡段，花美元多建议`493`卡段，注意是预付制信用卡。

![Pasted image 20230610151513.png](/assets/Pasted%20image%2020230610151513.png)

充值实测，转账`31$`，卡费`1$`，卡余额`29.38$`。充值手续费`1.95%`，最低充值`30$`，如果充值USDT有一点点汇率相对于USDC而言。

消费为非USD时有`1.25%`货币转换费，也就是说人民币消费场景时你的消费力打折`3.17%`，包含充值手续费+转换费。境外消费时可以用一下。

> Note: 其实在区块链网络发送稳定币也是要交易费的，不过这个费用是固定的不是按百分比收取，且不同交易所和网络转账费用不同。

#### 20230614更新

[OneKey Card](https://card.onekey.so/?i=J0NTH2)增加美国优选卡，可以支持ChatGPT / OpenAI充值啦～开卡和之前一样，非常简单。同时费率不变，参考之前的计算结果。

![Pasted image 20230614163449.png](/assets/Pasted%20image%2020230614163449.png)

### 其他供应商

在其他文章也找到一些虚拟信用卡的供应商，比如比较知名的Qbit Visa，Payoneer，但是需要企业开户或者需要境外网店入账100美元，操作复杂度更高，暂时放弃。

Depay很多网友反馈也可以付费ChatGPT，但是目前停止新用户注册，无法实测。

## 付费ChatGPT

根据上线实测，使用[OneKey Card](https://card.onekey.so/?i=J0NTH2)或[LimaoPay](https://www.limaopay.com/register/#/register?codes=DpMXg5cW)可以付费成功。

本文章只介绍OpenAI的API付费，ChatGPT Plus应该是一样的。登陆[OpenAI Platform](https://platform.openai.com/account/billing/payment-methods)网址，找到`Billing->Payment methods`，点击`Add payment method`。

由于使用新加坡的IP，所以在[这个网站](https://www.meiguodizhi.com/sg-address)生成新加坡的虚拟地址填入表单。

>Note: 如果采用虚拟卡进行开通，部分虚拟卡开通的时候会随机生成一个地址，如果这个时候为大家提供了地址，我们就可以直接使用这个虚拟地址，使用起来非常的方便。
>
>如果虚拟信用卡并会向大家提供相应的地址，我们可以尝试生成地址，接下来只需要直接填写就可以，操作起来非常的简单。

![Pasted image 20230610152942.png](/assets/Pasted%20image%2020230610152942.png)

申请时候信用卡的ZIP直接拷贝生成地址的邮编，点击Submit即可。添加成功后会直接扣款`5$`，随后按照使用额度付费。

>Note: 对于个人使用场景，20$真的可以使用很久了～

### 获得API Secret

在[API Keys](https://platform.openai.com/account/api-keys)页面可以查到所有Keys，也可以生成新的Key，注意保存，不要随便暴露，如果发现你的Key被滥用及时删除。

![Pasted image 20230610161403.png](/assets/Pasted%20image%2020230610161403.png)

> Note: 目前API无法使用`GPT-4`，需要加入Waitlist，或者等公测，最新的就是`gpt-3.5-turbo`。

![2022_03_wxsousuo.png](/assets/2022_03_wxsousuo.png)

