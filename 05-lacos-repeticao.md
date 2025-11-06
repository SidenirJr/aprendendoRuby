# 🔁 Laços de Repetição em Ruby

## Introdução

Laços de repetição permitem executar blocos de código múltiplas vezes. Ruby oferece várias formas de fazer iterações, desde loops tradicionais até iteradores elegantes e expressivos.

## 1. Loop Básico - loop

A forma mais simples de loop infinito:

```ruby
# Loop infinito (cuidado!)
i = 0
loop do
  puts i
  i += 1
  break if i >= 5  # Precisa de break para parar
end

# Saída: 0, 1, 2, 3, 4
```

**Uso prático:**

```ruby
# Menu interativo
loop do
  puts "\n=== Menu ==="
  puts "1. Opção 1"
  puts "2. Opção 2"
  puts "3. Sair"
  print "Escolha: "

  opcao = gets.chomp.to_i

  case opcao
  when 1
    puts "Opção 1 selecionada"
  when 2
    puts "Opção 2 selecionada"
  when 3
    puts "Saindo..."
    break
  else
    puts "Opção inválida"
  end
end
```

## 2. While - Enquanto

Executa enquanto a condição for verdadeira:

```ruby
contador = 0

while contador < 5
  puts "Contagem: #{contador}"
  contador += 1
end

# Saída: Contagem: 0, 1, 2, 3, 4
```

### While como Modificador

```ruby
i = 0
puts i += 1 while i < 5
# Imprime: 1, 2, 3, 4, 5
```

### Exemplo Prático

```ruby
# Validar entrada do usuário
senha = ""

while senha != "1234"
  print "Digite a senha: "
  senha = gets.chomp
  puts "Senha incorreta!" unless senha == "1234"
end

puts "Acesso permitido!"
```

## 3. Until - Até que

Oposto de `while` - executa **até que** a condição seja verdadeira:

```ruby
contador = 0

until contador >= 5
  puts "Contagem: #{contador}"
  contador += 1
end

# Mesmo resultado que while contador < 5
```

### Until como Modificador

```ruby
i = 0
puts i += 1 until i >= 5
# Imprime: 1, 2, 3, 4, 5
```

**Dica:** Prefira `while` para condições positivas e `until` para condições negativas.

```ruby
# Melhor usar while
while usuario_ativo
  # fazer algo
end

# Melhor usar until
until arquivo_processado
  # processar
end
```

## 4. For - Para

Itera sobre uma coleção ou range:

```ruby
# Com range
for i in 1..5
  puts i
end
# Saída: 1, 2, 3, 4, 5

# Com array
frutas = ["maçã", "banana", "laranja"]
for fruta in frutas
  puts fruta
end

# Com hash
pessoa = { nome: "Maria", idade: 25 }
for chave, valor in pessoa
  puts "#{chave}: #{valor}"
end
```

**⚠️ Importante:** Em Ruby, o `for` não é tão idiomático. Prefira usar **iteradores** (`.each`, etc).

## 5. Iteradores - A Forma Ruby

Os iteradores são a forma mais idiomática e poderosa de fazer loops em Ruby.

### 5.1. each - Para Cada

O iterador mais comum:

```ruby
# Com arrays
[1, 2, 3, 4, 5].each do |numero|
  puts numero
end

# Forma compacta (para uma linha)
[1, 2, 3, 4, 5].each { |n| puts n }

# Com hashes
pessoa = { nome: "João", idade: 30, cidade: "SP" }
pessoa.each do |chave, valor|
  puts "#{chave}: #{valor}"
end

# Com ranges
(1..5).each do |i|
  puts "Número #{i}"
end

# Com índice
frutas = ["maçã", "banana", "laranja"]
frutas.each_with_index do |fruta, indice|
  puts "#{indice}: #{fruta}"
end

# Saída:
# 0: maçã
# 1: banana
# 2: laranja
```

