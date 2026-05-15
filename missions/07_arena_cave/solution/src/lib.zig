const std = @import("std");

pub const Creature = struct {
    name: []const u8,
    habitat: []const u8,
};

pub fn parseCreatures(arena: std.mem.Allocator, input: []const u8) ![]Creature {
    if (input.len == 0) return &[_]Creature{};

    const count = countRecords(input);
    const creatures = try arena.alloc(Creature, count);

    var lines = std.mem.splitScalar(u8, input, '\n');
    var index: usize = 0;
    while (lines.next()) |line| {
        if (line.len == 0) continue;

        const colon = std.mem.indexOfScalar(u8, line, ':') orelse return error.InvalidRecord;
        const name = line[0..colon];
        const habitat = line[colon + 1 ..];
        if (name.len == 0 or habitat.len == 0) return error.InvalidRecord;

        creatures[index] = .{
            .name = try arena.dupe(u8, name),
            .habitat = try arena.dupe(u8, habitat),
        };
        index += 1;
    }

    return creatures;
}

fn countRecords(input: []const u8) usize {
    var count: usize = 0;
    var lines = std.mem.splitScalar(u8, input, '\n');
    while (lines.next()) |line| {
        if (line.len != 0) count += 1;
    }
    return count;
}
