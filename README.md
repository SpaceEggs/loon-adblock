# Loon Adblock Plugins

面向 [Loon](https://nsloon.app/) 的应用去广告插件集合。每个插件独立维护，采用尽量精确的域名和 URL 匹配，减少对应用正常功能的影响。

本仓库会持续增加其他应用的去广告插件，不限于 FotMob。

## 插件列表

| 应用 | 状态 | 支持系统 | 说明 | 安装 |
| --- | --- | --- | --- | --- |
| FotMob | 可用 | iOS / iPadOS | 移除推广、博彩广告、自有广告及曝光上报 | [查看说明](plugins/fotmob/README.md) · [添加到 Loon](https://raw.githubusercontent.com/SpaceEggs/loon-adblock/main/plugins/fotmob/FotMob_remove_ads.plugin) |

## 安装方法

1. 在上方插件列表中打开对应的“添加到 Loon”链接，复制 Raw URL。
2. 在 Loon 的插件页面通过 URL 添加插件。
3. 启用插件，并按插件说明开启所需的 Rewrite、Script 或 MitM。
4. 使用 MitM 的插件需要安装并完全信任 Loon 证书。
5. 完全退出目标应用后重新打开并验证效果。

GitHub Raw 内容可能有短暂缓存。插件更新后如果没有立即生效，请稍等几分钟再刷新。

## 目录结构

```text
.
├── plugins/
│   ├── README.md
│   └── <app>/
│       ├── <App>_remove_ads.plugin
│       └── README.md
├── scripts/
│   └── verify.sh
├── .github/workflows/
│   └── validate.yml
├── FotMob_remove_ads.plugin  # 旧订阅地址兼容入口
└── README.md
```

正式插件统一放在 `plugins/<app>/`。根目录中的旧插件文件仅用于保持已经发布的 Raw URL 可用，新插件不再放到根目录。

## 开发约定

- 一个应用使用一个独立目录，目录名使用小写英文。
- 插件文件使用 `<App>_remove_ads.plugin` 命名。
- 每个插件必须包含独立 README，说明功能、安装 URL、MitM Host、已知限制和排查方法。
- 优先使用精确 Host 与 URL，不使用不必要的宽泛域名规则。
- 只处理广告、推广和相关跟踪，不修改会员、订阅或账户权益。
- 提交前运行：

  ```sh
  ./scripts/verify.sh
  ```

详细约定见 [plugins/README.md](plugins/README.md)。

## 隐私与安全

请求日志和 HAR 可能包含 Cookie、Authorization、`auth_token`、邮箱、账户 ID、设备 ID 与推送 Token。提交 Issue 或分享日志前必须脱敏，原始抓包文件不要提交到仓库。

## 免责声明

本项目仅用于网络请求过滤和学习研究，不提供会员解锁，也不修改账户权益。第三方应用或接口升级后，插件可能失效；使用者应自行评估规则、MitM 和数据安全风险。

## License

[MIT](LICENSE)
