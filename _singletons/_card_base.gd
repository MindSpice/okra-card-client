extends Node





enum DamageClass {SINGLE, MULTI}
enum ActionType {MELEE, MAGIC, RANGED}
enum Level {ONE, TWO, THREE, FOUR}

const ACTION_RES = "res://cards/images/"


const ACTIONCARD = {
	"ONE" : [DamageClass.SINGLE, ActionType.MELEE ,true, false, 10, 5, 5, 5, 0 ,0, 22, 0],
	"TWO" : [DamageClass.SINGLE, ActionType.MELEE ,true, false, 10, 5, 5, 5, 0 ,0, 22, 0],
	"THREE" : [DamageClass.SINGLE, ActionType.MELEE ,true, false, 10, 5, 5, 5, 0 ,0, 22, 0],
	"FOUR" : [DamageClass.SINGLE, ActionType.MELEE ,true, false, 10, 5, 5, 5, 0 ,0, 22, 0],
	"FIVE" : [DamageClass.SINGLE, ActionType.MELEE ,true, false, 10, 5, 5, 5, 0 ,0, 22, 0],
	"SIX" : [DamageClass.SINGLE, ActionType.MELEE ,true, false, 10, 5, 5, 5, 0 ,0, 22, 0],
	"SEVEN" : [DamageClass.SINGLE, ActionType.MELEE ,true, false, 10, 5, 5, 5, 0 ,0, 22, 0],
	"EIGHT" : [DamageClass.SINGLE, ActionType.MELEE ,true, false, 10, 5, 5, 5, 0 ,0, 22, 0],
	"NINE" : [DamageClass.SINGLE, ActionType.MELEE ,true, false, 10, 5, 5, 5, 0 ,0, 22, 0],
	"TEN" : [DamageClass.SINGLE, ActionType.MELEE ,true, false, 10, 5, 5, 5, 0 ,0, 22, 0]
}
