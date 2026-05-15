const std = @import("std");

pub fn filterMatches(allocator: std.mem.Allocator, input: []const u8, pattern: []const u8) ![]u8 {
    if (pattern.len == 0) return error.EmptyPattern;

    const output_len = countMatchedBytes(input, pattern);
    const output = try allocator.alloc(u8, output_len);

    var write_index: usize = 0;
    var read_index: usize = 0;
    while (read_index < input.len) {
        const line_start = read_index;
        while (read_index < input.len and input[read_index] != '\n') {
            read_index += 1;
        }
        const line = input[line_start..read_index];
        if (read_index < input.len and input[read_index] == '\n') {
            read_index += 1;
        }

        if (std.mem.indexOf(u8, line, pattern) != null) {
            @memcpy(output[write_index .. write_index + line.len], line);
            write_index += line.len;
            output[write_index] = '\n';
            write_index += 1;
        }
    }

    return output;
}

fn countMatchedBytes(input: []const u8, pattern: []const u8) usize {
    var total: usize = 0;
    var read_index: usize = 0;

    while (read_index < input.len) {
        const line_start = read_index;
        while (read_index < input.len and input[read_index] != '\n') {
            read_index += 1;
        }
        const line = input[line_start..read_index];
        if (read_index < input.len and input[read_index] == '\n') {
            read_index += 1;
        }

        if (std.mem.indexOf(u8, line, pattern) != null) {
            total += line.len + 1;
        }
    }

    return total;
}
