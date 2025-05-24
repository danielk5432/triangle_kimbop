class_name CardData
extends Resource

@export var name: String
@export var description: String
@export var icon: Texture2D

# 기본 정보
@export var damage: float = 0.0
@export var damage_growth: float = 0.0
@export var multiplier: float = 1.0
@export var multiplier_growth: float = 1.0
@export var shield: int = 0
@export var shield_growth: int = 0

# 파괴 확률
@export var break_chance: float = 0.1
@export var break_chance_growth: float = 0.0  # 예: n당 0.05 추가

# 분류
@export_enum("Basic", "Combo", "Destruction", "Control") var card_type := "Basic"
@export_enum("+", "*", "X") var symbol := "+"  # 조합, 효과 구분용

# 작동 조건 / 변형 수치
@export var repeat_bonus: float = 0.0       # 연타: n에 따라 증가
@export var resonance_bonus: float = 0.0    # 공명 시 강화
@export var on_kill_effect: bool = false    # 처치 시 추가 턴 등

# 특수 효과 목록 (Signal형으로 확장도 가능)
@export var special_effects: Array[String] = []

# 특수기 or 발동 조건이 있는 효과들은 별도로 조건 확인 필요
