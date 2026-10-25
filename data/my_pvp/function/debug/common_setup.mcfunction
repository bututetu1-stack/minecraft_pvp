# 1. 既存のアイテムと役職タグを消す
clear @s
tag @s remove mechanic
tag @s remove ninja
tag @s remove scout
tag @s remove tank
tag @s remove berserker
tag @s remove magician
tag @s remove mag_flying_true
tag @s remove admiral
tag @s remove stalker
tag @s remove sculptor
tag @s remove chrono
tag @s remove role_assigned
tag @s remove gambler
tag @s remove samurai
tag @s remove sam_zanshin_guard
tag @s remove sam_iai_dashing
tag @s remove sam_iai_hit_this_dash
tag @s remove sharpshooter
tag @s remove sharp_focused
tag @s remove beastmaster

# IDがない場合は付与する（安全装置）
execute unless score @s player_id matches 1.. run function my_pvp:system/assign_new_id
