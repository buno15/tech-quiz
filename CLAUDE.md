# TechQuiz

A Claude Code slash command tool for technical skill training.
Engineers clone this repo and run `install.sh` to register `/techquiz` globally.

## Project Structure

```
.claude/commands/techquiz.md   Entry point (copied to ~/.claude/commands/)
prompts/quiz.md                Standard quiz flow
prompts/evaluate.md            Answer scoring and feedback
prompts/review.md              Re-quiz on weak answers
prompts/project.md             Generate questions from a real codebase
config/profile.yml.example     User config template
install.sh                     One-command installer
```

## How It Works

1. `techquiz.md` reads config and routes to the correct prompt file based on arguments
2. Each prompt file contains self-contained instructions Claude follows
3. `evaluate.md` is shared across all modes for consistent scoring
4. History is persisted at `~/.claude/techquiz/history/` (not in this repo)

## Development

To test locally without re-running `install.sh`, edit files directly in
`~/.claude/techquiz/prompts/` and `~/.claude/commands/techquiz.md`.

Run `install.sh` again to sync changes from the repo to the install location.
Existing config and history are never overwritten by `install.sh`.
