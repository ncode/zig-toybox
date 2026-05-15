# LEARNERS.md

Zig Toybox is for learning Zig by building small, weird, useful programs with only the standard library.

This guide is for humans pairing with an AI agent. The goal is not to let the agent hide the work. The goal is to make the machine visible: the standard library, allocation, errors, tests, and build steps.

---

## How to use an agent here

Ask the agent to help you learn, not just finish.

Good requests:

- "Give me a hint, not the solution."
- "Explain the allocator ownership in this function."
- "Show me where errors can return from this code."
- "Make the smallest change and explain why it works."
- "Write a test first, then let me try the implementation."
- "Review this mission for outdated Zig 0.16 APIs."

Less useful requests:

- "Just solve it."
- "Rewrite everything."
- "Hide the messy parts."
- "Use a package that makes this easier."

---

## Pairing modes

Use these phrases to control how much help you want.

### Hint mode

Ask for direction without code.

Example:

```text
Hint mode: I am stuck on parsing args. Point me at the relevant stdlib API without writing the solution.
```

### Step-by-step mode

Ask for one small next move at a time.

Example:

```text
Step-by-step mode: Give me the next test to write, then stop.
```

### Explain mode

Ask the agent to explain existing code.

Example:

```text
Explain mode: Walk through this function and identify where memory is allocated and freed.
```

### Review mode

Ask for critique before accepting code.

Example:

```text
Review mode: Check this mission for hidden allocation, swallowed errors, obsolete Zig APIs, and missing tests.
```

### Full-solution mode

Ask for the full patch when you want to compare against a working version.

Example:

```text
Full-solution mode: Implement the smallest working version, then explain the key Zig concepts.
```

Use this mode intentionally. Reading a solution is useful only if you also inspect the ownership, error flow, and tests.

---

## What to ask after code changes

After an agent changes code, ask:

- What changed?
- Why is this the smallest useful change?
- What Zig concept does this teach?
- Where is memory owned?
- Where can errors return?
- Which stdlib APIs matter?
- Which tests or build commands proved it works?
- What was not verified?

These questions keep the learning active.

---

## How to read a mission

Start with the mission README.

Then inspect:

- `src/lib.zig` for testable logic
- `src/main.zig` for CLI, file, or terminal wiring
- `tests.zig` for expected behavior
- `fixtures/` for input files
- `expected/` for deterministic output
- `hints/` when you want help without a full solution

The preferred pattern is pure core, impure shell:

```text
lib.zig  -> parse, transform, validate, return errors
main.zig -> args, files, terminal output, process setup
```

This makes the useful logic easier to test and understand.

---

## Things the agent should not hide

Do not let an agent hide:

- allocation
- deallocation
- ownership transfer
- error unions
- `try`
- stdlib APIs
- build steps
- failing tests

If something looks magical, ask the agent to unpack it.

Useful prompt:

```text
Do not hide the machine. Explain what Zig and the standard library are doing here.
```

---

## How to use failures

Failures are part of the toybox.

When a test fails, ask:

- What behavior failed?
- What input triggered it?
- What did Zig report exactly?
- Is this a compile error, runtime error, test expectation failure, or leak report?
- What is the smallest change that would make this pass?

For memory missions, leak reports are especially useful. They are not shame. They are the leak monster pointing at the missing `defer`.

---

## Keep the standard library visible

This project uses only:

```zig
const std = @import("std");
```

That constraint is the point. It helps you learn what Zig gives you without hiding behind frameworks or packages.

When the agent uses a stdlib API, ask what namespace it came from and why it is the right tool for this mission.
