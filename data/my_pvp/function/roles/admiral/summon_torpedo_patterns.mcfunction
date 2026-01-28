
# --- A. 島風 (temp=0) : 5-way Fan ---
# Center
execute if score @s temp matches 0 run summon armor_stand ^ ^1 ^1 {Tags:["adm_torpedo","new_torp","type_shimakaze","processing"],Invisible:1b,Marker:1b,NoGravity:1b}
execute if score @s temp matches 0 run data modify entity @e[tag=processing,limit=1] Rotation set from entity @s Rotation
execute if score @s temp matches 0 run tag @e[tag=processing] remove processing

# Left 15
execute if score @s temp matches 0 run summon armor_stand ^ ^1 ^1 {Tags:["adm_torpedo","new_torp","type_shimakaze","processing"],Invisible:1b,Marker:1b,NoGravity:1b}
execute if score @s temp matches 0 run data modify entity @e[tag=processing,limit=1] Rotation set from entity @s Rotation
execute if score @s temp matches 0 as @e[tag=processing] run tp @s ~ ~ ~ ~-15 ~
execute if score @s temp matches 0 run tag @e[tag=processing] remove processing

# Left 30
execute if score @s temp matches 0 run summon armor_stand ^ ^1 ^1 {Tags:["adm_torpedo","new_torp","type_shimakaze","processing"],Invisible:1b,Marker:1b,NoGravity:1b}
execute if score @s temp matches 0 run data modify entity @e[tag=processing,limit=1] Rotation set from entity @s Rotation
execute if score @s temp matches 0 as @e[tag=processing] run tp @s ~ ~ ~ ~-30 ~
execute if score @s temp matches 0 run tag @e[tag=processing] remove processing

# Right 15
execute if score @s temp matches 0 run summon armor_stand ^ ^1 ^1 {Tags:["adm_torpedo","new_torp","type_shimakaze","processing"],Invisible:1b,Marker:1b,NoGravity:1b}
execute if score @s temp matches 0 run data modify entity @e[tag=processing,limit=1] Rotation set from entity @s Rotation
execute if score @s temp matches 0 as @e[tag=processing] run tp @s ~ ~ ~ ~15 ~
execute if score @s temp matches 0 run tag @e[tag=processing] remove processing

# Right 30
execute if score @s temp matches 0 run summon armor_stand ^ ^1 ^1 {Tags:["adm_torpedo","new_torp","type_shimakaze","processing"],Invisible:1b,Marker:1b,NoGravity:1b}
execute if score @s temp matches 0 run data modify entity @e[tag=processing,limit=1] Rotation set from entity @s Rotation
execute if score @s temp matches 0 as @e[tag=processing] run tp @s ~ ~ ~ ~30 ~
execute if score @s temp matches 0 run tag @e[tag=processing] remove processing


# --- B. 阿武隈 (temp=1) : 3-way Parallel ---
# Center
execute if score @s temp matches 1 run summon armor_stand ^ ^1 ^1 {Tags:["adm_torpedo","new_torp","type_abukuma","processing"],Invisible:1b,Marker:1b,NoGravity:1b}
execute if score @s temp matches 1 run data modify entity @e[tag=processing,limit=1] Rotation set from entity @s Rotation
execute if score @s temp matches 1 run tag @e[tag=processing] remove processing

# Left 1.5
execute if score @s temp matches 1 run summon armor_stand ^1.5 ^1 ^1 {Tags:["adm_torpedo","new_torp","type_abukuma","processing"],Invisible:1b,Marker:1b,NoGravity:1b}
execute if score @s temp matches 1 run data modify entity @e[tag=processing,limit=1] Rotation set from entity @s Rotation
execute if score @s temp matches 1 run tag @e[tag=processing] remove processing

# Right 1.5
execute if score @s temp matches 1 run summon armor_stand ^-1.5 ^1 ^1 {Tags:["adm_torpedo","new_torp","type_abukuma","processing"],Invisible:1b,Marker:1b,NoGravity:1b}
execute if score @s temp matches 1 run data modify entity @e[tag=processing,limit=1] Rotation set from entity @s Rotation
execute if score @s temp matches 1 run tag @e[tag=processing] remove processing


# --- C. 北上 (temp=2) : 9-way Hyper (-40 ~ +40) ---
# Center (0)
execute if score @s temp matches 2 run summon armor_stand ^ ^1 ^1 {Tags:["adm_torpedo","new_torp","type_kitakami","processing"],Invisible:1b,Marker:1b,NoGravity:1b}
execute if score @s temp matches 2 run data modify entity @e[tag=processing,limit=1] Rotation set from entity @s Rotation
execute if score @s temp matches 2 run tag @e[tag=processing] remove processing

