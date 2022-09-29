function shell_key_bindings

  if test -x "$(command -v wl-copy)"
    function copyline
      commandline -b | sed -z '$ s/\n$//' | wl-copy
    end
  else
    function copyline
      commandline -b | sed -z '$ s/\n$//' | xsel ib
    end
  end

  bind \cxc copyline

end

