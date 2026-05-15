# Mission 02: Args And Flags

## Pitch

The goblin found your `argv`. It wants one name, maybe one shouty flag, and absolutely no parser framework.

## What you will build

A tiny argument parser for:

```text
args-and-flags [--shout] <name>
```

The starter compiles, but parsing is still marked as unfinished. The maintained solution lives in `solution/src/`.

## What you will learn

- How to parse a slice of argument strings.
- How Zig error unions model missing names, unknown flags, and too many names.
- How to format into a caller-provided buffer without heap allocation.

## Rules

- Use only the Zig standard library and local imports.
- Do not add a command-line parser dependency.
- Keep `renderGreeting` heap-free by writing into the provided buffer.
- Keep error cases explicit.

## Run it

Run your learner version:

```sh
zig build run-02-args-and-flags -- Mira
```

Run the maintained solution:

```sh
zig build run-02-args-and-flags-solution -- --shout Mira
```

## Test it

Run your learner tests:

```sh
zig build test-02-args-and-flags
```

These may fail until you finish the mission.

Check the maintained solution:

```sh
zig build test-02-args-and-flags-solution
zig build test
```

## Victory condition

Your learner tests pass for normal greetings, shout greetings, unknown flags, missing names, and too many names.

## Boss mode

Support `--help` as a successful usage request, then add a focused test that proves it returns usage without treating `--help` as an unknown flag or requiring a name.

## Break it on purpose

Remove the empty-name check and run the learner tests. An empty string is still an argument, but it is not a useful name.

## Reflection

- Why does `parse` accept `[]const []const u8` instead of reading process args directly?
- Which function owns the output buffer used by `renderGreeting`?
- Why is `error.UnknownFlag` better than silently ignoring a typo?
