# AGENTS.md

## Project: Zig Toybox

Zig Toybox is a stdlib-only learning playground for Zig 0.16.

The goal is not to build another syntax exercise collection. The goal is to help people want to use Zig by building small, weird, useful, and satisfying programs using only:

```zig
const std = @import("std");
```

This repository is also a learning bridge for the maintainer. When an AI agent works here, the job is not only to produce code; the job is to help the maintainer understand Zig by making focused changes, explaining tradeoffs, and keeping the project honest.

---

## Documentation map

- `AGENTS.md` is the operating contract for autonomous coding agents.
- `LEARNERS.md` is the human pairing guide for learning Zig with agent help.
- `README.md` is the short project entry point.

When instructions overlap, agents should follow `AGENTS.md` for implementation behavior and use `LEARNERS.md` only to support learner-facing explanations.

---

## Non-negotiable constraints

- Target Zig version: **Zig 0.16.x**.
- Use only the Zig standard library.
- Do not add third-party Zig packages unless explicitly requested.
- Do not add framework dependencies.
- Do not add a package manager workflow.
- Do not silently copy examples from older Zig versions.
- Prefer official Zig 0.16 documentation and release notes over blog posts, forum snippets, or older examples.
- Keep changes minimal, focused, and reviewable.
- Every mission must be runnable, testable, and educational.
- Every mission must teach a real Zig concept, not just produce cute output.
- The human learner is the primary user. Code clarity beats cleverness.

---

## Product vision

This project should feel like:

> Learn Zig by building cursed little stdlib-only programs.

The vibe should be playful but technically serious.

Good examples:

- a fortune goblin CLI
- a tiny grep
- a byte/hex inspector
- a leak monster
- an arena allocator cave
- a comptime spellbook
- a terminal dungeon map
- a tiny packet encoder/decoder
- a JSON creature index
- a no-heap challenge

Bad examples:

- generic fizzbuzz clones
- dry syntax worksheets
- framework tutorials
- “copy this code and trust me” lessons
- AI-generated walls of Zig without explanation
- exercises that hide the standard library instead of exposing it

This project should not clone Ziglings. Ziglings already owns the “fix tiny broken programs” lane. Zig Toybox should own the “build small stdlib-only toys that make systems programming feel fun” lane.

---

## Audience

Primary audience:

- Programmers curious about Zig.
- Developers who know another systems language and want to understand Zig’s mental model.
- People who learn by building and breaking things.
- The maintainer, who wants AI assistance while learning Zig directly.

Assume the learner may understand programming well but may not know Zig syntax, allocator conventions, error unions, `comptime`, or the Zig build system yet.

Do not talk down to the learner.

---

## Agent operating model

When working in this repository:

1. Inspect the existing files before changing anything.
2. Make the smallest useful change.
3. Prefer one coherent patch over broad rewrites.
4. Preserve the educational style.
5. Keep code stdlib-only.
6. Update tests when behavior changes.
7. Update mission docs when learning goals change.
8. Explain important Zig concepts in plain English after changes.
9. If an API is uncertain, verify against Zig 0.16 docs before using it.
10. If you cannot run commands, say exactly what was not run.

### Autonomous mission intake

Before adding or materially changing a mission, identify:

- mission number and slug
- learning goal
- user-facing behavior
- Zig concepts taught
- stdlib APIs used
- files to create or modify
- tests and fixtures needed
- build steps to add
- docs and hints to update

If any of these are unknown, infer the smallest reasonable version from the roadmap and existing missions. Ask the user only when the choice changes the mission's purpose, safety, or public behavior.

Do not:

- invent APIs
- use old Zig examples without checking 0.16 compatibility
- hide errors with `catch unreachable`
- introduce global mutable state for convenience
- add dependency management
- over-engineer mission infrastructure
- create abstractions before at least two missions need them
- rewrite working code just to match personal style

---

## Expected repository shape

Prefer this shape unless the repository already uses a different one:

