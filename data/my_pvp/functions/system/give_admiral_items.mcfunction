clear @s

# 1. [砲撃支援] (メイン火力: CT 20秒) -> Slot 0
# Tag: adm_artillery, CMD: 1
item replace entity @s container.0 with minecraft:carrot_on_a_stick{adm_artillery:1b,CustomModelData:1,display:{Name:'{"text":"【砲撃支援】","color":"gold","bold":true}',Lore:['{"text":"[右クリック] 指定地点へ砲撃","color":"yellow"}','{"text":"CT: 20秒","color":"gray"}']},Unbreakable:1b} 1

# 2. [魚雷カットイン] (近-中距離: CT 10秒) -> Slot 1
# Tag: adm_torpedo, CMD: 2
# 変更: 説明文を具体的動作に合わせて修正
item replace entity @s container.1 with minecraft:carrot_on_a_stick{adm_torpedo:1b,CustomModelData:2,display:{Name:'{"text":"【魚雷カットイン】","color":"aqua","bold":true}',Lore:['{"text":"[右クリック] 前方3方向へ魚雷発射","color":"yellow"}','{"text":"CT: 10秒","color":"gray"}']},Unbreakable:1b} 1

# 3. [航空支援] (必殺技: CT 40秒) -> Slot 2
# Tag: adm_air, CMD: 3
item replace entity @s container.2 with minecraft:carrot_on_a_stick{adm_air:1b,CustomModelData:3,display:{Name:'{"text":"【航空支援】","color":"red","bold":true}',Lore:['{"text":"[右クリック] 絨毯爆撃要請","color":"yellow"}','{"text":"CT: 30秒","color":"gray"}']},Unbreakable:1b} 1

# 4. [対空カットイン] (防御: CT 15秒) -> Slot 3
# Tag: adm_aa, CMD: 4
# 変更: 説明文を簡潔で分かりやすい表現に修正
item replace entity @s container.3 with minecraft:carrot_on_a_stick{adm_aa:1b,CustomModelData:4,display:{Name:'{"text":"【対空カットイン】","color":"green","bold":true}',Lore:['{"text":"[右クリック] 周囲の敵を弾き飛ばす","color":"yellow"}','{"text":"CT: 15秒","color":"gray"}']},Unbreakable:1b} 1

# 5. [陣形指示用の羅針盤] -> Slot 4
# 統一: item replaceを使用
item replace entity @s container.4 with minecraft:recovery_compass{admiral_compass:1b,display:{Name:'{"text":"艦隊指揮羅針盤","color":"gold","bold":true}',Lore:['{"text":"右クリックで陣形変更","color":"gray"}']},AttributeModifiers:[{AttributeName:"generic.attack_damage",Name:"generic.attack_damage",Amount:4.0d,Operation:0,UUID:[I;111,222,333,444],Slot:"mainhand"}],Unbreakable:1b} 1