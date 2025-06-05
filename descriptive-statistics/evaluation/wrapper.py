# wrapper.py  – NEVER edit this in the student file!
import sys, pathlib
code = pathlib.Path(sys.argv[1]).read_text().strip()
print(code)
