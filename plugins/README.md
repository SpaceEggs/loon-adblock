# 插件目录

正式发布的 Loon 插件按应用存放在本目录中。

## 新增插件

新增应用时创建：

```text
plugins/<app>/
├── <App>_remove_ads.plugin
└── README.md
```

同时完成以下事项：

1. 在仓库根目录 `README.md` 的插件列表中增加一行。
2. 使用 GitHub Raw URL 作为 Loon 安装地址。
3. 在插件 README 中记录验证过的应用版本、接口、MitM Host 与已知限制。
4. 运行 `./scripts/verify.sh`。

## 规则原则

- 优先使用精确 URL Rewrite，其次使用精确域名规则。
- 避免直接屏蔽承载核心业务数据的应用主域名。
- Response Mock 应保持原接口的数据类型和最小兼容结构。
- MitM Host 只包含插件实际需要解密的域名。
- 不提交抓包日志、HAR、Cookie、Token、账户资料或设备标识。
- 不通过改写订阅状态、会员字段或账户权限实现去广告。
