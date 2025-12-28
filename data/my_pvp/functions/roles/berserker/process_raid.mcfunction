# 1. アイテム保護 & 所有者特定
data merge entity @s {PickupDelay:32767s,Invulnerable:1b}
scoreboard players operation #TEMP player_id = @s player_id
tag @a remove current_caster
execute as @a[tag=berserker] if score @s player_id = #TEMP player_id run tag @s add current_caster

# 2. 条件チェック
tag @s remove can_process
# CTチェック
execute if entity @p[tag=current_caster,scores={cd_ber_raid=0}] run tag @s add can_process
# HPコストチェック (4ダメージ受けても死なないか = HP5以上)
execute as @p[tag=current_caster] store result score #HP temp run data get entity @s Health
execute if score #HP temp matches ..4 run tag @s remove can_process


# --- 3. 発動 (成功時) ---
# CT設定 (5秒)
execute if entity @s[tag=can_process] as @p[tag=current_caster] run scoreboard players set @s cd_ber_raid 100

# コスト支払い (4ダメージ)
execute if entity @s[tag=can_process] as @p[tag=current_caster] run damage @s 4 minecraft:generic

# 範囲攻撃 & ノックバック
execute if entity @s[tag=can_process] at @p[tag=current_caster] as @a[distance=..4,gamemode=!spectator] unless score @s player_id = #TEMP player_id run damage @s 6 minecraft:player_attack by @p[tag=current_caster]

# 演出
execute if entity @s[tag=can_process] at @p[tag=current_caster] run playsound minecraft:entity.player.attack.sweep master @a ~ ~ ~ 1 0.5
execute if entity @s[tag=can_process] at @p[tag=current_caster] run particle minecraft:sweep_attack ~ ~1 ~ 1 0 1 0 5
execute if entity @s[tag=can_process] at @p[tag=current_caster] run particle minecraft:block_marker minecraft:redstone_block ~ ~1 ~ 0.5 0.5 0.5 0.1 20


# --- 4. 失敗時 (CT中またはHP不足) ---
execute unless entity @s[tag=can_process] at @p[tag=current_caster] run playsound minecraft:ui.button.click master @s ~ ~ ~ 1 2
execute unless entity @s[tag=can_process] at @p[tag=current_caster] run tellraw @s [{"text":"⚠ HP不足 または CT中","color":"red"}]


# 5. アイテム返却 & 消去 (赤染料を返す)
# インベントリになければ返す
execute as @p[tag=current_caster] unless entity @s[nbt={Inventory:[{tag:{berserker_raid:1b}}]}] run item replace entity @s container.2 with minecraft:red_dye{berserker_raid:1b,display:{Name:'{"text":"ブラッドクリスタル","color":"dark_red","bold":true}',Lore:['{"text":"Q: ブラッドレイド (Cost: 4HP)","color":"gray"}','{"text":"周囲をなぎ払い、敵を吹き飛ばす","color":"dark_red"}','{"text":"CT: 5s","color":"aqua"}']}} 1

kill @s