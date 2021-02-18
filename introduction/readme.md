# Getting-Start

## [Introduction](https://elixir-lang.org/getting-started/introduction.html)

### _Interative mode_: **iex**

### _Initial Commands_:
```elixir
iex(1)> 40 + 2
42
iex(2)> "hello" <> " world"
"hello world"
```

### _Running Scripts_: `elixir hello-word.exs`

## [Basic types](https://elixir-lang.org/getting-started/basic-types.html)

### _Get Data Type_: `i data`
```elixir
iex(1)> i 1
```
will show something like this:
```
Term
  1
Data type
  Integer
Reference modules
  Integer
Implemented protocols
  IEx.Info, Inspect, List.Chars, String.Chars
```

### _Basic Types_:
```elixir
iex> 1          # integer
iex> 0x1F       # integer
iex> 1.0        # float
iex> true       # boolean
iex> :atom      # atom / symbol
iex> "elixir"   # string
iex> [1, 2, 3]  # list
iex> {1, 2, 3}  # tuple
```

### _Math_:
```elixir
iex> 1 + 2
3
iex> 5 * 5
25
iex> 10 / 2
5.0
```
`10/2` always return a float number, to get an integer, use `div` and `rem` functions:
```elixir
iex> div(10, 2)
5
iex> div 10, 2
5
iex> rem 10, 3
1
```

### _Shortcut Notations_:
```elixir
iex> 0b1010 # binary
10
iex> 0o777 # octal
511
iex> 0x1F # hexadecimal
31
```

### _Scientific Notation_
```elixir
iex> 1.0
1.0
iex> 1.0e-10
1.0e-10
```

### _Round Function_:
```elixir
iex> round(3.58)
4
iex> trunc(3.58)
3
```

## [Conditions](https://elixir-lang.org/getting-started/case-cond-and-if.html)

### Case

_code_
```elixir
case {1, 2, 3} do       
  {1, _x, 3} ->  
    "This clause will match and bind _x to 2 in this clause"

  {4, 5, 6} ->
    "This clause won't match"

   _ ->
    "This clause would match any value"
end
```
_out_
```elixir
"This clause will match and bind _x to 2 in this clause"
```

**To use pattern match you need to use pin`^` operator**

_code_
```elixir
x = 1

case 10 do
  ^x -> "Won't match"
  _ -> "Will match"
end
```
_out_
```elixir
"Will match"
```

**Clause allow extra coditions to be specified via guards**

_code_
```elixir
case {1, 2, 3} do
  {1, x, 3} when x > 0 ->
    "Will match"
  _ ->
    "Would match, if guard condition were not satisfied"
end
```
_out_
```elixir
"Will match"
```

**Erros in guards will not leak but simply make the guard fail**

```elixir
iex> hd(1)
** (ArgumentError) argument error
  :erlang.hd(1)
```

_code_
```elixir
case 1 do
  x when hd(x) -> "Won't match"
  x -> "Got #{x}"
end
```
_out_
```elixir
"Got 1"
```
**Anonymous Functions can also have multiple clauses and guards**

_code_
```elixir
f = fn
  x, y when x > 0 -> x + y
  x, y -> x * y
end
```
```elixir
iex> f.(1, 3)
4
iex> f.(-1, 3)
-3
```

### Cond

**Useful to make multi conditions with different values and return the first that match true**

_code_
```elixir
cond do
  2 + 2 == 5 ->
    "This will not be true"
  2 * 2 == 3 ->
    "Nor this"
  1 + 1 == 2 ->
    "But this will"
end
```
_out_
```elixir
"But this will"
```
**This is equivalentto `else if` clause in many imperative languages (used much less here)**

**Is necessary add a final condition equal `true`, wich always will match, because if all the conditions return `nil` of `false`an error `CondClauseError` is raised**

_code_
```elixir
cond do
  2 + 2 == 5 -> 
    "This is never true"
  2 * 2 -> 3
    "Nor this"
  true ->
    "This is always true, equivalent to else"
end
```
_out_
```elixir
"This is always true, equivalent to else"
```

**`cond` considers any value besides `nil` or `false` to be `true`**

_code_
```elixir
cond do
  hd([1, 2, 3]) -> "1 is considered as true"
end
```
_out_
```elixir
"1 is considered true"
```

### If/Unless

**Elixir povider macros `if/2` and `unless/2` wich are useful when you needto checkfor onlyon condition**

_code_
```elixir
if true do
  "This works!"
end
```
_out_
```elixir
This works!""
```

_code_
```elixir
unless true do
  "This is will never be seen"
end
```
_out_
```elixir
nil
```

**They also suport `else`**
```elixir
if nil do
  "This won't be seen"
else
  "This will"
end
```
_out_
```elixir
"This will"
```

### `do/end` blocks

```elixir
iex> if true, do: 1 + 2
2
iex> if false, do: :this, else: :that
:that
```

These are equivalent:
_code/1_
```elixir
if true do
  a = 1 + 2
  a + 10
end
```
_code/2_
```elixir
if true, do: (
  a = 1 + 2
  a + 10
)
```
_out/all_
```
13
```

## [Binaries, strings, and charlists](https://elixir-lang.org/getting-started/binaries-strings-and-char-lists.html)

### Unicode and Code Points

**You can use `?` before a character literal to see your code point**
```elixir
iex> ?a
97
iex> ?ł
322
```
```elixir
iex> "\u0061" === "a"
true
iex>0x0061 = 97 = ?a
97
```

### UTF-8 and Encodings

**Elixir uses UTF-8 to encode its strings, which means that code are encoded as a series of 8-bit bytes**

**`String.lenght/1` count graphemes, but `byte_size/1` reveals the number of underlying raw bytes needed to store the string when using UTF-8. UTF-8 requires one byte to represent the characters `h`, `e`, and `o`, but two bytes to represent `ł`**

```elixir
iex> string = "hełło"
iex> String.length(string)
5
iex> byte_size(string)
7
```
### Charlist

**A charlist is a list of integers where all the integers are valid code points**

```elixir
iex> 'hełło'
[104, 101, 322, 322, 111]
iex> is_list 'hełło'
true
iex> 'hello'
'hello'
iex> List.first('hello')
104
```
```elixir
iex> heartbeats_per_minute = [99, 97, 116]
'cat'
```

```elixir
iex> to_charlist "hełło"
[104, 101, 322, 322, 111]
iex> to_string 'hełło'
"hełło"
iex> to_string :hello
"hello"
iex> to_string 1
"1"
```
```elixir
iex> 'this ' <> 'fails'
** (ArgumentError) expected binary argument in <> operator but got: 'this '
    (elixir) lib/kernel.ex:1821: Kernel.wrap_concatenation/3
    (elixir) lib/kernel.ex:1808: Kernel.extract_concatenations/2
    (elixir) expanding macro: Kernel.<>/2
    iex:1: (file)
iex> 'this ' ++ 'works'
'this works'
iex> "he" ++ "llo"
** (ArgumentError) argument error
    :erlang.++("he", "llo")
iex> "he" <> "llo"
"hello"
```
