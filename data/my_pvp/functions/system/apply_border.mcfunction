## apply_border (リファクタ版)
## 目的: `/trigger border_distance set <n>` で指定された n を使って
## - ワールドスポーンをプレイヤー位置に設定
## - worldborder を中心 ~ ~ で半辺 = n に設定（worldborder set には n*2 を渡す）
## - `gamerule spawnRadius` に n を設定
## 実装方針:
##  - 数値依存 (worldborder set / gamerule / #BORDER_RADIUS 設定) は `n` ごとの分岐で処理
##  - プレイヤー位置に依存する共通処理（setworldspawn / center / マーカーの召喚 と トリガーリセット）はまとめて実行
## これにより重複行を大幅に削減します。

## --- 数値依存ブロック (n = 1..50) ---
## 各 n について: worldborder set (n*2), gamerule spawnRadius n, グローバル偽プレイヤーに n を保存
## （注: スコア名は `#BORDER_RADIUS` を使います）

## 1..100 を必要に応じて生成
execute if entity @a[scores={border_distance=1}] run gamerule spawnRadius 1
execute if entity @a[scores={border_distance=2}] run gamerule spawnRadius 2
execute if entity @a[scores={border_distance=3}] run gamerule spawnRadius 3
execute if entity @a[scores={border_distance=4}] run gamerule spawnRadius 4
execute if entity @a[scores={border_distance=5}] run gamerule spawnRadius 5
execute if entity @a[scores={border_distance=6}] run gamerule spawnRadius 6
execute if entity @a[scores={border_distance=7}] run gamerule spawnRadius 7
execute if entity @a[scores={border_distance=8}] run gamerule spawnRadius 8
execute if entity @a[scores={border_distance=9}] run gamerule spawnRadius 9
execute if entity @a[scores={border_distance=10}] run gamerule spawnRadius 10
execute if entity @a[scores={border_distance=11}] run gamerule spawnRadius 11
execute if entity @a[scores={border_distance=12}] run gamerule spawnRadius 12
execute if entity @a[scores={border_distance=13}] run gamerule spawnRadius 13
execute if entity @a[scores={border_distance=14}] run gamerule spawnRadius 14
execute if entity @a[scores={border_distance=15}] run gamerule spawnRadius 15
execute if entity @a[scores={border_distance=16}] run gamerule spawnRadius 16
execute if entity @a[scores={border_distance=17}] run gamerule spawnRadius 17
execute if entity @a[scores={border_distance=18}] run gamerule spawnRadius 18
execute if entity @a[scores={border_distance=19}] run gamerule spawnRadius 19
execute if entity @a[scores={border_distance=20}] run gamerule spawnRadius 20
execute if entity @a[scores={border_distance=21}] run gamerule spawnRadius 21
execute if entity @a[scores={border_distance=22}] run gamerule spawnRadius 22
execute if entity @a[scores={border_distance=23}] run gamerule spawnRadius 23
execute if entity @a[scores={border_distance=24}] run gamerule spawnRadius 24
execute if entity @a[scores={border_distance=25}] run gamerule spawnRadius 25
execute if entity @a[scores={border_distance=26}] run gamerule spawnRadius 26
execute if entity @a[scores={border_distance=27}] run gamerule spawnRadius 27
execute if entity @a[scores={border_distance=28}] run gamerule spawnRadius 28
execute if entity @a[scores={border_distance=29}] run gamerule spawnRadius 29
execute if entity @a[scores={border_distance=30}] run gamerule spawnRadius 30
execute if entity @a[scores={border_distance=31}] run gamerule spawnRadius 31
execute if entity @a[scores={border_distance=32}] run gamerule spawnRadius 32
execute if entity @a[scores={border_distance=33}] run gamerule spawnRadius 33
execute if entity @a[scores={border_distance=34}] run gamerule spawnRadius 34
execute if entity @a[scores={border_distance=35}] run gamerule spawnRadius 35
execute if entity @a[scores={border_distance=36}] run gamerule spawnRadius 36
execute if entity @a[scores={border_distance=37}] run gamerule spawnRadius 37
execute if entity @a[scores={border_distance=38}] run gamerule spawnRadius 38
execute if entity @a[scores={border_distance=39}] run gamerule spawnRadius 39
execute if entity @a[scores={border_distance=40}] run gamerule spawnRadius 40
execute if entity @a[scores={border_distance=41}] run gamerule spawnRadius 41
execute if entity @a[scores={border_distance=42}] run gamerule spawnRadius 42
execute if entity @a[scores={border_distance=43}] run gamerule spawnRadius 43
execute if entity @a[scores={border_distance=44}] run gamerule spawnRadius 44
execute if entity @a[scores={border_distance=45}] run gamerule spawnRadius 45
execute if entity @a[scores={border_distance=46}] run gamerule spawnRadius 46
execute if entity @a[scores={border_distance=47}] run gamerule spawnRadius 47
execute if entity @a[scores={border_distance=48}] run gamerule spawnRadius 48
execute if entity @a[scores={border_distance=49}] run gamerule spawnRadius 49
execute if entity @a[scores={border_distance=50}] run gamerule spawnRadius 50
execute if entity @a[scores={border_distance=51}] run gamerule spawnRadius 51
execute if entity @a[scores={border_distance=52}] run gamerule spawnRadius 52
execute if entity @a[scores={border_distance=53}] run gamerule spawnRadius 53
execute if entity @a[scores={border_distance=54}] run gamerule spawnRadius 54
execute if entity @a[scores={border_distance=55}] run gamerule spawnRadius 55
execute if entity @a[scores={border_distance=56}] run gamerule spawnRadius 56
execute if entity @a[scores={border_distance=57}] run gamerule spawnRadius 57
execute if entity @a[scores={border_distance=58}] run gamerule spawnRadius 58
execute if entity @a[scores={border_distance=59}] run gamerule spawnRadius 59
execute if entity @a[scores={border_distance=60}] run gamerule spawnRadius 60
execute if entity @a[scores={border_distance=61}] run gamerule spawnRadius 61
execute if entity @a[scores={border_distance=62}] run gamerule spawnRadius 62
execute if entity @a[scores={border_distance=63}] run gamerule spawnRadius 63
execute if entity @a[scores={border_distance=64}] run gamerule spawnRadius 64
execute if entity @a[scores={border_distance=65}] run gamerule spawnRadius 65
execute if entity @a[scores={border_distance=66}] run gamerule spawnRadius 66
execute if entity @a[scores={border_distance=67}] run gamerule spawnRadius 67
execute if entity @a[scores={border_distance=68}] run gamerule spawnRadius 68
execute if entity @a[scores={border_distance=69}] run gamerule spawnRadius 69
execute if entity @a[scores={border_distance=70}] run gamerule spawnRadius 70
execute if entity @a[scores={border_distance=71}] run gamerule spawnRadius 71
execute if entity @a[scores={border_distance=72}] run gamerule spawnRadius 72
execute if entity @a[scores={border_distance=73}] run gamerule spawnRadius 73
execute if entity @a[scores={border_distance=74}] run gamerule spawnRadius 74
execute if entity @a[scores={border_distance=75}] run gamerule spawnRadius 75
execute if entity @a[scores={border_distance=76}] run gamerule spawnRadius 76
execute if entity @a[scores={border_distance=77}] run gamerule spawnRadius 77
execute if entity @a[scores={border_distance=78}] run gamerule spawnRadius 78
execute if entity @a[scores={border_distance=79}] run gamerule spawnRadius 79
execute if entity @a[scores={border_distance=80}] run gamerule spawnRadius 80
execute if entity @a[scores={border_distance=81}] run gamerule spawnRadius 81
execute if entity @a[scores={border_distance=82}] run gamerule spawnRadius 82
execute if entity @a[scores={border_distance=83}] run gamerule spawnRadius 83
execute if entity @a[scores={border_distance=84}] run gamerule spawnRadius 84
execute if entity @a[scores={border_distance=85}] run gamerule spawnRadius 85
execute if entity @a[scores={border_distance=86}] run gamerule spawnRadius 86
execute if entity @a[scores={border_distance=87}] run gamerule spawnRadius 87
execute if entity @a[scores={border_distance=88}] run gamerule spawnRadius 88
execute if entity @a[scores={border_distance=89}] run gamerule spawnRadius 89
execute if entity @a[scores={border_distance=90}] run gamerule spawnRadius 90
execute if entity @a[scores={border_distance=91}] run gamerule spawnRadius 91
execute if entity @a[scores={border_distance=92}] run gamerule spawnRadius 92
execute if entity @a[scores={border_distance=93}] run gamerule spawnRadius 93
execute if entity @a[scores={border_distance=94}] run gamerule spawnRadius 94
execute if entity @a[scores={border_distance=95}] run gamerule spawnRadius 95
execute if entity @a[scores={border_distance=96}] run gamerule spawnRadius 96
execute if entity @a[scores={border_distance=97}] run gamerule spawnRadius 97
execute if entity @a[scores={border_distance=98}] run gamerule spawnRadius 98
execute if entity @a[scores={border_distance=99}] run gamerule spawnRadius 99
execute if entity @a[scores={border_distance=100}] run gamerule spawnRadius 100


