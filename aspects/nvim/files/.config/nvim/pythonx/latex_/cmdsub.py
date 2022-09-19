from builtin import choose_next

command_mapping = ['🚀', '🚁', '🚂', '🚃', '🚄', '🚅', '🚆', '🚇', '🚈', '🚉', '🚊', '🚋', '🚌', '🚍', '🚎', '🚏']


def command_cycle(target, commands, bracketnum = 1):
    length = len(commands)
    command_map = command_mapping[:length]
    for i in range(length):
        target = target.replace(commands[i], command_map[i])
    string = list(target)
    depth = braces = 0
    for i in range(len(string) - 1, -1, -1):
        if string[i] == '}': depth += 1
        elif string[i] == '{': depth -= 1
        elif braces == bracketnum:
            if not depth:
                try:
                    string[i] = choose_next(string[i], command_map, length)
                    break
                except:
                    pass
        braces += 0 if depth else 1
    result = ''.join(string)
    for i in range(length):
        result = result.replace(command_map[i], commands[i])
    return result


def command_swap(target, command_1, command_2, bracketnum = 1):
    string = list(target.replace(command_1, '🚀').replace(command_2, '🚁'))
    depth = braces = 0
    for i in range(len(string) - 1, -1, -1):
        if string[i] == '}': depth += 1
        elif string[i] == '{': depth -= 1
        elif braces == bracketnum:
            if not depth:
                if string[i] == '🚀': string[i] = '🚁'
                elif string[i] == '🚁': string[i] = '🚀'
            break
        braces += 0 if depth else 1
    return ''.join(string).replace('🚀', command_1).replace('🚁', command_2)
