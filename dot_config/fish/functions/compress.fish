function compress --wraps=tar
    tar -czf (basename $argv).tar.gz $argv
end
