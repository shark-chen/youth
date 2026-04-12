# Agent 发现 backlog（模板）

> **本机数据文件**：实际记录为 **`.cursor/agent-backlog.md`**（已 gitignore）。此处为格式说明，可提交仓库。  
> **用法**：分析中发现**超出当前任务范围**的问题时，向 `agent-backlog.md` **追加一行**，勿整文件覆盖。

## 行格式（建议）

```text
- [YYYY-MM-DD] 一句话描述 — 可选 `lib/...` 或模块名
```

## 示例

```text
- [2026-04-12] 某页 Obx 与 ScrollView 嵌套导致 layout 异常 — `lib/modules/home/mine/user_info/user_info_page.dart`
- [2026-04-12] 缺少接口失败重试 — 网络层待评估
```
