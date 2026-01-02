# 1. 試合リセット処理（ここで全データが消去される）
function my_pvp:system/reset_game

# --- 【重要】消えてしまった計算用定数を再設定 ---
# reset * temp でこれらも消えてしまうため、ここで値を戻します
scoreboard players set #POINT_KILL temp 10
scoreboard players set #POINT_DEATH temp 5
scoreboard players set #100 temp 100
scoreboard players set #20 temp 20

# --- スコアの初期化 ---
# 全員を 0 にセットして計算可能にする
scoreboard players set @a kills 0
scoreboard players set @a deaths 0
scoreboard players set @a points 0

# 2. IDの完全リセットと再割り振り
# グローバルカウンターを 1 に戻す
scoreboard players set #NEXT_ID player_id 1

# 全プレイヤーの現在のIDを消去
scoreboard players reset @a player_id

# 全員に新しいIDを(1から順に)割り振る
execute as @a run function my_pvp:system/assign_new_id


# 3. 役職抽選プロセス
function my_pvp:system/init_role_deck
function my_pvp:system/distribute_loop

# --- ボスバーの初期化 ---
# 全プレイヤーに表示
bossbar set my_pvp:timer players @a
bossbar set my_pvp:timer visible true
bossbar set my_pvp:timer color yellow
bossbar set my_pvp:timer value 6000

# 4. 4秒後(80tick)に、試合開始の合図を出す
schedule function my_pvp:system/start_sequence 4s replace
