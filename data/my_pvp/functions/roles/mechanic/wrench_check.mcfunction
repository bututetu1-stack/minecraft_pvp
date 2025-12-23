# A. しゃがみながら（述語が真）自分のガジェットに近づいたら「リサイクル」

execute if predicate my_pvp:is_sneaking at @s as @e[tag=gadget,distance=..2.5] if score @s player_id = @p player_id run function my_pvp:roles/mechanic/recycle

# B. 立ったまま（述語が偽）自分のガジェットに近づいたら「修理」

execute unless predicate my_pvp:is_sneaking at @s as @e[tag=gadget,distance=..2.5] if score @s player_id = @p player_id run function my_pvp:roles/mechanic/repair