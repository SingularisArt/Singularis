def create_table(snip):
    rows = snip.buffer[snip.line].split('x')[0]
    cols = snip.buffer[snip.line].split('x')[1]

    def int_val(string): return int(''.join(s for s in string if s.isdigit()))

    rows = int_val(rows)
    cols = int_val(cols)

    offset = cols + 1
    old_spacing = snip.buffer[snip.line][:snip.buffer[snip.line].rfind(
        '\t') + 1]

    snip.buffer[snip.line] = ''

    final_str = old_spacing + \
        "\\begin{tabular}{|" + \
        "|".join(['$' + str(i + 1) for i in range(cols)]) + "|}\n"

    for i in range(rows):
        final_str += old_spacing + '\t'
        final_str += " & ".join(['$' + str(i * cols + j + offset)
                                for j in range(cols)])

        final_str += " \\\\\\\n"

    final_str += old_spacing + "\\end{tabular}\n$0"

    snip.expand_anon(final_str)


def add_row(snip):
    row_len = int(''.join(s for s in snip.buffer[snip.line] if s.isdigit()))
    old_spacing = snip.buffer[snip.line][:snip.buffer[snip.line].rfind(
        '\t') + 1]

    snip.buffer[snip.line] = ''

    final_str = old_spacing
    final_str += " & ".join(['$' + str(j + 1) for j in range(row_len)])
    final_str += " \\\\\\"

    snip.expand_anon(final_str)


def complete(t, opts):
    if t:
        opts = [m[len(t):] for m in opts if m.startswith(t)]
    if len(opts) == 1:
        return opts[0]
    return '(' + '|'.join(opts) + ')'
