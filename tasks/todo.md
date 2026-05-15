# Mission Intake Plan

## Acceptance Criteria

- Decide the first mission slice to add.
- Keep the project stdlib-only and Zig 0.16-compatible.
- Preserve the learner-facing mission layout from `AGENTS.md`.
- Include runnable code, tests, docs, and progressive hints for each approved mission.
- Verify with `zig fmt .` and `zig build test` once implementation starts.

## Checklist

- [x] Explore project context.
- [x] Clarify first mission scope.
- [x] Propose mission-start approaches and tradeoffs.
- [x] Present design for approval.
- [x] Write and review design spec.
- [x] Create implementation plan.
- [x] Implement approved mission slice.
- [x] Run formatting and tests.
- [x] Summarize results and verification.

## Working Notes

- At planning start, the repository had no `missions/`, `docs/`, or `build.zig` yet.
- Installed Zig is `0.16.0`.
- Recent commits are documentation-only foundation commits.
- Worktree was clean before planning started.
- `tasks/lessons.md` does not exist yet, so there are no prior lessons to review.
- User chose to design the full MVP mission arc `00` through `09`.
- Approved direction: design full curriculum now, implement in small reviewable slices starting with `00_hello_basement`.
- Design spec written to `docs/superpowers/specs/2026-05-15-mvp-missions-design.md`.
- Self-review found no placeholder markers and no scope contradiction; implementation remains incremental.
- First-slice implementation plan written to `docs/superpowers/plans/2026-05-15-hello-basement.md`.
- Implemented `00_hello_basement` with root build wiring.
- Verification: `zig fmt .` passed.
- Verification: `zig build test` passed.
- Verification: `zig build run-00-hello-basement` printed `Hello from the basement.`.
- README learner-onboarding refactor design written to `docs/superpowers/specs/2026-05-15-readme-learner-onboarding-design.md`.
- README learner-onboarding implementation plan written to `docs/superpowers/plans/2026-05-15-readme-learner-onboarding.md`.
- Refactored root `README.md` into a learner-first quick start and mission guide.
- Verification: `zig build test` passed after README refactor.
- Verification: `zig build run-00-hello-basement` printed `Hello from the basement.` after README refactor.
- Implementation plan written to `docs/superpowers/plans/2026-05-15-mission-starter-solution-slice-1.md`.
- Slice 1 scope: refactor `00_hello_basement` into learner and solution lanes and update build wiring.
- Slice 1 verification: `zig fmt .` passed.
- Slice 1 verification: `zig build test` passed against solution tests.
- Slice 1 verification: `zig build test-00-hello-basement-solution` passed.
- Slice 1 verification: `zig build run-00-hello-basement-solution` printed `Hello from the basement.`.
- Slice 1 verification: `zig build test-00-hello-basement` failed as expected for the starter greeting.
- Slice 1 verification: `zig build run-00-hello-basement` printed `The basement is still dark.`.

## Slice 2 Checklist

- [x] Confirm isolated worktree and Zig 0.16.0 baseline.
- [x] Add missions `01_fortune_goblin`, `02_args_and_flags`, and `03_tiny_todo` with shared tests first.
- [x] Implement learner starters that compile but intentionally fail shared tests.
- [x] Implement maintained solutions and CLIs.
- [x] Wire new missions into `build.zig` and root README.
- [x] Run formatting, solution tests, expected learner failures, and solution CLIs.
- [x] Append Slice 2 verification results.

## Slice 2 Working Notes

- Slice 2 worktree: `/Users/ncode/.config/superpowers/worktrees/zig-toybox/mvp-missions-starter-solution`.
- Installed Zig is `0.16.0`.
- Baseline `zig build test` passed before Slice 2 edits.
- Implemented `01_fortune_goblin`, `02_args_and_flags`, and `03_tiny_todo` with learner starters, maintained solutions, shared tests, READMEs, and hints.
- Build wiring now registers missions 00-03; root `zig build test` runs maintained solution tests only.
- Verification: `zig fmt .` passed.
- Verification: `zig build test` passed.
- Verification: `zig build test-01-fortune-goblin-solution` passed.
- Verification: `zig build test-02-args-and-flags-solution` passed.
- Verification: `zig build test-03-tiny-todo-solution` passed.
- Verification: `zig build test-01-fortune-goblin` failed as expected for starter count/text gaps.
- Verification: `zig build test-02-args-and-flags` failed as expected with `error.Todo` starter parsing.
- Verification: `zig build test-03-tiny-todo` failed as expected with `error.Todo` starter file operations.
- Verification: `zig build run-01-fortune-goblin-solution` printed `The goblin found a shiny slice.`.
- Verification: `zig build run-02-args-and-flags-solution -- --shout Mira` printed `HELLO, MIRA`.
- Verification: `zig build run-03-tiny-todo-solution -- .zig-cache/tmp/slice2-cli-todo.txt add "feed the goblin" && zig build run-03-tiny-todo-solution -- .zig-cache/tmp/slice2-cli-todo.txt list` printed `feed the goblin`.

