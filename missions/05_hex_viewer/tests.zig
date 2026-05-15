const std = @import("std");
const mission = @import("mission");

test "hex viewer formats empty input" {
    const output = try mission.formatHex(std.testing.allocator, "");
    defer std.testing.allocator.free(output);

    try std.testing.expectEqualStrings("", output);
}

test "hex viewer formats a small binary sample" {
    const bytes = [_]u8{ 0x00, 0x41, 0x7f, 0xff };
    const output = try mission.formatHex(std.testing.allocator, &bytes);
    defer std.testing.allocator.free(output);

    try std.testing.expectEqualStrings("00000000  00 41 7f ff  |.A..|\n", output);
}

test "hex viewer wraps at eight bytes per line" {
    const output = try mission.formatHex(std.testing.allocator, "abcdefghi");
    defer std.testing.allocator.free(output);

    try std.testing.expectEqualStrings(
        "00000000  61 62 63 64 65 66 67 68  |abcdefgh|\n" ++
            "00000008  69  |i|\n",
        output,
    );
}