execute as @a[scores={border_distance=1}] run worldborder set 2
execute as @a[scores={border_distance=1}] run scoreboard players set #BORDER_RADIUS border_radius 1

execute as @a[scores={border_distance=2}] run worldborder set 4
execute as @a[scores={border_distance=2}] run scoreboard players set #BORDER_RADIUS border_radius 2

execute as @a[scores={border_distance=3}] run worldborder set 6
execute as @a[scores={border_distance=3}] run scoreboard players set #BORDER_RADIUS border_radius 3

execute as @a[scores={border_distance=4}] run worldborder set 8
execute as @a[scores={border_distance=4}] run scoreboard players set #BORDER_RADIUS border_radius 4

execute as @a[scores={border_distance=5}] run worldborder set 10
execute as @a[scores={border_distance=5}] run scoreboard players set #BORDER_RADIUS border_radius 5

execute as @a[scores={border_distance=6}] run worldborder set 12
execute as @a[scores={border_distance=6}] run scoreboard players set #BORDER_RADIUS border_radius 6

execute as @a[scores={border_distance=7}] run worldborder set 14
execute as @a[scores={border_distance=7}] run scoreboard players set #BORDER_RADIUS border_radius 7

execute as @a[scores={border_distance=8}] run worldborder set 16
execute as @a[scores={border_distance=8}] run scoreboard players set #BORDER_RADIUS border_radius 8

