const std = @import("std");

pub fn build(b: *std.Build) void {
    const target = b.standardTargetOptions(.{});
    const optimize = b.standardOptimizeOption(.{});

    const hello_mod = b.createModule(.{
        .root_source_file = b.path("missions/00_hello_basement/src/main.zig"),
        .target = target,
        .optimize = optimize,
    });
    const hello_exe = b.addExecutable(.{
        .name = "00_hello_basement",
        .root_module = hello_mod,
    });
    b.installArtifact(hello_exe);

    const run_hello = b.addRunArtifact(hello_exe);
    if (b.args) |args| {
        run_hello.addArgs(args);
    }
    const run_hello_step = b.step("run-00-hello-basement", "Run mission 00: hello basement");
    run_hello_step.dependOn(&run_hello.step);

    const hello_tests_mod = b.createModule(.{
        .root_source_file = b.path("missions/00_hello_basement/tests.zig"),
        .target = target,
        .optimize = optimize,
    });
    const hello_tests = b.addTest(.{
        .name = "test-00-hello-basement",
        .root_module = hello_tests_mod,
    });
    const run_hello_tests = b.addRunArtifact(hello_tests);

    const test_hello_step = b.step("test-00-hello-basement", "Run mission 00 tests");
    test_hello_step.dependOn(&run_hello_tests.step);

    const test_step = b.step("test", "Run all mission tests");
    test_step.dependOn(&run_hello_tests.step);
}
