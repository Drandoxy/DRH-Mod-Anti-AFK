import mods.anti_afk.IdleLatch;
class IdleLatchTest {
    static function main() {
        var latch = new IdleLatch();
        if (latch.pending(false)) throw "Non-AFK acted";
        if (!latch.pending(true)) throw "First appearance missed";
        if (!latch.pending(true)) throw "Unavailable slots consumed appearance";
        latch.consume();
        if (latch.pending(true)) throw "Repeated action";
        latch.pending(false);
        if (!latch.pending(true)) throw "New appearance missed";
        latch.consume(); latch.reset();
        if (!latch.pending(true)) throw "New hero not rearmed";
        trace("Idle latch regressions passed");
    }
}
