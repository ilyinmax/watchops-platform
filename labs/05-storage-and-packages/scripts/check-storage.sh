echo "=== Filesystem space ==="
df -h /

echo "=== Inodes ==="
df -i /

echo "=== Logs size ==="
du -sh logs/

echo "=== Archives ==="
ls -lh archives/
