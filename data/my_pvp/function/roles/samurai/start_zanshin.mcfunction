# 残心 (Zanshin) 構え開始
# パリィ準備状態に入る (1.5秒間)
tag @s add sam_zanshin_guard
scoreboard players set @s sam_zanshin_active 30

# CTセット (失敗時用) - 構え終了時に上書きされる
scoreboard players set @s cd_sam_zanshin 160

# 演出
particle minecraft:enchant ~ ~1 ~ 0.4 0.5 0.4 0.5 8
playsound minecraft:item.armor.equip_iron master @s ~ ~ ~ 0.6 1.5
