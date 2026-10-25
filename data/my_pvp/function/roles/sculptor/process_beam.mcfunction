# 石化光線アイテムドロップ処理 (バーサーカーパターン)
# @s = 落ちた amethyst_shard アイテム

# 1. 所有者特定 (player_id 一致)
scoreboard players operation #TEMP player_id = @s player_id
tag @a remove item_recipient
execute as @a[tag=sculptor] if score @s player_id = #TEMP player_id run tag @s add item_recipient

# 2. CT中: アイテム即時返却 + Not Ready 表示
execute as @a[tag=item_recipient,scores={cd_sculptor_beam=1..}] unless entity @s[nbt={Inventory:[{components:{"minecraft:custom_data":{sculptor_beam:1b}}}]}] run give @s minecraft:amethyst_shard[minecraft:custom_data={sculptor_beam:1b},minecraft:custom_name='{"text":"石化光線","color":"blue","bold":true,"italic":false}',minecraft:lore=['{"text":"[Q]キー(捨てる): 石化光線発射","color":"yellow"}','{"text":"視線方向12m貫通、命中で6ダメ + 完全停止4秒","color":"gray"}','{"text":"CT: 10s","color":"aqua"}']] 1
execute as @a[tag=item_recipient,scores={cd_sculptor_beam=1..}] run title @s actionbar {"text":"石化光線 Not Ready...","color":"red"}
execute as @a[tag=item_recipient,scores={cd_sculptor_beam=1..}] at @s run playsound minecraft:ui.button.click master @s ~ ~ ~ 1 1.5

# 3. CTゼロ: スキル発動 (バーサーカーパターン: アイテムは返却せず CT終了時に sculptor_main で自動返却)
execute as @a[tag=item_recipient,scores={cd_sculptor_beam=..0}] at @s run function my_pvp:roles/sculptor/use_beam

# 4. 後始末
tag @a remove item_recipient
kill @s