```text
.
├── AGENTS.md
├── README.md
├── build.zig
├── build.zig.zon
├── docs/
│   ├── mission-design.md
│   ├── stdlib-map.md
│   └── zig-0.16-notes.md
├── missions/
│   ├── 00_hello_basement/
│   │   ├── README.md
│   │   ├── src/
│   │   │   ├── main.zig
│   │   │   └── lib.zig
│   │   ├── tests.zig
│   │   ├── fixtures/
│   │   ├── expected/
│   │   └── hints/
│   │       ├── 01.md
│   │       ├── 02.md
│   │       └── 03.md
│   └── 01_fortune_goblin/
│       └── ...
└── tools/
    └── README.md
```

Rules:

- `missions/NN_slug/README.md` explains the mission to humans.
- `missions/NN_slug/src/main.zig` is the runnable CLI when the mission has one.
- `missions/NN_slug/src/lib.zig` contains testable logic.
- `missions/NN_slug/tests.zig` contains mission-specific tests.
- `fixtures/` contains input files.
- `expected/` contains expected output files when useful.
- `hints/` contains progressive hints.
- Avoid shared helpers until repeated patterns are obvious.

---

## Build and test commands

Before making assumptions, run:

```sh
zig version
```

Expected major/minor: `0.16.x`.

Common commands:

```sh
zig fmt .
zig build
zig build test
```

If the build script provides per-mission steps, prefer commands like:

```sh
zig build test-00-hello-basement
zig build run-00-hello-basement
zig build test-04-mini-grep
zig build run-04-mini-grep -- pattern fixtures/sample.log
```

If these steps do not exist yet, add them gradually. Do not build an elaborate runner before the first few missions prove the shape.

Generated directories such as `.zig-cache/` and `zig-out/` must not be committed.

---

## Zig 0.16-specific guidance

Zig 0.16 has significant standard library and IO changes. Do not assume code from Zig 0.11, 0.12, 0.13, 0.14, or 0.15 still compiles.

For programs that need process initialization, IO, args, or allocator context, prefer the Zig 0.16 style:

```zig
const std = @import("std");

pub fn main(init: std.process.Init) !void {
    const gpa = init.gpa;
    const io = init.io;

    _ = gpa;
    _ = io;
}
```

Simple examples that only print debug text may still use:

```zig
const std = @import("std");

pub fn main() void {
    std.debug.print("Hello, {s}!\n", .{"World"});
}
```

Rules:

- For IO-heavy code, prefer accepting an IO parameter/context instead of reaching for global-ish workarounds.
- For tests involving allocation, prefer `std.testing.allocator`.
- For tests involving IO, check whether `std.testing.io` is appropriate.
- When using `std.Io`, verify current signatures against Zig 0.16 docs.
- Avoid obsolete stdlib APIs.
- Avoid examples from older forum posts unless validated locally.
- Prefer `zig std` to inspect local stdlib docs.

---

## Zig style rules

### Imports

At the top of Zig files:

```zig
const std = @import("std");
```

Only alias stdlib namespaces when it improves clarity:

```zig
const Allocator = std.mem.Allocator;
```

Avoid large alias blocks copied across every file.

### Naming

- Types: `PascalCase`
- Functions: `camelCase`
- Variables: `snake_case`
- Constants: `snake_case` unless Zig convention for a type or namespace suggests otherwise
- Files and directories: lowercase with underscores where useful

Mission directories use:

```text
NN_short_slug
```

Example:

```text
04_mini_grep
```

### Functions

Prefer small functions that expose ownership and error behavior.

Good:

```zig
pub fn parseLine(allocator: std.mem.Allocator, line: []const u8) !Record {
    _ = allocator;
    _ = line;
    // ...
}
```

Bad:

```zig
pub fn parseLine(line: []const u8) Record {
    // secretly allocates, panics, or stores global state
}
```

### Errors

Use `try` and explicit error handling.

Avoid:

```zig
someFallibleCall() catch unreachable;
```

Allowed only when:

