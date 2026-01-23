# --- アイテムドロップ検知 (Chronomancer) ---

# 1. タイム・リバース (青い砂時計)
execute as @e[type=item,nbt={Item:{tag:{chrono_reverse:1b}}}] at @s run function my_pvp:roles/chrono/process_reverse

# 2. 時空の静止 (黄色の砂時計)
execute as @e[type=item,nbt={Item:{tag:{chrono_stasis:1b}}}] at @s run function my_pvp:roles/chrono/process_stasis

# 3. クロック・アップ (赤い砂時計)
execute as @e[type=item,nbt={Item:{tag:{chrono_clockup:1b}}}] at @s run function my_pvp:roles/chrono/process_clockup

# 4. 刻の宝剣 (Iron Sword)
# 名前やLoreで判定するより、chronoタグを持つプレイヤーが落とした鉄の剣を判定するのが確実
# ただし、アイテム自体にタグがないと、他人の剣も吸ってしまう可能性がある
# そのため、chrono役職の鉄の剣にはタグが無い場合が多いので、
# 「chronoが近くにいて、鉄の剣が落ちていれば吸い寄せる」簡易実装にする
# 4. 刻の宝剣 (Iron Sword)
execute as @e[type=item,nbt={Item:{id:"minecraft:iron_sword"}}] at @s if entity @p[tag=chrono,distance=..3] run item replace entity @p[tag=chrono,distance=..3] hotbar.0 with minecraft:iron_sword{display:{Name:'{"text":"刻の宝剣","color":"aqua","italic":false}'}}
execute as @e[type=item,nbt={Item:{id:"minecraft:iron_sword"}}] at @s if entity @p[tag=chrono,distance=..3] run kill @s