### 5.2. times - N Vezes

Executa um bloco N vezes:

```ruby
5.times do |i|
  puts "Iteração #{i}"
end
# Saída: Iteração 0, 1, 2, 3, 4

# Sem usar o índice
3.times do
  puts "Ruby é legal!"
end

# Forma compacta
5.times { |i| puts i }
```

### 5.3. upto e downto - Incremento/Decremento

```ruby
# upto - de um número até outro (crescente)
1.upto(5) do |i|
  puts i
end
# Saída: 1, 2, 3, 4, 5

# downto - de um número até outro (decrescente)
5.downto(1) do |i|
  puts i
end
# Saída: 5, 4, 3, 2, 1

# Exemplo prático: contagem regressiva
puts "Iniciando em:"
5.downto(1) do |i|
  puts i
  sleep 1
end
puts "GO!"
```

### 5.4. step - Com Passo

Itera com um incremento específico:

```ruby
# De 0 a 10, pulando de 2 em 2
0.step(10, 2) do |i|
  puts i
end
# Saída: 0, 2, 4, 6, 8, 10

# Com ranges
(0..10).step(2) do |i|
  puts i
end

# Decrescente
10.step(0, -2) do |i|
  puts i
end
# Saída: 10, 8, 6, 4, 2, 0
```

### 5.5. map - Transformar Elementos

Cria um novo array com os resultados:

```ruby
# Dobrar todos os números
numeros = [1, 2, 3, 4, 5]
dobrados = numeros.map { |n| n * 2 }
puts dobrados.inspect
# => [2, 4, 6, 8, 10]

# Com blocos multi-linha
nomes = ["joão", "maria", "pedro"]
nomes_maiusculos = nomes.map do |nome|
  nome.capitalize
end
# => ["João", "Maria", "Pedro"]

# Atalho com Symbol#to_proc
nomes.map(&:upcase)
# => ["JOÃO", "MARIA", "PEDRO"]

# map! modifica o array original
numeros = [1, 2, 3]
numeros.map! { |n| n * 2 }
puts numeros.inspect  # => [2, 4, 6]
```

### 5.6. select - Filtrar Elementos

Retorna apenas elementos que atendem a condição:

```ruby
# Números pares
numeros = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
pares = numeros.select { |n| n.even? }
puts pares.inspect
# => [2, 4, 6, 8, 10]

# Strings longas
palavras = ["oi", "olá", "bom dia", "tchau", "até logo"]
longas = palavras.select { |p| p.length > 4 }
# => ["bom dia", "até logo"]

# Atalho
numeros.select(&:even?)

# reject é o oposto de select
impares = numeros.reject { |n| n.even? }
# => [1, 3, 5, 7, 9]
```

### 5.7. reduce (inject) - Acumular Valores

Combina todos os elementos em um único valor:

```ruby
# Somar todos os números
numeros = [1, 2, 3, 4, 5]
soma = numeros.reduce(0) { |acumulador, n| acumulador + n }
puts soma  # => 15

# Forma curta
soma = numeros.reduce(:+)  # => 15

# Multiplicação
produto = numeros.reduce(1) { |acc, n| acc * n }  # => 120
produto = numeros.reduce(:*)  # => 120

# Exemplo prático: construir hash
frutas = ["maçã", "banana", "maçã", "laranja", "banana", "maçã"]
contagem = frutas.reduce(Hash.new(0)) do |hash, fruta|
  hash[fruta] += 1
  hash
end
puts contagem.inspect
# => {"maçã"=>3, "banana"=>2, "laranja"=>1}
```

### 5.8. each_with_object - Acumular em Objeto

Similar ao `reduce`, mas mais legível:

