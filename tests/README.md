# Offline checks

Run `python tests/run.py --haxe <path-to-haxe>`.

Tests run the actual mod sources with small host doubles. They check one action per AFK appearance, rearming, slot priority, cooldown and mana fallback, paired release, and town/results guards. These checks do not replace native game compilation or gameplay testing.
