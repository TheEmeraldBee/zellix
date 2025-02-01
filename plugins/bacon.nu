export def init-bacon [] {}

def main [] {
  zellij run -d down -- bacon clippy
  sleep 50ms
  zellij action resize decrease
  zellij action resize decrease
  zellij action resize decrease
  zellij action resize decrease
}
