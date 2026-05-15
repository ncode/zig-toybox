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
