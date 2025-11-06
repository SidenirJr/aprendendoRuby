# 📚 Arrays e Hashes em Ruby

## Introdução

Arrays e Hashes são as estruturas de dados mais importantes em Ruby. Arrays armazenam coleções ordenadas de elementos, enquanto Hashes armazenam pares chave-valor.

## 1. Arrays

Arrays são coleções ordenadas e indexadas de elementos.

### Criando Arrays

```ruby
# Array vazio
vazio = []
vazio = Array.new

# Array com elementos
numeros = [1, 2, 3, 4, 5]
frutas = ["maçã", "banana", "laranja"]

# Array misto (diferentes tipos)
misto = [1, "texto", 3.14, true, :simbolo]

# Array de strings com %w
palavras = %w[ruby python javascript]
# => ["ruby", "python", "javascript"]

# Array com tamanho fixo e valor padrão
zeros = Array.new(5, 0)
# => [0, 0, 0, 0, 0]

# Array com bloco (cada elemento único)
quadrados = Array.new(5) { |i| i ** 2 }
# => [0, 1, 4, 9, 16]

# Range para array
(1..5).to_a  # => [1, 2, 3, 4, 5]
```

### Acessando Elementos

```ruby
frutas = ["maçã", "banana", "laranja", "uva", "melancia"]

# Índice começa em 0
puts frutas[0]     # => maçã
puts frutas[2]     # => laranja

# Índices negativos (do final para o início)
puts frutas[-1]    # => melancia (último)
puts frutas[-2]    # => uva (penúltimo)

# Métodos de acesso
frutas.first       # => maçã
frutas.last        # => melancia
frutas.fetch(1)    # => banana
frutas.fetch(10, "não existe")  # => não existe (valor padrão)

# Múltiplos elementos (slice)
frutas[1, 3]       # => ["banana", "laranja", "uva"] (a partir do índice 1, 3 elementos)
frutas[1..3]       # => ["banana", "laranja", "uva"]
frutas[1...3]      # => ["banana", "laranja"]

# Acessar além do tamanho retorna nil
frutas[100]        # => nil
```

### Modificando Arrays

```ruby
frutas = ["maçã", "banana"]

# Adicionar elementos
frutas << "laranja"              # => ["maçã", "banana", "laranja"]
frutas.push("uva")               # => ["maçã", "banana", "laranja", "uva"]
frutas.push("kiwi", "manga")     # Adicionar múltiplos
frutas.unshift("morango")        # Adicionar no início

# Modificar elemento
frutas[0] = "abacaxi"

# Remover elementos
frutas.pop                       # Remove e retorna o último
frutas.shift                     # Remove e retorna o primeiro
frutas.delete("banana")          # Remove elemento específico
frutas.delete_at(1)              # Remove por índice

# Limpar array
frutas.clear                     # => []

# Remover nils
[1, nil, 2, nil, 3].compact      # => [1, 2, 3]

# Remover duplicatas
[1, 2, 2, 3, 3, 3].uniq          # => [1, 2, 3]
```

### Operações com Arrays

```ruby
a = [1, 2, 3]
b = [3, 4, 5]

# Concatenação
a + b              # => [1, 2, 3, 3, 4, 5]
a.concat(b)        # Modifica a

# Repetição
a * 3              # => [1, 2, 3, 1, 2, 3, 1, 2, 3]

# Diferença (remove elementos)
a - b              # => [1, 2]

# Interseção (elementos em comum)
a & b              # => [3]

# União (elementos únicos dos dois)
a | b              # => [1, 2, 3, 4, 5]

# Verificar elemento
a.include?(2)      # => true
```

### Métodos Importantes de Arrays

