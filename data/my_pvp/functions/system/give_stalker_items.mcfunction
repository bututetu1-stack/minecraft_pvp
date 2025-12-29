# --- 1. 装備配布 (1.20.1用) ---
# 武器: 凶手の剣 (Base 4ダメージ)
# UUIDは [I;...] 形式、AttributeModifiersはtagの中に書く
item replace entity @s container.0 with minecraft:iron_sword{is_stalker_weapon:1b,Unbreakable:1b,AttributeModifiers:[{AttributeName:"generic.attack_damage",Amount:3.0d,Operation:0,Slot:"mainhand",UUID:[I;111,222,333,444],Name:"weak_damage"}],display:{Name:'{"text":"凶手の剣","italic":false,"color":"dark_red"}',Lore:['{"text":"ターゲット以外には弱い","color":"gray"}']}} 1

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