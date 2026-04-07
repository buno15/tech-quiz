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

## Code Verification (Optional)

Skip this section entirely if the question is not code-related (no fenced code block in the question or model answer).

### Supported languages

| Fence tag | Write temp file (Bash) | Run command |
|-----------|------------------------|-------------|
| `python`/`python3` | `cat > /tmp/tq_verify.py` | `python3 /tmp/tq_verify.py` |
| `javascript`/`js` | `cat > /tmp/tq_verify.js` | `node /tmp/tq_verify.js` |
| `typescript`/`ts` | `cat > /tmp/tq_verify.ts` | `npx --yes ts-node /tmp/tq_verify.ts` |
| `bash`/`sh` | `cat > /tmp/tq_verify.sh` | `bash /tmp/tq_verify.sh` |
| `ruby`/`rb` | `cat > /tmp/tq_verify.rb` | `ruby /tmp/tq_verify.rb` |
| `php` | `cat > /tmp/tq_verify.php` | `php /tmp/tq_verify.php` |
| `perl`/`pl` | `cat > /tmp/tq_verify.pl` | `perl /tmp/tq_verify.pl` |
| `lua` | `cat > /tmp/tq_verify.lua` | `lua /tmp/tq_verify.lua` |
| `r` | `cat > /tmp/tq_verify.r` | `Rscript /tmp/tq_verify.r` |
| `elixir`/`ex` | `cat > /tmp/tq_verify.ex` | `elixir /tmp/tq_verify.ex` |
| `dart` | `cat > /tmp/tq_verify.dart` | `dart run /tmp/tq_verify.dart` |
| `swift` | `cat > /tmp/tq_verify.swift` | `swift /tmp/tq_verify.swift` |
| `haskell`/`hs` | `cat > /tmp/tq_verify.hs` | `runghc /tmp/tq_verify.hs` |
| `powershell`/`ps1` | `cat > /tmp/tq_verify.ps1` | `pwsh /tmp/tq_verify.ps1` |
| `go` | `cat > /tmp/tq_verify.go` | `go run /tmp/tq_verify.go` |
| `rust`/`rs` | `cat > /tmp/tq_verify.rs` | `rustc -o /tmp/tq_verify_bin /tmp/tq_verify.rs && /tmp/tq_verify_bin` |
| `c` | `cat > /tmp/tq_verify.c` | `gcc -o /tmp/tq_verify_bin /tmp/tq_verify.c && /tmp/tq_verify_bin` |
| `cpp`/`c++` | `cat > /tmp/tq_verify.cpp` | `g++ -o /tmp/tq_verify_bin /tmp/tq_verify.cpp && /tmp/tq_verify_bin` |
| `java` | extract public class name → `cat > /tmp/{ClassName}.java` | `cd /tmp && javac {ClassName}.java && java -cp /tmp {ClassName}` |
| `kotlin`/`kt` | `cat > /tmp/tq_verify.kt` | `kotlinc /tmp/tq_verify.kt -include-runtime -d /tmp/tq_verify.jar && java -jar /tmp/tq_verify.jar` |

### Step 1 — Offer
Ask:
```
コードを実行して検証しますか？(y · n)
```

### Step 2 — If `y`

For each code block to run, write it via Bash heredoc then execute:
```bash
cat > /tmp/tq_verify.{ext} << 'TQEOF'
{code}
TQEOF
{run command}
```

1. **User's code** — if the user's answer contains a fenced code block, run it first and show:
   ```
   実行結果（あなたのコード）:
   ─────────────────────────
   {stdout / stderr — truncate after 40 lines}
   ─────────────────────────
   ```
2. **Model answer code** — if it differs from the user's code (or user had no code), run it and show:
   ```
   実行結果（模範解答）:
   ─────────────────────────
   {stdout / stderr — truncate after 40 lines}
   ─────────────────────────
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
