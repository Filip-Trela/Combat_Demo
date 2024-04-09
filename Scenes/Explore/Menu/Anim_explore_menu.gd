extends AnimationTree

@onready var state_m = self["parameters/playback"]

func none_to_main():
	state_m.travel("none_to_main")

func main_to_magic():
	state_m.travel("main_to_magic")

func magic_to_magicsub():
	state_m.travel("magic_to_magicsub")

func main_to_pawn():
	state_m.travel("main_to_pawn")
	
func pawn_to_pawnsub():
	state_m.travel("pawn_to_pawnsub")

func main_to_system():
	state_m.travel("main_to_system")
	
func magic_to_main():
	state_m.travel("main_idle")
	
func magicsub_to_magic():
	state_m.travel("magic_idle")
	
func pawn_to_main():
	state_m.travel("main_idle")
	
func pawnsub_to_pawn():
	state_m.travel("pawn_idle")
	
func system_to_main():
	state_m.travel("main_idle")
	
func pawn_to_pawnitems():
	state_m.travel("pawn_to_pawnitems")
	
func hide():
	state_m.travel("End")
