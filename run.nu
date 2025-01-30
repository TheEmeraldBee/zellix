#!/usr/bin/env nu
def setup-files [session] {
  let path = "/tmp/zellix/" + $session

  # Ensure the session folder actually got deleted
  try { rm -r $path }

  # Create the session folder.
  mkdir $path
}

def main [module_path, filepath?, session?] {
  # Find the path of the zelix command.
  let path = $env.FILE_PWD
  $env.ZELLIX_PATH = $path

  let session = match $session {
    # Create a crazy, random set of characters for the session name
    null => (random chars --length 10)

    # Just use what was put for the session name.
    _ => $session
  }

  # Allow for zellix to function like the `hx` command, accepting a filepath if wanted.
  let filepath = match $filepath {
    null => ("./"),
    _ => $filepath
  }
  $env.ZELLIX_OPEN = $filepath

  # Create useful environment variables for users.
  $env.ZELLIX_SESSION = $session
  $env.ZELLIX_TMP = "/tmp/zellix/" + $session
  $env.ZELLIX_MOD = $module_path

  # Set up the tmp folder for the zellix session.
  setup-files $session

  # Set Layout And Config Paths for the zellij session
  let layout_path = $env.ZELLIX_PATH + "/layout.kdl"
  let config_path = $env.ZELLIX_PATH + "/zellij-config.kdl"

  # Create the zellij session
  zellij -s $session -n $layout_path -c $config_path

  # Delete The Session Folder
  rm -r $env.ZELLIX_TMP

  # Thank the user!
  print $"(ansi cb)Thank you for using Zellix!(ansi reset)"
}
