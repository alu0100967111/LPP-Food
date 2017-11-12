require "spec_helper"

include FoodGem
include DLLModule

DATA_FILENAME = "docs/data.txt"

RSpec.describe FoodGem do
  
  before :all do
      @food_array = read_data(DATA_FILENAME)
    end

  context "Instanciación de clase Food." do
    it "Crear un objeto Alimento con un nombre y tres pares (macronutriente, contenido energético): Proteínas, glúcidos y lípidos." do
      Food.new("Huevo frito", [14.1, 4], [0.0, 4], [19.5, 9], "Lacteos")
    end
    it "No permitir que el primer atributo sea no String." do
      expect {Food.new(5, [14.1, 4], [0.0, 4], [19.5, 9], "Lacteos")}.to raise_error(RuntimeError)
    end
    it "No permitir que el segundo, tercer y cuarto atributo sea no Array." do
      expect {Food.new("Huevo frito", 5, 6, 7, "Lacteos")}.to raise_error(RuntimeError)
    end
    it "No permitir que el segundo, tercer y cuarto atributo sean un par vacío." do
      expect {Food.new("Huevo frito", [], [], [], "Lacteos")}.to raise_error(RuntimeError)
    end
    it "No permitir que el segundo, tercer y cuarto atributo no sean un par." do
      expect {Food.new("Huevo frito", [5], [6], [7, 8, 5], "Lacteos")}.to raise_error(RuntimeError)
    end
    it "No permitir que el segundo, tercer y cuarto atributo sean un par de no Float||Int." do
      expect {Food.new("Huevo frito", ["A", "B"], ["A", "B"], ["A", "B"], "Lacteos")}.to raise_error(RuntimeError)
    end
  end
  
  context "Obtener atributos de un Alimento." do
    food = Food.new("Huevo frito", [14.1, 4], [0.0, 4], [19.5, 9], "Lacteos")
    it "Obtener el nombre del alimento" do
      expect(food.name).to eq("Huevo frito")
    end
    it "Obtener la cantidad de proteínas del alimento en gramos." do
      expect(food.protein_quantity).to eq(14.1)
    end
    it "Obtener la cantidad de glúcidos del alimento en gramos." do
      expect(food.glucid_quantity).to eq(0.0)
    end
    it "Obtener la cantidad de lípidos del alimento en gramos." do
      expect(food.lipid_quantity).to eq(19.5)
    end
  end
  
  context "Leer datos por fichero." do
    it "Llamo a la función read_data con un fichero de texto donde están los datos." do
      read_data(DATA_FILENAME)
    end
    it "Compruebo que la función read_data me devuelve un array de Alimento." do
      expect(read_data(DATA_FILENAME)).to be_instance_of(Array)
    end
    it "Compruebo que la función read_data me devuelva el primer elemento bien leído." do
      expect(@food_array[0].name).to eq("Huevo frito")
      expect(@food_array[0].protein_quantity).to eq(14.1)
      expect(@food_array[0].glucid_quantity).to eq(0.0)
      expect(@food_array[0].lipid_quantity).to eq(19.5)
    end
  end
  
  context "Realizar Operaciones en el alimento." do
    it "Obtener el valor energético del alimento." do
      expect(@food_array[0].energetic_content).to eq(56.4 + 0.0 + 175.5)
    end
    it "Mostrar datos del alimento." do
      expect(@food_array[0].to_s).to eq ("Grupo: Huevos, lacteos y helados | Nombre: Huevo frito | Proteínas: 14.1 gramos | Glúcidos: 0.0 gramos | Lípidos: 19.5 gramos | Contenido Energético: 231.9 Kcal.")
    end
    it "Comparar con array de resultados los valores energéticos del alimento." do
      result_array = [231.9, 61.2, 69, 142.7, 112.3, 132.8, 74.4, 225.5, 202, 897.2, 479.2, 399.2, 343.4, 314.6, 70.5, 19.8, 31.1, 54.4, 92.2];
      for i in 0...(result_array.count)
        expect(@food_array[i].energetic_content.round(2)).to eq(result_array[i]) # Redondeamos a 2!
      end
    end
  end
  
  context "Jerarquía de clases" do
    before :each do
      @food = Food.new("Huevo frito", [14.1, 4], [0.0, 4], [19.5, 9], "Huevos, lacteos y helados")
    end
    
    it "Food sea Food" do
      expect(@food).is_a?Food
    end
    it "Food sea FoodAbstract" do
      expect(@food).is_a?FoodAbstract
    end
    it "Food sea Object" do
      expect(@food).is_a?Object
    end
    it "Food sea BasicObject" do
      expect(@food).is_a?BasicObject
    end
    it "Food no sea instancia FoodAbstract" do
      expect(@food.instance_of?FoodAbstract).to eq(false)
    end
    it "Food sea instancia de Food" do
      expect(@food).instance_of?Food
    end
    it "Clase Food sea clase Class" do
      expect(Food).is_a?Class
    end
  end
  
  context "Comparando alimentos" do
    before :all do
      @food_1 = @food_array[0] # Huevo frito
      @food_2 = @food_array[1] # Leche vaca
      @food_3 = @food_array[2] # Yogurt
    end
    
    it "Comprobar que huevo frito es mayor que Leche de vaca" do
      expect(@food_1).to be > @food_2
    end
    it "Comprobar que leche de vaca es menor que Yogurt" do
      expect(@food_2).to be < @food_3
    end
    it "Comprobar que leche de vaca es igual que leche de vaca" do
      expect(@food_2).to eq(@food_2)
    end
    it "Comprobar que Yogurt está entre Huevo fito y Leche de vaca" do
      expect(@food_3).to be_between(@food_2, @food_1).exclusive
    end
  end
  
