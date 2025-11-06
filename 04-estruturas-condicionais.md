# 🔀 Estruturas Condicionais em Ruby

## Introdução

Estruturas condicionais permitem que o programa tome decisões e execute diferentes blocos de código baseado em condições. Ruby oferece várias formas elegantes de fazer isso.

## 1. If, Elsif, Else

### Sintaxe Básica

```ruby
idade = 18

if idade >= 18
  puts "Maior de idade"
end
```

### If com Else

```ruby
idade = 16

if idade >= 18
  puts "Maior de idade"
else
  puts "Menor de idade"
end
```

### If com Elsif

```ruby
nota = 85

if nota >= 90
  puts "Conceito A"
elsif nota >= 80
  puts "Conceito B"
elsif nota >= 70
  puts "Conceito C"
elsif nota >= 60
  puts "Conceito D"
else
  puts "Conceito F"
end
```

### If como Modificador (Inline)

Ruby permite escrever `if` no final da linha para condições simples:

```ruby
# Forma tradicional
if idade >= 18
  puts "Pode votar"
end

# Forma inline (mais idiomática para linhas únicas)
puts "Pode votar" if idade >= 18

# Outros exemplos
preco = 100
preco *= 0.9 if dia == "sexta"  # Desconto de 10% na sexta

arquivo = "dados.txt"
File.delete(arquivo) if File.exist?(arquivo)
```

### Retorno Implícito

Em Ruby, `if` retorna o valor da última expressão avaliada:

```ruby
resultado = if nota >= 60
  "Aprovado"
else
  "Reprovado"
end

puts resultado

# Forma mais compacta (preferível)
status = nota >= 60 ? "Aprovado" : "Reprovado"
```

## 2. Unless - O "If Negado"

`unless` é o oposto de `if` - executa o código quando a condição é **falsa**.

### Sintaxe Básica

```ruby
chovendo = false

unless chovendo
  puts "Vamos ao parque!"
end

# Equivalente a:
if !chovendo
  puts "Vamos ao parque!"
end
```

### Unless com Else

```ruby
autenticado = false

unless autenticado
  puts "Por favor, faça login"
else
  puts "Bem-vindo!"
end

# ⚠️ Prefira usar if neste caso para maior clareza:
if autenticado
  puts "Bem-vindo!"
else
  puts "Por favor, faça login"
end
```

### Unless como Modificador

```ruby
# Forma inline
puts "Acesso negado" unless autenticado

# Outros exemplos
arquivo.close unless arquivo.closed?
enviar_email unless email.empty?
```

**⚠️ Importante:**
- Evite usar `elsif` com `unless` (confuso!)
- Prefira `unless` apenas para condições simples
- Use `if !condição` se ficar mais legível

## 3. Case/When - Switch Melhorado

O `case` do Ruby é muito mais poderoso que o `switch` de outras linguagens.

### Sintaxe Básica

```ruby
dia = "segunda"

case dia
when "segunda", "terça", "quarta", "quinta", "sexta"
  puts "Dia útil"
when "sábado", "domingo"
  puts "Fim de semana"
else
  puts "Dia inválido"
end
```

### Case com Ranges

```ruby
nota = 85

case nota
when 90..100
  puts "Conceito A"
when 80...90
  puts "Conceito B"
when 70...80
  puts "Conceito C"
when 60...70
  puts "Conceito D"
else
  puts "Conceito F"
end
```

### Case com Expressões Regulares

```ruby
texto = "ruby@example.com"

case texto
when /^[\w]+@[\w]+\.com$/
  puts "E-mail válido"
when /^\d{3}-\d{4}$/
  puts "Telefone"
when /^\d{5}-\d{3}$/
  puts "CEP"
else
  puts "Formato desconhecido"
end
```

### Case com Classes

```ruby
valor = 42

case valor
when Integer
  puts "É um número inteiro"
when String
  puts "É uma string"
when Array
  puts "É um array"
when Hash
  puts "É um hash"
else
  puts "Tipo desconhecido"
end
```

