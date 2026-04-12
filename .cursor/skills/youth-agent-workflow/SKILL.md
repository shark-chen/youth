---
name: youth-agent-workflow
description: >-
  Youth 多阶段任务与收工流程：task-plan、agent-backlog、session-handoff、
  check-task-plan 命令。在长任务、收尾、交接时使用。
---

# Youth Agent 工作流（任务计划 · 发现记录 · 会话交接）

完整设计说明已迁入本仓库 **`docs/任务计划技术文档说明.md`**、**`docs/发现即记录技术文档说明.md`**、**`docs/会话交接技术文档说明.md`**（源自 BigSeller-A 同主题文档，附录已改为 Youth 路径）。

## 何时使用

- 用户任务明显分多阶段、或明确说 **计划 / 对照进度 / 交接 / 收尾**
- 需要避免模型在 compaction 后 **过早宣称「全部完成」**
- 发现范围外问题要 **落盘** 而不是只在聊天里提一句

## 本机文件（均已 gitignore）

| 文件 | 用途 |
|------|------|
| `.cursor/task-plan.md` | 阶段列表 `[ ]` / `[x]` + 当前进度 |
| `.cursor/agent-backlog.md` | 发现即记录，**一行一条追加** |
| `.cursor/session-handoff.md` | 会话交接正文（用户要求落盘时） |

## 可提交仓库的模板

- `.cursor/task-plan.template.md`
- `.cursor/agent-backlog.template.md`
- `.cursor/session-handoff.template.md`

新建本机文件时：复制对应模板再改。

## Cursor 命令（`.cursor/commands/`）

| 命令文件 | 作用 |
|----------|------|
| `check-task-plan.md` | 读取 `task-plan.md` 并对照汇报 |
| `session-handoff.md` | 按模板输出交接；可选写入 `session-handoff.md` |
| `agent-backlog-append.md` | 规范地向 `agent-backlog.md` **追加**一行 |

## Agent 执行要点

### 任务计划

- 多阶段任务开始时应建议或协助建立 **`.cursor/task-plan.md`**（从模板复制）。
- 每完成一阶段：对应行改为 **`[x]`**，更新「当前进度」。
- **仍有 `[ ]` 时不得宣称整体任务完成**。

### 发现即记录

- 超出当前 PR/任务范围的观察：**追加**到 **`agent-backlog.md`**，格式见模板。
- **禁止**为追加一条而整文件重写（避免覆盖历史）。

### 会话交接

- 触发词示例：交接、收尾、会话摘要、收工。
- 输出 **简体中文**，小节对齐 **`session-handoff.template.md`**，且必须包含：**任务计划进度**、**观察到但未处理**。
- 用户要求保存时 **仅** 写入 **`.cursor/session-handoff.md`**。

## 与项目规则的关系

**`.cursor/rules/youth-flutter.mdc`**（`alwaysApply: true`）已嵌入上述硬约束；本 skill 提供步骤与文件索引，便于显式 `@` 引用。
