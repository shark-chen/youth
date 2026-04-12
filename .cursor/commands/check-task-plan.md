# 对照任务计划检查进度

name: check-task-plan
description: 读取 .cursor/task-plan.md 并对照汇报，避免仅凭对话记忆

## 说明

- 行为约定见 **`.cursor/rules/youth-flutter.mdc`** 中 **任务计划**。
- 若不存在 **`.cursor/task-plan.md`**：说明无计划文件，建议用户按需从 **`.cursor/task-plan.template.md`** 复制建立本机 `task-plan.md`。

## 步骤（Agent）

1. 若存在 `.cursor/task-plan.md`，完整阅读「阶段列表」与「当前进度」。
2. 用简体中文汇报：已完成阶段、未完成阶段、是否允许宣称整体完成。
3. 若用户希望：根据对话更新 `task-plan.md` 中的勾选与「当前进度」（仅写本机该文件）。