### Case com Lambdas/Procs

```ruby
par = ->(x) { x.even? }
positivo = ->(x) { x > 0 }

numero = 4

case numero
when par
  puts "Número par"
when positivo
  puts "Número positivo"
else
  puts "Número ímpar negativo"
end
```

### Case com Retorno

```ruby
resultado = case dia_semana
when 1..5
  "Dia útil"
when 6..7
  "Fim de semana"
else
  "Dia inválido"
end

puts resultado
```

### Case sem Variável (Substituto para If/Elsif)

```ruby
idade = 25
tem_carteira = true

case
when idade < 18
  puts "Menor de idade, não pode dirigir"
when idade >= 18 && !tem_carteira
  puts "Precisa tirar carteira"
when idade >= 18 && tem_carteira
  puts "Pode dirigir"
end
```

## 4. Operador Ternário

Forma concisa de `if/else` para atribuições simples:

```ruby
# Sintaxe: condição ? valor_se_true : valor_se_false

idade = 20
status = idade >= 18 ? "Adulto" : "Menor"

# Equivalente a:
if idade >= 18
  status = "Adulto"
else
  status = "Menor"
end

# Outros exemplos
max = a > b ? a : b
saudacao = hora < 12 ? "Bom dia" : "Boa tarde"
preco_final = membro ? preco * 0.9 : preco
```

**⚠️ Cuidado:** Evite aninhar ternários, fica difícil de ler!

```ruby
# ❌ Ruim - difícil de ler
resultado = x > 0 ? (y > 0 ? "A" : "B") : (y > 0 ? "C" : "D")

# ✅ Bom - use if/elsif/else
if x > 0
  resultado = y > 0 ? "A" : "B"
else
  resultado = y > 0 ? "C" : "D"
end
```

## 5. Operadores Lógicos em Condicionais

### && (E lógico)

```ruby
idade = 25
tem_carteira = true

# Ambas as condições devem ser verdadeiras
if idade >= 18 && tem_carteira
  puts "Pode dirigir"
end

# Short-circuit: se a primeira for false, não avalia a segunda
valor = nil
if valor && valor.length > 0
  puts "Valor não vazio"
end
```

### || (OU lógico)

```ruby
dia = "sábado"

# Pelo menos uma condição deve ser verdadeira
if dia == "sábado" || dia == "domingo"
  puts "Fim de semana!"
end

# Atribuição com valor padrão
nome = nome_usuario || "Anônimo"
```

### ! (NÃO lógico)

```ruby
autenticado = false

if !autenticado
  puts "Faça login"
end

# Métodos que terminam com ? retornam boolean
if !lista.empty?
  puts "Lista tem itens"
end

# Prefira usar unless neste caso
unless lista.empty?
  puts "Lista tem itens"
end
```

## 6. Valores Truthy e Falsy

Em Ruby, apenas `false` e `nil` são falsy. **Tudo o mais** é truthy!

```ruby
# Falsy
if false
  puts "Não executa"
end

if nil
  puts "Não executa"
end

# Truthy (diferente de outras linguagens!)
if 0
  puts "Executa! (0 é truthy em Ruby)"
end

if ""
  puts "Executa! (string vazia é truthy)"
end

if []
  puts "Executa! (array vazio é truthy)"
end

if {}
  puts "Executa! (hash vazio é truthy)"
end
```

## 7. Guard Clauses (Cláusulas de Guarda)

Padrão idiomático Ruby para retornar cedo e evitar aninhamento:

