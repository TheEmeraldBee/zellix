export def init-ai [] {}

def --wrapped main [...args] {
  zellij run -c -f -- aichat ...$args
}

def --wrapped "main pane" [...args] {
  zellij run -c -d right -- aichat ...$args
}
