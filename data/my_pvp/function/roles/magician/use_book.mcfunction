# 魔術本の使用処理（ラッパー: 重複実行防止）

# アクションロックが付いていれば処理をスキップ

# ロックを取得して1tickでクリアする（多重起動防止）
tag @s add mag_action_lock
schedule function my_pvp:roles/magician/clear_action_lock 1t replace

# 実処理を別ファイルに移して呼び出す
function my_pvp:roles/magician/use_book_inner
