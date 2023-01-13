function echo_battery
  set -l capacity $(acpi -b 2> /dev/null | grep -oP '\d{2,}(?=%)')
  set -l is_charging $(acpi -a 2> /dev/null | grep -q 'on-line')
  set -l icon ''
  if test -n "$capacity"
    if test -n "$is_charging" 
      set icon ''
    else if test "$capacity" -gt 90
      set icon ''
    else if test "$capacity" -gt 75
      set icon ''
    else if test "$capacity" -gt 50
      set icon ''
    else if test "$capacity" -gt 25
      set icon ''
    end
    echo "Battery: $icon $capacity%%"
  end
end

function echo_acpi
  set -l temperature $(acpi -t 2> /dev/null | head -1 | grep -oP '\d+\.\d')
  if test -n "$temperature"
    echo "ACPI: $temperature°C"
  end
end

function fish_greeting
  if test $(tput cols) -gt 100 \
      && test $(tput lines) -gt 30 \
      && not test "$POETRY_ACTIVE" = '1'
    set -l LC_TIME 'en_US.UTF-8'
    set -l green '\e[0;32m'
    set -l reset '\e[m'
    printf "$green"
    printf '\n ███████╗ ██╗  ██╗'
    printf '\n ██╔════╝ ██║ ██╔╝'
    printf "  $(date +'%A %d-%m-%Y %H:%M:%S')"
    printf '\n ███████╗ █████╔╝ '
    printf "  $(echo_acpi)"
    printf '\n ╚════██║ ██╔═██╗ ' 
    printf "  $(echo_battery)"
    printf '\n ███████║ ██║  ██╗'
    printf '\n ╚══════╝ ╚═╝  ╚═╝'
    printf "$reset\n"
  end
end
