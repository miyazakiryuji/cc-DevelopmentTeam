# cc-DevelopmentTeam

[日本語](./README.md) | English

> A Claude Code plugin that brings a 4-department workflow (design / develop / review / test) plus a security advisor, with automatic spec back-fill.

## What does this plugin do?

In one line: **it splits the work of developing with Claude Code into a 5-role team (4 departments + 1 specialist advisor)**.

| Role | Responsibility |
| --- | --- |
| architect | Design (write the spec) |
| developer | Implement (write the code) |
| reviewer | Review (flag issues, no edits) |
| tester | Test (write and run, ensure green) |
| security-reviewer | Security audit (call in addition, on demand) |

The plugin's biggest feature is that **even if you skip the design phase and implement directly, the spec is automatically back-filled when you're done**. You can run "code first, spec later" while still leaving knowledge in the repo.

> **Common rule:** All commands and agents **never auto-execute destructive changes**. File moves, deletes, renames that could break the build always require user approval first.

## Who is this for?

- People starting solo development who don't know where to begin
- People who want Claude Code to build things, but don't want to end up not knowing what was built
- People who find writing specs tedious but want documentation to stick around
- Engineers who want to reproduce the team workflow (design → implement → review → test) in solo development

> **If you're not sure, run `/cc-development-team:guide` first.** It hears out your current state and narrows the next command down to 1 or 2.

---

## 30-second install

```bash
cd ~/my-project
claude
```

Inside Claude Code:

```
/plugin marketplace add miyazakiryuji/cc-DevelopmentTeam
/plugin install cc-development-team@cc-development-team
/cc-development-team:init-dept
```

For details, see [guides/quickstart.md](./guides/quickstart.md) (Japanese).

---

## Command quick reference

| What you want to do | Command |
| --- | --- |
| Don't know where to start | `/cc-development-team:guide` |
| Brainstorm app ideas | `/cc-development-team:brainstorm` |
| Create / update specs | `/cc-development-team:architect [name]` |
| Develop (develop mode) | `/cc-development-team:develop [name]` |
| Write / run tests | `/cc-development-team:test [name]` |
| Refactor existing code | `/cc-development-team:refactor [target]` |
| Check project status | `/cc-development-team:status` |
| Pre-release check | `/cc-development-team:release-check` |
| Security review | `/cc-development-team:security-review [name]` |
| Spec / code drift check | `/cc-development-team:sync-spec [name]` |
| Initialize project | `/cc-development-team:init-dept` |
| Check for plugin updates | `/cc-development-team:update` |

For detailed usage, see [guides/commands.md](./guides/commands.md) (Japanese).

---

## Documentation

The full documentation lives in [guides/](./guides/), written in Japanese. Key entry points:

| When you want to... | Read |
| --- | --- |
| Try it for the first time | [guides/quickstart.md](./guides/quickstart.md) |
| Understand the Claude plan choice | [guides/plans.md](./guides/plans.md) |
| Start mobile development | [guides/mobile-ide.md](./guides/mobile-ide.md) |
| Update the plugin | [guides/update.md](./guides/update.md) |
| Choose the right command | [guides/commands.md](./guides/commands.md) |
| Understand each agent's role | [guides/departments.md](./guides/departments.md) |
| See the workflow diagrams | [guides/workflow.md](./guides/workflow.md) |
| Check the project layout | [guides/directory-structure.md](./guides/directory-structure.md) |
| Read the FAQ | [guides/faq.md](./guides/faq.md) |
| Troubleshoot | [guides/troubleshooting.md](./guides/troubleshooting.md) |
| See a sample project layout | [examples/todo-app-web/](./examples/todo-app-web/) |
| Modify the plugin itself | [guides/development.md](./guides/development.md) |

> **English documentation is currently limited to this README.** Guide files are Japanese-only for now. We may translate them based on demand.

---

## Prerequisites

1. **Claude Code** installed
   - Official site: <https://claude.com/claude-code>
   - Docs: <https://docs.claude.com/en/docs/claude-code/overview>
2. A terminal (macOS Terminal, Windows PowerShell, etc.)
3. A project folder to try it in (`mkdir my-first-app` works fine)

> **Picking a Claude plan?** → [guides/plans.md](./guides/plans.md)
>
> **Doing mobile development?** → [guides/mobile-ide.md](./guides/mobile-ide.md) (dedicated IDE recommended)

---

## How it works (in short)

1. **`init-dept`** sets up the project with 3 brief hearings:
   - Project type (Web / Mobile)
   - Architecture pattern (Feature-based / MVC / Clean Architecture / MVVM / MVI / TCA / etc.)
   - Where your app code lives (`src/` / `lib/` / `app/` / `apps/` / etc.)
2. **`brainstorm`** helps you generate app ideas from casual conversation
3. **`architect`** turns the idea into a 3-tier doc hierarchy:
   - `docs/vision/` (concept + roadmap, project-wide)
   - `docs/basic-design/basic-design.md` (architecture, ER, API, all features, project-wide)
   - `docs/requirements/<feature>.md` + `docs/specs/<feature>.md` (per feature)
4. **`develop`** enters develop mode, where you can hand it requests one after another. At mode start, it asks "full cycle (with tests) or lean (implementation only)?"
5. **`test`** runs tests in a separate command, showing results and asking before applying fixes
6. **`release-check`** verifies MVP completeness, tests, manual tasks, security, and spec drift, then drafts release notes

For per-feature traceability, every doc references a `F-XXX` feature ID maintained in `basic-design.md`.

---

## License

[MIT License with Attribution Requirement](./LICENSE)

- **Free to use** (personal, commercial, business — any use)
- **Modification and redistribution are OK**
- **However**, if you publish a fork / modified version / derived plugin, you **must clearly state** that the original is this repository.

### How to attribute (one or more of the following)

- The README or main documentation of your derived project
- A user-visible "About" or "Credits" section
- Package / plugin metadata (`plugin.json` / `package.json` `description`)

### Example wording

```
Based on cc-DevelopmentTeam by miyazakiryuji
(https://github.com/miyazakiryuji/cc-DevelopmentTeam).
```

Or in Japanese:

```
このプロジェクトは miyazakiryuji の cc-DevelopmentTeam
(https://github.com/miyazakiryuji/cc-DevelopmentTeam) をベースにしています。
```

> If you only use it privately for yourself, attribution is not required. It's only needed when **redistributing or publishing**.
