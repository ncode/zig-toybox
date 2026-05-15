const std = @import("std");
const mission = @import("mission");

test "tiny todo adds and lists two items" {
    var tmp = std.testing.tmpDir(.{});
    defer tmp.cleanup();

    const allocator = std.testing.allocator;
    const io = std.testing.io;

    try mission.addTodo(allocator, io, tmp.dir, "todos.txt", "feed the goblin");
    try mission.addTodo(allocator, io, tmp.dir, "todos.txt", "polish the slice");

    const todos = try mission.listTodos(allocator, io, tmp.dir, "todos.txt");
    defer allocator.free(todos);

    try std.testing.expectEqualStrings("feed the goblin\npolish the slice\n", todos);
}

test "tiny todo removes the first item" {
    var tmp = std.testing.tmpDir(.{});
    defer tmp.cleanup();

    const allocator = std.testing.allocator;
    const io = std.testing.io;

    try mission.addTodo(allocator, io, tmp.dir, "todos.txt", "feed the goblin");
    try mission.addTodo(allocator, io, tmp.dir, "todos.txt", "polish the slice");
    try mission.removeTodo(allocator, io, tmp.dir, "todos.txt", 1);

    const todos = try mission.listTodos(allocator, io, tmp.dir, "todos.txt");
    defer allocator.free(todos);

    try std.testing.expectEqualStrings("polish the slice\n", todos);
}

test "tiny todo rejects empty items" {
    var tmp = std.testing.tmpDir(.{});
    defer tmp.cleanup();

    try std.testing.expectError(
        error.EmptyItem,
        mission.addTodo(std.testing.allocator, std.testing.io, tmp.dir, "todos.txt", ""),
    );
}

test "tiny todo rejects invalid remove indexes" {
    var tmp = std.testing.tmpDir(.{});
    defer tmp.cleanup();

    const allocator = std.testing.allocator;
    const io = std.testing.io;

    try std.testing.expectError(error.InvalidIndex, mission.removeTodo(allocator, io, tmp.dir, "missing.txt", 1));

    try mission.addTodo(allocator, io, tmp.dir, "todos.txt", "feed the goblin");
    try std.testing.expectError(error.InvalidIndex, mission.removeTodo(allocator, io, tmp.dir, "todos.txt", 0));
    try std.testing.expectError(error.InvalidIndex, mission.removeTodo(allocator, io, tmp.dir, "todos.txt", 2));
}
