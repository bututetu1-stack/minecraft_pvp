# A. しゃがみながら自分のガジェットに近づいたら「リサイクル」
execute if entity @s[nbt={IsSneaking:1b}] at @s as @e[tag=gadget,distance=..2.5] if score @s player_id = @p player_id run function my_pvp:roles/mechanic/recycle

# B. 立ったまま自分のガジェットに近づいたら「修理」
execute unless entity @s[nbt={IsSneaking:1b}] at @s as @e[tag=gadget,distance=..2.5] if score @s player_id = @p player_id run function my_pvp:roles/mechanic/repair