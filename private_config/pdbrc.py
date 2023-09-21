try:
    import pdb
    import pygments.formatters

    class Config(pdb.DefaultConfig):
        highlight = True
        # pygments_formatter_class = "pygments.formatter.TerminalTrueColorFormatter"
        # pygments_formatter_kwargs = {"style": "monokai"}
        formatter = pygments.formatters.TerminalTrueColorFormatter(
            style="monokai",
        )
        use_pygments = True
        sticky_by_default = True
        prompt = "\033[1;92mpdb++> \033[0m"
        current_line_color = "39;100;1"

except ModuleNotFoundError:
    pass
