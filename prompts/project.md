# Project Mode

Generate questions from the actual codebase in the current working directory.

## Parse Arguments
From the full arguments (after `project`):
- **Path** (optional): specific subdirectory or file to focus on
  - e.g. `project src/auth 6` → focus on `src/auth/`, level 6
  - e.g. `project 5` → whole project, level 5
- **Level**: integer 1–10 (last numeric token; fallback to `default_level` from config)

## Step 1 — Discover Project
Use Glob and Read to explore the project:

1. Look for dependency/manifest files to detect the tech stack:
   `package.json`, `go.mod`, `Cargo.toml`, `requirements.txt`, `Gemfile`,
   `pom.xml`, `build.gradle`, `pyproject.toml`, `composer.json`

2. Read `CLAUDE.md` and `README.md` if present for project context.

3. If a path is specified, glob files under that path.
   Otherwise, sample key source files from the project root.

## Step 2 — Report Tech Stack
Briefly report what was detected:
```
Project analysis:
  Detected : {language(s)}, {framework(s)}, {key libraries}
  Focus    : {path or "whole project"}
  Level    : {level}

Generating question...
```

## Step 3 — Generate Question
Create **one** question that is **specific to this codebase**.

Good question types:
- Point to a real function/file and ask about its behavior or edge cases
- Identify a potential bug, race condition, or security issue in actual code
- Ask how a specific design decision could be improved
- Ask what would happen if a certain input is given
- Ask about the tradeoff of an architectural choice visible in the code

The question MUST reference actual file names, function names, or code snippets
from the project — not generic examples.

Include relevant code snippets in fenced code blocks.

## Step 4 — Present
```
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
[PROJECT] {file or area}  Level {level}

{question}
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
Your answer (or: skip · end):
```

Wait for the user's input.

## Step 5 — Evaluate
Load and follow `~/.claude/techquiz/prompts/evaluate.md`.
Use `project` as the category slug when saving.

## Step 6 — Continue
```
Next question from this project? (y · end)
```

- `y` → pick a different area of the codebase and generate another question
- `end` → print session summary and exit
