import sublime_plugin
import time


class InsertDatetimeCommand(sublime_plugin.TextCommand):
    def run(self, edit):
        sel = self.view.sel();
        for s in sel:
            self.view.replace(edit, s, 
                "{{{0}}}".format(time.strftime("%Y-%m-%d %H:%M")))