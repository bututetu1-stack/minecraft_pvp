# 彫刻刀の処理
# @s = 落ちている彫刻刀アイテム

# 1. アイテム保護
data merge entity @s {PickupDelay:32767s,Invulnerable:1b}

# 2. 近くの彫刻家プレイヤーを特定してタグ付け
tag @a remove current_caster
execute at @s as @p[tag=sculptor,distance=..5] run tag @s add current_caster

# 3. CTチェック
# CTが0かつ、プレイヤーがいる場合のみ実行
execute at @s as @a[tag=current_caster,scores={cd_sculptor_create=0}] run function my_pvp:roles/sculptor/spawn_sculpture

# CT中の場合のエフェクト (キャンセル音)
execute at @s as @a[tag=current_caster,scores={cd_sculptor_create=1..}] run playsound minecraft:ui.button.click master @s ~ ~ ~ 1 1.5

# 4. 彫刻刀を返却
execute as @a[tag=current_caster] unless entity @s[nbt={Inventory:[{components:{"minecraft:custom_data":{sculptor_chisel:1b}}}]}] run give @s minecraft:iron_sword[minecraft:custom_data={sculptor_chisel:1b},minecraft:unbreakable={},minecraft:attribute_modifiers={modifiers:[{type:"generic.attack_damage",amount:4.0,operation:"add_value",slot:"mainhand",id:"my_pvp:sculptor_chisel_damage"}],show_in_tooltip:false},minecraft:custom_name='{"text":"彫刻刀","color":"blue","italic":false}',minecraft:lore=['{"text":"捨てると彫刻を召喚","color":"gray"}','{"text":"最大20個まで設置可能","color":"aqua"}']] 1

# 5. タグ解除
tag @a remove current_caster

# 6. アイテム消去
kill @s
