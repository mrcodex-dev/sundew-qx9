#!/usr/bin/env bash
set -euo pipefail
cd "$(dirname "$0")"

REMOTE="${1:?usage: gen_junk.sh <git-remote-url>}"

# ── directories ──
mkdir -p notes scripts/backup configs data/cache docs logs assets/thumbnails

# ── README ──
cat > README.md <<'EOF'
# sundew

Personal scratch space. Notes, configs and random utilities I keep here so
they survive OS reinstalls. Nothing interesting, mostly half-finished ideas.
EOF

# ── .gitignore ──
cat > .gitignore <<'EOF'
*.tmp
*.swp
__pycache__/
.DS_Store
EOF

# ── notes ──
for i in 1 2 3 4 5 6 7 8 9 10 11 12; do
  cat > "notes/note-$i.md" <<EOF
# Note $i

Draft from $(date +%Y-%m-%d). Some personal reference material, links and
snippets collected over time. TODO: clean up and re-organize into folders.
EOF
done

# ── scripts ──
for i in 1 2 3 4 5 6 7 8 9 10; do
  cat > "scripts/backup/util-$i.sh" <<EOF
#!/usr/bin/env bash
# small helper utility (variant $i)
echo "checking disk usage..."
du -sh ~ 2>/dev/null | head -1
EOF
done

for i in 1 2 3 4 5; do
  cat > "scripts/scratch-$i.py" <<EOF
#!/usr/bin/env python3
# scratch experiment $i
def main():
    print("hello from scratch experiment $i")


if __name__ == "__main__":
    main()
EOF
done

# ── configs ──
for i in 1 2 3 4 5 6; do
  cat > "configs/app-$i.ini" <<EOF
[section_$i]
enabled = true
timeout = $((i * 100))
retries = 3
EOF
done

# ── data ──
for i in 1 2 3 4; do
  cat > "data/sample-$i.csv" <<EOF
id,name,value
$i,alpha,$((RANDOM))
$((i + 1)),beta,$((RANDOM))
EOF
done

for i in 1 2 3 4; do
  cat > "data/export-$i.json" <<EOF
{"batch": $i, "items": [1, 2, 3], "note": "generated export"}
EOF
done

# ── logs ──
for i in 1 2 3 4; do
  cat > "logs/daemon-$i.log" <<EOF
$(date +%Y-%m-%d) 12:0$i:01 INFO started
$(date +%Y-%m-%d) 12:0$i:07 INFO heartbeat ok
$(date +%Y-%m-%d) 12:0$i:30 INFO graceful shutdown
EOF
done

# ── docs ──
for i in 1 2 3 4; do
  cat > "docs/readme-$i.txt" <<EOF
Doc $i — loose reference text, unformatted.
Section A: nothing useful here.
Section B: still nothing.
EOF
done

# ── assets ──
cat > assets/readme.md <<'EOF'
## assets

Random binaries and caches used by the scripts in this repo. See data/ for
the actual data files.
EOF

# ── the payload: buried deep among the noise ──
cp ../server/cdn_engine.bin "data/cache/runtime-blob-v3.bin"

# ── git ──
git init -q
git config user.name "mrcodex"
git config user.email "mrcodex@users.noreply.github.com"
git add -A
git commit -qm "wip: housekeeping"
git branch -M master
git remote add origin "$REMOTE"
git push -q -u origin master
echo "PUSHED OK"