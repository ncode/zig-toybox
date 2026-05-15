const std = @import("std");
const cave = @import("lib.zig");

pub fn main() !void {
    var arena = std.heap.ArenaAllocator.init(std.heap.page_allocator);
    defer arena.deinit();

    const creatures = try cave.parseCreatures(arena.allocator(), "TODO:cave\n");
    for (creatures) |creature| {
        std.debug.print("{s} -> {s}\n", .{ creature.name, creature.habitat });
    }
}
