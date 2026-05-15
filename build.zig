const std = @import("std");

const Mission = struct {
    dir: []const u8,
    step: []const u8,
    title: []const u8,
};

pub fn build(b: *std.Build) void {
    const target = b.standardTargetOptions(.{});
    const optimize = b.standardOptimizeOption(.{});

    const test_step = b.step("test", "Run all solution mission tests");

    addMission(b, target, optimize, test_step, .{
        .dir = "00_hello_basement",
        .step = "00-hello-basement",
        .title = "mission 00: hello basement",
    });
    addMission(b, target, optimize, test_step, .{
        .dir = "01_fortune_goblin",
        .step = "01-fortune-goblin",
        .title = "mission 01: fortune goblin",
    });
    addMission(b, target, optimize, test_step, .{
        .dir = "02_args_and_flags",
        .step = "02-args-and-flags",
        .title = "mission 02: args and flags",
    });
    addMission(b, target, optimize, test_step, .{
        .dir = "03_tiny_todo",
        .step = "03-tiny-todo",
        .title = "mission 03: tiny todo",
    });
    addMission(b, target, optimize, test_step, .{
        .dir = "04_mini_grep",
        .step = "04-mini-grep",
        .title = "mission 04: mini grep",
    });
    addMission(b, target, optimize, test_step, .{
        .dir = "05_hex_viewer",
        .step = "05-hex-viewer",
        .title = "mission 05: hex viewer",
    });
    addMission(b, target, optimize, test_step, .{
        .dir = "06_leak_monster",
        .step = "06-leak-monster",
        .title = "mission 06: leak monster",
    });
    addMission(b, target, optimize, test_step, .{
        .dir = "07_arena_cave",
        .step = "07-arena-cave",
        .title = "mission 07: arena cave",
    });
    addMission(b, target, optimize, test_step, .{
        .dir = "08_json_creature_index",
        .step = "08-json-creature-index",
        .title = "mission 08: json creature index",
    });
    addMission(b, target, optimize, test_step, .{
        .dir = "09_comptime_spellbook",
        .step = "09-comptime-spellbook",
        .title = "mission 09: comptime spellbook",
    });
}

fn addMission(
    b: *std.Build,
    target: std.Build.ResolvedTarget,
    optimize: std.builtin.OptimizeMode,
    all_solution_tests: *std.Build.Step,
    comptime mission: Mission,
) void {
    const learner_exe_mod = b.createModule(.{
        .root_source_file = b.path("missions/" ++ mission.dir ++ "/src/main.zig"),
        .target = target,
        .optimize = optimize,
    });
    const learner_exe = b.addExecutable(.{
        .name = mission.dir,
        .root_module = learner_exe_mod,
    });
    b.installArtifact(learner_exe);

    const run_learner = b.addRunArtifact(learner_exe);
    if (b.args) |args| {
        run_learner.addArgs(args);
    }
    const run_learner_step = b.step("run-" ++ mission.step, "Run learner " ++ mission.title);
    run_learner_step.dependOn(&run_learner.step);

    const solution_exe_mod = b.createModule(.{
        .root_source_file = b.path("missions/" ++ mission.dir ++ "/solution/src/main.zig"),
        .target = target,
        .optimize = optimize,
    });
    const solution_exe = b.addExecutable(.{
        .name = mission.dir ++ "_solution",
        .root_module = solution_exe_mod,
    });
    b.installArtifact(solution_exe);

    const run_solution = b.addRunArtifact(solution_exe);
    if (b.args) |args| {
        run_solution.addArgs(args);
    }
    const run_solution_step = b.step("run-" ++ mission.step ++ "-solution", "Run solution " ++ mission.title);
    run_solution_step.dependOn(&run_solution.step);

    const learner_lib_mod = b.createModule(.{
        .root_source_file = b.path("missions/" ++ mission.dir ++ "/src/lib.zig"),
        .target = target,
        .optimize = optimize,
    });
    const learner_tests_mod = b.createModule(.{
        .root_source_file = b.path("missions/" ++ mission.dir ++ "/tests.zig"),
        .target = target,
        .optimize = optimize,
    });
    learner_tests_mod.addImport("mission", learner_lib_mod);
    const learner_tests = b.addTest(.{
        .name = "test-" ++ mission.step,
        .root_module = learner_tests_mod,
    });
    const run_learner_tests = b.addRunArtifact(learner_tests);
    const test_learner_step = b.step("test-" ++ mission.step, "Run learner tests for " ++ mission.title);
    test_learner_step.dependOn(&run_learner_tests.step);

    const solution_lib_mod = b.createModule(.{
        .root_source_file = b.path("missions/" ++ mission.dir ++ "/solution/src/lib.zig"),
        .target = target,
        .optimize = optimize,
    });
    const solution_tests_mod = b.createModule(.{
        .root_source_file = b.path("missions/" ++ mission.dir ++ "/tests.zig"),
        .target = target,
        .optimize = optimize,
    });
    solution_tests_mod.addImport("mission", solution_lib_mod);
    const solution_tests = b.addTest(.{
        .name = "test-" ++ mission.step ++ "-solution",
        .root_module = solution_tests_mod,
    });
    const run_solution_tests = b.addRunArtifact(solution_tests);
    const test_solution_step = b.step("test-" ++ mission.step ++ "-solution", "Run solution tests for " ++ mission.title);
    test_solution_step.dependOn(&run_solution_tests.step);

    all_solution_tests.dependOn(&run_solution_tests.step);
}
