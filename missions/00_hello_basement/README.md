# Mission 00: Hello Basement

## Pitch

The basement light is off. Your first job is to make Zig say the right thing.

## What you will build

A tiny command-line program that prints one stable greeting:

```text
Hello from the basement.
```

The learner code starts with the wrong greeting. The maintained solution lives in
`solution/src/` if you want to compare after trying the hints.

## What you will learn

- How a Zig file imports the standard library with `@import("std")`.
- How `std.debug.print` formats output.
- How `zig build`, per-mission test steps, and solution test steps fit together.
- How this repository splits testable logic from the runnable CLI shell.

## Rules

- Use only the Zig standard library; local mission imports are okay.
- Do not allocate heap memory.
- Do not read or write files.
- Keep the greeting deterministic.

## Run it

Run your learner version:

```sh
zig build run-00-hello-basement
```

Run the maintained solution:

```sh
zig build run-00-hello-basement-solution
```

## Test it

Run your learner tests:

```sh
zig build test-00-hello-basement
```

These may fail until you finish the mission.

Check the maintained solution:

```sh
zig build test-00-hello-basement-solution
zig build test
```

## Victory condition

Your learner test passes and `zig build run-00-hello-basement` prints
`Hello from the basement.`.

## Boss mode

Change the greeting in exactly one place and keep both the CLI output and tests
in sync.

## Break it on purpose

Remove the newline from `src/lib.zig`, then run
`zig build test-00-hello-basement`. The stable greeting test should complain.

## Reflection

- Why does `src/main.zig` import `lib.zig` instead of storing its own copy of the greeting?
- What does `{s}` mean in the call to `std.debug.print`?
- Why does `zig build test` use `solution/src/` instead of your learner starter?
