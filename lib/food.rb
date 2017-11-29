require "food/version"
require "food/food_class"
require "food/dll"
require "food/sort"

# Root Module for the Gem
# @author Angel Igareta (alu0100967111@ull.edu.es)
module FoodGem
    
  def read_samples_data (samples_data_filename)
    data_file = File.open(samples_data_filename)
    data_file = data_file.read.split("\n")[1..-1] # Divido el fichero en líneas y quito la primera
    data_line_array = data_file.collect! { |data_array| data_array.split(" ") } # Cambio las líneas a arrays
    
    # Hash with (name of the food, sample array for all the persons to that foods)
    sample_people_hash = Hash.new([])
    person_number = 1
    line_counter = 0
    
    # Mientras no hayamos recorrido todas las lineas y el primero sea un int (nuevo individuo)
    while ((line_counter < data_line_array.count) && (data_line_array[line_counter][0].to_i == person_number))
      
      data_line = data_line_array[line_counter]
    
      person_number = person_number + 1 # Change of person
      data_line = data_line[1..-1] # Delete the person number
      
      while ((line_counter < data_line_array.count) && (data_line_array[line_counter][0].to_i != person_number))
        food_name = data_line[0].capitalize
        sample_person_array = data_line[1..-1].collect { |data| data.to_f } # Cambio numeros a float

        if (sample_people_hash[food_name] == [])
          if (food_name == "Glucosa")
            sample_people_hash.each_key { |name| sample_people_hash[name][person_number-2].push(sample_person_array) }
          else
            sample_people_hash[food_name] = [[sample_person_array]]
          end
        else
          sample_people_hash[food_name].push([sample_person_array])
        end
      
        line_counter = line_counter + 1 # Cambio de línea
        unless (line_counter >= data_line_array.count)
          data_line = data_line_array[line_counter]
        end
      end
    end
    
    #sample_people_hash.each{ |x, y| puts "#{x} => #{y}" }
    
    return sample_people_hash
  end
  
  # Method to read data by file
  # @params data_filename [String] filename of the data
  # @return [Array] Return array of food
  def read_data (data_filename, samples_data_filename = "")
    data_string = File.open(data_filename).read.split("\n") # Divido el fichero en string de lineas
    food_array = []
    
    if (samples_data_filename != "")
      sample_people_hash = read_samples_data(samples_data_filename)
    end
  
    data_string.each { |data_line|
      data_line = data_line.split(" ") # La divido en espacios
      name = ""
      
      while (data_line[0] != data_line[0].to_f.to_s) # Si el nombre no cambia al pasar de string afloat es que es un float
        name << data_line[0] << " "
        data_line = data_line[1..-1] # Quito el primer elemento
      end
      
      food_name = name[0..-2].capitalize
      protein = [data_line[0].to_f, PROTEIN_ENERGY]
      glucid = [data_line[1].to_f, GLUCID_ENERGY]
      lipid = [data_line[2].to_f, LIPID_ENERGY]
      
      data_line = data_line[3..-1] 
      
      
      group_name = ""
      while (!data_line[0].nil?) # Si el nombre no cambia al pasar de string afloat es que es un float
        group_name << data_line[0] << " "
        data_line = data_line[1..-1] # Quito el primer elemento
      end
      
      if (samples_data_filename != "")
        food = Food.new(food_name, protein, glucid, lipid, group_name[0..-2], sample_people_hash[food_name])
      else
        food = Food.new(food_name, protein, glucid, lipid, group_name[0..-2])
      end
      
      food_array.push(food)
    }
    
    return food_array
  end
  
end