function addtopath --description 'Adds an item to your PATH variable'
    set victim $argv[1]
    
    if not contains $victim $PATH
        set PATH $victim $PATH
    end
end
