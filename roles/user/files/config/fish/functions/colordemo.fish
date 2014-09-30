function colordemo
	for color_name in (set_color --print-colors)
set_color $color_name
printf "%16s" $color_name
set_color -o $color_name
printf "%16s" "bold $color_name"
set_color normal
echo
end
end