```ruby
# Criar hash a partir de array
palavras = ["ruby", "python", "javascript"]
tamanhos = palavras.each_with_object({}) do |palavra, hash|
  hash[palavra] = palavra.length
end
# => {"ruby"=>4, "python"=>6, "javascript"=>10}

# Agrupar por primeira letra
nomes = ["Ana", "Bruno", "Alice", "Carlos", "Beatriz"]
agrupados = nomes.each_with_object({}) do |nome, hash|
  primeira_letra = nome[0]
  hash[primeira_letra] ||= []
  hash[primeira_letra] << nome
end
# => {"A"=>["Ana", "Alice"], "B"=>["Bruno", "Beatriz"], "C"=>["Carlos"]}
```

### 5.9. Outros Iteradores Úteis

```ruby
# any? - verifica se algum elemento atende a condição
numeros = [1, 2, 3, 4, 5]
tem_par = numeros.any? { |n| n.even? }  # => true
tem_negativo = numeros.any? { |n| n < 0 }  # => false

# all? - verifica se todos os elementos atendem a condição
todos_positivos = numeros.all? { |n| n > 0 }  # => true
todos_pares = numeros.all?(&:even?)  # => false

# none? - verifica se nenhum elemento atende a condição
nenhum_negativo = numeros.none? { |n| n < 0 }  # => true

# one? - verifica se exatamente um elemento atende a condição
somente_um_par = [1, 2, 3].one?(&:even?)  # => true

# find (detect) - retorna o primeiro elemento que atende
primeiro_par = numeros.find { |n| n.even? }  # => 2

# count - conta elementos que atendem a condição
qtd_pares = numeros.count(&:even?)  # => 2

# partition - divide em dois arrays (true/false)
pares, impares = numeros.partition(&:even?)
# pares => [2, 4], impares => [1, 3, 5]

# take - pega os primeiros N elementos
primeiros_3 = numeros.take(3)  # => [1, 2, 3]

# drop - remove os primeiros N elementos
resto = numeros.drop(3)  # => [4, 5]
```

## 6. Controle de Fluxo em Loops

### break - Sair do Loop

```ruby
# Parar quando encontrar valor
numeros = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
numeros.each do |n|
  break if n > 5
  puts n
end
# Saída: 1, 2, 3, 4, 5

# break com valor de retorno
resultado = [1, 2, 3, 4, 5].each do |n|
  break "Achei!" if n == 3
  n
end
puts resultado  # => "Achei!"
```

### next - Pular Iteração

```ruby
# Pular números pares
1.upto(10) do |i|
  next if i.even?
  puts i
end
# Saída: 1, 3, 5, 7, 9

# Processar apenas valores válidos
dados = [1, nil, 2, nil, 3, nil, 4]
dados.each do |valor|
  next if valor.nil?
  puts "Processando: #{valor}"
end
```

### redo - Repetir Iteração

```ruby
# Repetir até entrada válida
[1, 2, 3].each do |i|
  print "Digite 'sim': "
  resposta = gets.chomp
  redo unless resposta == "sim"
  puts "Iteração #{i} concluída"
end
```

### retry - Reiniciar Loop (apenas em rescue)

```ruby
tentativas = 0
begin
  puts "Tentativa #{tentativas + 1}"
  # Simular falha
  raise "Erro" if tentativas < 2

  puts "Sucesso!"
rescue
  tentativas += 1
  retry if tentativas < 3
  puts "Máximo de tentativas atingido"
end
```

## 7. Loops Aninhados

```ruby
# Tabuada
1.upto(5) do |i|
  1.upto(5) do |j|
    puts "#{i} x #{j} = #{i * j}"
  end
  puts "---"
end

# Matriz
matriz = [
  [1, 2, 3],
  [4, 5, 6],
  [7, 8, 9]
]

matriz.each_with_index do |linha, i|
  linha.each_with_index do |valor, j|
    puts "matriz[#{i}][#{j}] = #{valor}"
  end
end
```

## 8. Blocos de Uma Linha vs Multi-linha