execute as @a[scores={border_distance=9}] run worldborder set 18
execute as @a[scores={border_distance=9}] run scoreboard players set #BORDER_RADIUS border_radius 9

execute as @a[scores={border_distance=10}] run worldborder set 20
execute as @a[scores={border_distance=10}] run scoreboard players set #BORDER_RADIUS border_radius 10

execute as @a[scores={border_distance=11}] run worldborder set 22
execute as @a[scores={border_distance=11}] run scoreboard players set #BORDER_RADIUS border_radius 11

execute as @a[scores={border_distance=12}] run worldborder set 24
execute as @a[scores={border_distance=12}] run scoreboard players set #BORDER_RADIUS border_radius 12

execute as @a[scores={border_distance=13}] run worldborder set 26
execute as @a[scores={border_distance=13}] run scoreboard players set #BORDER_RADIUS border_radius 13

execute as @a[scores={border_distance=14}] run worldborder set 28
execute as @a[scores={border_distance=14}] run scoreboard players set #BORDER_RADIUS border_radius 14

execute as @a[scores={border_distance=15}] run worldborder set 30
execute as @a[scores={border_distance=15}] run scoreboard players set #BORDER_RADIUS border_radius 15

execute as @a[scores={border_distance=16}] run worldborder set 32
execute as @a[scores={border_distance=16}] run scoreboard players set #BORDER_RADIUS border_radius 16

