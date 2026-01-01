# --- 1. 装備配布 (1.20.1用) ---
# ターゲット以外へのダメージ(4)を基準に設定
# Amount: 3.0 + 基礎ダメージ(1.0) = 4.0 ダメージ
give @s minecraft:iron_sword{display:{Name:'{"text":"暗殺者の短剣","color":"dark_purple","italic":false}',Lore:['{"text":"非対象には威力減衰","color":"gray"}']},AttributeModifiers:[{AttributeName:"generic.attack_damage",Name:"generic.attack_damage",Amount:3.0d,Operation:0,UUID:[I;111,222,333,444],Slot:"mainhand"}],Unbreakable:1b} 1
# 追跡用コンパス
# LodestonePos, LodestoneDimension をtag直下に書く
item replace entity @s container.1 with minecraft:compass{is_tracking_compass:1b,LodestoneDimension:"minecraft:overworld",LodestoneTracked:0b,LodestonePos:{X:0,Y:0,Z:0},display:{Name:'{"text":"追跡のコンパス","italic":false,"color":"gold"}'}} 1

# --- 2. ステータス初期化 ---
scoreboard players set @s target_id 0
scoreboard players set @s target_check_timer 0

# 最初のターゲットを決定
function my_pvp:roles/stalker/assign_target

# ロール付与タグ
tag @s add stalker