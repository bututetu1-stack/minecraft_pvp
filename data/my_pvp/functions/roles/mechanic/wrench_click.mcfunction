# 1. インタラクション情報を消去（連打防止）
data remove entity @s interaction

# 2. ターゲットIDの確保
# クリックされた判定(@s)の持ち主IDを一時スコアに保存
scoreboard players operation #TEMP player_id = @s player_id

# 3. 実行と分岐
# プレイヤー(@p)が条件を満たしているか確認し、
# 満たしていれば「ガジェット本体(@e)」を実行者(@s)にして処理を行わせる

# A. 【解体】スニーク中
# execute as @p (プレイヤーとして条件チェック) -> at ... (ガジェットの場所へ) -> as @e (実行者をガジェットに交代) -> run recycle
execute as @p[distance=..3,predicate=my_pvp:is_sneaking,nbt={SelectedItem:{id:"minecraft:iron_axe"}}] if score @s player_id = #TEMP player_id at @e[tag=gadget,limit=1,distance=..1,sort=nearest] as @e[tag=gadget,limit=1,distance=..0.1,sort=nearest] run function my_pvp:roles/mechanic/recycle

# B. 【修理】スニークなし
# 修理(repair)も同様に、ガジェットを実行者にして呼び出すのが安全です
execute as @p[distance=..3,predicate=!my_pvp:is_sneaking,nbt={SelectedItem:{id:"minecraft:iron_axe"}}] if score @s player_id = #TEMP player_id at @e[tag=gadget,limit=1,distance=..1,sort=nearest] as @e[tag=gadget,limit=1,distance=..0.1,sort=nearest] run function my_pvp:roles/mechanic/repair