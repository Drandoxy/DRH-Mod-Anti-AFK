package distributedObjects;

class HeroGameObjectOwner {
	public var AFK:Bool = true;
	public var canInitiateAnAttack:Bool = true;
	public var stateMachine:Dynamic = {currentStateName: "ActorDefaultState"};
	public var manaPoints:Float = 10;
	public var weaponControllers:Array<combat.weapon.WeaponController> = [];
	public var PlayerAttack:Attack = new Attack();

	public function new() {}

	public function isDead():Bool
		return false;
}

class Attack {
	public var downs:Array<Int> = [];
	public var ups:Array<Int> = [];

	public function new() {}

	public function isCharging():Bool
		return false;

	public function onWeaponDown(i:UInt, a:Bool):Void
		downs.push(i);

	public function onWeaponUp(i:UInt, a:Bool):Void
		ups.push(i);
}
