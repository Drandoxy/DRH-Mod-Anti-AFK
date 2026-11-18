import mods.anti_afk.Main;
import mods.api.Context;
import combat.weapon.WeaponController;
import distributedObjects.HeroGameObjectOwner;

@:access(mods.anti_afk.Main)
class BehaviorTest {
	static function tick(mod:Main) {
		openfl.Lib.now += 2000;
		mod.frame(new openfl.events.Event());
	}

	static function expect(ok:Bool, reason:String) {
		if (!ok)
			throw reason;
	}

	static function main() {
		var mod = new Main();
		mod.context = new Context();
		var hero = new HeroGameObjectOwner();
		mod.hero = hero;
		hero.weaponControllers = [new WeaponController(0), new WeaponController(0), new WeaponController(0)];
		tick(mod);
		expect(hero.PlayerAttack.downs.length == 1 && hero.PlayerAttack.downs[0] == 0, "Primary priority");
		tick(mod);
		expect(hero.PlayerAttack.downs.length == 1, "Repeat during same AFK");
		hero.AFK = false;
		tick(mod);
		hero.AFK = true;
		hero.weaponControllers[0].IsInCooldown = true;
		tick(mod);
		expect(hero.PlayerAttack.downs[1] == 1, "Cooldown fallback");
		hero.AFK = false;
		tick(mod);
		hero.AFK = true;
		hero.weaponControllers[1].mAttackArray = [new gameMasterDictionary.GMAttack(50)];
		tick(mod);
		expect(hero.PlayerAttack.downs[2] == 2, "Mana fallback");
		expect(hero.PlayerAttack.ups.length == 3, "Each tap released");
		hero.AFK = false;
		tick(mod);
		hero.AFK = true;
		mod.context.state.inTown = true;
		tick(mod);
		expect(hero.PlayerAttack.downs.length == 3, "Town action");
		mod.context.state.inTown = false;
		mod.context.core.facade.menuNavigationController.getTopUILayer = function() return "DISTRIBUTED_DUNGEON_SUMMARY";
		tick(mod);
		expect(hero.PlayerAttack.downs.length == 3, "Summary action");
		trace("Actual Main: slot priority, cooldown/mana fallback, one-shot, release, town and summary guards passed");
	}
}
