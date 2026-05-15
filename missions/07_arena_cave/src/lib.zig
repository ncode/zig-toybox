const std = @import("std");

pub const Creature = struct {
    name: []const u8,
    habitat: []const u8,
};

pub fn parseCreatures(arena: std.mem.Allocator, input: []const u8) ![]Creature {
    _ = arena;
    _ = input;
    return error.Todo;
}
