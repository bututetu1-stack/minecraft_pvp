# アイテムを保護し、忍者の元へ戻す
data merge entity @s {PickupDelay:0s,Age:0s}
execute at @s run tp @s @p[tag=ninja,distance=..100,limit=1,sort=nearest]
playsound minecraft:entity.item.pickup master @a ~ ~ ~ 0.5 2.0