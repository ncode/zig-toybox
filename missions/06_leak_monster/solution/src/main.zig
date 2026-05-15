const std = @import("std");
const leak = @import("lib.zig");

pub fn main(init: std.process.Init) !void {
    var monster = try leak.summon(init.gpa, "leak monster");
    defer monster.deinit(init.gpa);

    const output = try leak.roar(init.gpa, monster);
    defer init.gpa.free(output);

    std.debug.print("{s}\n", .{output});
}
