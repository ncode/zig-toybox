const std = @import("std");
const todo = @import("lib.zig");

const usage = "usage: tiny-todo <path> add <item> | list | remove <index>\n";

pub fn main(init: std.process.Init) !void {
    var iterator = try std.process.Args.Iterator.initAllocator(init.minimal.args, init.gpa);
    defer iterator.deinit();

    _ = iterator.skip();

    const path = iterator.next() orelse {
        std.debug.print("{s}", .{usage});
        return error.MissingArgument;
    };
    const command = iterator.next() orelse {
        std.debug.print("{s}", .{usage});
        return error.MissingArgument;
    };

    const cwd = std.Io.Dir.cwd();

    if (std.mem.eql(u8, command, "add")) {
        const item = iterator.next() orelse {
            std.debug.print("{s}", .{usage});
            return error.MissingArgument;
        };
        try todo.addTodo(init.gpa, init.io, cwd, path, item);
    } else if (std.mem.eql(u8, command, "list")) {
        const items = try todo.listTodos(init.gpa, init.io, cwd, path);
        defer init.gpa.free(items);
        std.debug.print("{s}", .{items});
    } else if (std.mem.eql(u8, command, "remove")) {
        const index_text = iterator.next() orelse {
            std.debug.print("{s}", .{usage});
            return error.MissingArgument;
        };
        const index = try std.fmt.parseInt(usize, index_text, 10);
        try todo.removeTodo(init.gpa, init.io, cwd, path, index);
    } else {
        std.debug.print("{s}", .{usage});
        return error.UnknownCommand;
    }
}