execute as @a[scores={border_distance=17}] run worldborder set 34
execute as @a[scores={border_distance=17}] run scoreboard players set #BORDER_RADIUS border_radius 17

execute as @a[scores={border_distance=18}] run worldborder set 36
execute as @a[scores={border_distance=18}] run scoreboard players set #BORDER_RADIUS border_radius 18

execute as @a[scores={border_distance=19}] run worldborder set 38
execute as @a[scores={border_distance=19}] run scoreboard players set #BORDER_RADIUS border_radius 19

execute as @a[scores={border_distance=20}] run worldborder set 40
execute as @a[scores={border_distance=20}] run scoreboard players set #BORDER_RADIUS border_radius 20

execute as @a[scores={border_distance=21}] run worldborder set 42
execute as @a[scores={border_distance=21}] run scoreboard players set #BORDER_RADIUS border_radius 21

execute as @a[scores={border_distance=22}] run worldborder set 44
execute as @a[scores={border_distance=22}] run scoreboard players set #BORDER_RADIUS border_radius 22

execute as @a[scores={border_distance=23}] run worldborder set 46
execute as @a[scores={border_distance=23}] run scoreboard players set #BORDER_RADIUS border_radius 23

execute as @a[scores={border_distance=24}] run worldborder set 48
execute as @a[scores={border_distance=24}] run scoreboard players set #BORDER_RADIUS border_radius 24

execute as @a[scores={border_distance=25}] run worldborder set 50
execute as @a[scores={border_distance=25}] run scoreboard players set #BORDER_RADIUS border_radius 25

execute as @a[scores={border_distance=26}] run worldborder set 52
execute as @a[scores={border_distance=26}] run scoreboard players set #BORDER_RADIUS border_radius 26

execute as @a[scores={border_distance=27}] run worldborder set 54
execute as @a[scores={border_distance=27}] run scoreboard players set #BORDER_RADIUS border_radius 27

execute as @a[scores={border_distance=28}] run worldborder set 56
execute as @a[scores={border_distance=28}] run scoreboard players set #BORDER_RADIUS border_radius 28

execute as @a[scores={border_distance=29}] run worldborder set 58
execute as @a[scores={border_distance=29}] run scoreboard players set #BORDER_RADIUS border_radius 29

execute as @a[scores={border_distance=30}] run worldborder set 60
execute as @a[scores={border_distance=30}] run scoreboard players set #BORDER_RADIUS border_radius 30

execute as @a[scores={border_distance=31}] run worldborder set 62
execute as @a[scores={border_distance=31}] run scoreboard players set #BORDER_RADIUS border_radius 31

execute as @a[scores={border_distance=32}] run worldborder set 64
execute as @a[scores={border_distance=32}] run scoreboard players set #BORDER_RADIUS border_radius 32

execute as @a[scores={border_distance=33}] run worldborder set 66
execute as @a[scores={border_distance=33}] run scoreboard players set #BORDER_RADIUS border_radius 33

execute as @a[scores={border_distance=34}] run worldborder set 68
execute as @a[scores={border_distance=34}] run scoreboard players set #BORDER_RADIUS border_radius 34

execute as @a[scores={border_distance=35}] run worldborder set 70
execute as @a[scores={border_distance=35}] run scoreboard players set #BORDER_RADIUS border_radius 35

execute as @a[scores={border_distance=36}] run worldborder set 72
execute as @a[scores={border_distance=36}] run scoreboard players set #BORDER_RADIUS border_radius 36

execute as @a[scores={border_distance=37}] run worldborder set 74
execute as @a[scores={border_distance=37}] run scoreboard players set #BORDER_RADIUS border_radius 37

