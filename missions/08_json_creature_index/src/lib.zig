const std = @import("std");

pub const Creature = struct {
    name: []const u8,
    habitat: []const u8,
};

pub const Index = struct {
    pub fn deinit(self: *Index) void {
        _ = self;
    }

    pub fn count(self: Index) usize {
        _ = self;
        return 0;
    }

    pub fn findHabitat(self: Index, name: []const u8) ?[]const u8 {
        _ = self;
        _ = name;
        return null;
    }
};

pub fn parseIndex(allocator: std.mem.Allocator, json_bytes: []const u8) !Index {
    _ = allocator;
    _ = json_bytes;
    return error.Todo;
}
