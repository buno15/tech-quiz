# TechQuiz

A Claude Code slash command for technical skill training.  
Each engineer installs it in their own Claude Code environment and pays only for their own AI usage.

## Features

- **Any topic** — not limited to a fixed category list
- **Level 1–10** — fine-grained difficulty instead of easy/medium/hard
- **One question at a time** — focused, interactive Q&A with AI scoring
- **No duplicate questions** — history is tracked and avoided automatically
- **Review mode** — re-quiz on questions you answered poorly
- **Project mode** — generate questions from your own codebase
- **Any language** — configure English, Japanese, or any language Claude supports

## Requirements

- [Claude Code](https://claude.ai/code)

## Install

```bash
git clone https://github.com/yourname/techquiz
cd techquiz
./install.sh
```

That's it. `/techquiz` is now available in every project you open in Claude Code.

## Usage

```bash
# Quiz on any topic at any level
/techquiz TypeScript 5
/techquiz "System Design" 8
/techquiz Rust 3
/techquiz "Machine Learning" 6

# All categories defined in your profile
/techquiz all 5

# Review questions you answered poorly
/techquiz review
/techquiz review TypeScript

# Generate questions from the current project's code
/techquiz project 6
/techquiz project src/auth 7
```

## Session flow

```
/techquiz Go 7

Q: Explain the difference between buffered and unbuffered channels
  in Go, and describe a scenario where choosing the wrong type
  could cause a deadlock.

Your answer (or: skip · end):
> Unbuffered channels block until both sender and receiver are ready...

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
Score: 8/10  ◎

Feedback:
Good explanation of the blocking behavior. You correctly identified
the synchronization guarantee of unbuffered channels.

Model answer:
Unbuffered channels require both goroutines to be ready simultaneously.
Buffered channels allow sending up to N values without a receiver.
Deadlock risk: using unbuffered in a single goroutine that sends then
receives — neither operation can proceed.
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

Next question? (y · <new level 1-10> · end)
```

## Configuration

Edit `~/.claude/techquiz/config/profile.yml` after install:

```yaml
language: en          # en, ja, zh, ko, es, fr, de, ...
default_level: 5      # 1–10
categories:           # used by /techquiz all
  - TypeScript
  - Go
  - System Design
```

## History

Questions and scores are saved locally at `~/.claude/techquiz/history/`.  
This data never leaves your machine.

## Uninstall

```bash
rm ~/.claude/commands/techquiz.md
rm -rf ~/.claude/techquiz
```