execute as @a[scores={border_distance=38}] run worldborder set 76
execute as @a[scores={border_distance=38}] run scoreboard players set #BORDER_RADIUS border_radius 38

execute as @a[scores={border_distance=39}] run worldborder set 78
execute as @a[scores={border_distance=39}] run scoreboard players set #BORDER_RADIUS border_radius 39

execute as @a[scores={border_distance=40}] run worldborder set 80
execute as @a[scores={border_distance=40}] run scoreboard players set #BORDER_RADIUS border_radius 40

execute as @a[scores={border_distance=41}] run worldborder set 82
execute as @a[scores={border_distance=41}] run scoreboard players set #BORDER_RADIUS border_radius 41

execute as @a[scores={border_distance=42}] run worldborder set 84
execute as @a[scores={border_distance=42}] run scoreboard players set #BORDER_RADIUS border_radius 42

execute as @a[scores={border_distance=43}] run worldborder set 86
execute as @a[scores={border_distance=43}] run scoreboard players set #BORDER_RADIUS border_radius 43

execute as @a[scores={border_distance=44}] run worldborder set 88
execute as @a[scores={border_distance=44}] run scoreboard players set #BORDER_RADIUS border_radius 44

execute as @a[scores={border_distance=45}] run worldborder set 90
execute as @a[scores={border_distance=45}] run scoreboard players set #BORDER_RADIUS border_radius 45

execute as @a[scores={border_distance=46}] run worldborder set 92
execute as @a[scores={border_distance=46}] run scoreboard players set #BORDER_RADIUS border_radius 46

execute as @a[scores={border_distance=47}] run worldborder set 94
execute as @a[scores={border_distance=47}] run scoreboard players set #BORDER_RADIUS border_radius 47

execute as @a[scores={border_distance=48}] run worldborder set 96
execute as @a[scores={border_distance=48}] run scoreboard players set #BORDER_RADIUS border_radius 48

execute as @a[scores={border_distance=49}] run worldborder set 98
execute as @a[scores={border_distance=49}] run scoreboard players set #BORDER_RADIUS border_radius 49

execute as @a[scores={border_distance=50}] run worldborder set 100
execute as @a[scores={border_distance=50}] run scoreboard players set #BORDER_RADIUS border_radius 50

execute as @a[scores={border_distance=51}] run worldborder set 102
execute as @a[scores={border_distance=51}] run scoreboard players set #BORDER_RADIUS border_radius 51

execute as @a[scores={border_distance=52}] run worldborder set 104
execute as @a[scores={border_distance=52}] run scoreboard players set #BORDER_RADIUS border_radius 52

execute as @a[scores={border_distance=53}] run worldborder set 106
execute as @a[scores={border_distance=53}] run scoreboard players set #BORDER_RADIUS border_radius 53

execute as @a[scores={border_distance=54}] run worldborder set 108
execute as @a[scores={border_distance=54}] run scoreboard players set #BORDER_RADIUS border_radius 54

execute as @a[scores={border_distance=55}] run worldborder set 110
execute as @a[scores={border_distance=55}] run scoreboard players set #BORDER_RADIUS border_radius 55

execute as @a[scores={border_distance=56}] run worldborder set 112
execute as @a[scores={border_distance=56}] run scoreboard players set #BORDER_RADIUS border_radius 56

execute as @a[scores={border_distance=57}] run worldborder set 114
execute as @a[scores={border_distance=57}] run scoreboard players set #BORDER_RADIUS border_radius 57

execute as @a[scores={border_distance=58}] run worldborder set 116
execute as @a[scores={border_distance=58}] run scoreboard players set #BORDER_RADIUS border_radius 58

execute as @a[scores={border_distance=59}] run worldborder set 118
execute as @a[scores={border_distance=59}] run scoreboard players set #BORDER_RADIUS border_radius 59

execute as @a[scores={border_distance=60}] run worldborder set 120
execute as @a[scores={border_distance=60}] run scoreboard players set #BORDER_RADIUS border_radius 60