- the mission explicitly teaches why this is wrong or dangerous, or
- an invariant is truly impossible and explained in a comment.

Prefer meaningful errors where they improve the lesson:

```zig
const ParseError = error{
    EmptyInput,
    InvalidToken,
    Overflow,
};
```

Do not create huge custom error sets without need.

### Memory

Memory ownership must be visible.

Rules:

- Pass allocators explicitly.
- Free or deinit what you allocate.
- Use `defer` and `errdefer` intentionally.
- Prefer stack buffers when the mission is about bounded data.
- Prefer `std.ArrayList` only when dynamic growth is part of the lesson.
- Prefer `std.AutoHashMap` only when maps are part of the lesson.
- Do not hide allocations in helpers without documenting ownership.
- Tests should catch leaks where practical.

Every heap-owning type should have an obvious `deinit` story.

### Comptime

Use `comptime` when it teaches something real or simplifies runtime code.

Good uses:

- command tables generated from enum values
- compile-time lookup tables
- type-driven formatting demos
- generated tests
- static validation

Bad uses:

- cleverness for its own sake
- replacing simple runtime code with unreadable metaprogramming
- building a framework before missions need it

Rule:

> Comptime is allowed only when it makes runtime code simpler or teaches a concrete Zig idea.

### IO

Zig 0.16 IO is part of the learning experience.

Rules:

- Keep IO boundaries explicit.
- Keep pure logic separate from IO when possible.
- Put parsing/transformation logic in `lib.zig`.
- Put process/terminal/file wiring in `main.zig`.
- In tests, prefer testing pure logic directly.
- For filesystem tests, use temporary directories or mission fixtures.
- Do not write outside temporary/test-controlled paths.
- Do not assume Unix-only paths unless the mission says it is Unix-specific.

### Formatting output

Output should be deterministic in tests.

Avoid tests that depend on:

- current time
- random data without a fixed seed
- OS-specific path formatting
- terminal width
- environment variables

If randomness is part of a mission, inject it or use deterministic test data.

---

## Mission design rules

Every mission must have a clear learning purpose.

Each mission README should include:

```md
# Mission NN: Name

## Pitch

A short playful description.

## What you will build

Concrete user-facing behavior.

## What you will learn

- Zig concept 1
- Zig concept 2
- stdlib namespace or API

## Rules

- Constraint 1
- Constraint 2
- Constraint 3

## Run it

Commands to run the mission.

## Test it

Commands to test the mission.

## Victory condition

What must work when the learner is done.

## Boss mode

Optional harder challenge.

## Break it on purpose

One intentional failure that teaches something.

## Reflection

A few questions that make the learner explain what happened.
```

Keep mission READMEs short enough to read before coding.

Tiny missions may keep optional sections brief. Do not pad `Boss mode`, `Break it on purpose`, or `Reflection` with fake complexity just to fill space.

---

## First mission set

The first release should prove the concept with 6 to 10 missions.

Recommended MVP:

```text
00_hello_basement
01_fortune_goblin
02_args_and_flags
03_tiny_todo
04_mini_grep
05_hex_viewer
06_leak_monster
07_arena_cave
08_json_creature_index
09_comptime_spellbook
```

### 00_hello_basement

Purpose:

- confirm Zig 0.16 setup
- show `std.debug.print`
- introduce `zig build`
- introduce `zig test`
- introduce mission layout

Rules:

- no heap allocation
- no filesystem access
- tiny code

### 01_fortune_goblin

Purpose:

- arrays and slices
- basic CLI output
- deterministic selection
- simple tests

Rules:

- no random dependency yet unless deterministic
- keep output stable

### 02_args_and_flags

Purpose:

- process args
- basic command dispatch
- error messages
- usage output

Rules:

- no third-party CLI parser
- avoid overbuilding a parser framework

### 03_tiny_todo

Purpose:

- file IO
- append/list/remove
- simple serialization
- error handling

Rules:

- store plain text
- use a test-controlled file path
- do not write to the user’s real home directory during tests

### 04_mini_grep

