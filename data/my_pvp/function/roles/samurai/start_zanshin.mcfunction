# 残心 (Zanshin) 構え開始
# パリィ準備状態に入る (1.5秒間)
tag @s add sam_zanshin_guard
scoreboard players set @s sam_zanshin_active 30

# CTセット (失敗時用) - 構え終了時に上書きされる
scoreboard players set @s cd_sam_zanshin 160

# --- 構え開始演出 (強化) ---
# アクションバー: 構え状態表示
title @s actionbar [{"text":"⛨ 残心 ","color":"dark_blue","bold":true},{"text":"構え中...","color":"aqua"}]

# 構えオーラ (青い魔法陣)
particle minecraft:enchant ~ ~1 ~ 0.5 0.5 0.5 0.8 18 force
particle minecraft:dust{color:[0.3,0.6,1.0],scale:1.0} ~ ~1 ~ 0.4 0.5 0.4 0 15 force
particle minecraft:soul_fire_flame ~ ~0.1 ~ 0.4 0 0.4 0 8 force

# 効果音層: 鎧装着 + 弓引き絞り (緊張感) + 鈴音
playsound minecraft:item.armor.equip_iron master @s ~ ~ ~ 0.8 1.5
playsound minecraft:item.crossbow.loading_middle master @s ~ ~ ~ 1 1.4
playsound minecraft:block.amethyst_block.chime master @s ~ ~ ~ 0.5 1.5
