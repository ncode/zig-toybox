const std = @import("std");
const flags = @import("lib.zig");

pub fn main(init: std.process.Init) !void {
    var iterator = try std.process.Args.Iterator.initAllocator(init.minimal.args, init.gpa);
    defer iterator.deinit();

    _ = iterator.skip();

    var args: [8][]const u8 = undefined;
    var count: usize = 0;
    while (iterator.next()) |arg| {
        if (count == args.len) {
            std.debug.print("{s}", .{flags.usage});
            return error.TooManyArguments;
        }
        args[count] = arg;
        count += 1;
    }

    const command = flags.parse(args[0..count]) catch |err| {
        std.debug.print("{s}", .{flags.usage});
        return err;
    };

    var buffer: [128]u8 = undefined;
    const greeting = try flags.renderGreeting(&buffer, command);
    std.debug.print("{s}", .{greeting});
}
