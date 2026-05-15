const std = @import("std");
const creatures = @import("lib.zig");

pub fn main(init: std.process.Init) !void {
    const sample =
        \\{"creatures":[
        \\  {"name":"moth","habitat":"cavern"},
        \\  {"name":"goblin","habitat":"basement"}
        \\]}
    ;

    var index = try creatures.parseIndex(init.gpa, sample);
    defer index.deinit();

    const habitat = index.findHabitat("goblin") orelse "missing";
    std.debug.print("goblin -> {s}\n", .{habitat});
}
