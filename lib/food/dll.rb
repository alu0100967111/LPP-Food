# Double Linked List Class

# Class Doubly Linked List
module DLLModule
  
  # Struct Node for Doubly Linked List
  Node = Struct.new(:value, :next, :prev)
  
  # Class Doubly Linked List
  class DLL
    
    # Including Enumerable Module
    include Enumerable
    
    # @attr_reader size [int] size of the doubly linked list
    attr_reader :size
    
    # Constructor of DLL
    # @param value of Node
    # @param head [Node] Head of the DLL
    # @param tail [Node] Tail of the DLL
    # @param size [int] size of the doubly linked list
    def initialize (value = nil)
      node = Node.new(value)
      
      @head = node
      @tail = node
      @size = (node.nil?) ? 0 : 1
    end
  
    public
    
    # Insert element in DLL head
    # @param *value_array[array] set of values
    def insert_head (*value_array)
      value_array.each { |value|
        node = Node.new(value)
        insert_head_private(node);
      }
    end
    
    # Insert element in DLL tail
    # @param *value_array[array] set of values
    def insert_tail (*value_array)
      value_array.each { |value|
        node = Node.new(value)
        insert_tail_private(node);
      }
    end
    
    # Extract element in DLL head
    # @return [Node] value of the node that was in the head
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
    
    # Extract element in DLL tail
    # @return [Node] value of the node that was in the tail
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
    
    # Delete an specific element in DLL head
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
    
    # Return head value
    # @return [head(#value)]
    def get_head
      return @head.value
    end
    
    # Return tail value
    # @return [tail(#value)]
    def get_tail
      return @tail.value
    end
    
    # Return if DLL is empty
    def empty?
      return size == 0
    end
    
    # Essential method for Enumerable
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