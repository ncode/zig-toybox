# Mission 00: Hello Basement

## Pitch

The basement light turns on. Zig speaks first.

## What you will build

A tiny command-line program that prints one stable greeting:

```text
Hello from the basement.
```

## What you will learn

- How a Zig file imports the standard library with `@import("std")`.
- How `std.debug.print` formats output.
- How `zig build`, `zig build run-00-hello-basement`, and `zig build test` fit together.
- How this repository splits testable logic from the runnable CLI shell.

## Rules

- Use only the Zig standard library; local mission imports are okay.
- Do not allocate heap memory.
- Do not read or write files.
- Keep the greeting deterministic.

## Run it

```sh
zig build run-00-hello-basement
```

## Test it

```sh
zig build test-00-hello-basement
zig build test
```

## Victory condition

The run command prints `Hello from the basement.` and the tests pass.

## Boss mode

Change the greeting in exactly one place and keep both the CLI output and tests in sync.

## Break it on purpose

Remove the newline from `src/lib.zig`, then run `zig build test-00-hello-basement`. The stable greeting test should complain.

## Reflection

- Why does `src/main.zig` import `lib.zig` instead of storing its own copy of the greeting?
- What does `{s}` mean in the call to `std.debug.print`?
- Which file would you open first if the output changed unexpectedly?
