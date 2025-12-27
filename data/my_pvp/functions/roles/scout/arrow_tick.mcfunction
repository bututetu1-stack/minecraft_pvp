# 接地(inGround:1b)したらアンカー設置
execute if entity @s[nbt={inGround:1b}] run function my_pvp:roles/scout/deploy_anchor

# 一定時間(5秒)刺さらなかったら消滅
scoreboard players add @s gadget_life 1
execute if score @s gadget_life matches 100.. run kill @s