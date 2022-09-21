import sublime_plugin


class OpenTerminalCommand(sublime_plugin.WindowCommand):

    def run(self):
        cmd = '/usr/bin/terminator'
        self.window.run_command("exec", {"shell_cmd": cmd})
