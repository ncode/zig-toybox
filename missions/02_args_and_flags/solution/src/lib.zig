const std = @import("std");

pub const Command = struct {
    name: []const u8,
    shout: bool,
};

pub const usage = "usage: args-and-flags [--shout] <name>\n";

pub fn parse(args: []const []const u8) !Command {
    var name: ?[]const u8 = null;
    var shout = false;

    for (args) |arg| {
        if (std.mem.eql(u8, arg, "")) return error.MissingName;

        if (std.mem.startsWith(u8, arg, "--")) {
            if (std.mem.eql(u8, arg, "--shout")) {
                shout = true;
            } else {
                return error.UnknownFlag;
            }
        } else if (name == null) {
            name = arg;
        } else {
            return error.TooManyArguments;
        }
    }

    return .{
        .name = name orelse return error.MissingName,
        .shout = shout,
    };
}

pub fn renderGreeting(buffer: []u8, command: Command) ![]const u8 {
    if (!command.shout) {
        return std.fmt.bufPrint(buffer, "hello, {s}\n", .{command.name});
    }

    const prefix = "HELLO, ";
    const needed = prefix.len + command.name.len + 1;
    if (buffer.len < needed) return error.NoSpaceLeft;

    @memcpy(buffer[0..prefix.len], prefix);
    for (command.name, 0..) |byte, i| {
        buffer[prefix.len + i] = std.ascii.toUpper(byte);
    }
    buffer[needed - 1] = '\n';
    return buffer[0..needed];
}
