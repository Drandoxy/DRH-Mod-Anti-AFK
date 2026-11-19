package mods.anti_afk;

import mods.api.dungeon.Hero;

/** Only the current floor's heroes, not the retained history of departed players. */
class FriendRoster {
	public static function allowed(heroes:Array<Hero>):Bool {
		if (heroes == null || heroes.length == 0)
			return false;
		var localPresent = false;
		for (value in heroes) {
			var entry:Hero = value;
			if (entry == null)
				return false;
			if (entry.local) {
				localPresent = true;
			} else if (entry.player == null || !entry.player.isFriend) {
				return false;
			}
		}
		return localPresent;
	}
}
