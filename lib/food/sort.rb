class Array
    
  # Swap changes elements in position!
  def swap(i, j)
    clone_array = self.clone
    clone_array[i], clone_array[j] = clone_array[j], clone_array[i]
    clone_array
  end
  
  def swap!(i, j)
    self[i], self[j] = self[j], self[i]
  end
  
  def bubble_sort_imp()
    clone_array = self.clone
    
    for i in 1...clone_array.size
        for j in 0...(clone_array.size - i)
            clone_array.swap!(j, j+1) if (clone_array[j] > clone_array[j+1])
        end
    end
    
    clone_array
  end
  
  def bubble_sort_imp!()
    self.replace(self.bubble_sort_imp())
  end
  
  def bubble_sort()
    clone_array = self.clone
    
    (1...clone_array.size).each { |i|
      (0...(clone_array.size - i)).each { |j|
        clone_array.swap!(j, j+1) if (clone_array[j] > clone_array[j+1])
      }
    }
    
    clone_array
  end
  
  def bubble_sort!()
    self.replace(self.bubble_sort())
  end
  
  def merge_sort()
    split_array(self)
  end
  
  def merge_sort_imp()
    split_array(self)
  end
  
  private
  
  def split_array_imp(sorted_array)
    if (sorted_array.size <= 2)
      if ((sorted_array.size == 2) && (sorted_array[0] > sorted_array[1]))
        return sorted_array.swap(0, 1) 
      else
        return sorted_array
      end
    else
      middle = sorted_array.size / 2
      array_1 = split_array(sorted_array[0...middle])
      array_2 = split_array(sorted_array[middle...sorted_array.size])
      
      return merge_arrays(array_1, array_2)
    end
  end
  
  def merge_arrays_imp(array_1, array_2)
    sorted_array = Array.new()
    
    i = 0 # Iterador array_1
    j = 0 # Iterador array_2
    
    while ((i < array_1.size) && (j < array_2.size))  # Iterador array_3
      if (array_1[i] <= array_2[j])
        sorted_array.push(array_1[i])
        i = i+1
      else
        sorted_array.push(array_2[j])
        j = j+1
      end
    end
    
    while(i < array_1.size)
      sorted_array.push(array_1[i])
      i = i+1
    end
    
    while(j < array_2.size)
      sorted_array.push(array_2[j])
        j = j+1
    end
    
    return sorted_array
  end
  
  def split_array(sorted_array)
    if (sorted_array.size <= 2)
      if ((sorted_array.size == 2) && (sorted_array[0] > sorted_array[1]))
        return sorted_array.swap!(0, 1)
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