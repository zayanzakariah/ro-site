# PULSE — TOKEN EFFICIENCY & CODE COMPACTION PROTOCOL v1.0
Codename: LEAN ENGINE
Purpose: Same output quality. 60-70% fewer tokens burned.
Status: ACTIVE | Created: 2026-04-05

---

## CORE PRINCIPLE

Every token costs money. Every file read costs context window. Every verbose function costs comprehension time.

---

## SECTION 1: CODE COMPACTION RULES

### 1.1 — Write Dense, Not Verbose

BEFORE (wasteful — 847 tokens):
```js
function processUserData(userData) {
  if (userData === null || userData === undefined) {
    console.log("No user data provided");
    return null;
  }
  const userName = userData.name;
  const userEmail = userData.email;
  if (userName === undefined || userName === null) return null;
  if (userEmail === undefined || userEmail === null) return null;
  return { displayName: userName, contactEmail: userEmail, processed: true };
}
```

AFTER (compact — 210 tokens, identical behavior):
```js
function processUserData(d) {
  if (!d?.name || !d?.email) return null;
  return { displayName: d.name, contactEmail: d.email, processed: true };
}
```

### 1.2 — Compaction Checklist

- COMMENTS: Delete obvious. Keep only WHY, never WHAT.
- VARIABLES: Inline single-use.
- CONDITIONALS: Optional chaining, nullish coalescing, ternaries.
- FUNCTIONS: Arrow for simple transforms.
- LOOPS: .map/.filter/.reduce over manual loops.
- OBJECTS: Shorthand, spread, destructuring.
- IMPORTS: Destructure only what you use.
- DEAD CODE: Delete it. Git has history.

### 1.3 — Language-Specific

**JS/TS:** Destructure params, object method shorthand, async one-liners.
**Python:** List comprehensions, walrus operator, f-strings, unpacking.
**Bash:** Parameter expansion, combine commands, here-strings.

---

## SECTION 2: TOKEN-EFFICIENT FILE READING

### 2.1 — Never Read What You Already Know

Before reading ANY file, check:
1. Already in context this session? → DON'T RE-READ
2. Did I write it this session? → DON'T RE-READ
3. Need whole file or section? → READ ONLY SECTION
4. Can I grep for the specific line? → GREP

### 2.2 — Smart Reading

| Instead of | Do this |
|-----------|---------|
| cat entire_file.py | grep -n "function_name" file.py |
| cat package.json | jq '.dependencies' package.json |
| cat long_log.txt | tail -50 long_log.txt |
| re-reading file I just wrote | skip — you know it |
| reading 500-line file for 1 function | sed -n '45,60p' file.py |

### 2.3 — Context Window Budget

- 15% — System prompt + CLAUDE.md + protocols
- 10% — Memory files
- 5%  — Agent definitions (index only)
- 60% — ACTUAL WORK
- 10% — Buffer

> If burning 40%+ on reading before doing any work = FAILING this protocol.

---

## SECTION 3: PROMPT & OUTPUT COMPRESSION

### 3.1 — Compress Agent Prompts

Target: < 200 tokens per agent prompt.

Format:
```
Role: [one line]
Check: [comma-separated list]
Output format: {field, field, field}
Rules: [2-3 lines max]
```

### 3.2 — Response Compression Rules

1. NO PREAMBLE — start doing the work
2. NO RECAP — don't narrate what you did
3. NO FILLER WORDS — "basically", "essentially", "actually", "just"
4. NO EXPLAINING THE OBVIOUS — write the code
5. STRUCTURED OVER PROSE for status updates
6. ONE-LINERS for log entries
7. TABLES OVER PARAGRAPHS for comparisons
8. CODE OVER DESCRIPTIONS for technical solutions
9. DIFFS OVER FULL REWRITES when editing

### 3.3 — Agent Communication Format (max 100 tokens/report)

```
{agent_id} | {status} | {result_summary} | {next_action}
```

---

## SECTION 4: FILE & ARCHITECTURE COMPACTION

### 4.1 — File Consolidation

Consolidate when: 3+ files share 50%+ identical code, file < 20 lines, config spread across 5+ files.

Never consolidate: memory files, protocol files, independently versioned files.

### 4.2 — Memory File Compaction (weekly)

- inner-log.md: Archive entries > 7 days. Keep last 50.
- predictions.jsonl: Keep last 20 active.
- learnings.md: Prune unused > 30 days.
- Target: memory files stay under 200 lines each.
- Result: boot reads ~1000 tokens instead of ~5000.

---

## SECTION 5: CODING PATTERNS

### 5.1 — Config-Driven Over Code-Driven
One config + one engine beats 61 agent files.

### 5.2 — Template Strings Over Repeated Structures
```js
const template = (role, checks, format) =>
  `Role: ${role}\nCheck: ${checks}\nOutput: ${format}`;
```

### 5.3 — Lazy Loading Over Eager Loading
Read agent index (200 tokens) not all agent definitions (6000+ tokens).

---

## SECTION 6: THE 10 COMMANDMENTS

1. Don't read files already in context.
2. Don't read whole files for 5 lines.
3. Don't comment what the code says.
4. Don't use 10 lines when 2 do the same.
5. Don't repeat — extract, template, configure.
6. Don't load everything at boot.
7. Don't write prose when structured output works.
8. Don't preamble, recap, or narrate.
9. Don't keep dead code.
10. Don't sacrifice quality for brevity — same output, fewer tokens.

---

## QUALITY GATE

Compaction that breaks things is not efficiency — it's sabotage.
Goal: SAME OUTPUT, FEWER TOKENS. Not worse output.

Tests still pass? Edge cases handled? Code still readable? → Ship.
Any no? → Revert.
