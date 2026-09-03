#!/usr/bin/env bash
# small helper utility (variant 4)
echo "checking disk usage..."
du -sh ~ 2>/dev/null | head -1
