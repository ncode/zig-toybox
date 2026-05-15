const std = @import("std");

pub const Command = struct {
    name: []const u8,
    shout: bool,
};

pub const usage = "usage: args-and-flags [--shout] <name>\n";

pub fn parse(args: []const []const u8) !Command {
    _ = args;
    return error.Todo;
}

pub fn renderGreeting(buffer: []u8, command: Command) ![]const u8 {
    _ = command;
    return std.fmt.bufPrint(buffer, "hello, TODO\n", .{});
}
