# --- ギャンブラー アイテムドロップ検知 ---

# 1. 剣 (戻す)
# ※ 鉄の剣は他役職も使うため、必ず custom_data で自分の剣だけを判定する
execute if items entity @s contents *[minecraft:custom_data~{gambler_sword:1b}] as @p[tag=gambler,distance=..3] run item replace entity @s hotbar.0 with minecraft:iron_sword[minecraft:custom_data={gambler_sword:1b},minecraft:unbreakable={},minecraft:custom_name='{"text":"ギャンブラーの剣","color":"gray","italic":false}']
execute if items entity @s contents *[minecraft:custom_data~{gambler_sword:1b}] run kill @s

# 2. ブラックジャック (鉄インゴット)
# Start (State 0 or unset)
# タグ付与: プレイヤーの状態を確認しつつ、アイテム(@s)にタグを付ける
execute if items entity @s contents minecraft:iron_ingot if entity @p[tag=gambler,distance=..3] unless entity @p[tag=gambler,distance=..3,scores={bj_state=1..}] run tag @s add bj_start_process

# 実行: タグが付いたアイテムの近くのプレイヤーとして実行
execute if entity @s[tag=bj_start_process] as @p[tag=gambler,distance=..3,limit=1,sort=nearest] run function my_pvp:roles/gambler/skills/blackjack/start
execute if entity @s[tag=bj_start_process] run kill @s

# Hit (State 1)
# Startとして処理されていない場合のみチェック
execute unless entity @s[tag=bj_start_process] if items entity @s contents minecraft:iron_ingot if entity @p[tag=gambler,distance=..3,scores={bj_state=1}] run tag @s add bj_hit_process

# 実行
execute if entity @s[tag=bj_hit_process] as @p[tag=gambler,distance=..3,limit=1,sort=nearest,scores={bj_state=1}] run function my_pvp:roles/gambler/skills/blackjack/hit
execute if entity @s[tag=bj_hit_process] run kill @s


# 3. オール・イン (金塊)
execute if items entity @s contents minecraft:gold_nugget if entity @p[tag=gambler,distance=..3] run tag @s add all_in_process
execute if entity @s[tag=all_in_process] as @p[tag=gambler,distance=..3,limit=1,sort=nearest] run function my_pvp:roles/gambler/skills/all_in
execute if entity @s[tag=all_in_process] run kill @s

# 4. ルーレット (ガストの涙)
execute if items entity @s contents minecraft:ghast_tear if entity @p[tag=gambler,distance=..3] run tag @s add roulette_process
execute if entity @s[tag=roulette_process] as @p[tag=gambler,distance=..3,limit=1,sort=nearest] run function my_pvp:roles/gambler/skills/roulette
execute if entity @s[tag=roulette_process] run kill @s

# 共通: アイテムを戻す (処理が行われた場合)
execute if entity @s[tag=bj_start_process] if items entity @s contents minecraft:iron_ingot as @p[tag=gambler,distance=..3,scores={bj_state=0}] run item replace entity @s hotbar.1 with minecraft:iron_ingot[minecraft:custom_name='{"text":"ブラックジャック","color":"gold","italic":false}',minecraft:lore=['{"text":"[Q]キーでドロップして開始 (30 Coins)","color":"gray"}']]
execute if entity @s[tag=bj_start_process] if items entity @s contents minecraft:iron_ingot as @p[tag=gambler,distance=..3,scores={bj_state=1}] run item replace entity @s hotbar.1 with minecraft:iron_ingot[minecraft:custom_name='{"text":"ブラックジャック","color":"gold","italic":false}',minecraft:lore=['{"text":"ドロップ:[HIT] / 3秒放置:[STAY]","color":"green"}']]

execute if entity @s[tag=bj_hit_process] if items entity @s contents minecraft:iron_ingot as @p[tag=gambler,distance=..3,scores={bj_state=0}] run item replace entity @s hotbar.1 with minecraft:iron_ingot[minecraft:custom_name='{"text":"ブラックジャック","color":"gold","italic":false}',minecraft:lore=['{"text":"[Q]キーでドロップして開始 (30 Coins)","color":"gray"}']]
execute if entity @s[tag=bj_hit_process] if items entity @s contents minecraft:iron_ingot as @p[tag=gambler,distance=..3,scores={bj_state=1}] run item replace entity @s hotbar.1 with minecraft:iron_ingot[minecraft:custom_name='{"text":"ブラックジャック","color":"gold","italic":false}',minecraft:lore=['{"text":"ドロップ:[HIT] / 3秒放置:[STAY]","color":"green"}']]

# 処理済みならキル
execute if entity @s[tag=bj_start_process] run kill @s
execute if entity @s[tag=bj_hit_process] run kill @s

# 5. 運命のコイン (銅インゴット)
execute if items entity @s contents minecraft:copper_ingot if entity @p[tag=gambler,distance=..3] run tag @s add fate_coin_process
execute if entity @s[tag=fate_coin_process] as @p[tag=gambler,distance=..3,limit=1,sort=nearest] run function my_pvp:roles/gambler/skills/fate_coin
execute if entity @s[tag=fate_coin_process] run kill @s

# 6. 戦争 (赤色の染料) -> ★アイテム返却のみ (発動しない)
# ※ 赤色の染料はバーサーカー/時空跳躍者も使うため、custom_data で自分の染料だけを判定する
execute if items entity @s contents *[minecraft:custom_data~{gambler_war:1b}] as @p[tag=gambler,distance=..3] run item replace entity @s hotbar.5 with minecraft:red_dye[minecraft:custom_data={gambler_war:1b},minecraft:custom_name='{"text":"宣戦布告","color":"dark_red","italic":false}',minecraft:lore=['{"text":"攻撃して発動 (50 Coins)","color":"gray"}']]
execute if items entity @s contents *[minecraft:custom_data~{gambler_war:1b}] run kill @s
