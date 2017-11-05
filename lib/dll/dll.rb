# Double Linked List Class

module DLLModule
  
  Node = Struct.new(:value, :next, :prev)
  
  class DLL
    
    attr_reader :head, :tail, :size
    
    def initialize (node = nil)
      @head = node
      @tail = node
      @size = (node.nil?) ? 0 : 1
    end
    
    def insert_head (node)
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
    
    def insert_tail (node)
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
    
    def extract_head
      if @head.nil?
        return nil
      else
        @size -= 1
        
        node_to_return = @head
        
        @head = @head.next
        @head.prev = nil
        
        node_to_return.next = nil
        return node_to_return
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
        return node_to_return
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
            puts "size = #{size}"
            (current_node.prev).next = current_node.next
            (current_node.next).prev = current_node.prev
            current_node = nil
          end
          @size -= 1
        else
          current_node = current_node.next
        end
      end
    end
    
  end
    
end