# --- ギャンブラー アイテムドロップ検知 ---

# 1. 剣 (戻す)
execute if entity @s[nbt={Item:{id:"minecraft:iron_sword"}}] as @p[tag=gambler,distance=..3] run item replace entity @s hotbar.0 with minecraft:iron_sword{display:{Name:'{"text":"ギャンブラーの剣","color":"gray","italic":false}'}}
execute if entity @s[nbt={Item:{id:"minecraft:iron_sword"}}] run kill @s

# 2. ブラックジャック (鉄インゴット)
# 開始 (State 0) -> Start
# 開始 (State 0 or Unset) -> Start
execute if entity @s[nbt={Item:{id:"minecraft:iron_ingot"}}] as @p[tag=gambler,distance=..3,scores={bj_state=0}] run function my_pvp:roles/gambler/skills/blackjack/start
execute if entity @s[nbt={Item:{id:"minecraft:iron_ingot"}}] as @p[tag=gambler,distance=..3] unless score @s bj_state matches 1.. run function my_pvp:roles/gambler/skills/blackjack/start
# HIT (State 1) -> Hit
execute if entity @s[nbt={Item:{id:"minecraft:iron_ingot"}}] as @p[tag=gambler,distance=..3,scores={bj_state=1}] run function my_pvp:roles/gambler/skills/blackjack/hit

# 共通: アイテムを戻す
execute if entity @s[nbt={Item:{id:"minecraft:iron_ingot"}}] as @p[tag=gambler,distance=..3,scores={bj_state=0}] run item replace entity @s hotbar.1 with minecraft:iron_ingot{display:{Name:'{"text":"ブラックジャック","color":"gold","italic":false}',Lore:['{"text":"[Q]キーでドロップして開始 (30 Coins)","color":"gray"}']}}
execute if entity @s[nbt={Item:{id:"minecraft:iron_ingot"}}] as @p[tag=gambler,distance=..3] unless score @s bj_state matches 1.. run item replace entity @s hotbar.1 with minecraft:iron_ingot{display:{Name:'{"text":"ブラックジャック","color":"gold","italic":false}',Lore:['{"text":"[Q]キーでドロップして開始 (30 Coins)","color":"gray"}']}}
execute if entity @s[nbt={Item:{id:"minecraft:iron_ingot"}}] as @p[tag=gambler,distance=..3,scores={bj_state=1}] run item replace entity @s hotbar.1 with minecraft:iron_ingot{display:{Name:'{"text":"ブラックジャック","color":"gold","italic":false}',Lore:['{"text":"ドロップ:[HIT] / 3秒放置:[STAY]","color":"green"}']}}
execute if entity @s[nbt={Item:{id:"minecraft:iron_ingot"}}] run kill @s

# 3. オール・イン (金塊) -> スキル発動
execute if entity @s[nbt={Item:{id:"minecraft:gold_nugget"}}] as @p[tag=gambler,distance=..3] run function my_pvp:roles/gambler/skills/all_in
execute if entity @s[nbt={Item:{id:"minecraft:gold_nugget"}}] run kill @s

# 4. ルーレット (ガストの涙) -> スキル発動
execute if entity @s[nbt={Item:{id:"minecraft:ghast_tear"}}] as @p[tag=gambler,distance=..3] run function my_pvp:roles/gambler/skills/roulette
execute if entity @s[nbt={Item:{id:"minecraft:ghast_tear"}}] run kill @s

# 5. 運命のコイン (銅インゴット) -> スキル発動
execute if entity @s[nbt={Item:{id:"minecraft:copper_ingot"}}] as @p[tag=gambler,distance=..3] run function my_pvp:roles/gambler/skills/fate_coin
execute if entity @s[nbt={Item:{id:"minecraft:copper_ingot"}}] run kill @s

# 6. 戦争 (赤色の染料) -> ★アイテム返却のみ (発動しない)
execute if entity @s[nbt={Item:{id:"minecraft:red_dye"}}] as @p[tag=gambler,distance=..3] run item replace entity @s hotbar.5 with minecraft:red_dye{display:{Name:'{"text":"宣戦布告","color":"dark_red","italic":false}',Lore:['{"text":"攻撃して発動 (50 Coins)","color":"gray"}']}}
execute if entity @s[nbt={Item:{id:"minecraft:red_dye"}}] run kill @s
