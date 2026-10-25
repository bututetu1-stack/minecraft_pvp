# ダメージ2倍の追加ダメージ (マクロ)
# @s = 被害者 / 引数: $(amount) = 追加ダメージ量
$damage @s $(amount) my_pvp:penalty by @a[tag=boost_attacker,limit=1]
