# 1. 使用者（近くの提督）を特定し、陣形変更関数を実行
execute as @p[tag=admiral,distance=..3] run function my_pvp:roles/admiral/change_formation

# 2. アイテムを即座に「元のスロット(Slot 4)」に再配置
# giveコマンドだと増殖する可能性があるため、item replaceで上書きします
execute as @p[tag=admiral,distance=..3] run item replace entity @s container.4 with minecraft:recovery_compass{admiral_compass:1b,display:{Name:'{"text":"艦隊指揮羅針盤","color":"gold","bold":true}',Lore:['{"text":"Qキー(ドロップ)で使用","color":"gray"}','{"text":"[陣形変更]","color":"dark_aqua"}']},AttributeModifiers:[{AttributeName:"generic.attack_damage",Name:"generic.attack_damage",Amount:4.0d,Operation:0,UUID:[I;111,222,333,444],Slot:"mainhand"}],Unbreakable:1b} 1

# 3. 落ちているアイテムを消去
kill @s