const std = @import("std");

pub fn addTodo(allocator: std.mem.Allocator, io: std.Io, dir: std.Io.Dir, path: []const u8, item: []const u8) !void {
    _ = allocator;
    _ = io;
    _ = dir;
    _ = path;
    _ = item;
    return error.Todo;
}

pub fn listTodos(allocator: std.mem.Allocator, io: std.Io, dir: std.Io.Dir, path: []const u8) ![]u8 {
    _ = io;
    _ = dir;
    _ = path;
    return allocator.dupe(u8, "");
}

pub fn removeTodo(allocator: std.mem.Allocator, io: std.Io, dir: std.Io.Dir, path: []const u8, index: usize) !void {
    _ = allocator;
    _ = io;
    _ = dir;
    _ = path;
    _ = index;
    return error.Todo;
}
