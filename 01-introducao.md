# 💎 Introdução ao Ruby

## O que é Ruby?

Ruby é uma linguagem de programação **dinâmica**, **interpretada** e **orientada a objetos**, criada com foco na simplicidade e produtividade. Sua sintaxe elegante é natural de ler e fácil de escrever.

### Características Principais

- **Totalmente Orientada a Objetos**: Tudo em Ruby é um objeto, incluindo números e tipos primitivos
- **Tipagem Dinâmica**: Não é necessário declarar o tipo das variáveis
- **Sintaxe Elegante**: Código limpo e legível, próximo da linguagem natural
- **Flexível**: Permite modificar até mesmo partes fundamentais da linguagem
- **Blocos**: Conceito poderoso que facilita a criação de código expressivo

## História e Filosofia

Ruby foi criada em meados dos anos 1990 por **Yukihiro "Matz" Matsumoto** no Japão. A filosofia do Ruby é resumida no princípio:

> **"Ruby foi projetado para tornar os programadores felizes"** - Matz

### Princípio do Menor Espanto (POLA)

Ruby segue o princípio de que a linguagem deve se comportar de maneira que minimize a confusão para usuários experientes.

## Instalação

### Linux (Ubuntu/Debian)
```bash
sudo apt update
sudo apt install ruby-full
```

### macOS
```bash
# Usando Homebrew
brew install ruby
```

### Windows
Baixe o RubyInstaller em: https://rubyinstaller.org/

### Verificando a Instalação
```bash
ruby --version
# Deve mostrar algo como: ruby 3.x.x
```

## Seu Primeiro Programa Ruby

### Hello World

Crie um arquivo chamado `hello.rb`:

```ruby
puts "Olá, Mundo!"
```

Execute no terminal:
```bash
ruby hello.rb
```

**Saída:**
```
Olá, Mundo!
```

### Diferença entre puts, print e p

```ruby
# puts - imprime e adiciona uma nova linha
puts "Hello"
puts "World"

# print - imprime sem adicionar nova linha
print "Hello"
print "World"

# p - imprime a representação "inspect" do objeto (útil para debug)
p "Hello"
```

**Saída:**
```
Hello
World
HelloWorld
"Hello"
```

## IRB - Interactive Ruby Shell

O IRB é um REPL (Read-Eval-Print Loop) que permite executar código Ruby interativamente.

### Iniciando o IRB

```bash
irb
```

### Exemplos no IRB

```ruby
irb(main):001:0> 2 + 2
=> 4

irb(main):002:0> "Ruby".upcase
=> "RUBY"

irb(main):003:0> [1, 2, 3].sum
=> 6

irb(main):004:0> exit  # ou Ctrl+D para sair
```

## Comentários em Ruby

```ruby
# Este é um comentário de linha única

=begin
Este é um comentário
de múltiplas linhas
Útil para documentação mais longa
=end

puts "Código executável"  # Comentário inline
```

## Estrutura Básica de um Programa Ruby

```ruby
# comentario_exemplo.rb

# 1. Comentários e documentação no topo
# Este programa demonstra conceitos básicos do Ruby

# 2. Requires (importações) se necessário
require 'date'

# 3. Definição de constantes
NOME_APLICACAO = "Meu Programa Ruby"

# 4. Definição de métodos
def saudar(nome)
  "Olá, #{nome}!"
end

# 5. Código principal
puts NOME_APLICACAO
puts saudar("Maria")
puts "Data atual: #{Date.today}"
```

**Saída:**
```
Meu Programa Ruby
Olá, Maria!
Data atual: 2025-11-06
```

## Convenções Básicas

### 1. Nomes de Arquivos
- Use snake_case: `meu_programa.rb`
- Extensão `.rb` para arquivos Ruby

### 2. Indentação
- Use 2 espaços (não tabs)

```ruby
# Correto
def exemplo
  puts "Bem indentado"
end

# Incorreto
def exemplo
    puts "Mal indentado"
end
```

### 3. Ponto e Vírgula
- **Não são necessários** no final das linhas
- Ruby detecta automaticamente o fim de uma instrução

```ruby
# Correto - idiomático
puts "Ruby"
puts "é"
puts "elegante"

# Funciona, mas não é idiomático
puts "Ruby"; puts "é"; puts "elegante"
```

## Interpolação de Strings

Ruby permite inserir expressões dentro de strings usando `#{}`:

```ruby
nome = "João"
idade = 25

# Interpolação
puts "Meu nome é #{nome} e tenho #{idade} anos"

# Com expressões
puts "Daqui a 5 anos terei #{idade + 5} anos"

# Funciona apenas com aspas duplas
puts "Interpolação: #{nome}"      # Funciona
puts 'Sem interpolação: #{nome}'  # Não funciona, imprime literal
```

**Saída:**
```
Meu nome é João e tenho 25 anos
Daqui a 5 anos terei 30 anos
Interpolação: João
Sem interpolação: #{nome}
```

## Métodos Úteis para Iniciantes

```ruby
# gets - lê entrada do usuário
puts "Qual é seu nome?"
nome = gets.chomp  # chomp remove o \n do final

puts "Olá, #{nome}!"

# Conversões de tipo
"123".to_i     # => 123 (String para Integer)
123.to_s       # => "123" (Integer para String)
"3.14".to_f    # => 3.14 (String para Float)

# Verificando tipos
42.class       # => Integer
"texto".class  # => String
3.14.class     # => Float
true.class     # => TrueClass
```

## Exemplo Prático Completo

```ruby
# programa_interativo.rb

puts "=== Calculadora de Idade ==="
puts

print "Digite seu nome: "
nome = gets.chomp

print "Digite seu ano de nascimento: "
ano_nascimento = gets.chomp.to_i

ano_atual = 2025
idade = ano_atual - ano_nascimento

puts
puts "Olá, #{nome}!"
puts "Você tem aproximadamente #{idade} anos."
puts "Em 2030 você terá #{idade + 5} anos."
```

## Recursos para Aprender Mais

- **Documentação Oficial**: https://www.ruby-lang.org/pt/
- **Ruby Docs**: https://ruby-doc.org/
- **Try Ruby**: https://try.ruby-lang.org/ (playground online)
- **Ruby Koans**: http://rubykoans.com/ (exercícios interativos)

## Resumo

✅ Ruby é uma linguagem elegante e focada na felicidade do programador
✅ Totalmente orientada a objetos
✅ Sintaxe simples e legível
✅ IRB permite experimentar código interativamente
✅ Interpolação de strings facilita a construção de mensagens
✅ Use `puts` para imprimir saída
✅ Comentários começam com `#`

## Próximo Passo

No próximo capítulo, vamos aprender sobre **[Variáveis e Tipos de Dados](02-variaveis.md)** em Ruby!

---

[⬅️ Voltar ao Índice](README.md) | [➡️ Próximo: Variáveis e Tipos de Dados](02-variaveis.md)
