# --- 1. 装備配布 ---
# 実ダメージは trigger_attack の遅延攻撃で与える (ターゲット: 10 / 非ターゲット: 4)
# 物理攻撃は命中判定(stalker_attack 進捗)を起こすためだけなので 0.01 に抑える
# Amount: -0.99 + 基礎ダメージ(1.0) = 0.01 ダメージ (0 だと命中自体が発生しない)
give @s minecraft:iron_sword[minecraft:custom_data={is_stalker_weapon:1b},minecraft:custom_name='{"text":"暗殺者の短剣","color":"dark_purple","italic":false}',minecraft:lore=['{"text":"非対象には威力減衰","color":"gray"}'],minecraft:attribute_modifiers={modifiers:[{type:"attack_damage",amount:-0.99,operation:"add_value",slot:"mainhand",id:"my_pvp:stalker_dagger_damage"}],show_in_tooltip:false},minecraft:unbreakable={}] 1
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