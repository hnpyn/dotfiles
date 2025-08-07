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
        sticky_by_default = False
        prompt = "\001\033[1;92m\002pdb++>\001\033[0m\002 "
        current_line_color = "1;100;1"

except ModuleNotFoundError:
    pass
