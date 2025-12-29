# 1. アイテム保護
data merge entity @s {PickupDelay:32767s,Invulnerable:1b}

# 2. 所有者特定
scoreboard players operation #TEMP player_id = @s player_id
tag @a remove item_recipient
execute as @a[tag=stalker] if score @s player_id = #TEMP player_id run tag @s add item_recipient

# 3. アイテム返却 (持っていない場合のみ)
# ロードストーンの設定は配布時と同じ初期状態にします (update_compassで再設定されるため)
execute as @a[tag=item_recipient] unless entity @s[nbt={Inventory:[{tag:{is_tracking_compass:1b}}]}] run give @s minecraft:compass{is_tracking_compass:1b,LodestoneDimension:"minecraft:overworld",LodestoneTracked:0b,LodestonePos:{X:0,Y:0,Z:0},display:{Name:'{"text":"追跡のコンパス","italic":false,"color":"gold"}'}} 1

# 4. アイテム消去
kill @s