# デバッグ: 回収処理が走ったことを通知
tellraw @a [{"text":"[Debug] Running return_tool for: ","color":"yellow"},{"selector":"@s"}]

# アイテムを保護し、忍者の元へ戻す (TP方式)
data merge entity @s {PickupDelay:0s,Age:0s}
execute at @s run tp @s @p[tag=ninja,distance=..100,limit=1,sort=nearest]

# デバッグ: TP完了ログ
tellraw @a [{"text":"[Debug] TP Executed.","color":"aqua"}]

# 音
playsound minecraft:entity.item.pickup master @a ~ ~ ~ 0.5 2.0