```ruby
numeros = [3, 1, 4, 1, 5, 9, 2, 6]

# Informações
numeros.length     # => 8
numeros.size       # => 8 (mesmo que length)
numeros.empty?     # => false
numeros.count(1)   # => 2 (quantas vezes aparece 1)

# Ordenação
numeros.sort       # => [1, 1, 2, 3, 4, 5, 6, 9]
numeros.sort.reverse  # => [9, 6, 5, 4, 3, 2, 1, 1]
numeros.sort!      # Modifica o array original

# Ordem customizada
palavras = ["ruby", "python", "go", "javascript"]
palavras.sort_by { |p| p.length }
# => ["go", "ruby", "python", "javascript"]

# Embaralhar
numeros.shuffle    # => ordem aleatória

# Valores máximo e mínimo
numeros.max        # => 9
numeros.min        # => 1
numeros.minmax     # => [1, 9]

# Soma e média
numeros.sum        # => 31
numeros.sum / numeros.size.to_f  # => 3.875 (média)

# Primeiro e último N elementos
numeros.first(3)   # => [3, 1, 4]
numeros.last(3)    # => [9, 2, 6]

# Amostra aleatória
numeros.sample     # Elemento aleatório
numeros.sample(3)  # 3 elementos aleatórios

# Achatar arrays aninhados
aninhado = [1, [2, 3], [4, [5, 6]]]
aninhado.flatten   # => [1, 2, 3, 4, 5, 6]

# Transpor (matriz)
matriz = [[1, 2, 3], [4, 5, 6]]
matriz.transpose   # => [[1, 4], [2, 5], [3, 6]]

# Zip (combinar arrays)
a = [1, 2, 3]
b = ['a', 'b', 'c']
a.zip(b)          # => [[1, "a"], [2, "b"], [3, "c"]]
```

### Iteração em Arrays

```ruby
frutas = ["maçã", "banana", "laranja"]

# each - iterar sobre elementos
frutas.each do |fruta|
  puts fruta
end

# each_with_index - com índice
frutas.each_with_index do |fruta, i|
  puts "#{i}: #{fruta}"
end

# map - transformar elementos
maiusculas = frutas.map { |f| f.upcase }
# => ["MAÇÃ", "BANANA", "LARANJA"]

# select - filtrar elementos
numeros = [1, 2, 3, 4, 5, 6]
pares = numeros.select { |n| n.even? }
# => [2, 4, 6]

# reject - oposto de select
impares = numeros.reject { |n| n.even? }
# => [1, 3, 5]

# find - primeiro elemento que atende condição
primeiro_par = numeros.find { |n| n.even? }
# => 2

# reduce - acumular valor
soma = numeros.reduce(0) { |acc, n| acc + n }
# => 21

# any? - algum atende?
tem_par = numeros.any? { |n| n.even? }
# => true

# all? - todos atendem?
todos_positivos = numeros.all? { |n| n > 0 }
# => true

# none? - nenhum atende?
tem_negativo = numeros.none? { |n| n < 0 }
# => true
```

## 2. Hashes

Hashes armazenam pares chave-valor (como dicionários em outras linguagens).

### Criando Hashes

```ruby
# Hash vazio
vazio = {}
vazio = Hash.new

# Hash com pares chave-valor
pessoa = {
  "nome" => "João",
  "idade" => 30,
  "cidade" => "São Paulo"
}

# Com símbolos (mais comum e eficiente)
pessoa = {
  nome: "João",      # Sintaxe moderna
  idade: 30,
  cidade: "São Paulo"
}

# Equivalente (sintaxe antiga)
pessoa = {
  :nome => "João",
  :idade => 30,
  :cidade => "São Paulo"
}

# Hash com valor padrão
contador = Hash.new(0)
contador[:visitas] += 1  # Não dá erro, começa com 0

# Hash com bloco padrão
palavras = Hash.new { |hash, key| hash[key] = [] }
palavras[:ruby] << "legal"
palavras[:python] << "simples"
```

### Acessando Valores

```ruby
pessoa = { nome: "Maria", idade: 25, cidade: "Rio" }

# Acesso por chave
pessoa[:nome]        # => "Maria"
pessoa[:idade]       # => 25

# fetch - com valor padrão
pessoa.fetch(:email, "não informado")  # => "não informado"

# fetch com bloco
pessoa.fetch(:email) { "email@default.com" }

# dig - acesso aninhado seguro
dados = {
  usuario: {
    nome: "João",
    endereco: {
      cidade: "SP"
    }
  }
}

dados.dig(:usuario, :endereco, :cidade)  # => "SP"
dados.dig(:usuario, :telefone, :ddd)     # => nil (não dá erro)

# Valores e chaves
pessoa.keys          # => [:nome, :idade, :cidade]
pessoa.values        # => ["Maria", 25, "Rio"]
```

### Modificando Hashes

