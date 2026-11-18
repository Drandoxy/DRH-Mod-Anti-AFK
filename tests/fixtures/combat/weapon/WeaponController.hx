package combat.weapon;

class WeaponController {
	public var weapon:Dynamic;
	public var IsInCooldown:Bool = false;
	public var weaponDownActive:Bool = false;
	public var currentTimeline:Dynamic = null;
	public var mAttackArray:Array<Dynamic>;
	public var mNextAttackComboIndex:Int = 0;

	public function new(cost:Float) {
		weapon = {weaponData: {ChooseRandomAttack: false}, manaCostModifier: 1.0};
		mAttackArray = [new gameMasterDictionary.GMAttack(cost)];
	}
}
