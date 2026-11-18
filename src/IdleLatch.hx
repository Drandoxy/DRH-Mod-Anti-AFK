package mods.anti_afk;

/** One action per continuous AFK appearance; unavailable weapons do not consume it. */
class IdleLatch {
	var spent:Bool = false;

	public function new() {}

	public function pending(afk:Bool):Bool {
		if (!afk)
			spent = false;
		return afk && !spent;
	}

	public function consume():Void {
		spent = true;
	}

	public function reset():Void {
		spent = false;
	}
}
