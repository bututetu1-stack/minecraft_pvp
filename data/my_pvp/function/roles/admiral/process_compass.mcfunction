# 1. 使用者（近くの提督）を特定し、陣形変更関数を実行
execute as @p[tag=admiral,distance=..3] run function my_pvp:roles/admiral/change_formation

# 2. アイテムを即座に「元のスロット(Slot 4)」に再配置
# giveコマンドだと増殖する可能性があるため、item replaceで上書きします
execute as @p[tag=admiral,distance=..3] run item replace entity @s container.4 with minecraft:recovery_compass[minecraft:custom_data={admiral_compass:1b},minecraft:custom_name='{"text":"妖精の羅針盤","color":"gold","bold":true}',minecraft:lore=['{"text":"Qキー(ドロップ)で使用","color":"gray"}','{"text":"[陣形変更]","color":"dark_aqua"}'],minecraft:attribute_modifiers={modifiers:[{type:"attack_damage",amount:4.0,operation:"add_value",slot:"mainhand",id:"my_pvp:admiral_compass_damage"}],show_in_tooltip:true},minecraft:unbreakable={}] 1

# 3. 落ちているアイテムを消去
kill @s