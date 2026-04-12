# 生成会话交接摘要，供下次 Cursor 会话使用

name: session-handoff
description: 按项目规则输出「会话交接」Markdown，可选写入 .cursor/session-handoff.md

## 说明

- 行为约定见 **`.cursor/rules/youth-flutter.mdc`** 中 **任务计划**、**发现即记录**、**会话交接**。
- 输出须为 **简体中文**，结构对齐 **`.cursor/session-handoff.template.md`**（含 **任务计划进度**、**观察到但未处理**）。
- 若存在 **`.cursor/task-plan.md`**，交接中须如实反映阶段勾选，**不得**在仍有未勾选阶段时宣称整体已完成。
- 若存在 **`.cursor/agent-backlog.md`**，交接中须体现仍待跟进项或与之对照。
- 若用户要求保存交接：**只**写入本机 **`.cursor/session-handoff.md`**（已 `.gitignore`）；**不要**写入其他可提交的 `.md`，除非用户明确指定路径。

## 步骤（Agent）

1. 若存在 `.cursor/task-plan.md`，读取并用于填写「任务计划进度」。
2. 若存在 `.cursor/agent-backlog.md`，读取并用于填写「观察到但未处理」。
3. 根据当前对话与已修改文件，整理其余小节。
4. 在回复中给出完整「会话交接」正文（Markdown）。
5. 用户要求落盘时，仅将正文写入 `.cursor/session-handoff.md`，不另存到仓库内其他 md。
