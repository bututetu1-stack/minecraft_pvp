# 1. タグ付け
tag @s add berserker
tag @s add role_assigned

# 2. 通知
tellraw @s [{"text":"[System] ","color":"gray"},{"text":"あなたは ","color":"white"},{"text":"『バーサーカー』","color":"red","bold":true},{"text":" です！","color":"white"}]

# 3. ステータス設定 (最大HP 60 = ハート30個)
attribute @s minecraft:generic.max_health base set 60
attribute @s minecraft:generic.attack_damage base set 1

# 4. 全回復
effect give @s minecraft:instant_health 1 100 true
effect give @s minecraft:saturation 1 255 true

# 5. アイテム配布 (※ここを変更: 試合開始時にも呼ばれる共通関数を使用)
# function my_pvp:roles/berserker/give_items  <-- 元の記述
function my_pvp:system/give_berserker_items

# 6. 音
playsound minecraft:entity.ravager.roar master @s ~ ~ ~ 1 1