```ruby
# ❌ Ruim - muito aninhamento
def processar_pedido(pedido)
  if pedido
    if pedido.valido?
      if pedido.pago?
        # processar pedido
        puts "Pedido processado"
      else
        puts "Pedido não pago"
      end
    else
      puts "Pedido inválido"
    end
  else
    puts "Pedido não encontrado"
  end
end

# ✅ Bom - guard clauses
def processar_pedido(pedido)
  return puts "Pedido não encontrado" unless pedido
  return puts "Pedido inválido" unless pedido.valido?
  return puts "Pedido não pago" unless pedido.pago?

  # processar pedido
  puts "Pedido processado"
end
```

## 8. Métodos com ? (Predicados)

Ruby tem convenção de terminar métodos que retornam boolean com `?`:

```ruby
texto = "Ruby"

# Métodos built-in
texto.empty?       # => false
texto.include?("R")  # => true
5.even?            # => false
5.odd?             # => true
nil.nil?           # => true

# Seus próprios métodos
def maior_de_idade?(idade)
  idade >= 18
end

if maior_de_idade?(25)
  puts "É maior de idade"
end

# Em classes
class Usuario
  def initialize(idade)
    @idade = idade
  end

  def adulto?
    @idade >= 18
  end

  def idoso?
    @idade >= 65
  end
end

usuario = Usuario.new(30)
puts "Adulto" if usuario.adulto?
```

## Exemplo Prático Completo

```ruby
# sistema_notas.rb

puts "=== Sistema de Avaliação ==="
puts

print "Digite a nota (0-100): "
nota = gets.chomp.to_f

# Validação com guard clause
if nota < 0 || nota > 100
  puts "Erro: Nota deve estar entre 0 e 100"
  exit
end

# Calcular conceito usando case
conceito = case nota
when 90..100
  "A"
when 80...90
  "B"
when 70...80
  "C"
when 60...70
  "D"
else
  "F"
end

# Determinar status
status = nota >= 60 ? "APROVADO" : "REPROVADO"

# Mensagem motivacional usando if/elsif
mensagem = if nota >= 90
  "Excelente trabalho!"
elsif nota >= 80
  "Muito bom!"
elsif nota >= 70
  "Bom trabalho!"
elsif nota >= 60
  "Aprovado, mas pode melhorar"
else
  "Precisa estudar mais"
end

# Emoji baseado no conceito
emoji = case conceito
when "A" then "🌟"
when "B" then "😊"
when "C" then "🙂"
when "D" then "😐"
else "😞"
end

# Exibir resultados
puts "\n" + "="*40
puts "NOTA: #{nota}"
puts "CONCEITO: #{conceito} #{emoji}"
puts "STATUS: #{status}"
puts "MENSAGEM: #{mensagem}"
puts "="*40

# Recomendação usando unless
puts "\nRecomendação: Procure o professor" unless nota >= 70
```

## Resumo

✅ **if/elsif/else**: Estrutura condicional básica
✅ **unless**: Oposto de if, use apenas para condições simples
✅ **case/when**: Mais poderoso que switch, funciona com ranges, regex, classes
✅ **Ternário**: `condição ? true : false` para atribuições simples
✅ **Modificadores**: `ação if condição` para linhas únicas
✅ **Guard clauses**: Return early para evitar aninhamento
✅ **Truthy/Falsy**: Apenas `false` e `nil` são falsy
✅ **Métodos com ?**: Convenção para métodos que retornam boolean
✅ **Case sem variável**: Alternativa elegante a if/elsif

## Boas Práticas

1. Prefira modificadores inline para condições simples
2. Use `unless` apenas para condições simples e sem else
3. Use `case` quando tiver múltiplas condições sobre o mesmo valor
4. Use guard clauses para reduzir aninhamento
5. Evite aninhar ternários
6. Termine métodos que retornam boolean com `?`

## Próximo Passo

Agora vamos aprender sobre **[Laços de Repetição](05-lacos-repeticao.md)** em Ruby!

---

[⬅️ Anterior: Operadores](03-operadores.md) | [🏠 Voltar ao Índice](README.md) | [➡️ Próximo: Laços de Repetição](05-lacos-repeticao.md)
