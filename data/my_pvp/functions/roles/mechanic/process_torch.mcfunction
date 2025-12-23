# 1. 安全装置チェック
execute if entity @p[tag=mechanic,distance=..300] run tag @s add can_process

# 2. 補充
execute if entity @s[tag=can_process] run give @p[tag=mechanic,distance=..300,limit=1,sort=nearest] minecraft:redstone_torch{display:{Name:'{"text":"マイクロタレット","italic":false,"color":"gold"}'}} 1

# 3. 状態チェック（CDとコスト）
# まずタグをクリア
tag @a remove is_ready
tag @a remove on_cd
tag @a remove no_money

# プレイヤーの状態を判定してタグ付け
# A. クールダウン中の人 -> on_cd
execute if entity @s[tag=can_process] as @p[tag=mechanic,distance=..300,limit=1,sort=nearest,scores={place_cd=1..}] run tag @s add on_cd

# B. CDゼロ かつ スクラップ足りる(5以上) -> is_ready
execute if entity @s[tag=can_process] as @p[tag=mechanic,distance=..300,limit=1,sort=nearest,scores={place_cd=0,scrap=5..}] run tag @s add is_ready

# C. CDゼロ かつ スクラップ足りない(4以下) -> no_money
execute if entity @s[tag=can_process] as @p[tag=mechanic,distance=..300,limit=1,sort=nearest,scores={place_cd=0,scrap=..4}] run tag @s add no_money


# 4. 分岐実行
# A. 成功（設置 ＋ クールダウン100tick(5秒)付与）
execute if entity @s[tag=can_process] as @p[tag=is_ready] run scoreboard players set @s place_cd 100
execute if entity @s[tag=can_process] as @p[tag=is_ready] run function my_pvp:roles/mechanic/spawn_sentry

# B. クールダウン中エラー
execute if entity @s[tag=can_process] as @p[tag=on_cd] run function my_pvp:roles/mechanic/cd_error

# C. 金欠エラー
execute if entity @s[tag=can_process] as @p[tag=no_money] run function my_pvp:roles/mechanic/scrap_error

# 5. アイテム消去
execute if entity @s[tag=can_process] run kill @s