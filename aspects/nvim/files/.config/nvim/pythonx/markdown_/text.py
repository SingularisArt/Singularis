import vim

table_settings = [["-", "-"], [":", "-"], ["-", ":"], [":", ":"]]
before_puncs = ['', ' ', '，', '。', '；', '：', '\'', '‘', '"', '[', ']','(', ')', '{', '}', '<', '>', '、', '-']
after_puncs = ['', ' ', ',', '，', '.', '。', ';', '；',':', '：', '\'', '‘', '"', '[', ']','(', ')', '{', '}', '<', '>', '、', '!', '-']


def create_table(snip, align = 0):
	placeholders_string = snip.buffer[snip.line].strip()[-2:]
	rows_amount = int(placeholders_string[0])
	columns_amount = int(placeholders_string[1])
	prefix_str = "from builtin import display_width;"
	snip.buffer[snip.line] = ""
	anon_snippet_title = "| "
	anon_snippet_delimiter = "|"
	for col in range(1, columns_amount + 1):
		sync_rows = [x * columns_amount + col for x in range(rows_amount + 1)]
		sync_str = ",".join(["t[{0}]".format(x) for x in sync_rows])
		max_width_str = "max(list(map(display_width,[" + sync_str + "])))"
		cur_width_str = "display_width(t[" + str(col) + "])"
		rv_val = "(" + max_width_str + "-" + cur_width_str + ")*' '"
		anon_snippet_title += "${" + str(col)  + ":head" + str(col)\
			+ "}`!p " + prefix_str + "snip.rv=" + rv_val + "` | "
		anon_snippet_delimiter += table_settings[align][0] + "`!p " + prefix_str + "snip.rv="\
			+ max_width_str + "*'-'`" + table_settings[align][1] + "|"
	anon_snippet_title += "\n"
	anon_snippet_delimiter += "\n"
	anon_snippet_body = ""
	for row in range(1, rows_amount + 1):
		body_row = "| "
		for col in range(1, columns_amount + 1):
			sync_rows = [x * columns_amount + col for x in range(rows_amount + 1)]
			sync_str = ",".join(["t[{0}]".format(x) for x in sync_rows])
			max_width_str = "max(list(map(display_width,[" + sync_str + "])))"
			cur_width_str = "display_width(t[" + str(row * columns_amount + col) + "])"
			rv_val = "(" + max_width_str + "-" + cur_width_str + ")*' '"
			placeholder = "R{0}C{1}".format(row, col)
			body_row += "${" + str(row * columns_amount + col)  + ":" + placeholder\
				+ "}`!p " + prefix_str + "snip.rv=" + rv_val + "` | "
		body_row += "\n"
		anon_snippet_body += body_row
	anon_snippet_table = anon_snippet_title + anon_snippet_delimiter + anon_snippet_body
	snip.expand_anon(anon_snippet_table)
