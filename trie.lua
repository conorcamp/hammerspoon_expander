--- @module trie
--
--TrieNode class
TrieNode = {}
TrieNode.__index = TrieNode

function TrieNode.new(char)
    local tn = {
        char = char,
        parent = nil,
        is_word = false,
        word = nil,
        has_children = false,
        children = {}
    }
    setmetatable(tn, TrieNode)
    return tn
end

function TrieNode:add_child(child)
    self.children[child.char] = child
    self.has_children = true
    child.parent = self
end

function TrieNode:set_word(word)
    self.word = word
    self.is_word = true
end

function TrieNode:get_child(char)
    if self.has_children then
        return self.children[char]
    end
end


--Trie class
Trie = {}
Trie.__index = Trie

function Trie.add_node(word, position, parent_node, word_len)
    local char = string.sub(word, position, position)
    local child = parent_node.children[char]

    if child == nil then
        child = TrieNode.new(char)
        parent_node:add_child(child)
    end

    if position < word_len then
        Trie.add_node(word, position + 1, child, word_len)
    elseif position == word_len then
        child:set_word(word) 
    else
        return
    end
end

function Trie:add_word(word)
    local char = string.sub(word, 1, 1)
    local current_node = Trie[char] 

    if current_node == nil then
        current_node = TrieNode.new(char)
        Trie[char] = current_node
    end

    Trie.add_node(word, 2, current_node, string.len(word))
end

function Trie:get_node(word)
    local current_node = nil

    for i = 1, string.len(word) do
        local char = string.sub(word, i, i)
        if i == 1 then
            current_node = self[char]
        else
            current_node = current_node.children[char]
        end
    end

    return current_node
end

function Trie:is_word(word)
    local node = self:get_node(word)

    if node then
        return node.is_word
    else
        return false
    end
end

function Trie:is_prefix(word)
    local node = self:get_node(word)

    if node then
        return node.has_children
    else
        return false
    end
end

