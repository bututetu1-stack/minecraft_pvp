# 1. アイテム保護
data merge entity @s {PickupDelay:32767s,Invulnerable:1b}

# 接地判定は削除済み（即発動）
# execute unless entity @s[nbt={OnGround:1b}] run return 0

# 2. 所有者チェック
execute if entity @p[tag=berserker,distance=..300] run tag @s add can_process
tag @a remove on_cd
tag @a remove is_ready

# 3. 状態チェック
execute if entity @s[tag=can_process] as @p[tag=berserker,distance=..300,limit=1,sort=nearest,scores={cd_ber_raid=1..}] run tag @s add on_cd
execute if entity @s[tag=can_process] as @p[tag=berserker,distance=..300,limit=1,sort=nearest,scores={cd_ber_raid=0}] run tag @s add is_ready

# 4. 実行
# CT設定 (15秒 = 300tick)
execute if entity @s[tag=can_process] as @p[tag=is_ready] run scoreboard players set @s cd_ber_raid 300

# バフの発動処理
# コスト: 10ダメージ
execute if entity @s[tag=can_process] as @p[tag=is_ready] run damage @s 10 minecraft:magic

# 効果: 攻撃力上昇II, 移動速度上昇II, 暗闇 (10秒)
execute if entity @s[tag=can_process] as @p[tag=is_ready] run effect give @s minecraft:strength 10 1 true
execute if entity @s[tag=can_process] as @p[tag=is_ready] run effect give @s minecraft:speed 10 1 true
execute if entity @s[tag=can_process] as @p[tag=is_ready] run effect give @s minecraft:darkness 10 0 true

# 演出音 (鼓動 + 咆哮)
execute if entity @s[tag=can_process] as @p[tag=is_ready] run playsound minecraft:entity.warden.heartbeat master @a ~ ~ ~ 1 1
# 【変更】ピグリンの鳴き声を削除し、ラヴェジャーの咆哮に変更 (重厚な叫び声)
execute if entity @s[tag=can_process] as @p[tag=is_ready] run playsound minecraft:entity.ravager.roar master @a ~ ~ ~ 1 1

# 血飛沫エフェクト
# 1. 細かい血の霧 (Dust)
execute if entity @s[tag=can_process] as @p[tag=is_ready] run particle minecraft:dust 0.8 0 0 1 ~ ~1 ~ 0.5 0.5 0.5 0.1 50
# 2. 血飛沫 (Item Red Dye) - 視界を塞がない小さな破片
execute if entity @s[tag=can_process] as @p[tag=is_ready] run particle minecraft:item minecraft:red_dye ~ ~1.5 ~ 0.3 0.5 0.3 0.1 20

# 5. 失敗時の返却処理
execute if entity @s[tag=can_process] as @p[tag=on_cd] run function my_pvp:roles/berserker/cd_error

# CT中の返却アイテム
execute if entity @s[tag=can_process] as @p[tag=on_cd] run give @s minecraft:red_dye{berserker_raid:1b,display:{Name:'{"text":"ブラッドクリスタル","color":"dark_red","bold":true}',Lore:['{"text":"[Q]キー(捨てる): ブラッドレイジ","color":"yellow"}','{"text":"(Cost: 10HP)","color":"gray"}','{"text":"10秒間 攻撃力/速度上昇 & 暗闇","color":"dark_red"}','{"text":"CT: 15s","color":"aqua"}']}} 1

# アイテム消去
execute if entity @s[tag=can_process] run kill @s