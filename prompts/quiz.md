# Quiz Mode

## Parse Arguments
From the full arguments:
- **Category**: first token (e.g. `TypeScript`, `Go`, `"System Design"`)
- **Level**: integer 1–10 (second token; fallback to `default_level` from config)
- **Language**: from config `profile.yml`

Level guide:
| Level | Scope |
|-------|-------|
| 1–3   | Basic concepts and terminology |
| 4–6   | Practical usage and application |
| 7–9   | Design, optimization, deep internals |
| 10    | Expert edge cases and tradeoffs |

## Step 1 — Load History
Read `~/.claude/techquiz/history/index.md`.
You MUST NOT generate a question that duplicates or closely resembles any listed question.

## Step 2 — Generate Question
Generate exactly **one** question that is:
- Specific to the given category
- Calibrated to the given level
- Not a duplicate of any question in history
- Practical (real interview or real engineering scenario)
- Written in the configured language

If the question involves code, include it in a fenced code block.

## Step 3 — Present
Display the question, then prompt:

```
Your answer (or: skip · end):
```

Wait for the user's input.

## Step 4 — Evaluate
After receiving the answer, load and follow `~/.claude/techquiz/prompts/evaluate.md`.
Pass along: category, level, language, the question text, and the user's answer.

## Step 5 — Continue
After the evaluation output, ask:

```
Next question? (y · <new level 1-10> · end)
```

- `y` → generate another question (same category and level, still avoid history)
- Number → update level and generate next question
- `end` → print session summary and exit

## Session Summary Format
```
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
Session Summary
Category : {category}
Level    : {level}
Questions: {n}
Average  : {avg}/10
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
```
