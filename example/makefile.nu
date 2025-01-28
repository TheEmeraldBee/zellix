export def init-makefile [] {}

def main [] {
  try { ferrite }
  print "Press <Any> To Continue!"
  input -n 1 -s
}
