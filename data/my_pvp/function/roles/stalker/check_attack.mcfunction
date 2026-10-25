# 1. 攻撃対象候補の取得
tag @a remove attacked_victim
execute at @s as @a[distance=0.1..4,sort=nearest,limit=1,gamemode=!spectator] run tag @s add attacked_victim

# 2. ID照合
scoreboard players operation #TEMP player_id = @s target_id
execute as @a[tag=attacked_victim] if score @s player_id = #TEMP player_id run tag @s add is_my_target

# 3. ターゲットへの追加ダメージ
# 武器(4) + 追加(6) = 10 (ハート5個)
# ※ 以前は penalty_dmg/penalty_timer を設定するだけで、提督の遅延ダメージ処理 (adm_penalty_target のみ対象) が
#    動かず +6 が入っていなかった。攻撃直後で相手は無敵時間中なので、無敵時間・防具を無視する my_pvp:penalty で即座に与える
tag @s add stalker_attacker_now
execute as @a[tag=is_my_target] run damage @s 6 my_pvp:penalty by @a[tag=stalker_attacker_now,limit=1]
tag @s remove stalker_attacker_now

# --- 演出 (強化) ---
# 命中: 自分側
execute if entity @a[tag=is_my_target] run playsound minecraft:entity.player.attack.crit master @s ~ ~ ~ 1.5 0.7
execute if entity @a[tag=is_my_target] run playsound minecraft:item.armor.equip_chain master @s ~ ~ ~ 0.6 1.2
execute if entity @a[tag=is_my_target] at @a[tag=is_my_target] run particle minecraft:crit ~ ~1.5 ~ 0.5 0.5 0.5 0.1 30 force
execute if entity @a[tag=is_my_target] at @a[tag=is_my_target] run particle minecraft:dust{color:[0.4,0.0,0.4],scale:1.0} ~ ~1 ~ 0.5 0.5 0.5 0 25 force
execute if entity @a[tag=is_my_target] at @a[tag=is_my_target] run particle minecraft:cloud ~ ~0.5 ~ 0.4 0.3 0.4 0.05 15 force
execute if entity @a[tag=is_my_target] at @a[tag=is_my_target] run particle minecraft:flash ~ ~1 ~ 0 0 0 0 1 force

# 命中: ターゲット側 (動揺音)
execute if entity @a[tag=is_my_target] as @a[tag=is_my_target] at @s run playsound minecraft:entity.cat.hiss master @s ~ ~ ~ 0.7 1.5
execute if entity @a[tag=is_my_target] as @a[tag=is_my_target] at @s run playsound minecraft:entity.warden.tendril_clicks master @s ~ ~ ~ 0.8 1.5

# 4. 非ターゲット攻撃 (威力が出ない演出)
execute if entity @a[tag=attacked_victim,tag=!is_my_target] run playsound minecraft:block.note_block.bass master @s ~ ~ ~ 1 0.5
execute if entity @a[tag=attacked_victim,tag=!is_my_target] at @a[tag=attacked_victim,tag=!is_my_target] run particle minecraft:smoke ~ ~1 ~ 0.3 0.3 0.3 0.05 8 force
execute if entity @a[tag=attacked_victim,tag=!is_my_target] run tellraw @s [{"text":"[匕首] ","color":"dark_purple"},{"text":"獲物ではない…","color":"gray"}]

# 5. タグ掃除
tag @a remove attacked_victim
tag @a remove is_my_target