# -10 ~ -40
execute if score @s temp matches 2 run summon armor_stand ^ ^1 ^1 {Tags:["adm_torpedo","new_torp","type_kitakami","processing"],Invisible:1b,Marker:1b,NoGravity:1b}
execute if score @s temp matches 2 run data modify entity @e[tag=processing,limit=1] Rotation set from entity @s Rotation
execute if score @s temp matches 2 as @e[tag=processing] run tp @s ~ ~ ~ ~-10 ~
execute if score @s temp matches 2 run tag @e[tag=processing] remove processing

execute if score @s temp matches 2 run summon armor_stand ^ ^1 ^1 {Tags:["adm_torpedo","new_torp","type_kitakami","processing"],Invisible:1b,Marker:1b,NoGravity:1b}
execute if score @s temp matches 2 run data modify entity @e[tag=processing,limit=1] Rotation set from entity @s Rotation
execute if score @s temp matches 2 as @e[tag=processing] run tp @s ~ ~ ~ ~-20 ~
execute if score @s temp matches 2 run tag @e[tag=processing] remove processing

execute if score @s temp matches 2 run summon armor_stand ^ ^1 ^1 {Tags:["adm_torpedo","new_torp","type_kitakami","processing"],Invisible:1b,Marker:1b,NoGravity:1b}
execute if score @s temp matches 2 run data modify entity @e[tag=processing,limit=1] Rotation set from entity @s Rotation
execute if score @s temp matches 2 as @e[tag=processing] run tp @s ~ ~ ~ ~-30 ~
execute if score @s temp matches 2 run tag @e[tag=processing] remove processing

execute if score @s temp matches 2 run summon armor_stand ^ ^1 ^1 {Tags:["adm_torpedo","new_torp","type_kitakami","processing"],Invisible:1b,Marker:1b,NoGravity:1b}
execute if score @s temp matches 2 run data modify entity @e[tag=processing,limit=1] Rotation set from entity @s Rotation
execute if score @s temp matches 2 as @e[tag=processing] run tp @s ~ ~ ~ ~-40 ~
execute if score @s temp matches 2 run tag @e[tag=processing] remove processing

# +10 ~ +40
execute if score @s temp matches 2 run summon armor_stand ^ ^1 ^1 {Tags:["adm_torpedo","new_torp","type_kitakami","processing"],Invisible:1b,Marker:1b,NoGravity:1b}
execute if score @s temp matches 2 run data modify entity @e[tag=processing,limit=1] Rotation set from entity @s Rotation
execute if score @s temp matches 2 as @e[tag=processing] run tp @s ~ ~ ~ ~10 ~
execute if score @s temp matches 2 run tag @e[tag=processing] remove processing

execute if score @s temp matches 2 run summon armor_stand ^ ^1 ^1 {Tags:["adm_torpedo","new_torp","type_kitakami","processing"],Invisible:1b,Marker:1b,NoGravity:1b}
execute if score @s temp matches 2 run data modify entity @e[tag=processing,limit=1] Rotation set from entity @s Rotation
execute if score @s temp matches 2 as @e[tag=processing] run tp @s ~ ~ ~ ~20 ~
execute if score @s temp matches 2 run tag @e[tag=processing] remove processing

execute if score @s temp matches 2 run summon armor_stand ^ ^1 ^1 {Tags:["adm_torpedo","new_torp","type_kitakami","processing"],Invisible:1b,Marker:1b,NoGravity:1b}
execute if score @s temp matches 2 run data modify entity @e[tag=processing,limit=1] Rotation set from entity @s Rotation
execute if score @s temp matches 2 as @e[tag=processing] run tp @s ~ ~ ~ ~30 ~
execute if score @s temp matches 2 run tag @e[tag=processing] remove processing

execute if score @s temp matches 2 run summon armor_stand ^ ^1 ^1 {Tags:["adm_torpedo","new_torp","type_kitakami","processing"],Invisible:1b,Marker:1b,NoGravity:1b}
execute if score @s temp matches 2 run data modify entity @e[tag=processing,limit=1] Rotation set from entity @s Rotation
execute if score @s temp matches 2 as @e[tag=processing] run tp @s ~ ~ ~ ~40 ~
execute if score @s temp matches 2 run tag @e[tag=processing] remove processing