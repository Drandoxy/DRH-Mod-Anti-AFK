from pathlib import Path
import argparse, shutil, subprocess, tempfile
p=argparse.ArgumentParser();p.add_argument('--haxe',default='haxe');args=p.parse_args()
root=Path(__file__).resolve().parents[1]
with tempfile.TemporaryDirectory(prefix='anti-afk-check-') as folder:
    dest=Path(folder)
    shutil.copytree(root/'tests/fixtures',dest,dirs_exist_ok=True)
    shutil.copytree(root/'src',dest/'mods/anti_afk')
    for test in ['IdleLatchTest','BehaviorTest']:
        subprocess.run([args.haxe,'-cp',str(dest),'-main',test,'--interp'],check=True)
