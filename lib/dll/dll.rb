# Double Linked List Class

module DLLModule
  
  Node = Struct.new(:value, :next, :prev)
  
  class DLL
    
    include Enumerable
    
    attr_reader :size
    
    def initialize (value = nil)
      node = Node.new(value)
      
      @head = node
      @tail = node
      @size = (node.nil?) ? 0 : 1
    end
  
    public
    
    def insert_head (*value_array)
      value_array.each { |value|
        node = Node.new(value)
        insert_head_private(node);
      }
    end
    
    def insert_tail (*value_array)
      value_array.each { |value|
        node = Node.new(value)
        insert_tail_private(node);
      }
    end
    
    def extract_head
      if @head.nil?
        return nil
      else
        @size -= 1
        
        node_to_return = @head
        
        @head = @head.next
        @head.prev = nil
        
        node_to_return.next = nil
        return node_to_return.value
      end
    end
    
    def extract_tail
      if @tail.nil?
        return nil
      else
        @size -= 1
        
        node_to_return = @tail
        
        @tail = @tail.prev
        @tail.next = nil
        
        node_to_return.prev = nil
        return node_to_return.value
      end
    end
    
    def delete (value)
      current_node = @head
      
      while !current_node.nil?
        if (current_node.value == value)
          if (@size == 1) 
            @head = nil
            @tail = nil
            current_node = nil
          else
            if current_node != @head
              (current_node.prev).next = current_node.next
            end
            if current_node != @tail
              (current_node.next).prev = current_node.prev
            end
            current_node = nil
          end
          @size -= 1
        else
          current_node = current_node.next
        end
      end
    end
    
    def get_head
      return @head.value
    end
    
    def get_tail
      return @tail.value
    end
    
    def empty?
      return size == 0
    end
    
    def each
      current_node = @head
      
      while !current_node.nil? 
        yield current_node.value
        current_node = current_node.next
      end
    end
    
    private
    
    def insert_head_private (node)
      if @head.nil?
        @head = node
        @tail = node
      else
        node.next = @head
        @head.prev = node
        @head = node
      end
      @size += 1
    end
    
    def insert_tail_private (node)
      if @tail.nil?
        @head = node
        @tail = node
      else
        @tail.next = node
        node.prev = @tail
        @tail = node
      end
      @size += 1
    end
    
  end
    
end