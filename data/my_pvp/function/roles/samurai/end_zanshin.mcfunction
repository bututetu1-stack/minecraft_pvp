# 残心終了
tag @s remove sam_zanshin_guard
scoreboard players set @s sam_zanshin_active 0

# 構え解除演出 (静かに納刀)
particle minecraft:dust{color:[0.5,0.6,0.8],scale:0.8} ~ ~1 ~ 0.3 0.3 0.3 0 6 force
playsound minecraft:item.armor.equip_iron master @s ~ ~ ~ 0.5 0.8
