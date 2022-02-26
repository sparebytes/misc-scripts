# Edit Files

## Prepend to file

```bash
sed -i'.bak' -e '1s/^/;.../' somefile.txt
```
