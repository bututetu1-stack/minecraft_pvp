# 1. アイテム保護（無敵化）
# これでマグマに投げ込んでも消滅せず、確実に手元に戻ります
data merge entity @s {PickupDelay:32767s,Invulnerable:1b}

# 2. 安全装置チェック（持ち主特定）
execute if entity @p[tag=mechanic,distance=..300] run tag @s add can_process

# 3. 返却（即座に戻す）
execute if entity @s[tag=can_process] run give @p[tag=mechanic,distance=..300,limit=1,sort=nearest] minecraft:iron_axe{display:{Name:'{"text":"エンジニアレンチ","italic":false,"color":"white"}',Lore:['{"text":"右クリックで修理、スネーク+右クリックで解体","color":"gray"}']}} 1

# 4. アイテム消去
execute if entity @s[tag=can_process] run kill @s