```ruby
# ✅ Use { } para blocos de uma linha
[1, 2, 3].map { |n| n * 2 }

# ✅ Use do...end para blocos multi-linha
[1, 2, 3].map do |n|
  resultado = n * 2
  resultado + 1
end

# ❌ Evite do...end em uma linha (não idiomático)
[1, 2, 3].map do |n| n * 2 end  # Ruim

# ❌ Evite { } multi-linha (confuso)
[1, 2, 3].map { |n|
  resultado = n * 2
  resultado + 1
}  # Ruim
```

## Exemplo Prático Completo

```ruby
# processador_notas.rb

puts "=== Processador de Notas ==="
puts

# Coletar notas
notas = []
loop do
  print "Digite uma nota (ou 'fim' para terminar): "
  entrada = gets.chomp

  break if entrada.downcase == 'fim'

  nota = entrada.to_f
  if nota < 0 || nota > 10
    puts "Nota inválida! Digite entre 0 e 10."
    next
  end

  notas << nota
end

# Verificar se há notas
if notas.empty?
  puts "Nenhuma nota foi inserida."
  exit
end

# Processar notas
puts "\n=== Análise das Notas ==="

# Estatísticas básicas
media = notas.reduce(:+) / notas.size.to_f
maior = notas.max
menor = notas.min

puts "Total de notas: #{notas.size}"
puts "Média: #{media.round(2)}"
puts "Maior nota: #{maior}"
puts "Menor nota: #{menor}"

# Classificar notas
aprovados = notas.count { |n| n >= 6 }
reprovados = notas.count { |n| n < 6 }

puts "\nAprovados: #{aprovados}"
puts "Reprovados: #{reprovados}"

# Listar todas as notas com conceito
puts "\n=== Notas Detalhadas ==="
notas.each_with_index do |nota, index|
  conceito = case nota
  when 9..10 then "A"
  when 8...9 then "B"
  when 7...8 then "C"
  when 6...7 then "D"
  else "F"
  end

  status = nota >= 6 ? "✓" : "✗"
  puts "#{index + 1}. Nota: #{nota} | Conceito: #{conceito} #{status}"
end

# Verificações
puts "\n=== Verificações ==="
puts "Todos aprovados? #{notas.all? { |n| n >= 6 }}"
puts "Algum com nota máxima? #{notas.any? { |n| n == 10 }}"
puts "Nenhuma nota zero? #{notas.none?(&:zero?)}"
```

## Resumo

✅ **loop**: Loop infinito, precisa de break
✅ **while**: Executa enquanto condição é true
✅ **until**: Executa enquanto condição é false
✅ **for**: Itera sobre coleções (menos idiomático)
✅ **each**: Itera sobre cada elemento (mais idiomático)
✅ **times**: Executa N vezes
✅ **upto/downto**: Crescente/decrescente
✅ **map**: Transforma elementos
✅ **select/reject**: Filtra elementos
✅ **reduce**: Acumula valor único
✅ **break**: Sai do loop
✅ **next**: Pula iteração
✅ **{ }**: Para blocos de uma linha
✅ **do...end**: Para blocos multi-linha

## Boas Práticas

1. Prefira iteradores (`.each`, `.map`, etc) sobre `for`
2. Use `times` quando souber quantas vezes repetir
3. Use `map` quando quiser transformar dados
4. Use `select` quando quiser filtrar dados
5. Use `reduce` quando quiser acumular resultado
6. Use `{ }` para blocos de uma linha, `do...end` para múltiplas
7. Use `break` e `next` para controle de fluxo
8. Evite loops infinitos sem condição de parada

## Próximo Passo

Agora vamos aprender sobre **[Métodos e Funções](06-metodos-funcoes.md)** em Ruby!

---

[⬅️ Anterior: Estruturas Condicionais](04-estruturas-condicionais.md) | [🏠 Voltar ao Índice](README.md) | [➡️ Próximo: Métodos e Funções](06-metodos-funcoes.md)
