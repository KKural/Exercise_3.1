#!/usr/bin/env python3
import sys, importlib.util, pathlib

student_file = pathlib.Path(sys.argv[1])

spec = importlib.util.spec_from_file_location("student", student_file)
student = importlib.util.module_from_spec(spec)
spec.loader.exec_module(student)