end

RSpec.describe DLLModule do
  
  before :all do
    @food_array = read_data(DATA_FILENAME)
    
    @list_array = Hash.new() #H ash de nombre de lista y lista
    
    @food_array.each{ |food| # Rellenamos el Hash
      if (@list_array.has_key?(food.group_name)) # Si existe la lista con ese grupo, insertamos
        @list_array[food.group_name].insert_tail(food)
      else
        @list_array[food.group_name] = DLL.new(food)
        print food.group_name
      end
    }
  end
  
  context "Instanciación de un Nodo" do
    before:all do
      @node_2 = Node.new(4)
      @node_1 = Node.new(3, @node_2)
      @node_3 = Node.new(5, nil, @node_2)
    end
    
    it "Crear un nuevo nodo con valor 5" do
      expect(Node.new(5).value).to eq(5)
    end
    it "Acceder al elemento siguiente de un nodo" do
      expect(@node_1.next).to eq(@node_2)
    end
    it "Acceder al elemento anterior de un nodo" do
      expect(@node_3.prev).to eq(@node_2)
    end
    it "Modificar el elemento anterior de un nodo" do
      @node_2.prev = @node_1
      expect(@node_2.prev.value).to eq(3)
    end
    it "Modificar el elemento siguiente de un nodo" do
      @node_2.next = @node_3
      expect(@node_2.next.value).to eq(5)
    end
  end
  
  context "Instanciación de una Lista Doblemente Enlazada" do
    before:all do
      @list = DLL.new(4) # Lista final deseada: 0-> 1 -> 2 -> 3 -> 4 -> 5
    end
    
    it "Crear una nueva lista vacía" do
      DLL.new()
    end
    it "Crear una nueva lista con un sólo nodo" do
      DLL.new(4)
    end
    it "Comprobamos que exista cabeza" do
      expect(@list.get_head).to eq(4)
    end
    it "Comprobamos que exista cola" do
      expect(@list.get_tail).to eq(4)
    end
    it "Insertar un nuevo nodo en la lista por el frente" do
      @list.insert_head(3)
    end
    it "Insertar un nuevo nodo en la lista por la cola" do
      @list.insert_tail(5)
    end
    it "Comprobamos que se han insertado varios elementos en la lista" do
      expect(@list.size).to eq(3)
    end
    it "Comprobamos que se puedan insertar varios elementos de una vezen la lista" do
      @list.insert_head(2, 1, 0)
      expect(@list.size).to eq(6)
    end
    it "Extraer el primer elemento de la lista" do
      expect(@list.extract_head).to eq(0)
    end
    it "Extraer último elemento de la lista" do
      expect(@list.extract_tail).to eq(5)
    end
    it "Eliminar un elemento con un valor elegido de la lista" do
      @list.delete(4)
      expect(@list.size).to eq(3)
    end
  end
  
  context "Creación de listas de alimentos" do
    describe "Comprobar que existan las 7 listas" do
      it "Comprobar que existan elemento de la lista sea de grupo Huevos, lacteos y helados" do
        expect(@list_array["Huevos, lacteos y helados"]).not_to be_empty
      end
      it "Comprobar que existan elemento de la lista sea de grupo Carnes y derivados" do
        expect(@list_array["Carnes y derivados"]).not_to be_empty
      end
      it "Comprobar que existan elemento de la lista sea de grupo Pescados y mariscos" do
        expect(@list_array["Pescados y mariscos"]).not_to be_empty
      end
      it "Comprobar que existan elemento de la lista sea de grupo Alimentos grasos" do
        expect(@list_array["Alimentos grasos"]).not_to be_empty
      end
      it "Comprobar que existan elemento de la lista sea de grupo Alimentos ricos en carbohidratos" do
        expect(@list_array["Alimentos ricos en carbohidratos"]).not_to be_empty
      end
      it "Comprobar que existan elemento de la lista sea de grupo Verduras y Hortalizas" do
        expect(@list_array["Verduras y Hortalizas"]).not_to be_empty
      end
      it "Comprobar que existan elemento de la lista sea de grupo Frutas" do
        expect(@list_array["Frutas"]).not_to be_empty
      end
    end
  end

  context "Enumerando la lista de alimentos" do
    before :all do
      @hlh_list = @list_array["Huevos, lacteos y helados"]
      @cd_list = @list_array["Carnes y derivados"]
      @pm_list = @list_array["Pescados y mariscos"]
    end
    
    it "Usamos el método each de la lista doblemente enlazada" do
      @hlh_list.each{ |food| expect(food.group_name).to eq ("Huevos, lacteos y helados")}
    end
    it "Usamos el método all de la lista doblemente enlazada" do
      expect(@hlh_list.all?{ |food| food.group_name == "Huevos, lacteos y helados"}).to be_truthy
    end
    it "Usamos el método any de la lista doblemente enlazada" do
      expect(@hlh_list.any?{ |food| food.name == "Yogurt"}).to be_truthy
    end
    it "Usamos el método max de la lista doblemente enlazada" do
      expect(@hlh_list.max.name).to eq("Huevo frito")
    end
    it "Usamos el método min de la lista doblemente enlazada" do
      expect(@hlh_list.min.name).to eq("Leche vaca")
    end
    it "Usamos el método first de la lista doblemente enlazada" do
      expect(@hlh_list.first).to eq(@hlh_list.get_head)
    end
    it "Usamos el método count de la lista doblemente enlazada" do
      expect(@hlh_list.count).to eq(3)
    end
    it "Usamos el método find de la lista doblemente enlazada" do
      expect(@hlh_list.find{ |food| food.name == "Huevo frito"}).to eq(@hlh_list.get_head)
    end
    it "Usamos el método drop de la lista doblemente enlazada" do
      expect(@hlh_list.drop(2)).to eq([@hlh_list.get_tail])
    end
  end
end
