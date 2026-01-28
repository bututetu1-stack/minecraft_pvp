# 視野角判定
# @s = sculpture_hitbox
# 実行位置: @s (Hitbox) だが、角度計算はプレイヤー位置で行う必要がある

# ターゲット（自分）にタグ付け
tag @s add target_hitbox

# 計算処理（プレイヤーとして実行）
# @s(Hitbox)の位置(at @s) で実行することで、calc_angle内での相対座標基準をHitboxにする…と間違い。
# calc_angleは プレイヤーのRotationを取得し、プレイヤーの位置にマーカーを出して計算する。
# なので at @s (Hitbox) にする必要はない。むしろ at @a (Player) であるべき。
# execute ... at @s ... とあるが、as @a[...] なので、at @s はプレイヤーに上書きされる？
# いや、 as @a at @s だと、プレイヤーとして実行するが場所は @s(Hitbox) になる。
# そうなると calc_angle 内の summon marker ~ ~ ~ は Hitboxの位置に出る。
# これは正しいか？
# 「プレイヤーから見て彫刻が視野内か」を判定したい。
# マーカーは「プレイヤーの位置」に置いて、「彫刻の方」を向かせる。
# ならば at @s (Hitbox) ではなく at @a (Player) で実行すべき。
# しかし呼び出し元で execute at @s (Hitbox) している。
# check_fov 内で execute as @a[...] at @s (Player) とすればプレイヤー位置になる。
# @s は check_fov 内では Hitbox。
# execute as @a[...] at @s だと、 @s は Player になる！ (asで切り替わったから)
# つまり execute as @a[...] run function ... で十分。 function内で at @s すればプレイヤー位置になる。

# 修正: at @s (Hitbox) は削除し、呼び出し先で at @s (Player) を使うようにする。

execute as @a[tag=current_checker,limit=1] run function my_pvp:roles/sculptor/checker/calc_angle

# タグ削除
tag @s remove target_hitbox
