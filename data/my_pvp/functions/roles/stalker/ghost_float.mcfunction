# 1. クールダウン中なら終了
execute if score @s cd_stalker_float matches 1.. run return 0

# 2. 発動条件チェック
# (1) スニークしている
execute unless predicate my_pvp:is_sneaking run return 0
# (2) 真上を見ている (X回転が -85以下 / 真上が -90)
execute unless entity @s[x_rotation=..-85.0] run return 0
# (3) 天井がすぐ上にないか確認（埋まり防止）
execute unless block ~ ~2 ~ minecraft:air run return 0

# 3. 効果発動
# 浮遊 (Levitation) Lv10 を 0.8秒付与 → 一気に上昇
# ※落下ダメージはgameruleで無効化されているため、着地ケアは不要
effect give @s minecraft:levitation 1 9 true

# 4. 演出 (狂気の愛)
# 音: 羽ばたき音 + 魔女の笑い声（狂気感）
playsound minecraft:entity.phantom.flap master @a[distance=..15] ~ ~ ~ 1 0.8
playsound minecraft:entity.witch.celebrate master @a[distance=..15] ~ ~ ~ 1 1.5

# パーティクル: ハートと闇
# ハートを周囲にばら撒く
particle minecraft:heart ~ ~1 ~ 0.5 0.5 0.5 0 10
# 黒い煙（イカスミ）を足元に出して不穏さを演出
particle minecraft:squid_ink ~ ~0.5 ~ 0.3 0.3 0.3 0 10

# 5. クールダウン設定 (15秒 = 300tick)
scoreboard players set @s cd_stalker_float 300
tellraw @s [{"text":"[Skill] ","color":"gray"},{"text":"狂愛の飛翔","color":"dark_red","bold":true},{"text":" 発動","color":"gray"}]