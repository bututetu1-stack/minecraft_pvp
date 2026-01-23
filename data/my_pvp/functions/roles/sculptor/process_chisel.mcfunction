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
execute as @a[tag=current_caster] unless entity @s[nbt={Inventory:[{tag:{sculptor_chisel:1b}}]}] run give @s minecraft:iron_sword{sculptor_chisel:1b,Unbreakable:1b,AttributeModifiers:[{AttributeName:"generic.attack_damage",Name:"generic.attack_damage",Amount:4,Operation:0,UUID:[I;777,888,999,111],Slot:"mainhand"}],display:{Name:'{"text":"彫刻刀","color":"blue","italic":false}',Lore:['{"text":"捨てると彫刻を召喚","color":"gray"}','{"text":"最大20個まで設置可能","color":"aqua"}']},HideFlags:2} 1

# 5. タグ解除
tag @a remove current_caster

# 6. アイテム消去
kill @s
