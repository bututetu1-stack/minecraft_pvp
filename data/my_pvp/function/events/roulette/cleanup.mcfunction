# ルーレットイベント終了時のクリーンアップ

# 1. 中心エンティティ削除
kill @e[tag=roulette_center]

# 2. パーツ削除
kill @e[tag=roulette_part]

# 3. マーカー削除
kill @e[tag=angle_measure]
