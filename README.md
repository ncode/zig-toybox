# zig-toybox

Zig Toybox is a stdlib-only learning playground for Zig 0.16.x.

Build cursed little programs that make Zig's standard library, allocation model, errors, and build system easier to inspect.

## Quick Start

Install Zig 0.16.x, then check the compiler version:

```sh
zig version
```

Run every implemented mission test:

```sh
zig build test
```

Run the first mission:

```sh
zig build run-00-hello-basement
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
| [`00_hello_basement`](missions/00_hello_basement/) | Zig setup, `std.debug.print`, `zig build`, `zig test`, and the mission layout. | `zig build run-00-hello-basement` |

Run one mission's tests with:

```sh
zig build test-00-hello-basement
```

Run all implemented mission tests with:

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
