const std = @import("std");
const hex = @import("lib.zig");

const usage = "usage: hex-viewer <file>\n";
const max_input_bytes = 1024 * 1024;

pub fn main(init: std.process.Init) !void {
    var iterator = try std.process.Args.Iterator.initAllocator(init.minimal.args, init.gpa);
    defer iterator.deinit();

    _ = iterator.skip();

    const file = iterator.next() orelse {
        std.debug.print("{s}", .{usage});
        return error.MissingArgument;
    };

    const bytes = try std.Io.Dir.cwd().readFileAlloc(init.io, file, init.gpa, .limited(max_input_bytes));
    defer init.gpa.free(bytes);

    const output = try hex.formatHex(init.gpa, bytes);
    defer init.gpa.free(output);

    std.debug.print("{s}", .{output});
}