## Slice 3 Checklist

- [x] Add missions `04_mini_grep`, `05_hex_viewer`, and `06_leak_monster` with shared tests first.
- [x] Implement learner starters that compile but intentionally fail shared tests.
- [x] Implement maintained solutions and CLIs.
- [x] Wire new missions into `build.zig` and root README.
- [x] Run formatting, solution tests, expected learner failures, and solution CLIs.
- [x] Append Slice 3 verification results.

## Slice 3 Working Notes

- Slice 3 worktree: `/Users/ncode/.config/superpowers/worktrees/zig-toybox/mvp-missions-starter-solution`.
- Implemented `04_mini_grep`, `05_hex_viewer`, and `06_leak_monster` with learner starters, maintained solutions, shared tests, READMEs, and hints.
- Build wiring now registers missions 00-06; root `zig build test` runs maintained solution tests only.
- Zig 0.16 adjustment: `05_hex_viewer` uses explicit `usize` for chunk lengths so arithmetic around 8-byte rows does not infer a too-narrow integer type.
- Verification: `zig fmt .` passed.
- Verification: `zig build test` passed.
- Verification: `zig build test-04-mini-grep-solution` passed.
- Verification: `zig build test-05-hex-viewer-solution` passed.
- Verification: `zig build test-06-leak-monster-solution` passed.
- Verification: `zig build test-04-mini-grep` failed as expected with starter `error.Todo` behavior.
- Verification: `zig build test-05-hex-viewer` failed as expected with starter `error.Todo` behavior.
- Verification: `zig build test-06-leak-monster` failed as expected with starter `error.Todo` behavior.
- Verification: `zig build run-04-mini-grep-solution -- goblin missions/04_mini_grep/README.md` printed matching README lines containing `goblin`.
- Verification: `zig build run-05-hex-viewer-solution -- missions/05_hex_viewer/tests.zig` printed a deterministic 8-byte-width hex dump.
- Verification: `zig build run-06-leak-monster-solution` printed `LEAK MONSTER!`.

## Slice 4 Checklist

- [x] Add missions `07_arena_cave`, `08_json_creature_index`, and `09_comptime_spellbook` with shared tests first.
- [x] Implement learner starters that compile but intentionally fail shared tests.
- [x] Implement maintained solutions and CLIs.
- [x] Wire new missions into `build.zig` and root README.
- [x] Run formatting, solution tests, expected learner failures, and solution CLIs.
- [x] Append Slice 4 verification results.

## Slice 4 Working Notes

- Slice 4 worktree: `/Users/ncode/.config/superpowers/worktrees/zig-toybox/mvp-missions-starter-solution`.
- Installed Zig is `0.16.0`.
- Baseline `zig build test` passed before Slice 4 edits.
- Implemented `07_arena_cave`, `08_json_creature_index`, and `09_comptime_spellbook` with learner starters, maintained solutions, shared tests, READMEs, and hints.
- Build wiring now registers missions 00-09; root `zig build test` should run maintained solution tests only.
- Zig 0.16 adjustment: `08_json_creature_index` stores `std.json.Parsed(Schema)` in `Index` and calls `parsed.deinit()` so JSON-owned allocations are released by `Index.deinit`.
- Verification: `zig fmt .` passed.
- Verification: `zig build test` passed.
- Verification: `zig build test-07-arena-cave-solution` passed.
- Verification: `zig build test-08-json-creature-index-solution` passed.
- Verification: `zig build test-09-comptime-spellbook-solution` passed.
- Verification: `zig build test-07-arena-cave` failed as expected with starter `error.Todo` behavior.
- Verification: `zig build test-08-json-creature-index` failed as expected with starter `error.Todo` behavior.
- Verification: `zig build test-09-comptime-spellbook` failed as expected with empty starter table/null lookup behavior.
- Verification: `zig build run-07-arena-cave-solution` printed `moth -> cavern` and `goblin -> basement`.
- Verification: `zig build run-08-json-creature-index-solution` printed `goblin -> basement`.
- Verification: `zig build run-09-comptime-spellbook-solution` printed the three spell names and descriptions.
