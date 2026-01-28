# --- 1. 装備配布 (1.20.1用) ---
# ターゲット以外へのダメージ(4)を基準に設定
# Amount: 3.0 + 基礎ダメージ(1.0) = 4.0 ダメージ
give @s minecraft:iron_sword[minecraft:custom_data={is_stalker_weapon:1b},minecraft:custom_name='{"text":"暗殺者の短剣","color":"dark_purple","italic":false}',minecraft:lore=['{"text":"非対象には威力減衰","color":"gray"}'],minecraft:attribute_modifiers={modifiers:[{type:"generic.attack_damage",amount:3.0,operation:"add_value",slot:"mainhand",id:"my_pvp:stalker_dagger_damage"}],show_in_tooltip:true},minecraft:unbreakable={}] 1
# 追跡用コンパス
# LodestonePos, LodestoneDimension をtag直下に書く
item replace entity @s container.1 with minecraft:compass[minecraft:custom_data={is_tracking_compass:1b},minecraft:lodestone_tracker={target:{dimension:"minecraft:overworld",pos:[I;0,0,0]},tracked:false},minecraft:custom_name='{"text":"追跡のコンパス","italic":false,"color":"gold"}'] 1

# --- 2. ステータス初期化 ---
scoreboard players set @s target_id 0
scoreboard players set @s target_check_timer 0

# 最初のターゲットを決定
function my_pvp:roles/stalker/assign_target

# ロール付与タグ
tag @s add stalker