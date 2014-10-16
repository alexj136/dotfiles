import sys, subprocess, json

def get_workspaces():
    """Talk to i3 and get json data on existing workspaces"""
    cmd_output = subprocess.Popen(["i3-msg", "-t", "get_workspaces"],
            stdout=subprocess.PIPE).communicate()
    return json.loads(cmd_output[0].decode())

def existing_workspace_nums(data):
    """Takes workspace data output by get_workspaces and retreives a list of the
    ID numbers of the workspaces in use"""
    return list(map(lambda entry: entry['num'], data))

def focused_workspace_num(data):
    """Takes workspace data output by get_workspaces and returns the ID number
    of the focused workspace"""
    return list(filter(lambda entry: entry['focused'], data))[0]['num']

def next_workspace(existing, focused):
    """Determine what the 'next' workspace should be, i.e. the one to switch to
    next when switching through them with $mod+Tab"""
    if existing[-1] == focused: return existing[0]
    else: return existing[existing.index(focused) + 1]

def prev_workspace(existing, focused):
    """Determine what the 'previous' workspace should be, i.e. the one to switch
    to next when switching through them backwards with $mod+Shift+Tab"""
    if focused == existing[0]: return existing[-1]
    else: return existing[existing.index(focused) - 1]

def set_workspace(to_focus):
    """Ask i3 to focus the given workspace"""
    subprocess.call(["i3-msg", "workspace", str(to_focus)])

if __name__ in '__main__':
    if sys.argv[1] in ["next", "prev"]:
        data = get_workspaces()
        existing = existing_workspace_nums(data)
        focused = focused_workspace_num(data)
        if sys.argv[1] == "next":
            switch_to = next_workspace(existing, focused)
        elif sys.argv[1] == "prev":
            switch_to = prev_workspace(existing, focused)
        else:
            exit()
        set_workspace(switch_to)
        exit()
