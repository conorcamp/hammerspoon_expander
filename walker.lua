require "trie"
test_trie = Trie
test_trie:add_word("conor")

BufferNode = {Trie = test_trie}
BufferNode.__index = BufferNode

function BufferNode.new()
    local bn = {
        node     = nil,
        parent   = nil,
        child    = nil,
        is_alive = true,
        is_word  = false
    }
    setmetatable(bn, BufferNode)
    return bn
end

function BufferNode:next_char(char)
    if not self.node then
        self.node = self.Trie:get_node(char)
    else
        self.node = self.node:get_child(char)
    end
    self.is_alive, self.is_word = self:get_status()
end

function BufferNode:get_status()
    if not self.node then
        return false, false
    else
        local is_prefix = self.node.has_children
        local is_word = self.node.is_word
        return (is_prefix or is_word), is_word
    end
end

function BufferNode:get_word()
    return self.node.word
end


Walker = {}
Walker.__index = Walker

function Walker.new()
    local tw = {
        head = nil,
        tail = nil
    }
    setmetatable(tw, Walker)
    return tw
end

function Walker:add_new()
    print("adding new")
    local buffer_node = BufferNode.new()

    if self.head == nil then
        self.head = buffer_node
    elseif self.tail == nil then
        self.head.child = buffer_node
        buffer_node.parent = self.head
        self.tail = buffer_node
    else
        local prev_tail = self.tail
        prev_tail.child = buffer_node
        buffer_node.parent = prev_tail
        self.tail = buffer_node
    end
    print("head node in add_new:    ", self.head)
end

function Walker:pop_node(node)
    print("popping node:    ", node)
    local parent = node.parent
    local child = node.child

    if node == self.head then
        self.head = child
    elseif node == self.tail then
        self.tail = parent
    else
        parent.child = child
        child.parent = parent
    end
    node = nil
end

function Walker:next_char(char)
    self:add_new()
    local current_node = self.head

    while current_node ~= nil do
        --output_node = current_node.next_char(char)
        current_node:next_char(char)
        if current_node.is_word then
            return current_node:get_word()
        else
            local next_node = current_node.child
            if not current_node.is_alive then
                self:pop_node(current_node)
            end
            current_node = next_node
        end
    end
end
