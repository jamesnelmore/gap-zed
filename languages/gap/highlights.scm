; NOTE: In case multiple queries match, last query wins — go from least
; specific to most specific.
(identifier) @variable

; Constants
; convention: constants are of the form ALL_CAPS_AND_UNDERSCORES, length >= 2
((identifier) @constant
  (#match? @constant "^[A-Z_][A-Z_]+$"))

; Functions
(assignment_statement
  left: (identifier) @function
  right: (function))

(assignment_statement
  left: (identifier) @function
  right: (atomic_function))

(assignment_statement
  left: (identifier) @function
  right: (lambda))

(call
  function: (identifier) @function @function.call)

((call
  function: (identifier) @function @function.builtin)
  (#any-of? @function.builtin "Assert" "Info" "IsBound" "Unbind" "TryNextMethod"))

(parameters
  (identifier) @variable.parameter)

(qualified_parameters
  (identifier) @variable.parameter)

(qualified_parameters
  (qualified_identifier
    (identifier) @variable.parameter))

(lambda_parameters
  (identifier) @variable.parameter)

; arg is treated specially when it is the only parameter of a function
((parameters
  .
  (identifier) @variable.parameter .)
  (#eq? @variable.parameter "arg"))

((qualified_parameters
  .
  (identifier) @variable.parameter .)
  (#eq? @variable.parameter "arg"))

((qualified_parameters
  .
  (qualified_identifier
    (identifier) @variable.parameter) .)
  (#eq? @variable.parameter "arg"))

((lambda_parameters
  .
  (identifier) @variable.parameter .)
  (#eq? @variable.parameter "arg"))

(locals
  (identifier) @variable.parameter)

; Literals
(bool) @boolean

(integer) @number

(float) @number

(string) @string

(char) @string

(escape_sequence) @string.escape

[
  (help_topic)
  (help_book)
] @string.special

(tilde) @variable.special

; Record selectors
(record_entry
  left: [
    (identifier)
    (integer)
  ] @property)

(record_selector
  selector: [
    (identifier)
    (integer)
  ] @property)

(component_selector
  selector: [
    (identifier)
    (integer)
  ] @property)

(function_call_option
  [
    (identifier)
    (record_entry ; Record entries specify global properties in function calls
      left: [
        (identifier)
        (integer)
      ])
  ] @property)

(help_statement
  (help_selector) @property)

; Operators
[
  "+"
  "-"
  "*"
  "/"
  "^"
  "->"
  ":="
  "<"
  "<="
  "<>"
  "="
  ">"
  ">="
  ".."
  (ellipsis)
] @operator

(help_statement
  (help_operator) @operator)

; Keywords
[
  (break_statement)
  (continue_statement)
  "atomic"
  (quit_statement)
] @keyword

[
  "function"
  "local"
  "end"
] @keyword @keyword.function

[
  "and"
  "in"
  "mod"
  "not"
  "or"
] @keyword @keyword.operator

"rec" @keyword @keyword.type

[
  "readonly"
  "readwrite"
] @keyword @keyword.modifier

(atomic_function
  "atomic" @keyword @keyword.modifier)

[
  "for"
  "while"
  "do"
  "od"
  "repeat"
  "until"
] @keyword @keyword.repeat

[
  "if"
  "then"
  "elif"
  "else"
  "fi"
] @keyword @keyword.conditional

"return" @keyword @keyword.return

(pragma) @preproc @keyword.directive

; Punctuation
[
  ","
  ";"
  "."
  "!."
  ":"
] @punctuation.delimiter

[
  "("
  ")"
  "["
  "!["
  "]"
  "{"
  "}"
] @punctuation.bracket

(help_statement
  "?" @punctuation.special)

; Comments
(comment) @comment
