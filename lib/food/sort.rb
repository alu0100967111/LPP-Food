class Array
    
  # Swap changes elements in position!
  def swap(i, j)
    clone_array = self.clone
    
    clone_array[i], clone_array[j] = clone_array[j], clone_array[i]
    
    clone_array
  end
  
  def swap!(i, j)
    self.replace(swap(i, j))
  end
  
  def bubble_sort_for()
    clone_array = self.clone
    
    for i in 1...clone_array.size
        for j in 0...(clone_array.size - i)
            clone_array.swap!(j, j+1) if (clone_array[j] > clone_array[j+1])
        end
    end
    
    clone_array
  end
  
  def bubble_sort_for!()
    self.replace(self.bubble_sort_for())
  end
  
  def bubble_sort_each()
    clone_array = self.clone
    
    (1...clone_array.size).each { |i|
      (0...(clone_array.size - i)).each { |j|
        clone_array.swap!(j, j+1) if (clone_array[j] > clone_array[j+1])
      }
    }
    
    clone_array
  end
  
  def bubble_sort_each!()
    self.replace(self.bubble_sort_each())
  end
  
  def merge_sort()
    split_array(self)
  end
  
  private
  
  def split_array(sorted_array)
    if (sorted_array.size <= 2)
      if ((sorted_array.size == 2) && (sorted_array[0] > sorted_array[1]))
        return sorted_array.swap(0, 1)
      else
        return sorted_array
      end
    end
      
    middle = sorted_array.size / 2
    array_1 = split_array(sorted_array[0...middle])
    array_2 = split_array(sorted_array[middle...sorted_array.size])
    
    return merge_arrays(array_1, array_2)
  end
  
  def merge_arrays(array_1, array_2)
    sorted_array = Array.new()
    
    while (array_1.any? && array_2.any?)  # Iterador array_3
      if (array_1[0] <= array_2[0])
        sorted_array.push(array_1[0])
        array_1.delete_at(0)
      else
        sorted_array.push(array_2[0])
        array_2.delete_at(0)
      end
    end
    
    sorted_array.concat(array_1) if array_1.any?
    sorted_array.concat(array_2) if array_2.any?
    return sorted_array
  end
    
end