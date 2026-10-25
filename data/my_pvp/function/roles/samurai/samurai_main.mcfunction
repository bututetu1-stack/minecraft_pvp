# --- クールダウン消化 ---
execute if score @s cd_sam_zanshin matches 1.. run scoreboard players remove @s cd_sam_zanshin 1
execute if score @s cd_sam_iai matches 1.. run scoreboard players remove @s cd_sam_iai 1
execute if score @s cd_sam_hien matches 1.. run scoreboard players remove @s cd_sam_hien 1

# --- CT完了通知 (音) ---
execute if score @s cd_sam_zanshin matches 1 run playsound minecraft:block.note_block.chime master @s ~ ~ ~ 1 2
execute if score @s cd_sam_iai matches 1 run playsound minecraft:block.note_block.chime master @s ~ ~ ~ 1 2
execute if score @s cd_sam_hien matches 1 run playsound minecraft:block.note_block.chime master @s ~ ~ ~ 1 2

# --- アイテム返却 (CT明け) ---
# 居合
execute if score @s cd_sam_iai matches 1 run item replace entity @s container.2 with minecraft:red_dye[minecraft:custom_data={samurai_iai:1b},minecraft:custom_name='{"text":"居合","color":"red","bold":true}',minecraft:lore=['{"text":"[Q]キー(捨てる): 居合斬り","color":"yellow"}','{"text":"前方へ突進し貫通ダメージ","color":"red"}','{"text":"CT: 10s","color":"aqua"}']] 1

# 飛燕
execute if score @s cd_sam_hien matches 1 run item replace entity @s container.3 with minecraft:feather[minecraft:custom_data={samurai_hien:1b},minecraft:custom_name='{"text":"飛燕","color":"light_purple","bold":true}',minecraft:lore=['{"text":"[Q]キー(捨てる): 三段ジャンプ斬撃","color":"yellow"}','{"text":"上昇しながら周囲を斬る","color":"red"}','{"text":"CT: 12s","color":"aqua"}']] 1

# Rush Mode Safety (ラッシュ中にCT0なのにアイテム無い場合は即時再配布)
execute as @s[tag=rush_mode,scores={cd_sam_iai=0}] unless entity @s[nbt={Inventory:[{components:{"minecraft:custom_data":{samurai_iai:1b}}}]}] run item replace entity @s container.2 with minecraft:red_dye[minecraft:custom_data={samurai_iai:1b},minecraft:custom_name='{"text":"居合","color":"red","bold":true}',minecraft:lore=['{"text":"[Q]キー(捨てる): 居合斬り","color":"yellow"}','{"text":"前方へ突進し貫通ダメージ","color":"red"}','{"text":"CT: 10s","color":"aqua"}']] 1
execute as @s[tag=rush_mode,scores={cd_sam_hien=0}] unless entity @s[nbt={Inventory:[{components:{"minecraft:custom_data":{samurai_hien:1b}}}]}] run item replace entity @s container.3 with minecraft:feather[minecraft:custom_data={samurai_hien:1b},minecraft:custom_name='{"text":"飛燕","color":"light_purple","bold":true}',minecraft:lore=['{"text":"[Q]キー(捨てる): 三段ジャンプ斬撃","color":"yellow"}','{"text":"上昇しながら周囲を斬る","color":"red"}','{"text":"CT: 12s","color":"aqua"}']] 1

# --- アクションバー ---
title @s actionbar [{"text":"残心: ","color":"aqua"},{"score":{"name":"@s","objective":"cd_sam_zanshin"},"color":"white"},{"text":" | 居合: ","color":"red"},{"score":{"name":"@s","objective":"cd_sam_iai"},"color":"white"},{"text":" | 飛燕: ","color":"light_purple"},{"score":{"name":"@s","objective":"cd_sam_hien"},"color":"white"}]

# --- 残心(パリィ)処理 ---
# 構え中（盾を持って右クリック中）の検知 → タグ付与
execute if entity @s[nbt={SelectedItem:{components:{"minecraft:custom_data":{samurai_zanshin:1b}}}},predicate=my_pvp:is_blocking] if score @s cd_sam_zanshin matches ..0 run function my_pvp:roles/samurai/start_zanshin

# 構え中タグ付き → 反撃判定
execute if entity @s[tag=sam_zanshin_guard] run function my_pvp:roles/samurai/tick_zanshin

# --- 居合突進中の処理 ---
execute if entity @s[tag=sam_iai_dashing] run function my_pvp:roles/samurai/tick_iai

# --- アイテムスキャン ---
function my_pvp:roles/samurai/scan_items
