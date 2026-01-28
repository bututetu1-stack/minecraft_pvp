# Macro: Apply TP
# Args: rotation, radius

# game_center (または roulette_center) の位置を基準にする
$execute at @e[tag=roulette_center,limit=1] rotated $(rotation) 0 run tp @s ^ ^ ^$(radius) $(rotation) 0

