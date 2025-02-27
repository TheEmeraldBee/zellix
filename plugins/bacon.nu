export def init-bacon [] {}

def main [] {
  zellij run -d -c down -- bacon clippy
  sleep 50ms
  zellij action resize decrease
  zellij action resize decrease
  zellij action resize decrease
  zellij action resize decrease
}
