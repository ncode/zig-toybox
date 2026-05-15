const std = @import("std");

const bytes_per_line: usize = 8;

pub fn formatHex(allocator: std.mem.Allocator, bytes: []const u8) ![]u8 {
    if (bytes.len == 0) return allocator.dupe(u8, "");

    const output = try allocator.alloc(u8, dumpLength(bytes.len));
    var write_index: usize = 0;
    var offset: usize = 0;

    while (offset < bytes.len) {
        const line_len: usize = @min(bytes_per_line, bytes.len - offset);
        write_index += (try std.fmt.bufPrint(output[write_index .. write_index + 8], "{x:0>8}", .{offset})).len;
        output[write_index] = ' ';
        output[write_index + 1] = ' ';
        write_index += 2;

        for (bytes[offset .. offset + line_len], 0..) |byte, i| {
            if (i != 0) {
                output[write_index] = ' ';
                write_index += 1;
            }
            write_index += (try std.fmt.bufPrint(output[write_index .. write_index + 2], "{x:0>2}", .{byte})).len;
        }

        output[write_index] = ' ';
        output[write_index + 1] = ' ';
        output[write_index + 2] = '|';
        write_index += 3;

        for (bytes[offset .. offset + line_len]) |byte| {
            output[write_index] = if (byte >= 0x20 and byte <= 0x7e) byte else '.';
            write_index += 1;
        }

        output[write_index] = '|';
        output[write_index + 1] = '\n';
        write_index += 2;
        offset += line_len;
    }

    return output;
}

fn dumpLength(byte_count: usize) usize {
    var total: usize = 0;
    var offset: usize = 0;
    while (offset < byte_count) {
        const line_len: usize = @min(bytes_per_line, byte_count - offset);
        total += 8 + 2 + (line_len * 2) + (line_len - 1) + 2 + 1 + line_len + 2;
        offset += line_len;
    }
    return total;
}
