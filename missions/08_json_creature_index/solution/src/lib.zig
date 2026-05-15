const std = @import("std");

pub const Creature = struct {
    name: []const u8,
    habitat: []const u8,
};

const Schema = struct {
    creatures: []Creature,
};

pub const Index = struct {
    parsed: std.json.Parsed(Schema),

    pub fn deinit(self: *Index) void {
        self.parsed.deinit();
    }

    pub fn count(self: Index) usize {
        return self.parsed.value.creatures.len;
    }

    pub fn findHabitat(self: Index, name: []const u8) ?[]const u8 {
        for (self.parsed.value.creatures) |creature| {
            if (std.mem.eql(u8, creature.name, name)) return creature.habitat;
        }
        return null;
    }
};

pub fn parseIndex(allocator: std.mem.Allocator, json_bytes: []const u8) !Index {
    const parsed = try std.json.parseFromSlice(Schema, allocator, json_bytes, .{ .allocate = .alloc_always });
    return .{ .parsed = parsed };
}
