package mods.anti_afk;

import mods.api.Context;
import mods.api.Mod;
import distributedObjects.HeroGameObjectOwner;
import combat.weapon.WeaponController;
import gameMasterDictionary.GMAttack;
import openfl.events.Event;
import openfl.Lib;

class Main extends Mod {
	var context:Context;
	var hero:HeroGameObjectOwner;
	var subscriptions:Array<Dynamic> = [];
	var latch:IdleLatch = new IdleLatch();
	var nextCheck:Int = 0;

	override public function init(context:Context):Void {
		this.context = context;
		subscriptions.push(context.core.onObjectReady(function(object) {
			if (Std.isOfType(object, HeroGameObjectOwner)) {
				hero = cast object;
				latch.reset();
			}
		}));
		subscriptions.push(context.core.onObjectGone(function(object) {
			if (object == hero) {
				hero = null;
				latch.reset();
			}
		}));
		context.core.overlay.addEventListener(Event.ENTER_FRAME, frame);
	}

	function frame(event:Event):Void {
		var now = Lib.getTimer();
		if (now < nextCheck)
			return;
		nextCheck = now + 2000;
		if (hero == null
			|| context.state.floor == null
			|| context.state.inTown
			|| context.core.facade.mainStateMachine.currentStateName != "RunState") {
			latch.reset();
			return;
		}
		if (!latch.pending(hero.AFK)
			|| hero.isDead()
			|| !hero.canInitiateAnAttack
			|| hero.stateMachine.currentStateName != "ActorDefaultState")
			return;
		var layer = context.core.facade.menuNavigationController.getTopUILayer();
		if (layer != null && layer != "")
			return;
		var attack = hero.PlayerAttack;
		var weapons = hero.weaponControllers;
		if (attack == null || weapons == null || attack.isCharging())
			return;
		// Leave any player-held input or running attack alone.
		for (slot in 0...3) {
			if (slot < weapons.length
				&& weapons[slot] != null
				&& (weapons[slot].weaponDownActive || weapons[slot].currentTimeline != null))
				return;
		}
		for (slot in 0...3) {
			if (slot >= weapons.length || !available(weapons[slot]))
				continue;
			latch.consume();
			// Native down/up handlers form a tap, with no held key or repeat timer.
			attack.onWeaponDown(slot, false);
			attack.onWeaponUp(slot, false);
			return;
		}
	}

	function available(controller:WeaponController):Bool {
		if (controller == null || controller.weapon == null || controller.IsInCooldown)
			return false;
		var attacks:Array<Dynamic> = cast Reflect.field(controller, "mAttackArray");
		if (attacks == null || attacks.length == 0)
			return false;
		var rawIndex:Dynamic = Reflect.field(controller, "mNextAttackComboIndex");
		var index = rawIndex == null ? 0 : Std.int(rawIndex);
		if (index < 0 || index >= attacks.length)
			return false;
		var weapon = controller.weapon;
		var random = weapon.weaponData.ChooseRandomAttack;
		// Random attacks must all be affordable; never consume another slot after a tap.
		var start = random ? 0 : index;
		var end = random ? attacks.length : index + 1;
		for (i in start...end) {
			var candidate:GMAttack = cast attacks[i];
			if (candidate == null)
				return false;
			var cost:Float = candidate.ManaCost;
			if (candidate.StatOffsets != null)
				cost *= weapon.manaCostModifier;
			if (hero.manaPoints < cost)
				return false;
		}
		return true;
	}

	override public function dispose():Void {
		if (context != null)
			context.core.overlay.removeEventListener(Event.ENTER_FRAME, frame);
		for (subscription in subscriptions)
			subscription.cancel();
		subscriptions = [];
		hero = null;
		latch.reset();
	}
}
