# This is an example system to allow for the use of yazi as a
# filepicker that supports multiple files, opening folders,
# and re-opening the picker at the current path instead of the root project path.

# This command can not do anything that would be temporary.
# Example: Adding an Environment Variable here would not persist.
export def init-yazi [] {
  $env.PWD | save ($env.ZELLIX_TMP + "/yazi")
}

def main [] {

  # Load the file we created in init-yazi to get the current path that is selected.
  let current_path = open ($env.ZELLIX_TMP + "/yazi")

  # Open yazi at the current path, and print the selected files to stdout.
  let paths = yazi --chooser-file=/dev/stdout $current_path

  # Split the files by rows.
  let command = ($paths | each {|line| $line | split row "\n"})

  # Check if no files were selected, and exit if none are.
  if ($command | get 0 | str trim | is-empty) {
    exit 0
  }

  # Write the first file in the selection to the current path file..
  rm ($env.ZELLIX_TMP + "/yazi")
  $command | get 0 | save ($env.ZELLIX_TMP + "/yazi")

  # Join the list of filepaths we had above to support writing the paths to helix.
  let command_str = $command | str join " "

  # Set up the string for the actual command.
  let run = ":open " + $command_str

  zellij action toggle-floating-panes # Select Helix In The System
  zellij action write 27 # Exit To Normal Mode
  zellij action write-chars $run # Write actual Command
  zellij action write 13 # Press Enter to run the command
}
