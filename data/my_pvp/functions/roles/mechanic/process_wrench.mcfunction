# 1. アイテム保護（無敵化）
data merge entity @s {PickupDelay:32767s,Invulnerable:1b}

# 2. 安全装置チェック（持ち主特定）
execute if entity @p[tag=mechanic,distance=..300] run tag @s add can_process

# 3. 返却（即座に戻す）
# 【修正】Loreを新しい表記（Cost/Return表記）に統一しました
execute if entity @s[tag=can_process] run give @p[tag=mechanic,distance=..300,limit=1,sort=nearest] minecraft:iron_axe{display:{Name:'{"text":"エンジニアレンチ","italic":false,"color":"white"}',Lore:['{"text":"右クリック: 修理 (Cost: 1)","color":"gray"}','{"text":"スニーク+右クリック: 解体 (Return: 2)","color":"gray"}']}} 1

# 4. アイテム消去
execute if entity @s[tag=can_process] run kill @s