```ruby
pessoa = { nome: "João", idade: 30 }

# Adicionar/modificar
pessoa[:email] = "joao@example.com"
pessoa[:idade] = 31

# Merge - combinar hashes
padrao = { ativo: true, admin: false }
usuario = { nome: "Maria", idade: 25 }
completo = padrao.merge(usuario)
# => {:ativo=>true, :admin=>false, :nome=>"Maria", :idade=>25}

# merge! - modifica o hash original
pessoa.merge!(cidade: "SP")

# Remover chave
pessoa.delete(:idade)

# Limpar hash
pessoa.clear

# Manter apenas chaves específicas
config = { host: "localhost", porta: 3000, debug: true, timeout: 30 }
config.slice(:host, :porta)
# => {:host=>"localhost", :porta=>3000}

# Remover chaves específicas
config.except(:debug, :timeout)
# => {:host=>"localhost", :porta=>3000}
```

### Métodos Importantes de Hashes

```ruby
pessoa = { nome: "Maria", idade: 25, cidade: "SP" }

# Informações
pessoa.length      # => 3
pessoa.size        # => 3
pessoa.empty?      # => false

# Verificações
pessoa.key?(:nome)     # => true
pessoa.has_key?(:email)  # => false
pessoa.value?(25)      # => true
pessoa.has_value?("SP")  # => true

# Inverter chaves e valores
{ a: 1, b: 2 }.invert  # => {1=>:a, 2=>:b}

# Transformar chaves
pessoa.transform_keys { |k| k.to_s.upcase }
# => {"NOME"=>"Maria", "IDADE"=>25, "CIDADE"=>"SP"}

# Transformar valores
numeros = { a: 1, b: 2, c: 3 }
numeros.transform_values { |v| v * 2 }
# => {:a=>2, :b=>4, :c=>6}

# Converter para array
pessoa.to_a
# => [[:nome, "Maria"], [:idade, 25], [:cidade, "SP"]]
```

### Iteração em Hashes

```ruby
pessoa = { nome: "João", idade: 30, cidade: "SP" }

# each - iterar sobre pares chave-valor
pessoa.each do |chave, valor|
  puts "#{chave}: #{valor}"
end

# each_key - apenas chaves
pessoa.each_key do |chave|
  puts chave
end

# each_value - apenas valores
pessoa.each_value do |valor|
  puts valor
end

# map - transformar em array
pares_texto = pessoa.map { |k, v| "#{k}: #{v}" }
# => ["nome: João", "idade: 30", "cidade: SP"]

# select - filtrar pares
config = { debug: true, cache: false, logging: true }
ativos = config.select { |k, v| v == true }
# => {:debug=>true, :logging=>true}

# reject - filtrar pares (oposto)
desativados = config.reject { |k, v| v == true }
# => {:cache=>false}
```

## 3. Nested Structures (Estruturas Aninhadas)

```ruby
# Arrays de Hashes
usuarios = [
  { nome: "João", idade: 30 },
  { nome: "Maria", idade: 25 },
  { nome: "Pedro", idade: 35 }
]

usuarios.each do |usuario|
  puts "#{usuario[:nome]} tem #{usuario[:idade]} anos"
end

# Filtrar
jovens = usuarios.select { |u| u[:idade] < 30 }

# Hashes de Arrays
categorias = {
  frutas: ["maçã", "banana", "laranja"],
  vegetais: ["alface", "cenoura", "tomate"],
  carnes: ["frango", "carne", "peixe"]
}

categorias[:frutas].each do |fruta|
  puts fruta
end

# Hash de Hashes
enderecos = {
  casa: {
    rua: "Rua A",
    numero: 123,
    cidade: "SP"
  },
  trabalho: {
    rua: "Av B",
    numero: 456,
    cidade: "SP"
  }
}

puts enderecos[:casa][:rua]  # => "Rua A"
```

## 4. Exemplo Prático Completo

