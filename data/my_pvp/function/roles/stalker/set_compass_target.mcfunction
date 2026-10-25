# 追跡コンパスの指す座標を更新する (マクロ)
# 引数: $(target_x) $(target_y) $(target_z) = ターゲットの座標 (update_compass で storage に格納)
# filtered で追跡コンパス以外のアイテムは変更しないので、両手に適用して問題ない
$item modify entity @s weapon.mainhand {function:"minecraft:filtered",item_filter:{items:"minecraft:compass",predicates:{"minecraft:custom_data":{is_tracking_compass:1b}}},modifier:{function:"minecraft:set_components",components:{"minecraft:lodestone_tracker":{target:{dimension:"minecraft:overworld",pos:[I;$(target_x),$(target_y),$(target_z)]},tracked:false}}}}
$item modify entity @s weapon.offhand {function:"minecraft:filtered",item_filter:{items:"minecraft:compass",predicates:{"minecraft:custom_data":{is_tracking_compass:1b}}},modifier:{function:"minecraft:set_components",components:{"minecraft:lodestone_tracker":{target:{dimension:"minecraft:overworld",pos:[I;$(target_x),$(target_y),$(target_z)]},tracked:false}}}}
