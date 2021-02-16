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
