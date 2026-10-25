# --- クールダウン消化 ---
execute if score @s cd_sam_zanshin matches 1.. run scoreboard players remove @s cd_sam_zanshin 1
execute if score @s cd_sam_iai matches 1.. run scoreboard players remove @s cd_sam_iai 1
execute if score @s cd_sam_hien matches 1.. run scoreboard players remove @s cd_sam_hien 1

# --- CT完了通知 (音) ---
execute if score @s cd_sam_zanshin matches 1 run playsound minecraft:block.note_block.chime master @s ~ ~ ~ 1 2
execute if score @s cd_sam_iai matches 1 run playsound minecraft:block.note_block.chime master @s ~ ~ ~ 1 2
execute if score @s cd_sam_hien matches 1 run playsound minecraft:block.note_block.chime master @s ~ ~ ~ 1 2

# 共通スキル (大ジャンプ)
execute if score @s cd_super_jump matches 1.. run scoreboard players remove @s cd_super_jump 1
execute if score @s sneak_time matches 1.. run function my_pvp:roles/common/try_super_jump

# --- アイテム返却 (CT明け) ---
# 居合
execute if score @s cd_sam_iai matches 1 run item replace entity @s container.2 with minecraft:red_dye[minecraft:custom_data={samurai_iai:1b},minecraft:custom_name='{"text":"居合","color":"red","bold":true}',minecraft:lore=['{"text":"[Q]キー(捨てる): 居合斬り","color":"yellow"}','{"text":"前方へ突進し貫通ダメージ","color":"red"}','{"text":"CT: 10s","color":"aqua"}']] 1

# 飛燕
execute if score @s cd_sam_hien matches 1 run item replace entity @s container.3 with minecraft:feather[minecraft:custom_data={samurai_hien:1b},minecraft:custom_name='{"text":"飛燕","color":"light_purple","bold":true}',minecraft:lore=['{"text":"[Q]キー(捨てる): 三段ジャンプ斬撃","color":"yellow"}','{"text":"上昇しながら周囲を斬る","color":"red"}','{"text":"CT: 12s","color":"aqua"}']] 1

# --- アクションバー ---
title @s actionbar [{"text":"残心: ","color":"aqua"},{"score":{"name":"@s","objective":"cd_sam_zanshin"},"color":"white"},{"text":" | 居合: ","color":"red"},{"score":{"name":"@s","objective":"cd_sam_iai"},"color":"white"},{"text":" | 飛燕: ","color":"light_purple"},{"score":{"name":"@s","objective":"cd_sam_hien"},"color":"white"}]

# --- 残心(パリィ)処理 ---
# 構え中（盾を持って右クリック中）の検知 → タグ付与
# sam_blocking は samurai_blocking 進捗 (using_item) が構え中の毎tick 1 にする
execute if score @s sam_blocking matches 1.. unless entity @s[tag=sam_zanshin_guard] if score @s cd_sam_zanshin matches ..0 run function my_pvp:roles/samurai/start_zanshin

# 構え中タグ付き → 反撃判定
execute if entity @s[tag=sam_zanshin_guard] run function my_pvp:roles/samurai/tick_zanshin

# --- 居合突進中の処理 ---
execute if entity @s[tag=sam_iai_dashing] run function my_pvp:roles/samurai/tick_iai

# --- アイテムスキャン ---
function my_pvp:roles/samurai/scan_items

# --- アイテム返却 (CT 0 なのに手元に無い場合) ---
# ラッシュモード中は CT が毎tick 0 にされ「CT=1」を通らないため、上の返却だけでは戻らない
# ※ scan_items の後に置くこと (先に置くと、捨てた直後でまだ地面にあるアイテムまで返却してしまう)
execute if score @s cd_sam_iai matches ..0 unless items entity @s container.* *[minecraft:custom_data~{samurai_iai:1b}] unless items entity @s weapon.offhand *[minecraft:custom_data~{samurai_iai:1b}] run item replace entity @s container.2 with minecraft:red_dye[minecraft:custom_data={samurai_iai:1b},minecraft:custom_name='{"text":"居合","color":"red","bold":true}',minecraft:lore=['{"text":"[Q]キー(捨てる): 居合斬り","color":"yellow"}','{"text":"前方へ突進し貫通ダメージ","color":"red"}','{"text":"CT: 10s","color":"aqua"}']] 1
execute if score @s cd_sam_hien matches ..0 unless items entity @s container.* *[minecraft:custom_data~{samurai_hien:1b}] unless items entity @s weapon.offhand *[minecraft:custom_data~{samurai_hien:1b}] run item replace entity @s container.3 with minecraft:feather[minecraft:custom_data={samurai_hien:1b},minecraft:custom_name='{"text":"飛燕","color":"light_purple","bold":true}',minecraft:lore=['{"text":"[Q]キー(捨てる): 三段ジャンプ斬撃","color":"yellow"}','{"text":"上昇しながら周囲を斬る","color":"red"}','{"text":"CT: 12s","color":"aqua"}']] 1

# 構え検知フラグのリセット (構え続けていれば次のtickまでに進捗が再び 1 にする)
scoreboard players set @s sam_blocking 0
scoreboard players set @s sam_shield_block 0
