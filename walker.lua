require "trie"
Trie.add_word("conor")

BufferNode = {Trie = Trie}
BufferNode.__index = BufferNode

function BufferNode.new(char, parent)
    local bn = {
        node = nil,
        parent = parent,
        child = nil
    }
    setmetatable(bn, BufferNode)
    return bn
end

function BufferNode:next_char(char)
    if not self.node then
        self.Trie



Walker = {}
Walker.__index = Walker

function Walker.new()
    local tw = {
        head = nil
        tail = nil
    }
    setmetatable(tw, Walker)
    return tw
end

function Walker:add(buffer_node)
    if self.head == nil then
        self.head = buffer_node
    else
        buff

function Walker:next_char(char)
    local current_node = self.head

    while current_node ~= nil do
        output_node = current_node.next_char(char)
        if output_node then
            return output_node
        else
            if not current_node.is_alive then
                local next_node = current_node.child
                self.pop(current_node)
                current_node = next_node
            end
        end
    end
    self.add(char)



