# zig-toybox

Zig Toybox is a stdlib-only learning playground for Zig 0.16.x.

Build cursed little programs that make Zig's standard library, allocation model, errors, and build system easier to inspect.

## Quick Start

Install Zig 0.16.x, then check the compiler version:

```sh
zig version
```

Run every maintained solution test:

```sh
zig build test
```

Learner mission tests may start red on purpose. Run a learner test when you are
working that mission:

```sh
zig build test-00-hello-basement
```

Run the first maintained solution:

```sh
zig build run-00-hello-basement-solution
```

Expected output:

```text
Hello from the basement.
```

## How To Use A Mission

Start with the mission README, then inspect the code and tests.

| File | Why it matters |
| --- | --- |
| `missions/NN_slug/README.md` | Mission pitch, rules, commands, victory condition, and reflection prompts. |
| `missions/NN_slug/src/lib.zig` | Testable logic: parsing, transforming, validating, and ownership rules. |
| `missions/NN_slug/src/main.zig` | CLI, process, file, or terminal wiring. |
| `missions/NN_slug/tests.zig` | Expected behavior written as executable checks. |
| `missions/NN_slug/hints/` | Progressive help when you are stuck but do not want the full answer. |

The usual pattern is pure core, impure shell:

```text
lib.zig  -> logic you can test directly
main.zig -> wiring that talks to the outside world
```

## Current Missions

| Mission | Teaches | Run |
| --- | --- | --- |
| [`00_hello_basement`](missions/00_hello_basement/) | Zig setup, `std.debug.print`, `zig build`, shared tests, and the starter/solution layout. | `zig build run-00-hello-basement` |
| [`01_fortune_goblin`](missions/01_fortune_goblin/) | Arrays, slices, deterministic indexing, and simple shared tests. | `zig build run-01-fortune-goblin` |
| [`02_args_and_flags`](missions/02_args_and_flags/) | Argument parsing, command dispatch, usage errors, and bounded formatting. | `zig build run-02-args-and-flags -- Mira` |
| [`03_tiny_todo`](missions/03_tiny_todo/) | Zig 0.16 file IO, allocator ownership, plain-text serialization, append/list/remove. | `zig build run-03-tiny-todo -- todos.txt list` |
| [`04_mini_grep`](missions/04_mini_grep/) | String search, slices, line iteration, file reading, and owned filtered output. | `zig build run-04-mini-grep -- goblin README.md` |
| [`05_hex_viewer`](missions/05_hex_viewer/) | Byte-level thinking, offsets, hex formatting, ASCII rendering, and binary-safe output. | `zig build run-05-hex-viewer -- README.md` |
| [`06_leak_monster`](missions/06_leak_monster/) | Allocators, ownership, `defer`, `errdefer`, and leak detection. | `zig build run-06-leak-monster` |
| [`07_arena_cave`](missions/07_arena_cave/) | Arena allocator lifetime, batch parsing, and owned slices. | `zig build run-07-arena-cave` |
| [`08_json_creature_index`](missions/08_json_creature_index/) | `std.json` parsing, structured data, and parser-owned allocations. | `zig build run-08-json-creature-index` |
| [`09_comptime_spellbook`](missions/09_comptime_spellbook/) | `comptime`, enums, generated metadata, and static lookup tables. | `zig build run-09-comptime-spellbook` |

Run one learner mission's tests with:

```sh
zig build test-00-hello-basement
```

Run that mission's maintained solution tests with:

```sh
zig build test-00-hello-basement-solution
```

Run all maintained solution tests with:

```sh
zig build test
```

## Learning Rules

- Use only the Zig standard library.
- Keep allocation, ownership, errors, tests, and build steps visible.
- Prefer small missions that teach one or two real Zig concepts.
- Use hints before full solutions when you want to keep learning active.
- Break things on purpose; failures are part of the toybox.

## Guides

- Learners: read [`LEARNERS.md`](LEARNERS.md) for pairing modes, good prompts, and how to inspect a mission without hiding the machine.
- Agents and contributors: read [`AGENTS.md`](AGENTS.md) before changing code or adding missions.