execute as @a[scores={border_distance=61}] run worldborder set 122
execute as @a[scores={border_distance=61}] run scoreboard players set #BORDER_RADIUS border_radius 61

execute as @a[scores={border_distance=62}] run worldborder set 124
execute as @a[scores={border_distance=62}] run scoreboard players set #BORDER_RADIUS border_radius 62

execute as @a[scores={border_distance=63}] run worldborder set 126
execute as @a[scores={border_distance=63}] run scoreboard players set #BORDER_RADIUS border_radius 63

execute as @a[scores={border_distance=64}] run worldborder set 128
execute as @a[scores={border_distance=64}] run scoreboard players set #BORDER_RADIUS border_radius 64

execute as @a[scores={border_distance=65}] run worldborder set 130
execute as @a[scores={border_distance=65}] run scoreboard players set #BORDER_RADIUS border_radius 65

execute as @a[scores={border_distance=66}] run worldborder set 132
execute as @a[scores={border_distance=66}] run scoreboard players set #BORDER_RADIUS border_radius 66

execute as @a[scores={border_distance=67}] run worldborder set 134
execute as @a[scores={border_distance=67}] run scoreboard players set #BORDER_RADIUS border_radius 67

execute as @a[scores={border_distance=68}] run worldborder set 136
execute as @a[scores={border_distance=68}] run scoreboard players set #BORDER_RADIUS border_radius 68

execute as @a[scores={border_distance=69}] run worldborder set 138
execute as @a[scores={border_distance=69}] run scoreboard players set #BORDER_RADIUS border_radius 69

execute as @a[scores={border_distance=70}] run worldborder set 140
execute as @a[scores={border_distance=70}] run scoreboard players set #BORDER_RADIUS border_radius 70

execute as @a[scores={border_distance=71}] run worldborder set 142
execute as @a[scores={border_distance=71}] run scoreboard players set #BORDER_RADIUS border_radius 71

execute as @a[scores={border_distance=72}] run worldborder set 144
execute as @a[scores={border_distance=72}] run scoreboard players set #BORDER_RADIUS border_radius 72

execute as @a[scores={border_distance=73}] run worldborder set 146
execute as @a[scores={border_distance=73}] run scoreboard players set #BORDER_RADIUS border_radius 73

execute as @a[scores={border_distance=74}] run worldborder set 148
execute as @a[scores={border_distance=74}] run scoreboard players set #BORDER_RADIUS border_radius 74

execute as @a[scores={border_distance=75}] run worldborder set 150
execute as @a[scores={border_distance=75}] run scoreboard players set #BORDER_RADIUS border_radius 75

execute as @a[scores={border_distance=76}] run worldborder set 152
execute as @a[scores={border_distance=76}] run scoreboard players set #BORDER_RADIUS border_radius 76

execute as @a[scores={border_distance=77}] run worldborder set 154
execute as @a[scores={border_distance=77}] run scoreboard players set #BORDER_RADIUS border_radius 77

execute as @a[scores={border_distance=78}] run worldborder set 156
execute as @a[scores={border_distance=78}] run scoreboard players set #BORDER_RADIUS border_radius 78

execute as @a[scores={border_distance=79}] run worldborder set 158
execute as @a[scores={border_distance=79}] run scoreboard players set #BORDER_RADIUS border_radius 79

execute as @a[scores={border_distance=80}] run worldborder set 160
execute as @a[scores={border_distance=80}] run scoreboard players set #BORDER_RADIUS border_radius 80

execute as @a[scores={border_distance=81}] run worldborder set 162
execute as @a[scores={border_distance=81}] run scoreboard players set #BORDER_RADIUS border_radius 81

execute as @a[scores={border_distance=82}] run worldborder set 164
execute as @a[scores={border_distance=82}] run scoreboard players set #BORDER_RADIUS border_radius 82