Purpose:

- string search
- slices
- line iteration
- file reading

Rules:

- no regex
- handle missing files
- handle empty files
- add boss mode for streaming instead of reading whole file

### 05_hex_viewer

Purpose:

- byte-level thinking
- formatting
- offsets
- ASCII rendering
- binary-safe file handling

Rules:

- deterministic output
- test with small binary fixtures

### 06_leak_monster

Purpose:

- allocators
- ownership
- `defer`
- `errdefer`
- leak detection

Rules:

- intentionally start with a leak test or broken implementation
- teach how to fix it

### 07_arena_cave

Purpose:

- arena allocator pattern
- short-lived allocations
- batch parsing

Rules:

- explain why arena lifetime is correct here
- also explain when arena allocation would be wrong

### 08_json_creature_index

Purpose:

- stdlib JSON parsing/formatting
- structured data
- allocation ownership

Rules:

- use stdlib JSON only
- keep JSON schema tiny
- test malformed JSON

### 09_comptime_spellbook

Purpose:

- `comptime`
- enums
- generated command metadata
- compile-time validation

Rules:

- no clever framework
- show one practical use

---

## Testing expectations

Tests are part of the teaching experience.

Every mission should have tests that cover the relevant items below, as applicable:

- happy path
- empty input
- malformed input
- edge cases
- relevant memory ownership behavior
- at least one “cursed input” when applicable

Examples of cursed inputs:

```text
empty file
missing newline at EOF
huge line
invalid UTF-8
zero-length argument
unknown flag
permission denied
invalid number
overflow
duplicate key
truncated binary data
```

For tiny no-input missions, do not invent malformed-input behavior just to satisfy this list. Test the real behavior and keep the lesson honest.

Test naming style:

```zig
test "mini grep finds matching lines" {
    // ...
}

test "mini grep handles empty input" {
    // ...
}

test "parser rejects truncated packet" {
    // ...
}
```

Do not make tests overly clever. A learner should be able to read the test and understand the desired behavior.

---

## Documentation expectations

Every code change that changes user-facing behavior should update documentation.

Docs should:

- explain why the mission exists
- list stdlib APIs used
- show run/test commands
- include hints instead of full spoilers
- explain one or two Zig concepts after the code works

Avoid:

- giant theory dumps
- copying the language reference
- pretending there is only one correct design
- hiding tradeoffs

---

## Hints policy

Hints should be progressive.

Use three levels:

```text
hints/01.md - point at the concept
hints/02.md - point at the stdlib API or pattern
hints/03.md - near-solution explanation without dumping full code
```

Do not put full final solutions in hints unless the mission explicitly has a `solution/` directory later.

Hints should teach how to think, not just what to type.

---

## Explanation style for AI agents

After implementing or modifying something, summarize:

1. What changed.
2. Why it changed.
3. What Zig concept it teaches.
4. What command was run to validate it.
5. What was not validated, if anything.

Example:

```text
Changed `04_mini_grep` so matching logic lives in `src/lib.zig` and file wiring stays in `src/main.zig`.

The important Zig bit is that the search function now accepts slices and does not allocate, so the tests can exercise it without touching the filesystem.

Validated with:

zig fmt .
zig build test
```

Be direct. Do not oversell. Do not say “production-ready” unless it is actually production-ready.

---

## Build system guidance

Use Zig’s build system. Do not introduce Make, CMake, shell-only workflows, npm scripts, or Python runners unless explicitly requested.

The root `build.zig` should eventually:

- define project targets using `std.Build`
- expose `zig build test`
- expose per-mission test steps
- expose per-mission run steps where useful
- avoid hardcoded output paths
- avoid checking generated outputs into git
- keep build logic understandable to Zig beginners

Prefer obvious build logic over clever dynamic discovery until the mission count makes repetition painful.

Good early approach:

- manually register the first few missions
- refactor registration only after repetition is obvious

---

## Standard library learning map

Use missions to unlock stdlib areas gradually.

Suggested map:

