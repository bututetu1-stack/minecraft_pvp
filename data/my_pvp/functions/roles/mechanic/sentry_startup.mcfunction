# 1. タイマー減少
scoreboard players remove @s gadget_life 1

# 2. 音の再生 (金床を叩く音)
# 間隔を 10tick (0.5秒) に広げました。音量も 0.6 に下げて耳への負担を減らしています。
execute if score @s gadget_life matches 20 run playsound minecraft:block.anvil.use ambient @a ~ ~ ~ 0.6 1.0
execute if score @s gadget_life matches 10 run playsound minecraft:block.anvil.use ambient @a ~ ~ ~ 0.6 1.2
execute if score @s gadget_life matches 1 run playsound minecraft:block.anvil.use ambient @a ~ ~ ~ 0.6 1.5

# 3. 起動完了
# タイマーが0になったらタグを消して完了音
execute if score @s gadget_life matches ..0 run tag @s remove startup
execute if score @s gadget_life matches ..0 run playsound minecraft:block.note_block.pling ambient @a ~ ~ ~ 1 2.0