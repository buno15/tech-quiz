# Evaluate Mode

Evaluate the user's answer to the technical question.
If the user typed `skip`, skip scoring and just show the model answer, then proceed to "Next question?".

## Scoring Criteria
| Dimension | Weight |
|-----------|--------|
| Correctness — technically accurate | 50% |
| Completeness — covers key points | 30% |
| Depth — appropriate for the level | 20% |

## Output Format
```
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
Score: {X}/10  {◎ ≥8 | △ 5–7 | ✗ ≤4}

Feedback:
{2–4 sentences of specific, actionable feedback in the configured language}

Model answer:
{Concise reference answer highlighting what a strong response covers}
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
```

## Save Results

### 1. Update history index
Append one line under the appropriate category heading in
`~/.claude/techquiz/history/index.md`:

```
- [L{level}] {≤10-word question summary} ({YYYY-MM-DD}) [{score}/10]
```

Create the category heading (`## {Category}`) if it does not exist.

### 2. Write session record
File: `~/.claude/techquiz/history/sessions/{YYYY-MM-DD}-{category-slug}-{level}.md`

If the file does not exist, create it with this header:
```markdown
---
date: {YYYY-MM-DD}
category: {category}
level: {level}
language: {language}
---
```

Then append:
```markdown
## Q: {question summary}
**Question:** {full question text}
**Answer:** {user's answer}
**Score:** {score}/10
**Feedback:** {feedback}

---
```
