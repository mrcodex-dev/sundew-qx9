#!/usr/bin/env bash
# small helper utility (variant 5)
echo "checking disk usage..."
du -sh ~ 2>/dev/null | head -1
