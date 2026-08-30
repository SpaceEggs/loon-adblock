# FotMob 去广告（Loon）

用于 Loon 的 FotMob 去广告插件。规则来自对 FotMob iOS 客户端实际请求的分析，采用精确 URL 匹配，避免拦截比分、比赛详情、新闻、图片及订阅状态接口。

## 功能

- 清空 `pub.fotmob.com/prod/pub/odds/promo` 返回的推广与博彩广告列表。
- 清空 `pub.fotmob.com/prod/pub/houseads` 返回的 FotMob 自有广告列表。
- 阻止 `apigw.fotmob.com/imp` 广告曝光上报。
- 拦截已确认的 Nimbus 广告请求、点击追踪和广告落地页。
- 不修改 FotMob 会员或订阅状态。

## 安装

在 Loon 中添加以下插件 URL：

```text
https://raw.githubusercontent.com/SpaceEggs/loon-adblock/main/FotMob_remove_ads.plugin
```

安装后请确认：

1. 已在 Loon 中启用 MitM、Rewrite 和本插件。
2. 已安装并完全信任 Loon MitM 证书。
3. 完全退出 FotMob 后重新打开。

## 工作原理

插件对两个公开广告配置接口返回与原接口结构兼容的空结果：

```json
{"country":"","offers":[]}
```

```json
[]
```

这种方式不会直接拒绝 FotMob 的核心 API，也不会修改比赛、球队、球员和新闻数据。

## 排查

如果广告仍然出现：

1. 清空 Loon 请求记录并重启 FotMob。
2. 检查 `pub.fotmob.com/prod/pub/odds/promo` 是否命中 Rewrite。
3. 检查 `apigw.fotmob.com/imp` 是否被拒绝。
4. 广告内容消失但留下空白区域时，请提交脱敏后的请求记录和截图。

请勿公开上传包含 Cookie、Authorization、`auth_token`、邮箱或设备标识的日志。

## 免责声明

本项目仅用于网络请求过滤和学习研究，不提供会员解锁，也不修改账户权益。接口或客户端升级后，规则可能需要更新。

## License

[MIT](LICENSE)
