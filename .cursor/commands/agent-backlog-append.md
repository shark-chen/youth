# 发现即记录：追加一条到 agent-backlog

name: agent-backlog-append
description: 将超出当前任务的观察追加到本机 .cursor/agent-backlog.md（一行一条）

## 说明

- 格式见 **`.cursor/agent-backlog.template.md`**。
- **只追加**，不要整文件重写；文件路径 **`.cursor/agent-backlog.md`**（gitignore）。

## 步骤（Agent）

1. 用用户给定的一句话（或你从上下文提炼的观察）整理为一行：`- [YYYY-MM-DD] 简述 — 可选路径`。
2. 若文件不存在，可先写入带标题的一行说明 + 该条目。
3. 若文件已存在，在文件**末尾**追加新行。
