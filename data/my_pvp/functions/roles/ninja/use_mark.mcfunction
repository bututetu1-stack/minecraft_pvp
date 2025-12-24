# 1. アイテム設定 & 権限チェック
data merge entity @s {PickupDelay:32767s,Invulnerable:1b}
execute unless entity @s[nbt={OnGround:1b}] run return 0
execute if entity @p[tag=ninja,distance=..300] run tag @s add can_process

# 所有者を一時的にタグ付け
tag @p[tag=ninja,distance=..300,limit=1,sort=nearest] add temp_owner

# --- 分岐A: CT中 (返却して終了) ---
# 1. アイテムを返す
execute if entity @s[tag=can_process] as @p[tag=temp_owner,scores={cd_ninja_mark=1..}] run give @s minecraft:black_dye{display:{Name:'{"text":"影縫い (設置)","color":"dark_purple"}',Lore:['{"text":"Q: 投げて身代わりを設置 (1->2->3)","color":"gray"}','{"text":"CT: 3s","color":"aqua"}']}} 1
# 2. エラー音
execute if entity @s[tag=can_process] as @p[tag=temp_owner,scores={cd_ninja_mark=1..}] run playsound minecraft:ui.button.click master @s ~ ~ ~ 1 0.5
# 3. 落ちているアイテムを消す
execute if entity @s[tag=can_process] as @p[tag=temp_owner,scores={cd_ninja_mark=1..}] run kill @e[tag=can_process,limit=1,distance=..1]
# 4. CT中の場合のみ、ここでタグを消して終了
execute as @p[tag=temp_owner,scores={cd_ninja_mark=1..}] run tag @s remove temp_owner
execute unless entity @s run return 0


# --- 分岐B: 成功 (発動) ---
# 1. アイテムを返す (身代わりはまだ補充システムを作っていないため、即時返却のままにします)
execute if entity @s[tag=can_process] as @p[tag=temp_owner] run give @s minecraft:black_dye{display:{Name:'{"text":"影縫い (設置)","color":"dark_purple"}',Lore:['{"text":"Q: 投げて身代わりを設置 (1->2->3)","color":"gray"}','{"text":"CT: 3s","color":"aqua"}']}} 1

# 2. 発動処理 (マーカー方式に修正)
# アイテム(@s)の位置に目印となるマーカーを召喚
execute if entity @s[tag=can_process] at @s run summon marker ~ ~ ~ {Tags:["temp_shadow_loc"]}

# そのマーカーの場所(@e[...])で、プレイヤー(@p)として関数を実行
execute if entity @s[tag=can_process] at @e[tag=temp_shadow_loc,limit=1,sort=nearest] as @p[tag=temp_owner] run function my_pvp:roles/ninja/place_shadow_logic

# マーカーを消す
kill @e[tag=temp_shadow_loc]

# 3. 後始末 (アイテム消去とタグ削除)
kill @s
tag @p remove temp_owner