execute as @a[scores={border_distance=83}] run worldborder set 166
execute as @a[scores={border_distance=83}] run scoreboard players set #BORDER_RADIUS border_radius 83

execute as @a[scores={border_distance=84}] run worldborder set 168
execute as @a[scores={border_distance=84}] run scoreboard players set #BORDER_RADIUS border_radius 84

execute as @a[scores={border_distance=85}] run worldborder set 170
execute as @a[scores={border_distance=85}] run scoreboard players set #BORDER_RADIUS border_radius 85

execute as @a[scores={border_distance=86}] run worldborder set 172
execute as @a[scores={border_distance=86}] run scoreboard players set #BORDER_RADIUS border_radius 86

execute as @a[scores={border_distance=87}] run worldborder set 174
execute as @a[scores={border_distance=87}] run scoreboard players set #BORDER_RADIUS border_radius 87

execute as @a[scores={border_distance=88}] run worldborder set 176
execute as @a[scores={border_distance=88}] run scoreboard players set #BORDER_RADIUS border_radius 88

execute as @a[scores={border_distance=89}] run worldborder set 178
execute as @a[scores={border_distance=89}] run scoreboard players set #BORDER_RADIUS border_radius 89

execute as @a[scores={border_distance=90}] run worldborder set 180
execute as @a[scores={border_distance=90}] run scoreboard players set #BORDER_RADIUS border_radius 90

execute as @a[scores={border_distance=91}] run worldborder set 182
execute as @a[scores={border_distance=91}] run scoreboard players set #BORDER_RADIUS border_radius 91

execute as @a[scores={border_distance=92}] run worldborder set 184
execute as @a[scores={border_distance=92}] run scoreboard players set #BORDER_RADIUS border_radius 92

execute as @a[scores={border_distance=93}] run worldborder set 186
execute as @a[scores={border_distance=93}] run scoreboard players set #BORDER_RADIUS border_radius 93

execute as @a[scores={border_distance=94}] run worldborder set 188
execute as @a[scores={border_distance=94}] run scoreboard players set #BORDER_RADIUS border_radius 94

execute as @a[scores={border_distance=95}] run worldborder set 190
execute as @a[scores={border_distance=95}] run scoreboard players set #BORDER_RADIUS border_radius 95

execute as @a[scores={border_distance=96}] run worldborder set 192
execute as @a[scores={border_distance=96}] run scoreboard players set #BORDER_RADIUS border_radius 96

execute as @a[scores={border_distance=97}] run worldborder set 194
execute as @a[scores={border_distance=97}] run scoreboard players set #BORDER_RADIUS border_radius 97

execute as @a[scores={border_distance=98}] run worldborder set 196
execute as @a[scores={border_distance=98}] run scoreboard players set #BORDER_RADIUS border_radius 98

execute as @a[scores={border_distance=99}] run worldborder set 198
execute as @a[scores={border_distance=99}] run scoreboard players set #BORDER_RADIUS border_radius 99

execute as @a[scores={border_distance=100}] run worldborder set 200
execute as @a[scores={border_distance=100}] run scoreboard players set #BORDER_RADIUS border_radius 100

## --- 共通処理 ---
## 位置依存の処理（setworldspawn / worldborder center / マーカー更新 / トリガーリセット）
execute as @a[scores={border_distance=1..}] at @s run setworldspawn ~ ~ ~
execute as @a[scores={border_distance=1..}] at @s run worldborder center ~ ~
execute as @a[scores={border_distance=1..}] at @s run kill @e[tag=border_center]
execute as @a[scores={border_distance=1..}] at @s run summon armor_stand ~ ~ ~ {Tags:["border_center"],Invisible:1b,Invulnerable:1b,Marker:1b}
execute as @a[scores={border_distance=1..}] at @s run scoreboard players operation @e[tag=border_center,sort=nearest,limit=1] border_radius = #BORDER_RADIUS border_radius
execute as @a[scores={border_distance=1..}] run scoreboard players set @s border_distance 0