```text
std.debug        -> hello output, debug printing
std.testing      -> tests and expectations
std.mem          -> slices, equality, tokenization
std.process      -> args and process initialization
std.Io           -> Zig 0.16 IO model
std.fs           -> files and directories
std.ArrayList    -> dynamic collections
std.AutoHashMap  -> counting and indexes
std.json         -> structured data
std.fmt          -> formatting
std.crypto       -> optional later checksums/hashes
std.net          -> optional later networking missions, only after IO basics
```

Do not unlock too many APIs in one mission.

Each mission should introduce at most two or three significant stdlib concepts.

---

## Security and safety

Many missions touch files, args, parsing, and eventually maybe networking.

Rules:

- Tests must not modify files outside temporary directories or mission fixtures.
- Do not delete user files.
- Do not write to `$HOME` in tests.
- Do not run network calls by default in tests.
- Network missions, if added, must be opt-in and deterministic where possible.
- Do not shell out unless the mission explicitly teaches process execution.
- Do not execute downloaded/untrusted code.
- Keep fixtures small and reviewable.
- Avoid hidden telemetry or analytics.

---

## Cross-platform expectations

Default support target:

- Linux
- macOS

Windows support is welcome when it does not complicate beginner learning too much.

Avoid unnecessary Unix-only assumptions in early missions.

If a mission is Unix-specific, say so clearly in its README and tests.

---

## Git and patch style

Prefer small commits/patches.

Good patch:

```text
Add 04_mini_grep mission with README, tests, and minimal implementation.
```

Bad patch:

```text
Rewrite build system, add 12 missions, rename docs, and introduce a custom runner.
```

Do not mix unrelated changes.

Do not reformat unrelated files.

Do not rewrite working APIs without a reason.

---

## Review checklist

Before considering work done, check:

- [ ] Uses Zig 0.16-compatible APIs.
- [ ] Uses only the Zig standard library.
- [ ] Runs `zig fmt .`.
- [ ] Runs `zig build test`, or clearly states why not.
- [ ] Adds or updates tests.
- [ ] Updates mission README if behavior changed.
- [ ] Keeps IO and pure logic separated where practical.
- [ ] Handles errors explicitly.
- [ ] Does not hide allocations.
- [ ] Does not use `catch unreachable` casually.
- [ ] Does not write outside controlled paths.
- [ ] Keeps the mission fun and runnable.

---

## When adding a new mission

Acceptance criteria for a new mission:

- Mission README exists and explains the lesson.
- Runnable CLI exists when the mission has user-facing behavior.
- Testable logic lives in `src/lib.zig` when practical.
- Mission tests cover the relevant happy path and edge cases.
- Hints are progressive and do not dump the full solution.
- Build steps are wired into `build.zig` when the build script exists.
- `zig fmt .` and relevant `zig build` / `zig build test` commands pass, or failures are documented.
- Allocation ownership and error flow are visible in code and docs.

Use this process:

1. Create the mission directory.
2. Write the mission README first.
3. Add fixtures/expected output if needed.
4. Write tests before or alongside implementation.
5. Implement the smallest working version.
6. Add hints.
7. Wire mission into `build.zig` when the build script exists.
8. Run format and tests.
9. Summarize the Zig concepts taught.

Do not add a mission that only has docs and no runnable/testable code unless the task explicitly asks for a design-only mission.

---

## When fixing a mission

Use this process:

1. Reproduce or understand the failure.
2. Add a failing test if one does not exist.
3. Fix the smallest piece of code.
4. Keep the lesson intact.
5. Update hints/docs if the fix changes the intended learning path.
6. Run the mission test and global test if possible.
7. Explain the bug in learner-friendly terms.

---

## When refactoring

Only refactor when there is a clear benefit:

- duplicated mission registration
- repeated parsing helpers
- confusing ownership
- poor testability
- obsolete Zig 0.16 usage
- mission docs and code have drifted

Avoid premature framework-building.

This project should feel like a toybox, not an enterprise platform.

---

## Learner pairing support

