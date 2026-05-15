# Mission 03: Tiny Todo

## Pitch

The goblin has chores now. Store them as plain text, one cursed little line at a time.

## What you will build

A tiny todo library and CLI that can add, list, and remove items from a caller-provided file path.

The starter compiles, but the library returns `error.Todo` until you implement the file behavior. The maintained solution lives in `solution/src/`.

## What you will learn

- How Zig 0.16 passes `std.Io` and `std.Io.Dir` explicitly for file operations.
- How owned buffers are allocated, returned, and freed by the caller.
- How plain-text serialization can stay simple: one todo per line.

## Rules

- Use only the Zig standard library and local imports.
- Store one item per line with a trailing newline.
- Reject empty items with `error.EmptyItem`.
- `listTodos` must return an owned buffer that the caller frees.
- Use 1-based indexes for removal and return `error.InvalidIndex` for bad indexes.

## Run it

Run your learner version:

```sh
zig build run-03-tiny-todo -- todos.txt list
```

Run the maintained solution:

```sh
zig build run-03-tiny-todo-solution -- todos.txt add "feed the goblin"
zig build run-03-tiny-todo-solution -- todos.txt list
```

## Test it

Run your learner tests:

```sh
zig build test-03-tiny-todo
```

These may fail until you finish the mission.

Check the maintained solution:

```sh
zig build test-03-tiny-todo-solution
zig build test
```

## Victory condition

Your learner tests pass for adding, listing, removing, empty items, and invalid indexes without leaking allocated todo buffers.

## Boss mode

Change removal to preserve malformed files without trailing newlines, then add a test that proves your choice.

## Break it on purpose

Remove a `defer allocator.free(...)` in a test or implementation path and run the tests. Let Zig's testing allocator show you what ownership means.

## Reflection

- Why does `listTodos` allocate but `addTodo` does not return owned memory?
- Why do tests use `std.testing.tmpDir(.{})` instead of your real home directory?
- Where do file errors flow instead of being hidden?
