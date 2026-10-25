# 1. アイテム保護
data merge entity @s {PickupDelay:32767s,Invulnerable:1b}

# 接地判定は削除済み（即発動）
# execute unless entity @s[nbt={OnGround:1b}] run return 0

# 2. 所有者チェック
execute if entity @p[tag=berserker,distance=..300] run tag @s add can_process
tag @a remove on_cd
tag @a remove is_ready

# 3. 状態チェック
execute if entity @s[tag=can_process] as @p[tag=berserker,distance=..300,limit=1,sort=nearest,scores={cd_ber_jump=1..}] run tag @s add on_cd
execute if entity @s[tag=can_process] as @p[tag=berserker,distance=..300,limit=1,sort=nearest,scores={cd_ber_jump=0}] run tag @s add is_ready

# 4. 実行
# 4. 実行
# Reset previous falling state to prevent logic conflicts
execute as @p[tag=is_ready] run tag @s remove ber_falling
execute as @p[tag=is_ready] run tag @s remove ber_falling

# CT設定 (8秒 = 160tick)
# CT設定 (8秒 = 160tick)
# CT設定 (8秒 = 160tick)
scoreboard players set @p[tag=berserker,distance=..300,limit=1,sort=nearest] cd_ber_jump 160
execute if entity @p[tag=berserker,distance=..300,tag=rush_mode] run item replace entity @p[tag=berserker,distance=..300,limit=1,sort=nearest] container.1 with minecraft:feather[custom_data={berserker_jump:1b},custom_name='{"text":"リープ・フェザー","color":"green","bold":true}',lore=['{"text":"[Q]キー(捨てる): 大ジャンプ","color":"yellow"}','{"text":"(Cost: 4HP)","color":"gray"}','{"text":"着地時に衝撃波","color":"red"}','{"text":"空中[Shift]: 急降下 (衝撃波強化)","color":"red"}','{"text":"CT: 8s","color":"aqua"}']] 1

# 自傷ダメージは着地時に移動済み

# 浮遊設定 (1秒 Lv10)
execute if entity @s[tag=can_process] as @p[tag=is_ready] run effect give @s minecraft:levitation 1 15 true

# 着地判定用のタグを付与 (重要)
execute if entity @s[tag=can_process] as @p[tag=is_ready] run tag @s add ber_ready

# 【変更】ジャンプ開始の演出 (荒々しく)
# 【変更】ジャンプ開始の演出 (荒々しく)
# 音: エンダードラゴンの羽ばたき音から、爆発音とラヴェジャーの攻撃音を重ねた重い衝撃音に変更
execute if entity @s[tag=can_process] as @p[tag=is_ready] at @s run playsound minecraft:entity.generic.explode master @a ~ ~ ~ 1 0.8
execute if entity @s[tag=can_process] as @p[tag=is_ready] at @s run playsound minecraft:entity.ravager.attack master @a ~ ~ ~ 1 0.6

# パーティクル: 白い煙から、爆発エフェクトと土ブロックの破片に変更
execute if entity @s[tag=can_process] as @p[tag=is_ready] at @s run particle minecraft:explosion ~ ~0.5 ~ 0.2 0.1 0.2 0.1 5
execute if entity @s[tag=can_process] as @p[tag=is_ready] at @s run particle block{block_state:"minecraft:dirt"} ~ ~0.5 ~ 0.5 0.1 0.5 0.1 50


# 5. 失敗時の返却処理
execute if entity @s[tag=can_process] as @p[tag=on_cd] at @s run function my_pvp:roles/berserker/cd_error

# CT中の返却アイテム
execute if entity @s[tag=can_process] as @p[tag=on_cd] at @s run give @s minecraft:feather[custom_data={berserker_jump:1b},custom_name='{"text":"リープ・フェザー","color":"green","bold":true}',lore=['{"text":"[Q]キー(捨てる): 大ジャンプ","color":"yellow"}','{"text":"(Cost: 4HP)","color":"gray"}','{"text":"着地時に衝撃波","color":"red"}','{"text":"空中[Shift]: 急降下 (衝撃波強化)","color":"red"}','{"text":"CT: 8s","color":"aqua"}']] 1

# アイテム消去
execute if entity @s[tag=can_process] run kill @s