`LEARNERS.md` is the human-facing guide for pairing with agents.

When a user asks for implementation help in this repository, agents should still support learning by briefly explaining:

- the relevant Zig idea
- where memory is owned
- where errors flow
- which stdlib API matters
- which command validates the change

Keep these explanations short and concrete. Do not let learner support override the autonomous mission creation rules in this file.

---

## Tone

Use a playful project voice in mission text.

Examples:

```text
The goblin found your argv.
The leak monster grows every time you forget `deinit`.
The arena cave collapses all allocations at once.
The hex oracle only speaks in bytes.
```

Use a precise engineering voice in code comments and implementation notes.

Do not let jokes make the technical explanation unclear.

---

## Code comments

Prefer comments that explain why, not what.

Good:

```zig
// The arena owns every parsed creature name, so the caller only needs to
// deinit the arena after the whole index is discarded.
```

Bad:

```zig
// Increment i by 1.
```

Use comments for ownership, lifetime, unsafe assumptions, edge cases, and non-obvious Zig 0.16 APIs.

---

## Avoid these patterns

Avoid:

```zig
catch unreachable
```

unless teaching why it is risky.

Avoid hidden allocations:

```zig
fn normalizeName(name: []const u8) []const u8 {
    // bad if this secretly allocates
}
```

Avoid global mutable state:

```zig
var global_allocator: std.mem.Allocator = undefined;
```

Avoid clever comptime frameworks:

```zig
// no giant generic command engine for mission 02
```

Avoid swallowing errors:

```zig
_ = maybeFailingCall() catch {};
```

Avoid tests that only check that code compiles.

---

## Preferred educational patterns

Use these often:

### Pure core, impure shell

Put logic in `lib.zig`; put IO in `main.zig`.

```text
main.zig:
  parse args
  read/write files
  print output

lib.zig:
  transform slices
  parse bytes
  validate data
  return errors
```

### Ownership in function names/docs

Make ownership obvious:

```zig
pub fn parseOwned(...) !Thing
pub fn deinit(self: *Thing, allocator: std.mem.Allocator) void
```

### Boss mode

Each mission can have a harder optional constraint:

```text
Boss mode:
- no heap allocation
- stream input line by line
- reject malformed input without panicking
- support binary files
- make output deterministic
```

### Break it on purpose

Each mission should include one intentional breakage exercise:

```text
Remove `defer list.deinit()`.
Run the tests.
What changed?
```

This is especially useful for memory and error handling lessons.

---

## Future tracks

Do not build all of these immediately. Use them as direction.

### Terminal Toy Track

- fortune goblin
- tiny todo
- mini grep
- log summarizer
- word frequency counter
- password/passphrase generator

### Memory Track

- leak monster
- arena cave
- no-heap challenge
- allocation budget
- ownership maze

### Byte Wizard Track

- hex viewer
- endian oracle
- binary header reader
- packet postcard
- checksum shrine
- DNS label parser

### Comptime Track

- lookup table generator
- enum command table
- generated tests
- type-name oracle
- static validation

### IO Track

- file copier
- line streamer
- stdout/stderr behavior
- simple HTTP HEAD request only after std.Io basics are established

---

## External references for agents

Prefer these sources when checking facts:

- Zig 0.16 documentation: `https://ziglang.org/documentation/0.16.0/`
- Zig 0.16 release notes: `https://ziglang.org/download/0.16.0/release-notes.html`
- Zig build system docs: `https://ziglang.org/learn/build-system/`
- Local standard library docs: run `zig std`
- AGENTS.md format: `https://agents.md/`
- Codex AGENTS.md behavior: `https://developers.openai.com/codex/guides/agents-md`

When sources disagree, trust the installed Zig compiler and local `zig std` documentation first.

---

## Final instruction to agents

This repository exists to make Zig feel learnable, inspectable, and fun.

Do not hide the machine.

Do not hide the standard library.

Do not hide allocation.

Do not hide errors.

Build small toys that teach real Zig.
