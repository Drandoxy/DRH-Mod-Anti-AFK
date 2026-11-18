# Anti-AFK

<!-- drh:show -->
Taps one available weapon when the **Zzz / AFK indicator** appears above your own hero in a dungeon.

- Checks your hero once every **2 seconds**, without screen scanning or searching other players.
- Tries weapon slots **1 → 2 → 3** in order, skipping empty slots, cooldowns and attacks you cannot afford with your current mana.
- Taps only the first available weapon, then stops. It waits for the AFK indicator to clear before it can act on a new appearance. If none is available, it checks again at the next interval.
- Works with remapped controls because it uses weapon slots directly. It does not move your hero, aim at enemies, hold a key, or keep attacking.
- Does nothing in town, on results screens, in menus, while dead, or while you are already attacking or charging a weapon.

**Other players can still report you for being AFK. We recommend using this only in friends-only games.** This mod does not prevent reports or guarantee protection from penalties.

### Compatibility

Works alongside [Auto Dungeon / Loot Manager](https://github.com/Drandoxy/DRH-Mod-Auto-Dungeon-Loot-Manager) and [Party Auto Join](https://github.com/Drandoxy/DRH-Mod-Party-Time-Auto-Game-Joiner). Both are optional; Anti-AFK does not replace either mod or change their settings. Their linked pages include descriptions and screenshots.

Install through DRH Launcher. Disable Anti-AFK in the launcher when you do not want it running; restart the game after changing enabled mods.
<!-- /drh:show -->
