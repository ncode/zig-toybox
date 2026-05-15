const std = @import("std");

const max_todo_file_bytes = 64 * 1024;

pub fn addTodo(allocator: std.mem.Allocator, io: std.Io, dir: std.Io.Dir, path: []const u8, item: []const u8) !void {
    if (item.len == 0) return error.EmptyItem;

    const existing = try listTodos(allocator, io, dir, path);
    defer allocator.free(existing);

    const updated = try allocator.alloc(u8, existing.len + item.len + 1);
    defer allocator.free(updated);

    @memcpy(updated[0..existing.len], existing);
    @memcpy(updated[existing.len .. existing.len + item.len], item);
    updated[updated.len - 1] = '\n';

    try dir.writeFile(io, .{ .sub_path = path, .data = updated });
}

pub fn listTodos(allocator: std.mem.Allocator, io: std.Io, dir: std.Io.Dir, path: []const u8) ![]u8 {
    return dir.readFileAlloc(io, path, allocator, .limited(max_todo_file_bytes)) catch |err| switch (err) {
        error.FileNotFound => try allocator.dupe(u8, ""),
        else => err,
    };
}

pub fn removeTodo(allocator: std.mem.Allocator, io: std.Io, dir: std.Io.Dir, path: []const u8, index: usize) !void {
    if (index == 0) return error.InvalidIndex;

    const existing = try listTodos(allocator, io, dir, path);
    defer allocator.free(existing);
    if (existing.len == 0) return error.InvalidIndex;

    const updated = try allocator.alloc(u8, existing.len);
    defer allocator.free(updated);

    var item_index: usize = 1;
    var read_index: usize = 0;
    var write_index: usize = 0;
    var removed = false;

    while (read_index < existing.len) {
        const line_start = read_index;
        while (read_index < existing.len and existing[read_index] != '\n') {
            read_index += 1;
        }
        if (read_index < existing.len and existing[read_index] == '\n') {
            read_index += 1;
        }

        if (item_index == index) {
            removed = true;
        } else {
            const line = existing[line_start..read_index];
            @memcpy(updated[write_index .. write_index + line.len], line);
            write_index += line.len;
        }

        item_index += 1;
    }

    if (!removed) return error.InvalidIndex;

    try dir.writeFile(io, .{ .sub_path = path, .data = updated[0..write_index] });
}
