require "spec_helper"

include FoodGem
include DLLModule

DATA_FILENAME = "docs/data.txt"

RSpec.describe FoodGem do

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
      food_array = read_data(DATA_FILENAME)
      expect(food_array[0].name).to eq("Huevo frito")
      expect(food_array[0].protein_quantity).to eq(14.1)
      expect(food_array[0].glucid_quantity).to eq(0.0)
      expect(food_array[0].lipid_quantity).to eq(19.5)
    end
  end
  
  context "Realizar Operaciones en el alimento." do
    food_array = read_data(DATA_FILENAME)
    it "Obtener el valor energético del alimento." do
      expect(food_array[0].energetic_content).to eq(56.4 + 0.0 + 175.5)
    end
    it "Mostrar datos del alimento." do
      expect(food_array[0].to_s).to eq ("Grupo: Huevos, lacteos y helado | Nombre: Huevo frito | Proteínas: 14.1 gramos | Glúcidos: 0.0 gramos | Lípidos: 19.5 gramos | Contenido Energético: 231.9 Kcal. |")
    end
    it "Comparar con array de resultados los valores energéticos del alimento." do
      result_array = [231.9, 61.2, 69, 142.7, 112.3, 132.8, 74.4, 225.5, 202, 897.2, 479.2, 399.2, 343.4, 314.6, 70.5, 19.8, 31.1, 54.4, 92.2];
      for i in 0...(result_array.count)
        expect(food_array[i].energetic_content.round(2)).to eq(result_array[i]) # Redondeamos a 2!
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
  
end

RSpec.describe DLLModule do
  
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
      @node_1 = Node.new(3)
      @node_2 = Node.new(4)
      @node_3 = Node.new(5)
      
      @list = DLL.new(@node_2)
    end
    
    it "Crear una nueva lista vacía" do
      list = DLL.new()
    end
    it "Crear una nueva lista con un sólo nodo" do
      list = DLL.new(@node_2)
    end
    it "Comprobamos que exista cabeza" do
      expect(@list.head.value).to eq(4)
    end
    it "Comprobamos que exista cola" do
      expect(@list.tail.value).to eq(4)
    end
    it "Insertar un nuevo nodo en la lista por el frente" do
      @list.insert_head(@node_1)
    end
    it "Insertar un nuevo nodo en la lista por la cola" do
      @list.insert_tail(@node_3)
    end
    it "Comprobamos que se puedan insertar varios elementos en la lista" do
      expect(@list.size).to eq(3)
    end
    it "Extraer el primer elemento de la lista" do
      expect(@list.extract_head.value).to eq(3)
    end
    it "Extraer último elemento de la lista" do
      expect(@list.extract_tail.value).to eq(5)
    end
    it "Eliminar un elemento con un valor elegido de la lista" do
      @list.delete(4)
      expect(@list.size).to eq(0)
    end
  end
  
  context "Creación de listas de alimentos" do
    before :each do
      food_array = read_data(DATA_FILENAME)
      #node_array = []
      #food_array.each { |food| node_array.push(Node.new(food)) }
      #@list = node_array.select { |node| node.value.group_name == "Carnes y derivados" }
      @list_array = []
      @list_array.push(DLL.new(Node.new(food_array[3])))
    end
    
    it "Comprobar que haya 3 objetos en la lista" do
      expect(@list_array.count).to eq(1)
    end
    it "Comprobar que el elemento de la lista sea de grupo Carnes y derivados" do
      expect(@list_array[0].head.value.group_name).to eq("Carnes y derivados ")
    end
  end
  
end
