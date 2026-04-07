# Review Mode

Re-quiz on previously answered questions where the score was low.

## Parse Arguments
- Optional **category filter**: second token after `review` (e.g. `review TypeScript`)
- If no category given, review across all categories

## Step 1 — Load Weak Questions
Read all files in `~/.claude/techquiz/history/sessions/`.

Collect questions where **score ≤ 6** (△ or ✗).
If a category filter is given, restrict to that category.

Sort by score ascending (lowest first).

If no weak questions are found:
```
No weak questions found — great work!
Run /techquiz <category> <level> to keep practicing.
```
Then exit.

## Step 2 — Present
Show:
```
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
[REVIEW] {category}  Level {level}  Previous score: {score}/10

{full question text}
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
Your answer (or: skip · end):
```

Wait for the user's input.

## Step 3 — Evaluate
Load and follow `~/.claude/techquiz/prompts/evaluate.md`.

When saving the session record, update the existing entry for this question
(replace the previous score and feedback rather than appending a duplicate).

## Step 4 — Continue
```
Review another weak question? (y · end)
```

- `y` → pick the next lowest-scored question and repeat
- `end` → print summary and exit

## Summary Format
```
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
Review Summary
Reviewed : {n} questions
Improved : {m} questions (score increased)
Average  : {avg}/10
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
```
