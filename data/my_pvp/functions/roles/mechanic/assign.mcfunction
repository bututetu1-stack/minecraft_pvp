# 1. タグ付け
tag @s add mechanic
tag @s add role_assigned

# 2. チャットで通知
tellraw @s [{"text":"[System] ","color":"gray"},{"text":"あなたは ","color":"white"},{"text":"『機械工』","color":"gold","bold":true},{"text":" です！","color":"white"}]

# 3. 攻撃能力の無効化
# 基礎攻撃力を0にする
attribute @s minecraft:generic.attack_damage base set 0

# 弱体化Lv255を付与して、ダメージを完全に0にする
effect give @s minecraft:weakness infinite 255 true

# 4. アイテム配布
# 【削除】試合開始時に配るため、ここでは実行しません
# function my_pvp:system/give_mechanic_items

# 5. 効果音
playsound minecraft:block.anvil.use master @s ~ ~ ~ 1 1