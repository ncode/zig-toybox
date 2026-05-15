const std = @import("std");
const cave = @import("lib.zig");

pub fn main(init: std.process.Init) !void {
    var arena = std.heap.ArenaAllocator.init(init.gpa);
    defer arena.deinit();

    const sample = "moth:cavern\ngoblin:basement\n";
    const creatures = try cave.parseCreatures(arena.allocator(), sample);
    for (creatures) |creature| {
        std.debug.print("{s} -> {s}\n", .{ creature.name, creature.habitat });
    }
}
