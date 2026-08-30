# FotMob 去广告

用于 Loon 的 FotMob iOS / iPadOS 去广告插件。规则来自对 FotMob 客户端实际请求的分析，采用精确 URL 匹配，避免拦截比分、比赛详情、新闻、图片及订阅状态接口。

## 安装

在 Loon 中添加：

```text
https://raw.githubusercontent.com/SpaceEggs/loon-adblock/main/plugins/fotmob/FotMob_remove_ads.plugin
```

旧地址继续兼容，但新安装建议使用上面的正式路径：

```text
https://raw.githubusercontent.com/SpaceEggs/loon-adblock/main/FotMob_remove_ads.plugin
```

安装后确认已启用插件、Rewrite 和 MitM，并已安装且完全信任 Loon MitM 证书。完全退出 FotMob 后重新打开。

## 功能

- 清空 `pub.fotmob.com/prod/pub/odds/promo` 返回的推广与博彩广告列表。
- 清空 `pub.fotmob.com/prod/pub/houseads` 返回的 FotMob 自有广告列表。
- 为 Nimbus 广告竞价请求返回 HTTP 204 no-fill。
- 阻止 `apigw.fotmob.com/imp` 广告曝光上报。
- 拦截已确认的广告点击追踪与落地页。
- 不修改 FotMob 会员或订阅状态。

## MitM Host

```text
pub.fotmob.com
apigw.fotmob.com
fotmobas-fotmobsoccerlivescores.adsbynimbus.com
```

## 工作原理

插件对两个公开广告配置接口返回与原接口结构兼容的空结果：

```json
{"country":"","offers":[]}
```

```json
[]
```

Nimbus 广告竞价请求返回 HTTP 204，使竞价快速结束且不返回广告。

## 排查

1. 清空 Loon 请求记录并重启 FotMob。
2. 检查 `pub.fotmob.com/prod/pub/odds/promo` 是否命中 Rewrite。
3. 检查 Nimbus Host 是否命中 Rewrite，而不是 DNS-REJECT。
4. 检查 `apigw.fotmob.com/imp` 是否被拒绝。
5. 分享日志前删除 Cookie、Authorization、`auth_token`、邮箱和设备标识。

## 已知限制

FotMob iOS 客户端会在比赛列表中固定创建原生广告单元。即使所有广告请求均返回 no-fill，该单元仍可能保留为空白间隙。Loon 只能修改网络请求和响应，无法修改 App 内部的 UIKit/SwiftUI 行高或布局约束，因此本插件不保证消除该空白区域。
