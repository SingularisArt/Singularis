import vim


# Math Mode
def math():
    return vim.eval('vimtex#syntax#in_mathzone()') == '1'


# Pure Math Mode
def pure_math():
    return math() and not_chem() and not_unit()


# Inline Math Mode
def inline_math():
    return vim.eval("vimtex#syntax#in('texMathZoneX')") == '1'


# Display Math Mode
def display_math():
    return vim.eval("vimtex#syntax#in('texMathZoneX')") == '0' and \
        math()


# Chemistry Mode
def chem():
    return vim.eval("get(vimtex#cmd#get_current(), 'name')") == '\\ce' \
        and math()


# Not Chemistry Mode
def not_chem():
    return not chem()


# Unit Mode
def unit():
    return vim.eval("get(vimtex#cmd#get_current(), 'name')") == '\\pu' \
        and math()


# Not Unit Mode
def not_unit():
    return not unit()


# Text Mode
def text():
    return vim.eval('vimtex#syntax#in_mathzone()') == '0'


# Comment Mode
def comment():
    return vim.eval('vimtex#syntax#in_comment()') == '1'


# Specific Environment
def env(name):
    [x, y] = vim.eval("vimtex#env#is_inside('" + name + "')")
    return x != '0' and y != '0'