```ruby
# gerenciador_tarefas.rb

class GerenciadorTarefas
  def initialize
    @tarefas = []
    @id_atual = 1
  end

  def adicionar(descricao, prioridade: "média")
    tarefa = {
      id: @id_atual,
      descricao: descricao,
      prioridade: prioridade,
      concluida: false,
      criada_em: Time.now
    }

    @tarefas << tarefa
    @id_atual += 1

    puts "✓ Tarefa adicionada: #{descricao}"
  end

  def listar(filtro: :todas)
    tarefas_filtradas = case filtro
    when :pendentes
      @tarefas.reject { |t| t[:concluida] }
    when :concluidas
      @tarefas.select { |t| t[:concluida] }
    else
      @tarefas
    end

    if tarefas_filtradas.empty?
      puts "Nenhuma tarefa encontrada."
      return
    end

    puts "\n=== Tarefas (#{filtro}) ==="
    tarefas_filtradas.each do |tarefa|
      status = tarefa[:concluida] ? "✓" : "☐"
      prioridade = tarefa[:prioridade].upcase
      puts "#{status} [#{tarefa[:id]}] #{tarefa[:descricao]} (#{prioridade})"
    end
  end

  def concluir(id)
    tarefa = @tarefas.find { |t| t[:id] == id }

    if tarefa
      tarefa[:concluida] = true
      puts "✓ Tarefa #{id} concluída!"
    else
      puts "✗ Tarefa #{id} não encontrada."
    end
  end

  def remover(id)
    if @tarefas.delete_if { |t| t[:id] == id }.any?
      puts "✓ Tarefa #{id} removida!"
    else
      puts "✗ Tarefa #{id} não encontrada."
    end
  end

  def estatisticas
    total = @tarefas.size
    concluidas = @tarefas.count { |t| t[:concluida] }
    pendentes = total - concluidas

    # Contar por prioridade
    por_prioridade = @tarefas.group_by { |t| t[:prioridade] }
                             .transform_values(&:count)

    puts "\n=== Estatísticas ==="
    puts "Total de tarefas: #{total}"
    puts "Concluídas: #{concluidas}"
    puts "Pendentes: #{pendentes}"
    puts "\nPor prioridade:"
    por_prioridade.each do |prioridade, qtd|
      puts "  #{prioridade}: #{qtd}"
    end
  end

  def buscar(termo)
    encontradas = @tarefas.select do |t|
      t[:descricao].downcase.include?(termo.downcase)
    end

    if encontradas.empty?
      puts "Nenhuma tarefa encontrada com '#{termo}'"
    else
      puts "\n=== Resultados para '#{termo}' ==="
      encontradas.each do |t|
        puts "[#{t[:id]}] #{t[:descricao]}"
      end
    end
  end
end

# Usando o gerenciador
tarefas = GerenciadorTarefas.new

tarefas.adicionar("Estudar Ruby", prioridade: "alta")
tarefas.adicionar("Fazer exercícios", prioridade: "média")
tarefas.adicionar("Revisar código", prioridade: "baixa")
tarefas.adicionar("Ler documentação", prioridade: "alta")

tarefas.listar
tarefas.concluir(1)
tarefas.concluir(3)

puts "\n--- Apenas pendentes ---"
tarefas.listar(filtro: :pendentes)

tarefas.estatisticas
tarefas.buscar("Ruby")
```

## Resumo

### Arrays
✅ Coleção ordenada de elementos: `[1, 2, 3]`
✅ Acesso por índice (começa em 0): `arr[0]`
✅ Adicionar: `push`, `<<`, `unshift`
✅ Remover: `pop`, `shift`, `delete`
✅ Transformar: `map`, `select`, `reject`
✅ Acumular: `reduce`, `sum`
✅ Ordenar: `sort`, `sort_by`

### Hashes
✅ Pares chave-valor: `{ nome: "João", idade: 30 }`
✅ Acesso por chave: `hash[:nome]`
✅ Símbolos são preferidos como chaves
✅ Adicionar/modificar: `hash[:chave] = valor`
✅ Combinar: `merge`
✅ Filtrar: `select`, `reject`
✅ Transformar: `transform_keys`, `transform_values`

## Métodos Mais Usados

```ruby
# Arrays
arr.push(x)       # Adicionar no final
arr << x          # Mesmo que push
arr.pop           # Remover do final
arr.first / .last # Primeiro/último
arr.include?(x)   # Contém elemento?
arr.sort          # Ordenar
arr.map { }       # Transformar
arr.select { }    # Filtrar
arr.reduce { }    # Acumular

# Hashes
hash[:key]        # Acessar valor
hash[:key] = val  # Atribuir valor
hash.keys         # Todas as chaves
hash.values       # Todos os valores
hash.merge(other) # Combinar
hash.select { }   # Filtrar
hash.each { }     # Iterar
```

## Próximo Passo

Agora vamos aprender sobre **[Classes e Objetos](08-classes-objetos.md)** - Programação Orientada a Objetos em Ruby!

---

[⬅️ Anterior: Métodos e Funções](06-metodos-funcoes.md) | [🏠 Voltar ao Índice](README.md) | [➡️ Próximo: Classes e Objetos](08-classes-objetos.md)
